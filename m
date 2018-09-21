Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C32CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3B821479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slkZIjJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF3B821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390882AbeIUXd4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:33:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43267 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390231AbeIUXd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:33:56 -0400
Received: by mail-pg1-f196.google.com with SMTP id q19-v6so5507493pgn.10;
        Fri, 21 Sep 2018 10:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L+k4ypnKkycPOwFlI36xWACsn2CZXJIaPzsvBpmSD+o=;
        b=slkZIjJ/x1H8t8yNCCl3rbP5upH/mm7tSW7j9VhXhSxoBBz5N7hxue9opN9wdqxd5n
         WmOTqs6y8RcwTSSTnDEHFXeT2kkIdgoftfmN7WUk7B2Xd/rtEp0/yenuZ56zx/41/OJc
         wB60phUGYHFyjOYdrEt9sZRUBs7hIQSqNfzIl6p+Vb51z+pCM5MG6QQvDlFj+k/KSvc1
         WvDPCdP/LAWZp/YUWyiiYMIheEAGYIfiTRl9swA3zCR0FfFFF0u4pfKtlNRVFR4yYLKP
         OlhKtsV/e5koZa26ET/6jcVqf/TAXw6adfSx2sNC04st4REdPDFP68CBK8fAmCFKmLGq
         s/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L+k4ypnKkycPOwFlI36xWACsn2CZXJIaPzsvBpmSD+o=;
        b=rBMZL7jkbD/Z5xyt5aaQYM/TmyM4ZPMbjRdT0OXhkbkgn9+Vn5VOB2EJ4T0mTgj6wy
         OaDqVoI+ii30IibmmT3ZBTOsuMShHnv1Ehjx+xQh6r6agYBJV2+97/V8JTAh2M3uzzpr
         ZfbfvovSJuGG/U6rwMoVhJ7jVBRg/91eJL9sS3P7GeQKHUYHQQxBE2QvyLy/d0zPIusj
         PGN/IfGIoM34JsQhOYJxjGqxXaX/mIU1Ls86xRo/cJA+IAjuG2ozgBRnKm0vJflJd85E
         LhCvqCuH9NkYeE/Br2sL8dVb51LfJ4/rFNTLWFzB/th+sMEIsVNj2ZdOSHsomfkSDHab
         PhKA==
X-Gm-Message-State: APzg51BK73gbFV7v75gzdxHTRnFAs6fWTO4/mfbkS76whcc01WJTNxln
        Bn6eC+9lBAgdPjGtHfmbbCo=
X-Google-Smtp-Source: ANB0VdYjPRrcken/ZYKJdOdCQDD6b+sr6gIpcu1P7HwBOUrCmqFohWCHKO5u8Rusgogu+IMggzOaqA==
X-Received: by 2002:a62:ce82:: with SMTP id y124-v6mr15127261pfg.140.1537551839579;
        Fri, 21 Sep 2018 10:43:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y64-v6sm2924039pgb.82.2018.09.21.10.43.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 10:43:59 -0700 (PDT)
Date:   Fri, 21 Sep 2018 10:43:54 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: ina3221: Get channel names from DT node
Message-ID: <20180921174353.GA24662@Asurada-Nvidia.nvidia.com>
References: <20180921000753.21846-1-nicoleotsuka@gmail.com>
 <20180921000753.21846-3-nicoleotsuka@gmail.com>
 <21a6e8f3-c95d-43d0-ca3f-3f91ddfeff07@roeck-us.net>
 <20180921012038.GA23354@Asurada-Nvidia.nvidia.com>
 <20180921091813.GA21564@Asurada-Nvidia.nvidia.com>
 <75741ce9-80a3-9277-b8e3-2d3c3e003797@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75741ce9-80a3-9277-b8e3-2d3c3e003797@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 05:56:00AM -0700, Guenter Roeck wrote:

> > I tried is_visible but it looks like it won't be that neat to
> > implement as some attributes of this driver don't really pass
> > the channel index to the store()/show() but some other indexes.
> > 
> 
> The channel index is not the only means that can be used to determine
> the channel index. Many drivers use the position in the attrs[] array
> to determine the channel index. I don't see why this would not be
> possible here.

Hmmm, that should simply work...I didn't mean not possible though.

> > If you are very against the dynamical group, I can drop it to
> > leave the sysfs node as it was.
> > 
> > And for the name nodes that I was talking about above, I will
> > add an sysfs store() function so non-DT users can set them,
> > and I also removed the confusing "unknown" default name.
> > 
> 
> The label attributes are RO. Please follow the ABI.
> 
> temp[1-*]_label Suggested temperature channel label.

Thanks a lot for the hint. I looked up the doc and feel that
this one probably fits my situation more:
    in[0-*]_label   Suggested voltage channel label.

Will follow it in my next version.

Thank you
Nicolin
