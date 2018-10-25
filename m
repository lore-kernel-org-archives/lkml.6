Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95212C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2347120848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 23:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slM/jFaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2347120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727602AbeJZH4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:56:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35271 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeJZH4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:56:20 -0400
Received: by mail-pg1-f193.google.com with SMTP id 32-v6so4744382pgu.2;
        Thu, 25 Oct 2018 16:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=laJjab2z6UBoich3TNOFRF9Rdzj1bYWgRo8/bgL28Yc=;
        b=slM/jFaFaJYIWiO+5ksX2gPCWURoj+v6wpYg9SPnTd1hQjNCtR9NJ8GEfKFlwsxrFP
         24RxcycCtQI3wK2wfEBXTvvISSazj9ENGHLduPmLgVabWK22l/HlPPGKoG2tjH0U7bwh
         HAFNMIYedxlRkzVeARMFKg7C+kLT260GOJitj/jSUdkqtRer6VUh6W3Xb/Rq4HpesjrI
         ApMBqMPv/6uuCLFq/Blx48JF5j+i4/tdtetHOerejXQc5x//zQCdrPbvpLLJQFasz2ox
         aqeep+WB0a+HLLBGwF80cpQh018l9Mie4nL/uZX0YaJhitF5oXgEGxrxEmxEJcTQkbtE
         OEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=laJjab2z6UBoich3TNOFRF9Rdzj1bYWgRo8/bgL28Yc=;
        b=iGcHmptY3pQSNMK7km/Snx6omOR2wPe/YjZtTdORwePQrVy/9iSFoJvJgXfRLUfuTG
         r6pkjo5ri6bwmeljS/feg0g+vr2gLictn+GWEpq4F4lvuvfdF2dCGPEbJfvVK8WDhHjl
         pziipaHOteJnld0s+uwemRZS1gUxLYwQQvac+zNdrMVbR3SNIWH1uDJXQqS5Naa8503q
         zdS5n/0WPa6w+QxoVKNw867fPGs5p3EIOw91d1QRibRd9pVQrWOmjGn0s7iJDJPVEDlr
         iJLa4TVAqxNFT/aYllm1p2t/R9LPr65VljMuK6s8IzLIeJzla0zxoE3VIFKXMWLBODmq
         KKYw==
X-Gm-Message-State: AGRZ1gJiqNUe5Bl1nwR1I4SGCJy/8YWqk+tM1SyWXS8JhDjrDWaClQIb
        pvHlAs0jD0+6cW4RkwK5Zqc=
X-Google-Smtp-Source: AJdET5etq+HiFFjxgB89pA0pokhwNHTvl+W0xZ+BOXZNZ4kvjcj1ikyj3NheKcZGEV5+oLcjuAxrdQ==
X-Received: by 2002:a62:85cb:: with SMTP id m72-v6mr1141530pfk.173.1540509703145;
        Thu, 25 Oct 2018 16:21:43 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d126-v6sm26014237pgc.32.2018.10.25.16.21.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 16:21:43 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:21:38 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] hwmon: (core) Inherit power properties to hdev
Message-ID: <20181025232138.GA28487@Asurada-Nvidia.nvidia.com>
References: <20181024193402.16698-1-nicoleotsuka@gmail.com>
 <20181024193402.16698-2-nicoleotsuka@gmail.com>
 <20181025001301.Horde.VCevVrrSs6rOyXT41xiPOzW@cp2.active-venture.com>
 <20181025010116.GA4543@Asurada-Nvidia.nvidia.com>
 <20181025013349.GA7569@Asurada-Nvidia.nvidia.com>
 <20181025065531.Horde.JhVAJU3eOlwYcSJ57tV4I5-@cp2.active-venture.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025065531.Horde.JhVAJU3eOlwYcSJ57tV4I5-@cp2.active-venture.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 06:55:31AM +0000, linux@roeck-us.net wrote:
> > won't work then. I guess it'd be safer to ignore the problem of
> > the power node, i.e. using parent dev pointer for pm runtime.
> > 
> It might be worthwhile looking up how other virtal devices handle
> this problem. Maybe the hwmon code could have its own suspend/resume
> callbacks. Not sure how to make that work, though, and what those
> callbacks would (have to) do.

I am adding a core pm pointer to the class. A hwmon driver will
also need to pass a private pm pointer in a chip/info structure.
I will send it soon.

Thanks
Nicolin
