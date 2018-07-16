Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98CDECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8434E2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AzRWLSul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8434E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeGPOvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:51:01 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43735 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbeGPOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:51:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so32357366lfc.10;
        Mon, 16 Jul 2018 07:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=czjjMLGJJ4s193+QHk0i+6L++9djdwjP4yDHV0/hqTM=;
        b=AzRWLSulp6zUhHzlbUkDI6B6WrZT1TnOt11+jlCkKmNf2yL2D3z+ewCb210N5xDXoC
         2McR3T809sFqb6jF8Qb/UPlLBJ9PHM40MXBuaeN3RoQqTGmOsxBCIesdIhzelm8t04gs
         LcVAPAJiOWjngwiW8XO8YNm1SeHCe+rPJ73rRe1rWXTkN9S8kgL3XFbATLGTCD687Psz
         rX8UC+FvyUAyjDeZVclpQi1TH/sPNz9bW6PCD3azzbTTlBgaYnvdSyssQKKC3owIW2SR
         vc7I+UqQMI22LWOHuHr7mQkIlkRv/6AK1ein4RXLzIN/3qmuP5j52BIS03nCx2UQxv1Y
         +6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=czjjMLGJJ4s193+QHk0i+6L++9djdwjP4yDHV0/hqTM=;
        b=kRf0YjwceZp0SLd1Zhvka+GRLfuSDr6JQo1l8PlHPRidnb7yj1WngqOZyU4R/fL9cw
         v2XQXbz3zYDuuaOgdB3fjaviE20gW4RTmF+VKUpau74rrYH4mmyOCJrb83/K9vAnCEqq
         aauW7H39YVrUkh3vKVttZY2gRqqbbOIArGymV+4C95qH/Os2nZ/iH9k3r85SQO6fSSvS
         PfDWpUkXDp521DOgiCIO4ROqdztjpeQdLOZSTGYGpz8Droa+9cUyuFd1HUCRPw+hKQe7
         Tgq1muIpx4c3n2lbediRX/Jti2updtSp0k/MOU6EcLKYfqybqqXPsYEqT+pgvq+pvgnx
         zBwg==
X-Gm-Message-State: AOUpUlHbkzGB9hg508Q8llM7aQm76S9r2nVFQF4LNgMPmGE3N22hNEF/
        +xkcqmhEm4IrETPYIyLUOZg=
X-Google-Smtp-Source: AAOMgpeBaYFepOvEK+eCCDxxCMKHq6MqJt1Lo0QTlpjhwNzf/KSU8CcIBjhVvX/igdfY105pq3fNgg==
X-Received: by 2002:a19:1190:: with SMTP id 16-v6mr12630138lfr.122.1531750999287;
        Mon, 16 Jul 2018 07:23:19 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id m29-v6sm7968313lfj.45.2018.07.16.07.23.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 07:23:18 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ff4P8-0002iC-Iq; Mon, 16 Jul 2018 16:23:10 +0200
Date:   Mon, 16 Jul 2018 16:23:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>, broonie@kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] regulator: qcom_spmi: Fix warning Bad of_node_put()
Message-ID: <20180716142310.GQ10204@localhost>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
 <20180716113525.9335-2-niklas.cassel@linaro.org>
 <20180716120134.GL10204@localhost>
 <20180716132931.GA866@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716132931.GA866@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 03:29:31PM +0200, Niklas Cassel wrote:
> On Mon, Jul 16, 2018 at 02:01:34PM +0200, Johan Hovold wrote:
> > Hi Niklas,
> > 
> > On Mon, Jul 16, 2018 at 01:35:22PM +0200, Niklas Cassel wrote:
> > > For of_find_node_by_name(), you typically pass what the previous call
> > > returned. Therefore, of_find_node_by_name() increases the refcount of
> > > the returned node, and decreases the refcount of the node passed as the
> > > first argument.
> > > 
> > > However, in this case we don't pass what the previous call returned,
> > > so we have to increase the refcount of the first argument to compensate.
> > 
> > I don't think this is the right fix. of_find_node_by_name() should
> > generally not be used by drivers in the first place as it searches the
> > entire tree and can end up matching an entirely unrelated node.
> > 
> > I haven't looked at the device-tree binding in question, but you
> > probably want to use something like of_get_child_by_name() instead.
> > 
> 
> Hello Johan,
> 
> of_find_node_by_name() will only search the whole tree if the
> first argument is NULL, which isn't the case here.

It's searching the entire tree *starting* at its first argument, which
means you may end up matching a completely unrelated node (i.e. not a
child or even descendant) elsewhere in the tree.

> However, of_get_child_by_name() is indeed better suited here.
> Will send out a v2.

Unless you are doing a tree-wide search, using of_get_child_by_name() is
simply wrong.

I fixed up most of these bugs a few releases ago, but they keep on
creeping in.

> Thank you for your feedback, it is much appreciated :)

No worries.

Johan
