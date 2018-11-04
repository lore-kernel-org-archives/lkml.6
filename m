Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C51ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B09920685
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kRlJIqnk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B09920685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbeKDN2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:28:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38110 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKDN2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:28:30 -0500
Received: by mail-lj1-f195.google.com with SMTP id q186-v6so5060242ljb.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 21:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Qkma5xzPZ8pkoVpVCsx9oZwgB8m0T+Lwm551vBbQlpw=;
        b=kRlJIqnkF+n/qF5mgJO3D76Qk0eY6XSt++/1d+ORuwMyk+efUEWOeJ45PSot9Tnj9X
         o+zcEvcd1ttbuEx9yozUn/JoI3P3Lw4Ohs0oL4jL8Qbfoq/YS5DY1Vt60hNghlSdw01s
         R6uO2tKlY/q6+5iMPG7OaFIXEN7HsbUGK8YYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Qkma5xzPZ8pkoVpVCsx9oZwgB8m0T+Lwm551vBbQlpw=;
        b=nTO8xss+QaedBgLeTa96ntu6IR6hl9SygTkR569utAFQsHrrkGn2JRzhNc9wc3bhhC
         uY/ealaW8WzL5vbUqE6M+HTd52xBuquUUBiiCwRLi1LxilTqF+RfGcD0v0U7bKnieFhQ
         h/pdyAqSgfN+hfaJyuULVcQAxpume1IHfltR5Hrc6Cb/x64RhOlMJN0RJzrcTLI94qbR
         +P4luSo262F4RDqSfijQdIscm+TajOUlzomDNbdw/uT5qIv+dLgzK5wYVPpagIXTFmV3
         QQ3G6uWbZD00mONa+jzaqZ1v+QxIIR2+ic4daRi+D6bELXv7XJLcMTih4Mc1xMtpKgra
         E3Rw==
X-Gm-Message-State: AGRZ1gJUt7uipeNKS7i4cQ1F32X+cIsybcnKm+pVZbvpuNSLClM8OygO
        oTas9j/ChvjvPdiu/G4R4AxNemPyU0FRERwyWt4cBw==
X-Google-Smtp-Source: AJdET5c+LNQlUEepfVQrvggVrc/s3Oc10HNxu1CXVz/9CuK6AYj+5jkYUh2QnKwsEadNwc8Ki2cIFBPr/Rhq0HhGMKg=
X-Received: by 2002:a2e:9715:: with SMTP id r21-v6mr9745412lji.30.1541304899566;
 Sat, 03 Nov 2018 21:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181102182857.064326086@linuxfoundation.org> <34e8a999-20e1-5e7d-863b-b0585a24e83b@roeck-us.net>
 <20181103150434.GA24235@kroah.com>
In-Reply-To: <20181103150434.GA24235@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Sun, 4 Nov 2018 09:44:48 +0530
Message-ID: <CA+G9fYvCvhds_QPOBPuTP2RTY7i0R4uNU+=9CqPGq+8eojjKHQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/143] 4.14.79-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2018 at 20:34, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Nov 03, 2018 at 07:31:42AM -0700, Guenter Roeck wrote:
> > On 11/2/18 11:33 AM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.14.79 release.
> > > There are 143 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Sun Nov  4 18:27:59 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> >
> > Build results:
> >       total: 150 pass: 149 fail: 1
> > Failed builds:
> >       xtensa:allmodconfig
> > Qemu test results:
> >       total: 318 pass: 318 fail: 0\
> >
> > Build failure:
> >
> > In file included from include/linux/mlx5/port.h:36:0,
> >                  from include/linux/mlx5/driver.h: In function =E2=80=
=98mlx5_get_vector_affinity_hint=E2=80=99:
> > include/linux/mlx5/driver.h:1208:13: error:
> >       =E2=80=98struct irq_desc=E2=80=99 has no member named =E2=80=98af=
finity_hint=E2=80=99
> >
> > Caused by commit 19b743c448db ("net/mlx5: Fix mlx5_get_vector_affinity =
function").
>
> Odd, this should be fixed by a later patch in the same queue, as 0 day
> also reported this.
>
> Yes, e3ca34880652 ("net/mlx5: Fix build break when CONFIG_SMP=3Dn") in th=
e
> 4.14 tree should resolve this.  Ah, Sasha added it at the "last minute"
> after I did the -rc1 release.  So this should be resolved now, I'll push
> out a -rc2 so that it can be verified...

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64 and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.79-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: b825fd9fbad594b1eb7f4ba22588e33f00bca345
git describe: v4.14.78-144-gb825fd9fbad5
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.78-144-gb825fd9fbad5

No regressions (compared to build v4.14.78-144-g02f369a75b6e)


>
> thanks,
>
> greg k-h
