Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A98BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2081208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 07:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="uIipQPmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2081208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbeHWKto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 06:49:44 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:20849 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbeHWKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 06:49:44 -0400
Received: from mail-vk0-f45.google.com (mail-vk0-f45.google.com [209.85.213.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id w7N7LM74022658;
        Thu, 23 Aug 2018 16:21:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w7N7LM74022658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1535008882;
        bh=pIps5s6nDuDzBT3eBTmB8SGvveXutPglJpGrGePPLug=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=uIipQPmtTfGDKWmnq2ju1TKtMnL3fBVZ6pfRjxzvXW+QJf9m91iuZAtstSJjmF1iB
         jKCUXVnF3sYX1Fzy09DNBKEzyiFlHUBCuAEkG/MSIxU+YlcDABO5P+N98JhpHXxGul
         PpxnpbD4igmI8FOXMsSMdmblWXRlWi5lgvAYTiV//tynNvoEt2AvsFO00BsG5U9HeX
         Kbj2tOaRWPoji/gMDisCh7GmGMWMaDqyfnlsK2DOSV1jwWO//cluJ7I+ZpK6Xa4EKW
         AVctJYUkVrXk9bbGBWVCxUFO0yiv5x1Zh5Huumg8ThiQsdf5YSGhpd60LPCK5Zqi3r
         BXjuuS5HP7XNQ==
X-Nifty-SrcIP: [209.85.213.45]
Received: by mail-vk0-f45.google.com with SMTP id t4-v6so2122918vke.9;
        Thu, 23 Aug 2018 00:21:22 -0700 (PDT)
X-Gm-Message-State: AOUpUlEEbNSNANawugXtuKbcX9wkJxsDk6wcqYSMleR4rUJU8luJ17Cl
        rj9mttH3CfQ7ba2lY690Dy4WYiBR4/fpFz7vWjg=
X-Google-Smtp-Source: AA+uWPy4bnq8H3UoaEAOuMd/6LQLTboJJYBpqufhuSxOClWt1ivvtMj0C8hgEPcmtB3vtDSAVZtjqAm1MMN0IevzcgE=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr35679442vks.106.1535008881486;
 Thu, 23 Aug 2018 00:21:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Thu, 23 Aug 2018 00:20:40
 -0700 (PDT)
In-Reply-To: <7e154505-5f73-1054-e67e-cdfb249fec43@infradead.org>
References: <490A46D5-834E-46A9-9106-A31F94344F99@goldelico.com>
 <d5093e14-c826-9183-cd94-ecb99a799fc8@infradead.org> <CAKdAkRQ+BXezzT0JsuSa_-imHq+u-q2P5rMVMCL4=N18VYxSAw@mail.gmail.com>
 <7e154505-5f73-1054-e67e-cdfb249fec43@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 23 Aug 2018 16:20:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ2n7jceVTV+EMt4atMvrWs+K=kgVzL-OkiTxYJCFUzTg@mail.gmail.com>
Message-ID: <CAK7LNAQ2n7jceVTV+EMt4atMvrWs+K=kgVzL-OkiTxYJCFUzTg@mail.gmail.com>
Subject: Re: please revert commit ce8556cca6 "kbuild: verify that $DEPMOD is
 installed" introduced in v4.18.4.
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Dr. H. Nikolaus Schaller" <hns@goldelico.com>,
        Lucas De Marchi <lucas.demarchi@profusion.mobi>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jessica Yu <jeyu@kernel.org>,
        Chih-Wei Huang <cwhuang@linux.org.tw>,
        "3.8+" <stable@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-23 10:07 GMT+09:00 Randy Dunlap <rdunlap@infradead.org>:
> On 08/22/2018 05:39 PM, Dmitry Torokhov wrote:
>> On Wed, Aug 22, 2018 at 4:35 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> On 08/22/2018 11:53 AM, H. Nikolaus Schaller wrote:
>>>> This patch requires that /sbin/depmod is installed and installable on
>>>> the build host.
>>>>
>>>> But not all build hosts for cross compiling Linux are Linux systems
>>>> and are able to provide a working port of depmod, especially at the
>>>> file patch /sbin/depmod.
>>>>
>>>> I use, for example, a Darwin system to cross compile Linux and I run
>>>> depmod -a on the embedded system once, after installing a new Linux
>>>> kernel there.
>>>>
>>>> I have no problem with seeing a warning, but aborting the build process
>>>> is IMHO a bad idea since the previous behaviour didn't harm many people
>>>> as far as I see. Probably 99% of people compiling Linux kernels do that
>>>> on Linux and 99% of those have depmod installed for optimal operation of
>>>> their build host. So IMHO printing the warning is good enough.
>>>
>>> Thanks for the report and sorry about the problem.
>>>
>>> I'm OK with changing the error to a warning.
>>> Does the patch below work for you?
>>
>> Why would one want a warning on a host that never runs "make modules_install"?
>> Can this check be only done when we actually try to install modules?
>
>
> So Nikolaus:  how do you provoke this problem that you are reporting?
> It's not just a theoretical problem, is it?
>
> The way that I read the top-level Makefile, this check for $DEPMOD only happens
> when you run "make modules_install".
>
> --
> ~Randy


Unless I am misunderstanding, he wants to use
"make modules_install" just for copying modules.

Then, he will run depmod on the target system later.




-- 
Best Regards
Masahiro Yamada
