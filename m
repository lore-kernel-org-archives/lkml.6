Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985E4C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6667C21726
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 11:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="ZKzP1tV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbeLOLP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 06:15:56 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40412 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730074AbeLOLP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 06:15:56 -0500
Received: by mail-pg1-f193.google.com with SMTP id z10so3893662pgp.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Dec 2018 03:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=FLmOHc4e2ue+O9vUt6KDjy5RB+dn4ljFqcCLTcWmM6E=;
        b=ZKzP1tV0O1E0BKAxYUd1FLOwwM0yRJ4NUgf0hzmGPsW6zA8FzN9Yix309cfJvypAXg
         P3enODSJVfk0nXXcpPYIn1m5kNrOqaUd8YKpZt2lb3j/Xd8swghDXjHxKBSArEtCsyzE
         8iV53MU95c3sDA48OtUe4xaHvmwz7iLXLLMQHvCJp7w+uBuNMuUDvu7R0Cy9QQ7ZGg4Y
         CwVLQkPuRte0PEv12HynaONsRyQ9H/a34zItK31dA5az9leAwADuLs9IDEnIfyWwdfAg
         KIK52keqlV3kjvnhNyYLjRRgihk1mltp4VdVqftz6qbp//u4a6Uflf3m4nffr3K+IPjc
         v6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=FLmOHc4e2ue+O9vUt6KDjy5RB+dn4ljFqcCLTcWmM6E=;
        b=o38nf5SbUHtjVNIf7SIojfoXsvyDz2kxMdL3UwWXV33FuJx2QktzKRJBX7c8ulhPMR
         lzk8sy7nxF3NQCwq2VJuaPKucFVWyQBZTZRNNJbeE+0LKDisEuK9LPYfAU7t3yfX/ft2
         WZdkPYy8VrbWn5K5gAlcjbfklj/ReVcXmK9i9mXRltVqghDGdUgdyqONQ+8gE+kPEF0Y
         eGdm6GvXDkn4vvfrUGUV5sM6IdbyZ4IBL8ND649lXxZ5RKm5n7go4Bibh9ipN04jaWRd
         K/ua95u/ZLtSUN85DCn/fQmqrRBnbb3RJ5aSOhHeZIGBZS1FhWceshGaSNnpwJAD16w9
         Y4Xw==
X-Gm-Message-State: AA+aEWal07ZEXxSRQEjIiKiP6JAxG3TcO/J0e0JmaMfdbz+bY16dPhpg
        1W7bQWtENwGnE2cAJg8OM7xfKA==
X-Google-Smtp-Source: AFSGD/XxqwMKume44eUWpF3RlNd7V8jnGPpA6wcoZnNsWRhNLuI+6D/x6usk3ddC5XjythsFE1bCZA==
X-Received: by 2002:a62:7687:: with SMTP id r129mr6067803pfc.17.1544872555539;
        Sat, 15 Dec 2018 03:15:55 -0800 (PST)
Received: from [192.168.0.102] ([160.202.36.248])
        by smtp.gmail.com with ESMTPSA id x27sm17211304pfe.178.2018.12.15.03.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Dec 2018 03:15:54 -0800 (PST)
Date:   Sat, 15 Dec 2018 16:46:52 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/142] 4.19.10-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <2EC51071-B0CC-4779-BF21-7791733838F1@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 December 2018 5:28:05 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E10 release=
=2E
>There are 142 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Dec 16 11:57:12 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E10-rc1=2Egz
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
