Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1ACDC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570062145D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="VKSjFbkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 570062145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeKTSnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:43:25 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34991 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbeKTSnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:43:25 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so705234lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F55DLX6nyPL5JFz+Ql9KAaKTV9KNpGdBw10LSrAMXxo=;
        b=VKSjFbkGiGYTNz7b+sJs6bX/afVOarzLd5GINqEKWUWLbFZRDYQdlfb95hw+/2wsHk
         cTvjDyzVm32515gjzQaOrLLhK6oHN483vzCU9+yh9Ogb6XVxkhkrcr4/dyFkdH0PhkuI
         HnMOUpMFBVI5j/ZwdtIAze7/F1fFLUQlPIZLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F55DLX6nyPL5JFz+Ql9KAaKTV9KNpGdBw10LSrAMXxo=;
        b=Rb+8jrhtjBsjzMZ2/RgBr1rcmnLEpJ9sNnsVJBO1J3Du7sE1xkusa7sRXxWFZ3Z5dv
         gkffRnBIc5wmG574GTXyyNZrmp5TULWbESy2Xwh0yxQypQv28mzdewkbtt3f6sUcpLA1
         GZ08r6IQTP8A91V2b8kfjAyr89kRmfl2kwu1AdquS58hmfdDtA7XRmRSSAvc2Kbqm6/m
         SkiOk71hOxSCk1h1dLCIXr/85hIoaPjU/5mvN+IIc8fk7gHW2vjMI7/LyAPtP5mlJZfD
         MVg6N4YfUVwC45paBss4VV+llBM3q9bRquGL/BgYaA4hHx6mD+gdId3PTu2dC+j6QBty
         UiYw==
X-Gm-Message-State: AA+aEWbb7YNcUsriCTVqgQht8AkdEPDBstIXsreHvapWnDkdBqpJ6CFp
        x3Y00kgjd58DmxhFqKtpSmkKfF3Ys2bncrf+d4ZP8Q==
X-Google-Smtp-Source: AJdET5fIzx4QJKOHgtW2BZEdw+Dc2IgeOAJ5dd8c/WjXEyOE8n7/wM2h3GwslOOKbGBaNaYYvIKsES652isi36bYlPc=
X-Received: by 2002:a19:ca51:: with SMTP id h17mr211934lfj.126.1542701733108;
 Tue, 20 Nov 2018 00:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20181119162630.031306128@linuxfoundation.org>
In-Reply-To: <20181119162630.031306128@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 20 Nov 2018 13:45:21 +0530
Message-ID: <CA+G9fYuXJHd7h+qYKOo_a9nk8Zv4QFnKOjsxMWiB-4Hm0qQdRA@mail.gmail.com>
Subject: Re: [PATCH 4.4 000/160] 4.4.164-stable review
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

On Mon, 19 Nov 2018 at 22:27, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.164 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Nov 21 16:25:20 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.164-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.164-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 6c17c03ca5ac12e36d4d8d5eabc81b5076763046
git describe: v4.4.163-161-g6c17c03ca5ac
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.163-161-g6c17c03ca5ac

No regressions (compared to build v4.4.163-107-g3c957d7bc2fc)
