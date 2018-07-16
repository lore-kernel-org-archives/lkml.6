Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CC2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82D2620BED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 16:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBax5wc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82D2620BED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeGPQxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 12:53:49 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43381 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbeGPQxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 12:53:49 -0400
Received: by mail-pl0-f67.google.com with SMTP id o7-v6so5101760plk.10;
        Mon, 16 Jul 2018 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tIH/OIuk1gH/DNPJ/GL+K4f11Wpytc1jtWXhMnA+QeI=;
        b=RBax5wc3W7/l6y0Vqb44PLzGBN7R17Mg4DpnYTr5g23m0r1bNoAO4iSKJkMTIj5G/o
         A2LKTmCGjGu8Lyuq1PbXjfujst6ajZPhrZl+c3FJ4k0246BL/7aNn8ZWbcAGmVa8vYGH
         ua5BtiJOEHbLSKv6dSFWl+PCEQiCSk76J6aMtm9NNv8ybIjlzE3kYMJH+BQ5V/coLvHt
         ZSRVo91slqhvbQAjj+xuN6qQKnkWPX3s4kdP4EIdpZ7SjXTD96d7kPJ3FeYP4/C9Q5Ov
         adwLsNoj9AP2S4fayoi9C8LtxnOVPWzyF1YsvbqvNH5A7gnYkl2EOZ3Hwr4PMEqosBck
         PNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tIH/OIuk1gH/DNPJ/GL+K4f11Wpytc1jtWXhMnA+QeI=;
        b=i85qpUVRLbrzuTthCmI6IhodHy5UnxGevT/45+cFg7bC07+cUjPiGZrVOr0HDvXsqw
         DjyLTjUD8gV9VTDLkxPvCuqZF9YQTUUNYDCBBhLjkM4Ycwi7jNrIj1hA6i1HnnmI6ZJz
         JRALsjMKuKxh2oYWZlUJeDLbrRpG2Dvw1u+R+aJfvHd0fkJp5YrU7xrt34kK9cTeDnFf
         6D9Z+SFWkcSZqmr+1fNHDLD6E5lgsOvvx+mvI8Z/XjI0hbNJlh61ofec4KhGj3X0DpkC
         kcWnv12NxD/rP8en11WOuqhuHp54Hwzm/paMq36wUXdcQVm9K6/GmmhKs8AvcbIAS0SN
         +Mxw==
X-Gm-Message-State: AOUpUlEbhPlcJ61OxXXInJ4l6/ZU30+0dwl5ZnZjnrsxEUdMhGXalbg4
        O9kXtj6ASK5AfR6JlrxlmWM=
X-Google-Smtp-Source: AAOMgpf9RqpMS3H8Mx0ifuHGbikZwMh7fjMaG6cBAlC7ImWpfB0UD3CQUynvDUVnvAAiHERsg3bkpg==
X-Received: by 2002:a17:902:381:: with SMTP id d1-v6mr17310360pld.309.1531758340226;
        Mon, 16 Jul 2018 09:25:40 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z90-v6sm49090116pfk.85.2018.07.16.09.25.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 09:25:39 -0700 (PDT)
Date:   Mon, 16 Jul 2018 09:25:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/32] 4.9.113-stable review
Message-ID: <20180716162538.GB12065@roeck-us.net>
References: <20180716073504.433996952@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716073504.433996952@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 09:36:08AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.113 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Jul 18 07:34:43 UTC 2018.
> Anything received after that time might be too late.
>

Build results:
	total: 148 pass: 133 fail: 15
Failed builds: 
	mips:defconfig 
	mips:allnoconfig 
	mips:defconfig 
	mips:allmodconfig 
	mips:allnoconfig 
	mips:bcm47xx_defconfig 
	mips:bcm63xx_defconfig 
	mips:nlm_xlp_defconfig 
	mips:ath79_defconfig 
	mips:ar7_defconfig 
	mips:e55_defconfig 
	mips:cavium_octeon_defconfig 
	mips:malta_defconfig 
	mips:rt305x_defconfig 
	mips:defconfig 
Qemu test results:
	total: 166 pass: 154 fail: 12
Failed tests: 
	mips:malta_defconfig:nosmp 
	mips:malta_defconfig:smp 
	mips64:malta_defconfig:nosmp 
	mips64:malta_defconfig:smp 
	mipsel:24Kf:malta_defconfig:nosmp:initrd 
	mipsel:24Kf:malta_defconfig:smp:initrd 
	mipsel:24Kf:malta_defconfig:smp:rootfs 
	mipsel:mips32r6-generic:malta_32r6_defconfig:smp:rootfs 
	mipsel64:malta_defconfig:nosmp:rootfs 
	mipsel64:malta_defconfig:smp:initrd 
	mipsel64:malta_defconfig:smp:rootfs 
	mipsel64:fuloong2e_defconfig:fulong2e:rootfs

Error is always the same.

arch/mips/kernel/process.c:637:8:
	error: 'call_single_data_t' undeclared here (not in a function)
arch/mips/kernel/process.c: In function 'raise_backtrace':
/opt/buildbot/slave/stable-queue-4.9/build/arch/mips/kernel/process.c:648:22:
	error: 'csd' undeclared (first use in this function)

Details are available at http://kerneltests.org/builders.

Guenter
