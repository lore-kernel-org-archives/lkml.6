Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A01CAC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346B24024
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 12:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t61CcM4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5346B24024
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753963AbeGEMYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 08:24:40 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:38708 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGEMYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 08:24:39 -0400
Received: by mail-ua0-f196.google.com with SMTP id 59-v6so5281064uas.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/STsKoK7PqJAw7UkX4x7VNwrHz80BdwqqvgORA3Trk=;
        b=t61CcM4F884buLMKby0OcBspy4GLhmh3t7pIIGudRbljgXhUVzDWmAwMflUIeerJAL
         QE4lQ9Eo0FFB+dyaAn8LzHFbATXLHreAkjD7wMpvaskenvAaOoTZL5B3Ub17FrVjyTvV
         mniDDiTazI2+Gd2ZTwT85fpuiETEaAXlPhWB+NzQM55KbZ0ja3ANlJR7Navwy8RO3ORE
         783u/LJP+e23Xpbyh9mQs8DnhdGuvVdJnb8I2YzCl7NYQAn5SGDX2OJ/xm9yAK7P0/T5
         VEJqQqfk2uwC0iRGhqTa8MRc5T1W/X+SYHqZIiM8dmxsYeD9egEDdwECO7rK24Uld65n
         ZjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/STsKoK7PqJAw7UkX4x7VNwrHz80BdwqqvgORA3Trk=;
        b=o7ojos6BiWFgJfzNoj8VF2pHIB2EODQsAyL2K8SRNG1vvlGDYr5S2i1W8pIHvBlgIk
         KCVtwZcdOTE0MOCbLtjZ0kROfp3omV/JztWN1xBcFOvnBFAI6+TGdz79pNXFRgHKtgoV
         x590cxmygvzZjB7AOgSve6IgF3Qqwbd8Lpt17wJT6OIsqS9oMGC/aWZEZ/hVmGPF11ge
         zZ+In/S7LNC+EHkvjEnPiDVK78Q/FvF+OTS0yYHWno/Jo/nBE5KcGZ3rFJlnANEZ5cjS
         3J4KMT8fWE9KCoubTiUJSoR/VJaiNFeSrTbxtrGZl34EouzWKgPgewP3pwXLSX1XsqNG
         EvNA==
X-Gm-Message-State: APt69E1LZtZzQNumavpaU0ZVp44J/Owajzks7qMc885wmzEH//toPca+
        QLVwgb3HSjKzYHzMH9P083R3li2yHPHmq5m727Q=
X-Google-Smtp-Source: AAOMgpd2+Gb8nO5tV0v7mO6r0f4O1Q5/ZvBtmqQhGnVDgxoiMoZTHXvaYnr0xNvD0Vv0k7ShnFP0cFfe2eEbYL0zogs=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr3451392uai.47.1530793478102;
 Thu, 05 Jul 2018 05:24:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 05:24:37 -0700 (PDT)
In-Reply-To: <CAHCio2hf-kfmVgz=KCvE9L4nPZxEVcFrxv2R1Y11etG=KvyBwg@mail.gmail.com>
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
 <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
 <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com>
 <20180704081710.GH22503@dhcp22.suse.cz> <CAHCio2hf-kfmVgz=KCvE9L4nPZxEVcFrxv2R1Y11etG=KvyBwg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 5 Jul 2018 15:24:37 +0300
Message-ID: <CAHp75Vecv43Q6_LPaLd4YR3OowVKgpR7YJe2Od2Hj_KU7=kEGw@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Cc:     mhocko@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        aarcange@redhat.com,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 2:23 PM, =E7=A6=B9=E8=88=9F=E9=94=AE <ufo19890607@gm=
ail.com> wrote:
> Hi Michal and Andy

> The enum oom_constraint  will be added in the struct oom_control.  So
> I still think I should define it in oom.h.

You missed the point. I'm talking about an array of string literals.
Please, check what the warning I got from the compiler.

> Michal Hocko <mhocko@kernel.org> =E4=BA=8E2018=E5=B9=B47=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed 04-07-18 10:25:30, =E7=A6=B9=E8=88=9F=E9=94=AE wrote:
>> > Hi Andy
>> > The const char array need to be used by the new func
>> > mem_cgroup_print_oom_context and some funcs in oom_kill.c in the
>> > second patch.
>>
>> Just declare it in oom.h and define in oom.c
>> --
>> Michal Hocko
>> SUSE Labs



--=20
With Best Regards,
Andy Shevchenko
