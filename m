Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA553ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F7C821470
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="joLWZg+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F7C821470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbeGQIfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:35:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33009 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbeGQIfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:35:54 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so205565ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=73rw29TCh5vOjfjG/haU9FNX832EnmSt8teCleNr0YA=;
        b=joLWZg+U4RK+XqDvOlg9yGmis+QVdHdTVWB9wg8NZF2AUTVMEQ3ZRqlLZGuwm3ZfuO
         8FoVfLlVERVQlWhMyG9r1pNKYTodUcHvFjPvJvxeuAuVQqo+IIg1z5Lj9buwgLgkPhnK
         lZMg6G3kZGRi9PQGtJh0FlCjK1pATDjCORcI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=73rw29TCh5vOjfjG/haU9FNX832EnmSt8teCleNr0YA=;
        b=FmF/j6KazjH8C9zEQKqouGGQKUWC9hAGPqYNbfcvvjOlOoKBmMwTMGPY/CZCL44zZQ
         v5+P/vO1pp05rY5zEZ66LUDXOiyg/T2+l4oNpkLkhTBFjD0E7VO+P3dJqGduDGyFT+Tu
         7NOQzde0ZDNzBR0cv1KlvCbX9KXzYblIf0QaPrY/qohYIALH9QXanQ2Vky8nrIcclTKM
         IflzbTGPDt42A+zb86gGgvZZOz7S1+yGjdblQBZdOuEy0B2zE8VXQnaovtWx7OosZumS
         eNLXWwg0QBcTTRHZ/iPsMvSUJE/cdV8KWuHPLuovNKqEPJlBmsW8i9ItW6ZvTIzEqwSK
         vIYg==
X-Gm-Message-State: AOUpUlFusV3NsUutRAIoGtscIqYH/kPdY7LLC2wPeb4aee7fbzoEBZ8r
        rfjBfFYEYYj6BwoExKkG2fzeocsuARpix0xphzQkSw==
X-Google-Smtp-Source: AAOMgpf96k3JOBUYxX2C0OmJG5DPDuZ/Zg9zw8DXeFus4it5PuINbC83PQV6CevSLZLuBa+K1GNK+mftT1tiTIhjgig=
X-Received: by 2002:a2e:6505:: with SMTP id z5-v6mr580491ljb.62.1531814672396;
 Tue, 17 Jul 2018 01:04:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:04:31
 -0700 (PDT)
In-Reply-To: <20180716073450.534886211@linuxfoundation.org>
References: <20180716073450.534886211@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Jul 2018 13:34:31 +0530
Message-ID: <CA+G9fYuoPtBzP19np+Nq5m7HurxBCrzCG2NLr54BpNj=TfcB2g@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/54] 4.14.56-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 July 2018 at 13:04, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.14.56 release.
> There are 54 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 18 07:34:24 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.56-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

> Linus Torvalds <torvalds@linux-foundation.org>
>     Fix up non-directory creation in SGID directories

( For the record, sharing the report again on 4.14 )

Results from Linaro=E2=80=99s test farm.
Regressions detected.

LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
 - creat08
 - open10

Reported this bug internally on upstream Linux mainline week back.
Now this bug happening on 4.17, 4.14, 4.9 and 4.4

creat08 and open10 failed with this error,
TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set
