Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 862B4C43612
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57D962084C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzlBYSeS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfALRm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:42:57 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34837 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfALRm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:42:57 -0500
Received: by mail-pl1-f193.google.com with SMTP id p8so8222395plo.2;
        Sat, 12 Jan 2019 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xMtqqZVv9EQeQyMqpw1w3SpiZFT775suFHESHtuzK8s=;
        b=EzlBYSeSRsbqTdVvHuwDhwkmF795RvZ4HSQ+P2p6/aWo5Gn/w4ZrElBHxj5TrCqvoq
         W7cI/38F7s5jiAnps3k39q9VgdjdGca3JowNziocFrZIVWGXHd5n5M0SIukWEhDeaNC6
         R5csGOnhpCUpeItpwyj4O3urjH0cDoS8uQkdOYcJBcniQFhp9B14ST1pmVEWf6ujIPzA
         4XaMG25CiML72NgjSQS+YIvjYJgt7XeEkGHTttkl8yQxtqGkJFzPG0QjvwRo3Z56EE1X
         NoauP55pBNoMpicaCqcBe+PRSCcj+v6ByPWV0510iyOB6SAo9JquL7vW4xkS1jbCfrbi
         2/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xMtqqZVv9EQeQyMqpw1w3SpiZFT775suFHESHtuzK8s=;
        b=YLFQacQZ5qyKYRGvKaBNSqGT5T5ZtaE+NOVlxxuOoQDZsvs29/paDocfORiLw7BrRL
         jMYgYU1oaMZPAz91li09qYVN9sqjEsdYhxiFrDhCt4kDBvmdE5E7O+ntEZWwItTEXLUJ
         WijpnC59zHpdr2Gyf6+o98/QPDsaqcGA76AaswRH1gSl8/2y5lQ67yED3isAc/dvcirM
         5yBrjGa1szPA5vNgE3lderLeJKF4Gw2BdV7i9m0QMiwR/Mv8dz609bbt809Ze1DtwCqr
         RvG7fuL1doFTaeU+tApidLq8h1oLt2u/iTrbEiHTggQAqKzho/vYQ+H6Xs6A3ZeTdvHZ
         XQeg==
X-Gm-Message-State: AJcUukflI5ObLtl1gBPA0MNejcQ+eP8lKlLYSI40lDNKkXf45CUyoOcL
        KVmCnzXhN9bxTAC7oSGwxdPw2wc9
X-Google-Smtp-Source: ALg8bN4V4WC09MLNmDFCrfX4i+evHG0ORYZXaW5tjQAr3cuABw0qcDjODA3NiQlLDvyHJSSFzZnWNw==
X-Received: by 2002:a17:902:f091:: with SMTP id go17mr19747952plb.235.1547314975361;
        Sat, 12 Jan 2019 09:42:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v184sm113288441pfb.182.2019.01.12.09.42.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 09:42:54 -0800 (PST)
Subject: Re: [PATCH 4.4 00/88] 4.4.170-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20190111131045.137499039@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <a18fa311-274d-a5c7-1709-2d8a442bed87@roeck-us.net>
Date:   Sat, 12 Jan 2019 09:42:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/19 6:07 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.170 release.
> There are 88 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Jan 13 13:09:58 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 171 pass: 171 fail: 0
Qemu test results:
	total: 281 pass: 281 fail: 0

Guenter

