Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9141CC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4388125547
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 07:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="n1EYEYBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4388125547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGBHvO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 03:51:14 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50916 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753868AbeGBHvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 03:51:12 -0400
Received: by mail-wm0-f67.google.com with SMTP id v25-v6so6916323wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=TDWhKJ7OzPZDpUIBDnfRUepl73tfxpTXTMDGA+5dQZg=;
        b=n1EYEYBaYB0gnH7kTR2Zu/CeH0wm/AMh8NJEQwyYGXB5pyDHMkMS+ykHbbUomLk1aR
         lQVLARWmMQDb8Z6/5ghM8rfWaJEKcx0/ZXcLQH/MQgntYex65dY94GAzbFZJ9MlpKFMT
         +n391VmLyWAwlkMWz1nPoZxrCFtrJF9pSG3Q7M1HsGkyZONUwQQ2e2mD/YPG/jSB0At/
         d9BknB2cauR27QLdw/kBNzVTjcIrg5OZ3AH9dOupyanNbHQIxIGawoyIA/azTwIegeoB
         RsGNwh3OZ8czszdRl/FVWCP08YIiQOCewtnQzr/rcVoUoSC1FuBf2GjWZvWssyGTqkMt
         zzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=TDWhKJ7OzPZDpUIBDnfRUepl73tfxpTXTMDGA+5dQZg=;
        b=K2E75i4DftNaNETaVfWeY6WaU7fV7UkijYvqIBvTh752Pn1EX1oz6RHNRbT7DE/Iw8
         lvTnxSDDlSWSFptm/mIKBVN6A0y7RFr43v8axFvHr1b36JyYYnFvRoZUEgTKiC8O60dL
         2/teqCMzK1g29jvhbI0ea5B/tM7r0m3N5X0emg2XWaUpuovwI5ZF7/u/UOqI2++zoFia
         Wsve+NDWxBxRCQAW1HbSHOVEL5jFDfEa2H3h3aUDZVZ6VlhN0+QWVNsHpQnxPYnNQ8pQ
         vp7e+js7a4vO5lgBcuFtJXp1YOtnYDYBMB/lfQAgayVm2IUuxri+cdwvtAX1Ar3iWXI0
         4zug==
X-Gm-Message-State: APt69E2DGqivsCldTBlyJ/GhszLqrq4FYnYyDFYc9+TPknodpgMSDkgc
        LQBM1ONSBRTNeRTREP+zvEpmBDJ7
X-Google-Smtp-Source: AAOMgpfplgiSVDtwzZ1OvrCu/8UMFhYy3SLZkN8vGAO4QZwDq+mRMZwqFpEEtQdDr3YYwU7BK/7f/A==
X-Received: by 2002:a7b:c01a:: with SMTP id c26-v6mr7599717wmb.33.1530517871003;
        Mon, 02 Jul 2018 00:51:11 -0700 (PDT)
Received: from [10.19.49.101] ([217.69.3.142])
        by smtp.gmail.com with ESMTPSA id 137-v6sm10360867wmv.28.2018.07.02.00.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 00:51:10 -0700 (PDT)
Date:   Mon, 02 Jul 2018 13:21:02 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180701153122.365061142@linuxfoundation.org>
References: <20180701153122.365061142@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/85] 3.18.114-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh 'MSF Jarvis' Shandilya <harsh@prjkt.io>
Message-ID: <DB0643AC-9DDD-4BFF-83B0-D717259378E7@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1 July 2018 9:31:18 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundation=
=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E114 release=
=2E
>There are 85 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Tue Jul  3 15:31:04 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E114-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h

Built and compiled with -Werror for the OnePlus3T, no regressions noticed=
=2E Thanks for the update!
