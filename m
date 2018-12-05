Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655C0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2351D2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=prjkt-io.20150623.gappssmtp.com header.i=@prjkt-io.20150623.gappssmtp.com header.b="gb9rNOj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2351D2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=prjkt.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbeLEOUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:20:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45218 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeLEOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:20:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so10117339plm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 06:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prjkt-io.20150623.gappssmtp.com; s=20150623;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=JtDzsfU5fzZARP86cUYhCx6FX9z5jh/k9BQMXBz6GSs=;
        b=gb9rNOj7ufxYMtzLI2mO5m+HBiktvRlf2gGiFC3xS+b/dwn6MnZMOCVJpgfT5ZHXn1
         zYweCRPyV00J9+qKjmjZGcd7xpQhCWO+Smy5syijxmNb2SPAurcnN6+GXGaJouqsqDpl
         DnOGnpYdV7EMWacVGtDYRAVsVXPsLxmHKJGgLwY6Wf+OTJwNtHWSi23Lm53GDT3Aqw+R
         3m55FxOp28deVDnZyrciMC//p8g06u5rtItcSGIV7PY8TiHby/RZzBrIT5ObAFOdfZ8y
         U7QR3lM9haytz9CFDce9SRYb/TvlEa6khB8BrquxPpJ0gOfK8DBNxzo88Wt6ia35yCQt
         PC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=JtDzsfU5fzZARP86cUYhCx6FX9z5jh/k9BQMXBz6GSs=;
        b=sLoQxQFJLaR9x2FWP2MSb6+xX1vMhEeE82bHEyZnjMrItnwws73LP6yhZWc6MveLWN
         bIU9JfnQR252ej3DpVaR99d8DuTBYwqAxUlrFmVrFxA1I6RXWOXN61xllh733AilHn5N
         YNlhdtj17pn3R1yl966wAwKFIT9YW1d+szT8DZPqdwgM52BC7cr4eQcru3BJdeeM6zcI
         nGBN4pfffT6DjjoMsYZbOosDPDog7ODCb9nJezDCBqunHWMO1foTU6I2nqHrcCWDfEcz
         ARFelCZmGLoJ4pdZLqZMcuvLvB3i9Q7jF6mnTxqM7OZBC0A4N7waGBZlCPaaEf52IFaQ
         qNcQ==
X-Gm-Message-State: AA+aEWZgDXywxsvvQDaljVvDNQfyw92/2IFIqFE5dk0Lkvz0rWQpcK2a
        wkc+sPMl5g0B4wdLBN4OJ9j8tg==
X-Google-Smtp-Source: AFSGD/WgZD3ANgbXZwGQwM9ROFVDB7VxKjyhWaLYJ9R1lEADKb722+UJ/kArx+jE16ZxpzPdC8cilA==
X-Received: by 2002:a17:902:f64:: with SMTP id 91mr10772810ply.132.1544019641957;
        Wed, 05 Dec 2018 06:20:41 -0800 (PST)
Received: from [192.168.0.100] ([160.202.36.151])
        by smtp.gmail.com with ESMTPSA id t67sm7865212pfd.90.2018.12.05.06.20.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 06:20:40 -0800 (PST)
Date:   Wed, 05 Dec 2018 19:51:28 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20181204103649.950154335@linuxfoundation.org>
References: <20181204103649.950154335@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 4.19 000/139] 4.19.7-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
CC:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
From:   Harsh Shandilya <harsh@prjkt.io>
Message-ID: <4D8074B2-9CDA-45B3-B0AD-9887C962617A@prjkt.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 December 2018 4:18:01 PM IST, Greg Kroah-Hartman <gregkh@linuxfoundati=
on=2Eorg> wrote:
>This is the start of the stable review cycle for the 4=2E19=2E7 release=
=2E
>There are 139 patches in this series, all will be posted as a response
>to this one=2E  If anyone has any issues with these being applied, please
>let me know=2E
>
>Responses should be made by Thu Dec  6 10:36:22 UTC 2018=2E
>Anything received after that time might be too late=2E
>
>The whole patch series can be found in one patch at:
>	https://www=2Ekernel=2Eorg/pub/linux/kernel/v4=2Ex/stable-review/patch-4=
=2E19=2E7-rc1=2Egz
>or in the git tree and branch at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable-rc=
=2Egit
>linux-4=2E19=2Ey
>and the diffstat can be found below=2E
>
>thanks,
>
>greg k-h
Peachy as usual on the Lenovo IdeaPad 330-15ARR, no dmesg regressions=2E
--=20
Harsh Shandilya
PRJKT Development LLC
