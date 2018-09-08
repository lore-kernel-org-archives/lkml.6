Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F07C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 143DC206BB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hEb9qAxZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 143DC206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIICDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:03:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45895 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbeIICDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:03:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id i26-v6so8594867pfo.12;
        Sat, 08 Sep 2018 14:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CIP0/SlowHLLiJPXb/bIom3vnMgxOpXOVvQGdV6XeEo=;
        b=hEb9qAxZxLdQRIZTXl6oEPZlpnB7kUI46U18lMvjyRFLfVIEaMB0+BJnW3duvapspz
         PJ6HwHDkY/0+889lWjQaIxwJZ0uX/JCFdUoDioGkDgJlig9ImWv4hJ/3RzODApSUs/wK
         jshJn5D042eHRWAO2wz/c7BmTCtB9yG6VCTZpCNwC5jRbHbbj1a8fnQ63/tZsP/o00ja
         KEq7H7Ua0MT+a2+UB5PHCpUmDqb2wKed2FEmny5HIOGqZLTLH+6asLUSqNevbuqm6GBi
         7g5IFGBMzKdW6C344GQKaR34bPsVMvCUh3AnZczya8J26Zm6jLiclKH96N6GuuDnD41l
         ZtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CIP0/SlowHLLiJPXb/bIom3vnMgxOpXOVvQGdV6XeEo=;
        b=f9yaSoLBpAoyzOGl7uR35hA3JvYveGr9YbBboibTaBoyQiQpkbjZr7S5M7xxEISGWk
         de35iEJrAfi/Bf8AwOhOWnqmus4gpo/Xjdg2sBTTYjkmV2yTr+qy7JK+0XiohRufBkq2
         hjmj0MU2WNPzDV5dleBepQs6GAIgp1nB8FQfcylZpksuOTWSnoEHp2PRzdYYyB+N3sj/
         Opss4QW2EpdLujhpnJCKOQNQgyZpFPB/Uvb35q1yqGa6QAxM5/AS4/5ubvQAnBot8lzp
         He9PEOlWIxTr1dH+NRqE3XsYMUFvaN0uiiQY5CyviPH2vGbXX4nrqf2GuWnM7zFPV4Qt
         tnYA==
X-Gm-Message-State: APzg51DbzDW4iAjIBwYdWQC2xOiwu6WeNtqzQUFJE3pMuakBbAN0Elpz
        xIsDW1lI4Dvr3dSEFk5SexGSMv/h
X-Google-Smtp-Source: ANB0VdY0ag16eS1V2Vi4VwM/XJIStgyebMQd+AYIhxUkcWCFuP4/E5IEce10Z/8K/TqypxC0VMPLCg==
X-Received: by 2002:a63:a40a:: with SMTP id c10-v6mr14845352pgf.346.1536441364251;
        Sat, 08 Sep 2018 14:16:04 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d132-v6sm15477214pgc.93.2018.09.08.14.16.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:16:03 -0700 (PDT)
Subject: Re: [PATCH 4.14 00/89] 4.14.69-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180907210852.341064285@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7cfd62d8-e287-aff0-3e9e-2b59d7db42c7@roeck-us.net>
Date:   Sat, 8 Sep 2018 14:16:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907210852.341064285@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2018 02:08 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.69 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Sep  9 21:08:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 151 pass: 149 fail: 2
Failed builds:
	powerpc:defconfig
	powerpc:allmodconfig
Qemu test results:
	total: 311 pass: 293 fail: 18
Failed tests:
	powerpc:mac99:ppc64_book3s_defconfig:nosmp:initrd
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:initrd
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:ide:rootfs
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:mmc:rootfs
	powerpc:mac99:ppc64_book3s_defconfig:smp:cpu4:scsi[DC395]:rootfs
	powerpc:pseries:pseries_defconfig:initrd
	powerpc:pseries:pseries_defconfig:scsi:rootfs
	powerpc:pseries:pseries_defconfig:mmc:rootfs
	powerpc:pseries:pseries_defconfig:nvme:rootfs
	powerpc:pseries:pseries_defconfig:sata-sii3112:rootfs
	powerpc:pseries:pseries_defconfig:little:initrd
	powerpc:pseries:pseries_defconfig:little:scsi:rootfs
	powerpc:pseries:pseries_defconfig:little:sata-sii3112:rootfs
	powerpc:pseries:pseries_defconfig:little:scsi[MEGASAS]:rootfs
	powerpc:pseries:pseries_defconfig:little:scsi[FUSION]:rootfs
	powerpc:pseries:pseries_defconfig:little:mmc:rootfs
	powerpc:pseries:pseries_defconfig:little:nvme:rootfs
	powerpc:powernv:powernv_defconfig:initrd

Details are available at https://kerneltests.org/builders/.

Guenter
