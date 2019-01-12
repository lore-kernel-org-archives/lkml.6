Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EB2C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3870520835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="Fk8Czw+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfALO4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 09:56:15 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34131 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfALO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 09:56:14 -0500
Received: by mail-pf1-f196.google.com with SMTP id h3so8329580pfg.1
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 06:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eyV7SQKmrxzGGG0u1KoMEdO2cjhPJxwVO5YOheLgnrc=;
        b=Fk8Czw+3fYtwV4eQ01fYt/PYKzLz8OJmqa8wm9ikG1Y50uI4wsyAWR187lc6W2AoSL
         txK4Lrj1RtnYOEx0xtTzyj4z9j1rDmTSNWmR1wn9GUHV/aEIKFXgaeiDy6/9MY7WeHGU
         XkYyp3aHLrpkUmAC32auveE3FVZYTd5W9kcB7l1YHIUEqhQzEXw2pmSa2rB4WvpXPScM
         gkFOBgp2NlkZW+WrEPEHTkWyKpO+vaqNQGhxKSCVpo6K+uxu/JQg2U2miIgr4iWaBIBw
         scKTYOQpIFntJHXIZ3yV0/rOUSkBAZ/3u3CICeDTRhO9hT4dkoaF6grSxYN6pejmUItw
         9ajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eyV7SQKmrxzGGG0u1KoMEdO2cjhPJxwVO5YOheLgnrc=;
        b=V8g3XDpJVkiCO2kKK0NQjBVEqx6hhI71T3W0SRWfoaMTwg9e7jp4a7kGZr0++zNwLg
         k7RqHU4IWgHp02XENRfV8sGX9pDKCy6jLyE/P8HNx5ss6SJejJ2rlui0bBWNTemJRCaZ
         EDKHi2QeFBJmsoFjc1q+y3uVxYSZUfzv7r/K4XurLS+G3ATAMgdwtUiUGCkVbU4HCUTb
         CbfM31b7jkXJc4SukenWVR/Aw+yxW+QXYHBoiiBq6ZrBnsDfjdXiJT8jAT/4KuLY+aFt
         1RtYDULBkoW5NxyIo+1oBW2dYw+0Z8tsSnxYd9Vy12Kl9UDoLb5JgRxjUl2I/bki3oaD
         RCRw==
X-Gm-Message-State: AJcUukcBn7OGFTgiMZUN53syJAiWNoGaZRm7Ud/S8MrnA8XTiJ65zKni
        TzCvJv/2UuaIAOHCR3rtIaTMsA==
X-Google-Smtp-Source: ALg8bN7zhovAUTcAwuSpaBGEzCKRM8ubnGIHpyxZ1XSOK1OsiynclPpqx2kKQfz5HY4dukUrvFL4FA==
X-Received: by 2002:a63:fe48:: with SMTP id x8mr17314979pgj.261.1547304972810;
        Sat, 12 Jan 2019 06:56:12 -0800 (PST)
Received: from [192.168.0.101] ([103.57.87.77])
        by smtp.gmail.com with ESMTPSA id m20sm102285797pgb.56.2019.01.12.06.56.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 12 Jan 2019 06:56:12 -0800 (PST)
Date:   Sat, 12 Jan 2019 20:27:35 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20190111131045.137499039@linuxfoundation.org>
References: <20190111131045.137499039@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.4 00/88] 4.4.170-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <D6A3D633-A92E-4124-BC4D-58EF011B81DD@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 January 2019 7:37:29 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundati=
on=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E4=2E170 release=
=2E
>There are 88 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Sun Jan 13 13:09:58 UTC 2019=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E4=2E170-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E4=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Built and booted on the Pixel 2, no userspace or dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
