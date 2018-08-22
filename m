Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBB9C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03192146F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBqNDmsg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03192146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbeHVSMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 14:12:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36799 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbeHVSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 14:12:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so1660271lji.3;
        Wed, 22 Aug 2018 07:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9OL/QoC1Iaj0cbqFFq+OVBzZO3JS44FDpH5yUyUdkFc=;
        b=QBqNDmsgbWGNMvvqtBn0PHlDqXKozfJIZTxcmCWApbTsds4v8zdtlv4nySUrBHu61h
         OwL4Z3iAFVyiORiUQ7UQ0WuSX7aTY083kqJrNFIaiGsffIWpoBhUR9V7UZoE+h8v/2xU
         VPNsrOPHm1EWa+22+0H8SuHsu+opZrLAWMaN1oiDJpqFRAXkOvlz2egwXJ9n53KQEqkA
         gGsRKkdr+rk7F6F3cGJ653lwgOS8QF5c22Gzp/zBztavvh0I2Pj0J00INKcKbqHbTy/a
         CDo4OBQXcybo/PHBmPp2t9h/fMi32xkAxXlH5FneohU60LC1+GfS+Z1yGpvWAWD1GOsQ
         yJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=9OL/QoC1Iaj0cbqFFq+OVBzZO3JS44FDpH5yUyUdkFc=;
        b=G1pdYi+/ZY6EjQx/69HD+94iV/5M1X8TiChXCYxY7R7tRov+575Z+s8fREWg5WrWBp
         WFCIg/2yFk0CJefezpqyRXdyByefRh+wJt/VlcPzIyI396mcZOGc92hoNNrSEI6Hyt6P
         jYfman/9ZxljrfXQdOMHmdpsJIciQ/EHPMed00pa8yb2cQmLU246E2Y55RBI3Zbplrs+
         PloDd04jWRcqVZWgt9uPnyGe7VXWuNgAMnUa8zkT8HvDlo623GCd0byg+RaI2oj8iTjf
         bdSXh5eF+a2Ze7Oub5cHTll72fe9CrTW1HgquAEkLEK3sVgU7qR5plK6o2z+Horiwl91
         byNg==
X-Gm-Message-State: AOUpUlHBldngCvpC6JFywxKNO5ljeKn7Cnz3J5tEK45muG9FBRRCfgEn
        U+dw8bNBXq4tqmpM6WmUApg=
X-Google-Smtp-Source: AA+uWPwW4sF3JyhTDfHrdYfZmUMkVsQ9uNN5R+58uCM0tJH/GaeD6PsUGMVVWzK58C6cBzs5xRpf+w==
X-Received: by 2002:a2e:4401:: with SMTP id r1-v6mr39681641lja.21.1534949214507;
        Wed, 22 Aug 2018 07:46:54 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g87-v6sm348789lfh.92.2018.08.22.07.46.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 07:46:53 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fsUPQ-0006Yw-0M; Wed, 22 Aug 2018 16:46:56 +0200
Date:   Wed, 22 Aug 2018 16:46:55 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Johan <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ck.hu@mediatek.com, p.zabel@pengutronix.de,
        Rob Clark <robdclark@gmail.com>, airlied@linux.ie,
        Ulf Hansson <ulf.hansson@linaro.org>, rainyfeeling@outlook.com,
        boris.brezillon@bootlin.com, opendmb@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>, davem@davemloft.net,
        peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, sameo@linux.intel.com, sre@kernel.org
Subject: Re: [PATCH 0/9] of: fix compatible-child-node lookups
Message-ID: <20180822144655.GO14967@localhost>
References: <20180822105547.9634-1-johan@kernel.org>
 <CABGGisx6CDoDqxTo=q=jKBAb19Xx38N6pR=XrwzBHuSDtp_Wcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGGisx6CDoDqxTo=q=jKBAb19Xx38N6pR=XrwzBHuSDtp_Wcw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 09:32:11AM -0500, Rob Herring wrote:
> On Wed, Aug 22, 2018 at 5:57 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > Several drivers currently use of_find_compatible_node() to lookup child
> > nodes while failing to notice that the of_find_ functions search the
> > entire tree depth-first and therefore can match unrelated (non-child)
> > nodes.
> 
> That is not quite right. It searches all nodes following 'from', so
> not the entire tree unless 'from' is NULL. The purpose of 'from' is to
> iterate to find all compatible nodes. But you are correct that anyone
> calling of_find_compatible_node directly with from != NULL is wrong.

Yeah, sorry, I guess I could have been more specific. I just find
qualifying "searching the entire tree" with "starting from the node
specified in the first argument" to be too cumbersome to write. And it's
sort of implicit as the functions *are* iterators meant for searching
the entire tree (passing NULL as the first argument the first time).

> > This is related to the fixes I posted about a year ago, which addressed
> > a similar anti-pattern when looking up child nodes by name. Since it
> > took me more than a year to get all those fixes into Linus' tree (one
> > fix is still pending), and as these fixes depend on the new helper, I'm
> > suggesting that these all go in through Rob's or Greg's trees.
> 
> I'm happy to take them or apply the dependency now and then anything
> not picked up by sub-maintainers for 4.20.

Thanks, let's see if what the others prefer.

Johan
