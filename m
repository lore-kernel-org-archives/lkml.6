Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F7C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E43A20673
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="ORim/JXa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E43A20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbeK3Iz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:55:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38174 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeK3Iz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:55:27 -0500
Received: by mail-pf1-f196.google.com with SMTP id q1so1687865pfi.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 13:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=uPLwWQJYsPNw8dQ46AfWR4Yi4qSyUhMB+AUQbsh9RD8=;
        b=ORim/JXax6XoltDycPlCT530SJKUPO31omgLlBjg8ZLktI4msuPf2f2Q6K3OIOvx1g
         O0GlQJtx5nioYmstJYUUu7rSd8pA5kpRvEyloqZe+aqmqMsUdxwOSOKFcpGw3/Q9y9kY
         MfEYoNw/Vlq79McPPQa/AmTweo2KxOYS1jtc/GOrKFvO4JBkeNtqTpe+8kwlN60w3RBS
         XVz3P18oxF194ucyIDojl8zWDWhrJbRwn1AAmbpwpbKaVM+VActAcFTzc1R0KQncrOeu
         M0AGUHUYYSF52sXmimTTifAdffqqRmDqMl9Ls6pGRKr3viwpz/3PUVacFXnfUanxdOqp
         KRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=uPLwWQJYsPNw8dQ46AfWR4Yi4qSyUhMB+AUQbsh9RD8=;
        b=qmORMytXMQJFX19xQem1SlAlzB26xCLqu4uy/QCMJEZ5SlgIR04NFzqrjHsFkxEmB2
         jeK0dgyF9T4ZnfnHEC6EOzSQku9IWYorb6iBAMr/MyX949UaEnD3Q55THY7brPgSlY9n
         M/7LMQnvqqhmS/o90oIjo3ly4w4Dsn5TMEKT2dC0QRNjJpFxQwoU74WrvyO8I8L3ufMg
         CK+2UlIKAs4eKYnC9RvAmcK74InVsCbCIbIpcfp4N1CNoPbgXKbZWK2M2+23QOHTjHb5
         KUn6cdbZhJgMZSeb8ly2XOHC/fzJYvLMfiLwInHY4xbyy9usgxDdAYnt1DemZ2pVABhp
         nuGA==
X-Gm-Message-State: AA+aEWbyKtjS+JHooz77vGzAfs2voZE2NfthFfdQx6DCz+fLZp8dsa6d
        ZhxrFW4i8Ipawqc/TKnFq9QU21T4d/TaCQ==
X-Google-Smtp-Source: AFSGD/VPHwvHF8WwOTK7AdS7T6BzC7L3Ilw9st6gxoVYTgjbEovjOK3BLnRMq9mWZFNQajopRwaVpg==
X-Received: by 2002:a62:60c5:: with SMTP id u188mr3087011pfb.4.1543528116238;
        Thu, 29 Nov 2018 13:48:36 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.44])
        by smtp.gmail.com with ESMTPSA id q35sm3700970pgk.12.2018.11.29.13.48.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 13:48:35 -0800 (PST)
Date:   Fri, 30 Nov 2018 03:19:14 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181129140138.002176596@linuxfoundation.org>
References: <20181129140138.002176596@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/83] 3.18.128-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <78ABE877-831E-4236-87EE-3ACC52BF5195@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 November 2018 7:41:18 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E128 release=
=2E
>There are 83 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sat Dec  1 14:01:23 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E128-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the OnePlus 3T, no immediate regressions noticed=2E
--=20
Harsh Shandilya
PRJKT Development LLC
