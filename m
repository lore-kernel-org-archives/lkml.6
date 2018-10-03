Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419D9C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB80920835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 06:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ04WXZu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB80920835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCNjZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 09:39:25 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39855 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbeJCNjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 09:39:24 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so4406880wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 23:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NHuB/Mbc03PW39X3tm67Jd+0qYW4INKBsqq5fSLKNLA=;
        b=TZ04WXZujX6w7Wp5q84tdxndG5Gb+L6dkr9UBGC55KKYVmq9NzLKZOA31bsKQyNynk
         c+QsqPRPqV1Q6bdFh2C8s9z8V/ZZDns5hG2a53ETymVXGwlgZxE2GIIWWG+u5z3GbbRr
         IPhsdF6eoG6ZCwf8SJEHQOt8lP9xmj99bjxxrooixuqp7mXK8xyKvn/HfgkRDUrCxVFT
         QXo6mRcLrj0ejMpjM0XhNJt6mDzk4LjGPQg+xMvsuCaNsd6DIPGktEoGuxEdafiYZyjx
         Li/Busu+15dh83e2RzNv0vj5tv9eHfNupdvZ1DpDm6KcCpVQcgoipA2FabxNnEGn7GQG
         WECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NHuB/Mbc03PW39X3tm67Jd+0qYW4INKBsqq5fSLKNLA=;
        b=Fe8oLQ1FPPinFXWy7UxEdN5vvsVNhRI1TR4nAmQ3nlPNi404HgbugRWkh9HPdihU0B
         RNW48+SdxGChNvCXwXAHJe8H7jpMgIds+eSi5+7GTPnNLDq1jL6Z53lChfkCHuamIv4s
         IxYMcjvivcRVzlkYc8v+2XJxrI1Y37epYwjbvZ08zxEeTiO2FiZ9GO/pRzULCl+QGmAG
         BzMkKC4XszKb6Qv2r+rfH4mb22UcdVsE155cocJg7FaJ+PcVpmRNvkuu7qZEQr9m3E2W
         AhvOSvLs1P8SyCTyoRSCEwQ2N8divAgkAwzRQRXjH767ROhV4bfDUcj8NLIaTVKpu2v2
         Eu8g==
X-Gm-Message-State: ABuFfojQHmXDLV9oxw112nhB6cFEr5q8mLyGDzUH1cNlJXMiYLf8749x
        gHjsdyHxgK0H5ot17DJ/VFY=
X-Google-Smtp-Source: ACcGV61vzwXps/GSUyHExoOchbuYbXVyjRms97xGaXF6GPnDiE5euAZ609tKbfyw1fMlzl0LEKVXHw==
X-Received: by 2002:a1c:c708:: with SMTP id x8-v6mr392627wmf.116.1538549542273;
        Tue, 02 Oct 2018 23:52:22 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l67-v6sm2479314wma.20.2018.10.02.23.52.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 23:52:21 -0700 (PDT)
Date:   Wed, 3 Oct 2018 08:52:19 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Add a kernel parameter to change the padding size
 for KASLR
Message-ID: <20181003065219.GA28386@gmail.com>
References: <20181003013323.4162-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181003013323.4162-1-msys.mizuma@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:

> This patch series are adding an kernel parameter to change
> the padding size used for KASLR. It is useful for memory hotplug
> capable system. User can adjust the padding size to use it.
> 
> It is better if the padding size is calculated automatically,
> however, ACPI SRAT is not available at the KASLR initialization
> time. So, I add a message for user to tell the suitable padding
> size. User can set it on next reboot.
> 
> This patch series don't change the current default padding size.
> 
> Change log from v5:
>  - Fix build error if CONFIG_RANDOMIZE_MEMORY is not defined.

Please send a delta patch on top of tip:x86/boot with the get_rand_mem_physical_padding() fix, 
when doing that you'll see that I did some minor cleanups when applying the patches which your 
v6 series undoes.

Thanks,

	Ingo
