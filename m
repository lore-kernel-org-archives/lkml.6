Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C313C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D652A20685
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 07:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="hEW/7zRd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D652A20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbeKTRmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 12:42:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33835 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732808AbeKTRmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 12:42:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so504389pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 23:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=cqtZ/s1j65OXyPDscWgMk9iZWTEZCF7bvuNNPuRIMUo=;
        b=hEW/7zRdl4Fr3bvDJG0AR9cle020ERLZtS7diyXvqaBgqo/hD4p91/01lbsGkM9xPY
         47VxRXRHnSWm41KwpjsAsjZrXhUMbcMWaQUBnq9DvuKSQrIMG8YjsiVSOPlbVD9Xtqrx
         gEiUfwXJlHC8vnmOp/pholW1Q/wGUXt2N6DsR49zpbg//9PQDYZQdamHIwzXLKl5PBSt
         ACTquP4xk+FVEui6BGkUqsuudnDmwHnCHHFVPxwmkhirK3i46IFySTqS0XaAGpIlpD/Q
         tnc+5S825x2kXMDkbsPJ37mgjHRluYJy6grcCpghWxf9PzBFbOvq68P4V+6vWBeZ9Pbg
         b+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=cqtZ/s1j65OXyPDscWgMk9iZWTEZCF7bvuNNPuRIMUo=;
        b=j2n5ivDc25QjL7NPKKKzz/fmntPYLC7f9pPgjsKcMYaNRHLYnkegSimVDL2fEKg8OW
         TANReNGOa0pgrKPZVIxiesP22WjCrfKJgRK7f+33ed7AT4ugfbsEtrt4wOJ9Y55xSY0I
         19Yq2jMcMV8N8yga4RKlhLFTC7qIUYRQSylYdp/LJRx3rcUY4021/+5GYd7CM4W1KKYY
         YNlSMcHsJ6FXN1w4kMqZV6QN8Cp/bynGMk+EATGchA78+Ag2p10NKdf/hTRZ4veTsw0G
         fhv73XnxboBBAmuA9KFWOhox9psHfOFH4kGC0wn0L6kOHPMkt3YU/QdBesqIFqhjuPe8
         XblQ==
X-Gm-Message-State: AGRZ1gIC6CX2v2R6Mqi9q7JkTBH/o2tvLmX1fo+6U5OLcAEnOCcEQZNL
        n0vYHxS7EIFG+V703Hzckh6Z1A==
X-Google-Smtp-Source: AJdET5cZFxzZjZLGFE1kCa3tYLzoEfaO32fFLyDKC9IDVFSb4W0wmsd8ciy5c+5aUZtex4U7cQywpg==
X-Received: by 2002:a62:1c7:: with SMTP id 190mr1062387pfb.46.1542698069051;
        Mon, 19 Nov 2018 23:14:29 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.241])
        by smtp.gmail.com with ESMTPSA id q8-v6sm82348623pfa.18.2018.11.19.23.14.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 23:14:28 -0800 (PST)
Date:   Tue, 20 Nov 2018 12:44:31 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/205] 4.19.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <9998C846-1FD9-4825-8848-F8CC06FA0476@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 November 2018 9:55:07 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundat=
ion=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E3 release=
=2E
>There are 205 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Wed Nov 21 16:24:55 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E3-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E19=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
>
Compiled and booted on the Lenovo IdeaPad 330-15ARR, no dmesg regressions=
=2E
--=20
Harsh Shandilya
PRJKT Development LLC
