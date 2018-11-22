Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD09C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542B620831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="MRxsYleQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542B620831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404869AbeKVRxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:53:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34192 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKVRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:53:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so1316362pgg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 23:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=yZRILlFTdmw6Tufwqs/nZJ20YkpJK0pn6uUM3Lvn3A8=;
        b=MRxsYleQgfsrKQhATds8p73NZ8iLlMb61fHZrJRb624gLup5Yic/1TwMrJ4wjHu4EP
         eO2QBZFmz0SFBUNYf6B8xVYazGU/BiXpZDJ8doJBhwZ4WthntRvuV8KpGt6U5QI/KMM5
         uMyTlrRBkb3s1xu4qvh/HjMMayO+P7aCbhYOh7SkiXXgARtFASp7lvAiK8m1h1Ub8a1b
         nzx3uCrgM9cZQOuhlfGyr1NQlEMmZyRAe9UhYBBJIJ9l2HgYKk+s49UtmkRUff1PqW2N
         MU1wAV3HHKZgNsA/h7X0KcPAmgS1xbmgqNhmGAblX95f3oJ1LHIhrOI0kn9PQKoVn0JG
         Io1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=yZRILlFTdmw6Tufwqs/nZJ20YkpJK0pn6uUM3Lvn3A8=;
        b=XiF92e/j7T/6bldLo6UN+RBmwBfVtJHznuoeZJpYj9rAdHOGOCOYBKuI2luOapbXgd
         uCW3siHRRf+oC9Vyb8UPmlZ7v0Jb8SxAGsWBD1ZpJqaql2tOM5zVYZF5oK9M5TyT8qYH
         hqfb5cwn+71wehYDdSi33RAGwDfPZfJW5usZ+KOn6VjP1SwofPJNTsXV0hFNvdcPialb
         PnpQ+G/mBQy3/hTIIvIuHBmiPcrKGZJ5r92faKhfCCmEK2aq2ZN49V0oBSzL3oh0Mg3t
         n09IPTxZbKcgsKSZPXAHb84i+TtUYyVkXSdNAuvWdEvZ9gmkGSILeVquCVbBR5UkKJT5
         43cA==
X-Gm-Message-State: AA+aEWYZVOGO5zT15AIXOpOAi5jzrQN+N6ZeY9TDv26uWWNXeE0ZHt6R
        I8edbxlsp7wUwzaouxQf8w0qTQ==
X-Google-Smtp-Source: AFSGD/VXhA0wYgnEz1YrUxtLAX1Op7L/nCDwwVmYC3Ctwzo2QsIV5MaS1py/Oi1j9+BFMAkHFAVgKQ==
X-Received: by 2002:a63:5f95:: with SMTP id t143mr9080260pgb.395.1542870908259;
        Wed, 21 Nov 2018 23:15:08 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.241])
        by smtp.gmail.com with ESMTPSA id s2sm26940931pfa.167.2018.11.21.23.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 23:15:07 -0800 (PST)
Date:   Thu, 22 Nov 2018 12:45:42 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 00/42] 4.19.4-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <5F36AF54-5ADE-47D8-B0F8-01CD0DBAEDDD@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 November 2018 12:35:36 AM IST, Greg Kroah-Hartman <gregkh@linuxfounda=
tion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E4 release=
=2E
>There are 42 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Fri Nov 23 18:31:31 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E4-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E19=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
