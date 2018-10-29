Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3819C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6700620870
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 14:58:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="NVKqkmWQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6700620870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJ2Xr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 19:47:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40069 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeJ2Xr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 19:47:29 -0400
Received: by mail-wm1-f66.google.com with SMTP id b203-v6so8289596wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vPKZVKpVBlWevOi1yl6o147IiQoFsMY88pDy5N0Ej6M=;
        b=NVKqkmWQfjL9yY4fB1CEoAd0kEpA+X7ClaVpQeIBuvraNP9KiTNBZwWOtGvVrEP0+J
         boMODjaBCSGZW7GeVHEk2jWqcYoNitmI2JF/dxNy9Uhwf6x02Mm3bHPiQMrCEmOJ4HGX
         sU1VgLQ7loADW4axSqDvNXwK72Ctetj/vXeeR8GBVhJyJpy/0dx+HOGKoABWUnZ1OUCe
         wTtSZuJIM3Jr/ki1jHckkEhzCJKnGtf8w5YNvnzjr3q69gaPFt84165AJzw8kPdBn5f4
         c0s/uz2mtdesj86zTso3FtOsKiKnJuv2q96ACRg1BWZAuUV2C0xAkMPC3dVLZedM0b38
         6kFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vPKZVKpVBlWevOi1yl6o147IiQoFsMY88pDy5N0Ej6M=;
        b=CPZRh7WV+I9acJhCYwQx3YGtLmT/HPuWrc+GpP0JLXG7ccFhBeTiJ6DNYmIVRzu1av
         3HCnDbleoMaUF2ZylVZBAdmDPtTBzNU6g0SyBe8a0n0lTcFb3DiRsNMonrhL8zcZOZLW
         AN73UFG3aaEyfKlJR3UckXgrpeSM62Lk4kezxkaG4ZacgVsAJjRfn2XHgAGivvK+/HQR
         FuH3r0vDRpsaiDxDiz4Eo2PDkP3nVMpUG5wGvjtjcUq26uP9zVHN1wphoFjQ6dOQxpIu
         skn4qKJElFAxsE6oloVMzgbTvr+gi1rLShzA8e+z2FaDiz+h5d1THSq7j5A163Hezem2
         8dsA==
X-Gm-Message-State: AGRZ1gIcU4lDhOSRMeb+wymVZJC+L9r2nNu99y47nULyV1ChkI5JzIk7
        /p6jA1IDMk+XKrfHR1lT0V2iFQ==
X-Google-Smtp-Source: AJdET5foYkB/VFK8otgR0NpJJDe4K3/l+YZj/g1vST2bUU1MwvjhzQgBYzDtVlnEo7e0p5AAI/7N/A==
X-Received: by 2002:a1c:6483:: with SMTP id y125-v6mr13347866wmb.66.1540825107406;
        Mon, 29 Oct 2018 07:58:27 -0700 (PDT)
Received: from brauner.io ([2a02:8070:8895:9700:6d7a:7ba6:535c:106b])
        by smtp.gmail.com with ESMTPSA id k4-v6sm5209910wro.68.2018.10.29.07.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 07:58:26 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:58:19 +0100
From:   Christian Brauner <christian@brauner.io>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, mcgrof@kernel.org,
        akpm@linux-foundation.org, joe.lawrence@redhat.com,
        longman@redhat.com, linux@dominikbrodowski.net,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH v3 0/2] sysctl: handle overflow for file-max
Message-ID: <20181029145818.4bqmy25itjnqhodg@brauner.io>
References: <20181016223322.16844-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181016223322.16844-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 12:33:20AM +0200, Christian Brauner wrote:
> Hey,
> 
> Here is v3 of this patchset. Changelogs are in the individual commits.
> 
> Currently, when writing
> 
> echo 18446744073709551616 > /proc/sys/fs/file-max
> 
> /proc/sys/fs/file-max will overflow and be set to 0. That quickly
> crashes the system.
> 
> The first version of this patch intended to detect the overflow and cap
> at ULONG_MAX. However, we should not do this and rather return EINVAL on
> overflow. The reasons are:
> - this aligns with other sysctl handlers that simply reject overflows
>   (cf. [1], [2], and a bunch of others)
> - we already do a partial fail on overflow right now
>   Namely, when the TMPBUFLEN is exceeded. So we already reject values
>   such as 184467440737095516160 (21 chars) but accept values such as
>   18446744073709551616 (20 chars) but both are overflows. So we should
>   just always reject 64bit overflows and not special-case this based on
>   the number of chars.
> 
> (This patchset is in reference to https://lkml.org/lkml/2018/10/11/585.)

Just so that we don't forget, can we make sure that this gets picked
into linux-next? :)

Christian

> 
> Thanks!
> Christian
> 
> [1]: fb910c42cceb ("sysctl: check for UINT_MAX before unsigned int min/max")
> [2]: 196851bed522 ("s390/topology: correct topology mode proc handler")
> 
> Christian Brauner (2):
>   sysctl: handle overflow in proc_get_long
>   sysctl: handle overflow for file-max
> 
>  kernel/sysctl.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> -- 
> 2.17.1
> 
