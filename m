Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4C5C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4EC20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:51:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEl5BOVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4EC20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbeI2AQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:16:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51600 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbeI2AQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:16:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id y25-v6so3048127wmi.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=42KdwwpMqYNTGm9woRS/rwgRdRRM69f8qZaQDJg0IhU=;
        b=OEl5BOVLqftw7k0Vz2OR9jFMCPKeatcmvhnXNuUdoKnYs8EwZ5aOaxx83R7l8Qk6hM
         SY3HvUf5BqjEMrs4pDkeW5ZdL0lEBou37NSLWIG7wOT1kloclyWtUojw9rO806UEMIsT
         U+8M+2fManJMyclKT+HMWPaxKytkcUNqEb4xqsNasaHBLBvtcqqLzY+BA5IuzkTS21jF
         yMTTBnFP7y91SxB64p3ME5uhdx0nZ00ijNdAIq2wo1Hh0i9NUt6FG6EwnDdGyWmsiAtX
         x4YvqnRNk5a5IQwaDAAsCsKMEO4Lu4arSFPCDEvl8e7n2Q43cIg4cWyM/JI+PJoweXn5
         giqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=42KdwwpMqYNTGm9woRS/rwgRdRRM69f8qZaQDJg0IhU=;
        b=N/P7nHJAN+0sWsAS/nisfRdFKK0h85tyW2bzw8NXsKuq46Az/Zf40oo0jM6sZ0cyL5
         RLTpZ3PYZrFE3uxXXgjvS5uSIpMYhwClcFgYmneaDP/685+ImGZUhXtpAFcSssvyWvjO
         m7zuksLaMtvf1s9WmJljbxXGrOaYFwbpGHVNZPzr1LPyid1aOu6RLhLOWVCfxUQ7dL/8
         h5iJXilHR63aNN6zeOsL6fVKSYQ6M1SVwbH672rlY4Hze1TJNCNBUit97GHzUOYz/G+h
         VC5yGS7DAj8M0v9DZKU4Ix2o9fks0SLNkb3FA7ctbB4OC4JynSQ+Pq0bTN0S+7dYgMMF
         C0uA==
X-Gm-Message-State: ABuFfogxOvod6eBCZ79LYfHrWKmjbSENUIqfoM/6jNfMAC0R+fJsCVk7
        vKmiReblu192Qz2V3nMTlO72mMbd
X-Google-Smtp-Source: ACcGV63mvz4eO8WJB5hXHj0DsqpBhqyBGLTZf82nrmZwid+7LZtneQPNoHJN2awgSUw02ebRRijg0A==
X-Received: by 2002:a1c:cc0e:: with SMTP id h14-v6mr2318170wmb.2.1538157081462;
        Fri, 28 Sep 2018 10:51:21 -0700 (PDT)
Received: from [10.67.50.87] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id c8sm3611777wrx.92.2018.09.28.10.51.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:51:20 -0700 (PDT)
Subject: Re: [PATCH 0/3] ARM/PSCI: Fix THUMB2_KERNEL entry points
To:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Doug Berger <opendmb@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
References: <20180927192711.26455-1-f.fainelli@gmail.com>
 <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <26239d41-0d58-43fd-89e9-1576c84f89f2@gmail.com>
Date:   Fri, 28 Sep 2018 10:51:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c68b01ab-9077-73cc-8356-25a4e3a909f0@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/28/2018 01:08 AM, Robin Murphy wrote:
> On 2018-09-27 8:27 PM, Florian Fainelli wrote:
>> Hi all,
>>
>> While playing with THUMB2_KERNEL on ARCH_BRCMSTB, several issues came up
>> which are addressed by these 3 patches.
> 
> Hmmm, PSCI looks to explicitly support Thumb entrypoints ("T32 support"
> in section 6.4.3 of DEN0022D), so these changes smell a little of
> papering over a more fundamental problem, which is presumably either
> that Thumb symbols are not being resolved correctly, or that the
> firmware you're using has a bug.

Yes, I clearly missed that during the internal review of our
implementation and missed it again prior to submitting those patches,
shame on me.

The last patch is valid because it addresses a problem on 32-bit only
platforms which do not have a PSCI firmware at that point.

Thanks!
-- 
Florian
