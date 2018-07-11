Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B0BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7259620873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 13:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvX1wIYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7259620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbeGKNpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 09:45:13 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:33444 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387825AbeGKNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 09:45:12 -0400
Received: by mail-pf0-f181.google.com with SMTP id b17-v6so18455629pfi.0;
        Wed, 11 Jul 2018 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eaGhTT4G+0IC1HKkkuu/Okdx/aHpwTFdAjjUMAM84RY=;
        b=CvX1wIYIw96gs0QtyT96/5k4QeXOIROAlHP6L+mFIVFTP6YV/VWCSUeep67g5k2Y6r
         t3nTxeh+9yqFlrXr4oH+yXZK79WqCglKkE94uVaXLsVlKvVgFyeboOHrAAY3SCBOJzMg
         pwRfEznMZDlgTAqHXQxzqV8WmHTjhssjuYH/CcBWHG2MmKtfLgpmTAkQyiTYLvnRcavN
         B/IdRT3ry+LkJr9QVAEybZpSbxLDp0pM7qa0xLmkpRDZyfTbSnN1BcG/rOP2s0umORgT
         DienmiYFCCWzhog4G+wm37CVE+yXE96lbT3/8R1sZfwiGhQ3yvk/0h1hSfxbZfwalblZ
         SNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eaGhTT4G+0IC1HKkkuu/Okdx/aHpwTFdAjjUMAM84RY=;
        b=FPx9p+InaIVGjaZzlws2reS0RpGwkNzmyqo+22ELVSMD7Uaj5WYlLq/qnu/EY1GxeT
         7M4TmvCp/COO64+KORxqHKYG+zfXt5ncI8bjBsUipSRgunvew+rVVSk0RQQVvhJBpKtu
         ZHg5qrAsNKeY6Y8+rfNVHb33hz0h/n/ANNbDaZoYpWnudf0ek5r6/18W5FvuvA5F+MNm
         /349jA6wJRFwXeaoSVPALe4XF6Od4nBJMGqZLh8SaW0YYMSIvcZlx7A0OeNd/8RXawes
         Zp6wlqEho/hLWqHHLl/SFTkk8a3KpPCXtkT290Pq6ITlF1KyFqR9T78udMEidG4r2Fg3
         6E6Q==
X-Gm-Message-State: APt69E2PW2SlFmKWoOQ6iiXm9QnzGvyDHchbxroKe0YBxZ80DW07CNKD
        36QIQ/gB/Rpxwr20LzC7TLjH+A==
X-Google-Smtp-Source: AAOMgpdduyuQeAktGs3RHmZLwkKE5YDNhnfJg9fc2X6cLGQe8MQObJ73xVLDYtLJ6Ho8ZFgmw+4OQg==
X-Received: by 2002:a63:555:: with SMTP id 82-v6mr20205339pgf.25.1531316448097;
        Wed, 11 Jul 2018 06:40:48 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id z11-v6sm15452208pff.162.2018.07.11.06.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 06:40:47 -0700 (PDT)
Subject: Re: [PATCH 4.9 00/52] 4.9.112-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180710182449.285532226@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6ebe0e07-7f4f-8375-b13b-f942b6ed4e55@roeck-us.net>
Date:   Wed, 11 Jul 2018 06:40:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180710182449.285532226@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2018 11:24 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.112 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Jul 12 18:24:30 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 148 pass: 148 fail: 0
Qemu test results:
	total: 153 pass: 153 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
