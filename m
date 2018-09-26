Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183DDC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84582082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKDCV5Gx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A84582082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbeIZTm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:42:57 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34076 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728463AbeIZTm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:42:57 -0400
Received: by mail-pl1-f195.google.com with SMTP id f18-v6so1101506plr.1;
        Wed, 26 Sep 2018 06:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JvqSXdRNPRKMH7A3fTFu1L8SXmJxJmKGxE7pLCVlBVI=;
        b=bKDCV5GxaPtuF0GJ+Bpw+W/Uus9H1rYA8ztGeEQYVJ0/TlR8XYWU5L/v1L1FStZpPM
         bVM2tbRO2bBZ5xcaGf2kn4siTy9W/NTVEyFe5NGSzpFFqg2Z4FADRsM9XKhFASIKGN89
         HbCGYEr4yHXyMjilNbA/+6ENLa4vmHqDzfuzqo5p/mcGEXtdTCPzOAPp9jl0NhoOpET3
         XmJOmN3jNmL2jgiEbh4jwqr3dDBNh51BVhYKeE5sZ6Q1Cl0orGgj0FG7Gr7FhAcwqnP3
         rbwth9/pCMAG25VJLaqy2bEaesYxlZo8rbn35j4fxJfCPRp348zlXQO+pKAUJWACjugh
         VP+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JvqSXdRNPRKMH7A3fTFu1L8SXmJxJmKGxE7pLCVlBVI=;
        b=cU8OHV25mBuFh5Mfawt3+wpTcUXL9qWMoBZt18Zqi8aZKQ0qdiJMMWWBCYjxE1B0Ai
         IQ53g8GRLHyctvnm2MEldnuC2SPbf2ntjRrQFw5+0h3RK3EanwJMMCMcVR3Fkpa4HGmW
         wPQWVuZlNsYQra1akqje+U8tulE0+Kx3jhCcLw94oG0v0imByFFmT84ow1JQG+n18PPS
         zD/6oBQ001AeQXwjz1TFE3SGeVCAWYYKHCzbHFcVE2z1F7r9ZB7PCjcYoKH2EndlnxVk
         HJKQdA/TS41t2NWFrXkhNUThLEA9G6GmJGqmnFy1R2VzghTW80zAhm9Dqh0BX49/DP4G
         F7oQ==
X-Gm-Message-State: ABuFfoicJgQPd3mMgwSxQjWq8nHHgTGTDMRs7n9F2ZZAeLbG89gGaMeJ
        M1TS0lku8u3ya7qkd0wGqUgoItYn
X-Google-Smtp-Source: ACcGV61dUyMeN/E4ifFuYSNniy715WwS8AwILog3UKjigwEddEFyC6Wq4GELwZQv3v7QbEiJMW4MVQ==
X-Received: by 2002:a17:902:3fa5:: with SMTP id a34-v6mr6247424pld.244.1537968597638;
        Wed, 26 Sep 2018 06:29:57 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id 26-v6sm7931839pfs.168.2018.09.26.06.29.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 06:29:56 -0700 (PDT)
Subject: Re: [PATCH] parisc: Remove PTE load and fault check from L2_ptep
 macro
To:     John David Anglin <dave.anglin@bell.net>
Cc:     jejb@parisc-linux.org, Helge Deller <deller@gmx.de>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180926032101.GA2458@roeck-us.net>
 <dcb9250d-f811-90be-2c5a-4d15cb29b474@bell.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4ac3d6fe-ef61-546d-e9fa-c8189edd288a@roeck-us.net>
Date:   Wed, 26 Sep 2018 06:29:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dcb9250d-f811-90be-2c5a-4d15cb29b474@bell.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/26/2018 05:09 AM, John David Anglin wrote:
> Hi,
> 
> On 2018-09-25 11:21 PM, Guenter Roeck wrote:
>> This patch causes my parisc qemu tests to fail.
>> Unfortunately I don't have any useful log output; the failure
>> is silent. Reverting the patch fixes the problem.
> Can you be more specific on how to run these tests?
> 
> Dave
> 

Sorry. Please see

https://github.com/groeck/linux-build-test/tree/master/rootfs/parisc

My tests enable a number of device and debug options on top of defconfig.
Those are not necessary, though. The problem can be reproduced with defconfig.

With the initrd available from there, and with an image built using 'defconfig',
run

qemu-system-hppa \
	-kernel vmlinux -no-reboot \
	-initrd rootfs.cpio.gz \
	-append 'rdinit=/sbin/init console=ttyS0,115200' \
	-nographic -monitor null

I tested with qemu 2.12 and 3.0. Using "arch/parisc/boot/bzImage" as kernel
image does not make a difference.

Note: The initrd auto-reboots. To avoid that, add "noreboot" as additional
command line option.

Hope this helps,

Guenter
