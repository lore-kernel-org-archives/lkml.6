Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D033ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B747E2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 08:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gVIpZbBe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B747E2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeGQIiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:38:18 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33182 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbeGQIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:38:18 -0400
Received: by mail-lj1-f195.google.com with SMTP id s12-v6so211508ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 01:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5RmkDQH4hYZ5rYlEE/3hiPRvPbgdd0RQ+ts4IzMhYQY=;
        b=gVIpZbBeN/5gZkIPYF579izPzxwL5pf0MK2MEl9vK5/RBJoxhg456INwHr31zhrtr1
         sl5w90xO98+XWyEOsggtXbbZJ/JZVpfxCUnYYcBruuI5Q3AB5yG4HdGv77hkGsOwmkAZ
         YJIlXsufMKOH2k1tUZCxa1wl4IpG5MACWhdWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5RmkDQH4hYZ5rYlEE/3hiPRvPbgdd0RQ+ts4IzMhYQY=;
        b=HwCPz/PriIDsQg4o07KUAQdgUnu8Zo6oepL/0v5BAL1Z2omNpltQCFG9S2Eg3OOGNY
         E5xdXSO4q+QddVyK9RvXFCxPiPuIGb1UYspdGbFHDXKbKaEcihSpezu/Wqj4XiMTfF2v
         EXDMHvB3nk+Wm3GNDO6gQllla1QZkJK9uCQvE348MFvH39ldfTE7a+nywpqPGP9x+Bda
         gp0rIm7J7OJeEHhvR99ekGU2LzI5FgNh5WbCsTXJLpWreip/J1xa0YSotLsmtf6BoCds
         VDyrMmm58vJTNH4UDKae54TLXE7jqLub4GRqbNgmnzkb6JJvhEmTYvusakbPOjd7e1rl
         mtUw==
X-Gm-Message-State: AOUpUlFSB3YFfv/k0wQlO28fDovj6NkizzU5YG2iJM6KeRWx47r3sToU
        gPqLzjaIfx2HKiWkXDdFNzDah4A2SGHsVLlJcdOLQQ==
X-Google-Smtp-Source: AAOMgpePKmmqHOrhUgd1TXfNrSiEXGU5LztnOnAQhoFqC75R9mSc66+Ed3+N+9auNurUPC+G8o6VsOWIzw/l/Gw6j0Y=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr638521ljk.116.1531814815033;
 Tue, 17 Jul 2018 01:06:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 01:06:54
 -0700 (PDT)
In-Reply-To: <20180716073511.796555857@linuxfoundation.org>
References: <20180716073511.796555857@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 17 Jul 2018 13:36:54 +0530
Message-ID: <CA+G9fYt2P9ZR-x7ddWaz4xuiAMBygXevp9OdzVjV=NFfikhguQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/43] 4.4.141-stable review
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

On 16 July 2018 at 13:06, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.141 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Jul 18 07:34:50 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.141-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


> Linus Torvalds <torvalds@linux-foundation.org>
>    Fix up non-directory creation in SGID directories

( For the record, sharing the report again on 4.4 )

Results from Linaro=E2=80=99s test farm.
Regressions detected.

LTP syscalls failed test cases on all devices arm64, arm32 and x86_64,
 - creat08
 - open10

Reported this bug internally on upstream Linux mainline week back.
Now this bug happening on 4.17, 4.14, 4.9 and 4.4

creat08 and open10 failed with this error,
TFAIL  : testdir.B.3132/setgid: Incorrect modes, setgid bit should be set
