Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C161BC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 780762084A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544518863;
	bh=e8YHmbGw7SCHlxyIsYFHZ8qDYTJ6akeBJxHkzWdvXKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nLA0qa+Atl8hhkMFQ+2jjfmREYU50waJABH2fpW2wG5/OgYBTfVXa+O8LcKOov80n
	 LWjE4Qw/7LGuNM4GhfhxL0cfwYsYn94uaG5EvFMPgS0tU/XH1Y5jCbybkps0DNV56F
	 qox/nm0N/h+pntir7rPXO8HnZY/FMpK1B2OADIz4=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 780762084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbeLKJBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:01:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45174 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeLKJBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:01:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id b14so13181793wru.12;
        Tue, 11 Dec 2018 01:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uXEzyFPCa+8P7PACWC73ZYZnsVLAkBBXSJSrQtjuu+w=;
        b=G7RhiWkx0kE5Fz3xRHcu45Ghqc70/kxr62mF+Ml74ZWbVh1zJ1GpsxcOUL23POdPhQ
         GBKPEP70psB5Q+DmgyR1xUpQ8gYMTNymo9llJPrWKCLWryB0Fw95USRARs/Cpp4Hifsu
         ACYgFqWvXpZGWBtsxHfEPdfFVg2McaqBpQ4RBguaq8xteHFZE888wgVGrFrjUduce0Yh
         AePj4Wi0TBTf5vJc8ocTywsSXrbvFz4NFnxITDiF61itAUQPYzlofFaH7PD8yt7/9VLW
         hrliRYc54T2SY4vu/FFlXDbO7E/ymdVjc1V/V2sUELWzhYDnKZJascxBhx/o99mL3Ow0
         K3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uXEzyFPCa+8P7PACWC73ZYZnsVLAkBBXSJSrQtjuu+w=;
        b=Gskw08xRv/0cPvY/Ie5Tq1HFHCze6O8FNiMEMvrzxexNrJBTV3wP47VlSXZowxmkx9
         tmlC4qkCXpSEa+2vc1E2gSUq1+HoT1UxiSSheByxiqxIrEX0QLPcuioer/voeD92a8s+
         fAcoTSmb432MGfiWzk/aoPRxPM7oJNinsp1fA8sSeH5Ny+bCXcKJeZndX6zM+E2fX7Fw
         KboON1qrA2TfSLK9G34q8h4JvIweudE/AEVMVKCVK0UiKt6eKd+yaxCWP46c4mWpH5h/
         nrrPgwoJpeV4/5Afh0u2i0NBN1+hPeA7SwLcuVFxI3hO7OTSDEFUbRJre9HjrnFVhjn6
         1AlQ==
X-Gm-Message-State: AA+aEWa3vJU/J80sXGCIh20oTivzwIJeSL3qsnSa+326pnIFNVoKjZU8
        cNWPIx7D0B51bB3Yju0SiNc=
X-Google-Smtp-Source: AFSGD/UZZYinTu1pPaMHQG2gOnreUnWC3o2Hg0MVAto2dRUfGv8DG7TUUq2l+2jVhRjCOK+KF8GWaQ==
X-Received: by 2002:adf:ea11:: with SMTP id q17mr12090255wrm.328.1544518859824;
        Tue, 11 Dec 2018 01:00:59 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l20sm36151764wrb.93.2018.12.11.01.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 01:00:58 -0800 (PST)
Date:   Tue, 11 Dec 2018 10:00:56 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     linux-mm@kvack.org, mhocko@suse.com, bp@suse.de,
        pasha.tatashin@soleen.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        torvalds@linux-foundation.org, hpa@zytor.com, jkosina@suse.cz,
        ak@linux.intel.com
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/pti] x86/speculation/l1tf: Drop the swap storage limit
 restriction when l1tf=off
Message-ID: <20181211090056.GA30493@gmail.com>
References: <20181113184910.26697-1-mhocko@kernel.org>
 <tip-f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Michal Hocko <tipbot@zytor.com> wrote:

> Commit-ID:  f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48
> Gitweb:     https://git.kernel.org/tip/f4abaa98c4575cc06ea5e1a593e3bc2c8de8ef48
> Author:     Michal Hocko <mhocko@suse.com>
> AuthorDate: Tue, 13 Nov 2018 19:49:10 +0100
> Committer:  Thomas Gleixner <tglx@linutronix.de>
> CommitDate: Mon, 10 Dec 2018 22:07:02 +0100
> 
> x86/speculation/l1tf: Drop the swap storage limit restriction when l1tf=off

> [ tglx: Folded the documentation delta change ]

> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2095,6 +2095,9 @@
>  			off
>  				Disables hypervisor mitigations and doesn't
>  				emit any warnings.
> +				It also drops the swap size and available
> +				RAM limit restriction on both hypervisor and
> +				bare metal.

>  
>  			Default is 'flush'.
>  
> diff --git a/Documentation/admin-guide/l1tf.rst b/Documentation/admin-guide/l1tf.rst
> index b85dd80510b0..2e65e6cb033e 100644
> --- a/Documentation/admin-guide/l1tf.rst
> +++ b/Documentation/admin-guide/l1tf.rst
> @@ -405,6 +405,9 @@ time with the option "l1tf=". The valid arguments for this option are:
>  
>    off		Disables hypervisor mitigations and doesn't emit any
>  		warnings.
> +		It also drops the swap size and available RAM limit restrictions
> +                on both hypervisor and bare metal.
> +

Note tha there's also some whitespace damage here: all other similar 
lines in this RST file start with two tabs, this one starts with 8 
spaces.

Thanks,

	Ingo
