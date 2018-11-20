Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC520C04EBC
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466FA20671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="S04JqgEX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 466FA20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbeKTVHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 16:07:00 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37466 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbeKTVHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 16:07:00 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so731103pge.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 02:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=vgXY1Sh0kxJUfMDHD1qLN6OccgFpTg89323gDzjMF5Q=;
        b=S04JqgEXn/v+g3vS7e7hzUPfPiKPd61dymd4xuL+XtzdwcljTAcci01hwJt60gckOL
         SnDDb/rH38Fi0owrazmZ8qX5ngs0577a1vuPyUv4lmyVRkH7XvK3ouvT5S7tqswecQfu
         ZoAKUoqJw47D9QD52NRsTn+QJnWl7D7jBbIeT7D6X5KyDkRZa7riRS6luaP84VcuU1cV
         vSq6rLIvZ20mIyJMOG0ELEs78La+2k65RPQadsDEOk58WVP2qstyVo8UialtVk9NSo55
         p5ewRuem8czR2emQav0M9WS5HQLIMMG+r+K+9qTYuuLwT3PDgyM0Xl/ZU2muTTD/zTfn
         Akfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=vgXY1Sh0kxJUfMDHD1qLN6OccgFpTg89323gDzjMF5Q=;
        b=frTeEqXb6BINVpbwBB1CeXkPlmQahIsWZJmx+af6q+J1GfHIpkZ0a0eLJg/qHsAISF
         vAyJQT0Dh+KL1c1spZOFk2YCSFC+KlnAeZTcS0Kq2kS3uOiLvvSsz9CRPKi+/qIfxxbq
         WvcWZPB+3F+gCTeaTWBbVPABrBHPDUYXHhmWO/u0ZXCXhoQPAaiWLSgXFF/rOi+c5IWC
         6afgo1Ub97rG144NrnoPklAHPesA7/h/ZyACj7bdtDQ4ruiLvp71K08+lrRO9UuOdlU2
         BzaPMDeeYUQTS3s9ZXnZY1lnb0b9HS6iqOAIaDnzsCGpgtSkIvl5bA2WNjQcgmDNJrk5
         Jw5A==
X-Gm-Message-State: AA+aEWawHZf/XvzXhT8WlLlOyTM5Sn9z6fn/PNXe2owAama8A4n9RTiX
        g74doChYMOst7qhsUA6S3Uqtig==
X-Google-Smtp-Source: AJdET5cyN+Bxi3Uo7b/MVlRKTDeRt/EagMcg7NAdyHrtu3irrIITRYNOi8+EBmMNZQBSm6/FPGpJLg==
X-Received: by 2002:a63:7306:: with SMTP id o6mr1358724pgc.343.1542710311628;
        Tue, 20 Nov 2018 02:38:31 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.241])
        by smtp.gmail.com with ESMTPSA id i4sm44616452pfj.82.2018.11.20.02.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 02:38:31 -0800 (PST)
Date:   Tue, 20 Nov 2018 16:09:05 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181119162620.585061184@linuxfoundation.org>
References: <20181119162620.585061184@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3.18 00/90] 3.18.126-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <0DFBC924-F22E-4DA6-A755-BD5FD14CDD4D@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 November 2018 9:58:42 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 3=2E18=2E126 release=
=2E
>There are 90 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed Nov 21 16:25:28 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v3=2Ex/stable-review/patch-3=
=2E18=2E126-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-3=2E18=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Peachy as always on the OnePlus 3(T)=2E

P=2ES=2E Not tired of this old-ass tree yet? :P
--=20
Harsh Shandilya
PRJKT Development LLC
