Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD88C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F79B2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="OwF/Hp/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F79B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeLLTOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:14:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35852 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbeLLTOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:14:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so9330654pfc.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 11:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=TvQgmhzR+Ge1fgeY2+CjzJjCJemhpLEAIgjg0W13KNs=;
        b=OwF/Hp/B0kcwjF+DC2BuD6Lf2qv3PP9kx5hEj1n/ENVCfFZL+du1qxPnx8qGMl/U2m
         JqShC8Wds+BFuyr7uVl/2+lmNz9HzZ4UMoxiQroyX3JvjoxqYku80SZrh4lB/1ylnEWg
         jUmf7fjROTQ3y81J/yJ/N0yTEzyd0zo0FDPvR0TlQtqW+GosXFojAuGnVYbaIVUkVBhy
         rD97/wTmsqwoG8BczIVdkH3NEDATtwErdeJyPujOPivcNooBu6rzDBUomJl6VgO/UT+4
         N9xh34QAn43Nn2l4oeatG5EvuvgQ+j/4ApjM1Yr6Vrsv9JEpZuD36P6dGml/ILHHntfG
         a5NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=TvQgmhzR+Ge1fgeY2+CjzJjCJemhpLEAIgjg0W13KNs=;
        b=evgPRmIv7bHWG/5yNaP9JghvYzJjHvkw33PTRxww4Fy+LA0QjCzOWR0epmiExXtwXN
         pgXRqgPi2ZRi5yeV7oCnsQKQ1qxm3gxwDqUnCcMGiuCM4GEA4hQANAmTVxsjXcPKBP3A
         NCay20xBVRw1EDmmNcobhY9uGgJuz3370z9pKS6GuJlnmFBWpUWbnfJPgxEFK6MMxjpK
         9nDzcDQjzPef/isx+WGRNJebAbm2FDAemkI31LalKzvFUbh10w3k7MAkZQlnoQqlOZU/
         BxnFsMBTY5IZ7w2/cxmNaYhkvJtcLWG4FyTyytjyqtgszHblBYQ74qXcjnp8BHAEu3CW
         vVFg==
X-Gm-Message-State: AA+aEWZpS8ZZCaQikFVuDQdFQSAUqU061gHSr/WJNh6QQfELD0yRPFEi
        jB8A/xdkdsBsOC9mJE3a71hrNg==
X-Google-Smtp-Source: AFSGD/XGD7pj3oWeouasmEgXYUwjus4C3GsORz49C4Rwx2RY/o047CqUnOhDz/CCevNhIwzgLDMXgg==
X-Received: by 2002:a63:c0f:: with SMTP id b15mr19529889pgl.314.1544642045814;
        Wed, 12 Dec 2018 11:14:05 -0800 (PST)
Received: from [192.168.0.102] ([160.202.36.248])
        by smtp.gmail.com with ESMTPSA id 128sm24729481pfu.129.2018.12.12.11.14.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 11:14:05 -0800 (PST)
Date:   Thu, 13 Dec 2018 00:45:00 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.4 00/91] 4.4.167-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <72595ECB-5595-4311-B23A-8B0DE6315B1C@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 December 2018 9:10:19 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E4=2E167 release=
=2E
>There are 91 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Thu Dec 13 15:15:44 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E4=2E167-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E4=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Merged and build tested using GCC 7=2E3=2E1, GCC 8=2E2=2E1 and Clang 8=2E0=
=2E6 with -Werror, no build or dmesg regressions on the Pixel 2=2E
--=20
Harsh Shandilya
PRJKT Development LLC
