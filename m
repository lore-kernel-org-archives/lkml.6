Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9C0ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E5C21479
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpeUwOgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44E5C21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbeJRDQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:16:50 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46379 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbeJRDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:16:49 -0400
Received: by mail-pl1-f195.google.com with SMTP id v5-v6so13138326plz.13;
        Wed, 17 Oct 2018 12:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qro4JXhl7M+1/UbGa0rbA2aOSwEaGQCySDRyfhk0kHQ=;
        b=fpeUwOgv0vunUyGLwW03JdTioMCXGP14bBYmPiXX5GSdtUeP1KSeuKHsaZRipUFjwg
         6bAfcTpcPbLYK3FHSoGVeN6ltdOW0+jTGDs64XtwI42hVvo2lhGFjLdCvBOM2BfFIMc9
         /cvYDVMetD6Wd4w28KX+FLZeYpGhUqgb9V3Bp5dCAhowWMcU924un5WZthFvvRi089uo
         CoKEsgoJIMj3ZQpP+mYoWQA7QZ5HhmVT1W3M4FnvCsNkDySGCNC0eL8TbV0LkWygFqUe
         YIHpkNHMeVToqrSR9ZzIGUTfeqCbJ9EBKwfrPGq4MrGL3JN+sojTnpeGDScPWEUUxkqL
         utEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qro4JXhl7M+1/UbGa0rbA2aOSwEaGQCySDRyfhk0kHQ=;
        b=TJhJCoLnjySahno0Iemy85ZY1p5nHrVHQPwBvSlXYB/sL6caG8xFqXmKALmnzd5jpg
         CBm7OA/sn4Mbard8y5twl3PkeYbXxAZ8Q/P+Fypi+qCj5JeJGfoB0Dfd1035kRpMsl5U
         M8n4LBiRsnGU3yNykgVMlm0i7y04AhRjT+5rOVNqijZ/HBBFE0oj0EbtanqnnaY1tmLG
         BJsVk6BGjK1tnVrJMmPoumOEE0ivUZ3XzqZQE9ZR4G7lSZ0bCXf4b/hoUuuTN3xVwRyS
         ACuUxvzOtfceCpB6Jq8ir9ei5LVM4irst9WufNTZ+XPkz2oiRzoNQD8r48YrWjrnd8Jy
         MH8w==
X-Gm-Message-State: ABuFfohyzzgc8WT0fvqVXXE1rbGYSk9KHlkS6ZS16sLiQD+F4nm6rpj/
        luBMjKiXO1PLHEksG6lf9MMJpAFL
X-Google-Smtp-Source: ACcGV62ZZGLYikiLpPEqjz+h9iFPEyxN8ARBvHSv16l/xR6H2AQ8jw50oDAIvOlOm62uzK9NnMehCQ==
X-Received: by 2002:a17:902:34a:: with SMTP id 68-v6mr26970962pld.39.1539803982388;
        Wed, 17 Oct 2018 12:19:42 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id f193-v6sm25841315pfc.74.2018.10.17.12.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 12:19:41 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:19:39 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/71] 4.9.134-stable review
Message-ID: <20181017191939.GA1653@roeck-us.net>
References: <20181016170539.315587743@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 07:08:57PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.134 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct 18 17:05:18 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.133-70-gbc300460e99d:

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 308 pass: 308 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
