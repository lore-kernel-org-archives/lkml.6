Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F7FBC04E86
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16F9214AB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="dwzM60T0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16F9214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731863AbeHWMHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:07:49 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:18257 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbeHWMHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:07:47 -0400
X-Greylist: delayed 4683 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 08:07:45 EDT
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id w7N8d87h031907;
        Thu, 23 Aug 2018 17:39:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w7N8d87h031907
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535013549;
        bh=stMjNS7k15ZBMSRsw6Q0tOSPDVCFsOZomXtvepfcTtQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dwzM60T0ab911HTCSJQswRi5Bo0n+cG0KMMZcGIB+3Hpa6BJLiV9p9rtlw8ONhHli
         43F+iIwEm9zKt1lMtDZ1owpCVeT3C2EqBEmFCdmtZDfVeMH8hbYxTnYBA3gNQouCAE
         pI5M4fzC6IqwsyH7M0G9AQacX73iDQfoh/UzdPah01eJx0oFrpTLAL6HV8pmEcHnws
         V/BbZ4Gl0GcpgTycRoB0qXyQmtvaPMnAwPJcjH9UWw9ho1b4nHStYeHDKYyzerR2Ca
         t0nvY4WfkUENMYAfVdlgMWDul2aGjHle592WkOoAVES7NB5DtFBmjDZwQ9OztSMIM0
         0Dx8WSJ8SbJXg==
X-Nifty-SrcIP: [209.85.222.44]
Received: by mail-ua1-f44.google.com with SMTP id w7-v6so2746680uan.9;
        Thu, 23 Aug 2018 01:39:09 -0700 (PDT)
X-Gm-Message-State: APzg51AKb+7/+gpdJJ1f4NmKEzzY3/0/1vIQOwVJwFH4HCFNqqfV0QCl
        7RQSw47w7jUUwCbwYhWBCovkjTSjNYF+akqmp5w=
X-Google-Smtp-Source: ANB0VdZilJC4uAqzOOrsop+k3a6PenQV3cK3FUWKPd44TQF2L7FHRPaVCj7IxcTtvJlRr9XCQZstHem/fB7ki/9xZLI=
X-Received: by 2002:ab0:1a89:: with SMTP id j9-v6mr781105uai.19.1535013548259;
 Thu, 23 Aug 2018 01:39:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 01:38:27
 -0700 (PDT)
In-Reply-To: <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com> <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 17:38:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
Message-ID: <CAK7LNAQDRj7aKMNqkTL3XxbsFHUuYwOaPn8buh=b9O9+CaKjig@mail.gmail.com>
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,


2018-08-23 8:33 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
>> This patch requires that /sbin/depmod is installed and installable on
>> the build host.
>>
>> But not all build hosts for cross compiling Linux are Linux systems
>> and are able to provide a working port of depmod, especially at the
>> file patch /sbin/depmod.
>>
>> I use, for example, a Darwin system to cross compile Linux and I run
>> depmod -a on the embedded system once, after installing a new Linux
>> kernel there.
>>
>> I have no problem with seeing a warning, but aborting the build process
>> is IMHO a bad idea since the previous behaviour didn't harm many people
>> as far as I see. Probably 99% of people compiling Linux kernels do that
>> on Linux and 99% of those have depmod installed for optimal operation of
>> their build host. So IMHO printing the warning is good enough.
>
> Thanks for the report and sorry about the problem.
>
> I'm OK with changing the error to a warning.
> Does the patch below work for you?
>
> thanks.
> ---
> From: Randy Dunlap <rdunlap@infradead.org>
>
> When $DEPMOD is not found, only print a warning instead of exiting
> with an error message and error status.
>
> E.g.:
> Warning: 'make modules_install' requires /sbin/depmod. Please install it.
> This is probably in the kmod package.
> ../scripts/depmod.sh: line 44: /sbin/depmod: No such file or directory
> make[1]: *** [/home/rdunlap/lnx/lnx-418/Makefile:1244: _modinst_post] Error 127
> make: *** [Makefile:146: sub-make] Error 2
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  scripts/depmod.sh |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --- lnx-418.orig/scripts/depmod.sh
> +++ lnx-418/scripts/depmod.sh
> @@ -15,9 +15,8 @@ if ! test -r System.map ; then
>  fi
>
>  if [ -z $(command -v $DEPMOD) ]; then
> -       echo "'make modules_install' requires $DEPMOD. Please install it." >&2
> +       echo "Warning: 'make modules_install' requires $DEPMOD. Please install it." >&2
>         echo "This is probably in the kmod package." >&2
> -       exit 1


'exit 0' is missing here.

This shell script would fail, then abort the build process.


> ../scripts/depmod.sh: line 44: /sbin/depmod: No such file or directory
> make[1]: *** [/home/rdunlap/lnx/lnx-418/Makefile:1244: _modinst_post] Error 127
> make: *** [Makefile:146: sub-make] Error 2






-- 
Best Regards
Masahiro Yamada
