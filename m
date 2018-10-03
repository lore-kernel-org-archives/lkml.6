Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74796C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393FA20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqyEryVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393FA20684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbeJCTra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:47:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37642 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbeJCTr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:47:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id az3-v6so3452835plb.4;
        Wed, 03 Oct 2018 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4zZewjPPnz7lbwdmMGVA1+HDdhhAq8XWc+YcbPVVwKU=;
        b=CqyEryVxFhWmVbvtRD90WlcxcxWiIccKBdmIAt616ZGsZPy3k5t3YCOtoXeM1T15lx
         KxAAFYMTHj5TGbQgyoEsOyN/kmrNZFzFKP53MffnrIloS3ijkP5/FcUZkmbVcGGM89PG
         SFYqoD7Mdpfok3h3Qji4T2D2o48bbrbgifI+1VyvWWXPpvqBreGRqJz9CcmdRW0ttNAa
         Ok4MBsyH0apTiba8B19TH3Nuav93spgoBuMrAWHwZgvrsnEPdpEEdvsF5YDjJmCSsIV9
         /07wpx0+n5BG1wXW7stRDarb7KDkCyWNQ7vrbqczLZkQvE2IGrZnA6awLGQYnb6H+FHs
         slCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4zZewjPPnz7lbwdmMGVA1+HDdhhAq8XWc+YcbPVVwKU=;
        b=bFTvbv8J7IhB4y791AbYqv0lh85cAXJEyJWjTUxV33GpipBpJSmtxLxqjBtqzKsrI9
         U2PzpTFNd0CR3WuSVAMJEw3ZAYY8klq+/Hg4vwjuwo4dLXt5odUhM5mXZuFFm+cw0h/V
         8OdhUwgKnG4vKgEPmrOu19UUcEgeuzDhEetWumv4TPDIgGW0ukVSjrmhJ2kXIa7Gm64j
         dKoYbWEHh6Y1M+d2XFpaxlW0k4qgjAX4MOC3ZNSjdzjMd5uuvtahTBpIFq4FKlH1Wvsi
         ema+ZZObNfd9K+SXIFmbxKYk+PHg5Y6ObRYVkkou/WM9GBZ/PPAtADkC2smz9Brnc+DR
         eXuw==
X-Gm-Message-State: ABuFfojY5enbuK11+qUWVQRAno2xnm95zo/refuMMALhn11m1rmTdojy
        /zjaG2Gu42mmavRikt/RcF+UoyEl
X-Google-Smtp-Source: ACcGV614D2CotQQqw4iLR8i1FbbyDR8PUKj3yiZCv3BYg8cgdtZHGLmTdIpFp64gtsILtvHm4JukAA==
X-Received: by 2002:a17:902:8648:: with SMTP id y8-v6mr1540357plt.335.1538571551845;
        Wed, 03 Oct 2018 05:59:11 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 62-v6sm2156522pgc.58.2018.10.03.05.59.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 05:59:11 -0700 (PDT)
Subject: Re: [PATCH 4.18 000/228] 4.18.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20181002132459.032960735@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af80bbc1-6753-01d2-1ecb-830720b38f48@roeck-us.net>
Date:   Wed, 3 Oct 2018 05:59:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181002132459.032960735@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2018 06:21 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.18.12 release.
> There are 228 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Oct  4 13:24:08 UTC 2018.
> Anything received after that time might be too late.
> 



Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 321 pass: 320 fail: 1
Failed tests:
	powerpc:g3beige:ppc_book3s_defconfig:nosmp:ide:rootfs

Details are available at https://kerneltests.org/builders/.

Guenter
