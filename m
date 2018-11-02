Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA6DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:54:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52520657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMeQWfmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE52520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeKCBB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:01:59 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:45038 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbeKCBB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:01:59 -0400
Received: by mail-qk1-f196.google.com with SMTP id n12so3727803qkh.11;
        Fri, 02 Nov 2018 08:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AJsFJG6pVgdD7TFuZL47wJEnsgE1IRl/yFv0YTPAzHo=;
        b=kMeQWfmITBXoSFiFhkGGvIr4EIhmIaeqLpV1DNS0jmY3I9SpSkckPmQaZG03nxhVni
         tGzZ8GZiEFdnjAudjtZmhPhzddqYH0IbSNnsbeFb5c3AEeD2CKWQvhGCYLkixuMz0heA
         I8QzbvFprtjT033WAbni8XT2bIcN6qwIPir1fntTXqV2iPfeMxqdAmbhEB09AM62pNY8
         u2EhY0C5ccj433ZsRJ73xgdLM3ghfJIyBRk3pcqDYag5ZDHs8dfqRvEpJd+il1qf9IAE
         OSWECSGEEhTcWPDm84xy/T+Ec5c9SAk7T79O3bk0Tk3XQoQchlKrBnB/NaUJgqd5JirU
         wIjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AJsFJG6pVgdD7TFuZL47wJEnsgE1IRl/yFv0YTPAzHo=;
        b=fv4NV3w0u42DAZPo2F3LpPJ+mkRffjqRAPFJ6JQec7EQ7pFuUcf2g/CW55VgbxQ/37
         Knjh9ilJZ8VPJ2px2eX6TZvI3fkDz0TdtxbDo9bIpSuJGin4x7mItmzrOYFKNVc2hmrZ
         cmiOdhbuf+tAzQk6vvLd262o90yGueeM3iVB66oqzmlfEMMyHhXAjIL2fuHsm4iv6VkY
         vQoPsV8zq0jZIOWTcK1nvAUPK/0cVD0iZxRkJgMvuk/9047THAL/Lzhgh61WzrwNaeg4
         v3fMfWpxW9zI4cZjDgPeHmOrGWw86jSiaepvBQV54FW2Od/OZ7MiywnTdxgq0wh9NUyK
         HoBg==
X-Gm-Message-State: AGRZ1gJbb071V5JSzWakhyJz8/7G8VKr9FoACTNS8d+Czz8NRmFAnueV
        JUi8T7zQv74biwvnUrZMHPz6UzBcSm4bI7ojdYk=
X-Google-Smtp-Source: AJdET5dKFUaWXbxX0Q15kYXn64+xuQAXCosZwsUZjfnq63PheWwp/IJG8ADpae17roXFF+Hz43so91s4sd4JjMOxxA4=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr11056294qvl.180.1541174065689;
 Fri, 02 Nov 2018 08:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Fri, 2 Nov 2018 08:54:25 -0700 (PDT)
In-Reply-To: <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
References: <20181031145907.1ee2e866@canb.auug.org.au> <661e44c7-396a-6d58-efa7-ed292f2677c6@infradead.org>
 <CAK8P3a3aygFrD3PyZ8P==JzeYamE-x--MWCL54xzXDE_8u_R6Q@mail.gmail.com>
 <CAK7LNATirQwke8tqk5XukhkwKra6mWEXZ3AHcywNcwGFD2-voA@mail.gmail.com>
 <20181101142946.u5luuctqav6fec6k@mail.google.com> <CAK7LNAQbBG=KV5Q8o5-JiNCswuse94jECoqT+T+UEY7bLCRPNw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 2 Nov 2018 16:54:25 +0100
X-Google-Sender-Auth: i2Ha_WwgYgNAriqGy2nvqxiKseY
Message-ID: <CAK8P3a1w8p8OC-9_0mtMUxEojvyVfXvF8Ka4J7TnoyZ=gr2Fow@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 31 (vboxguest)
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> On Thu, Nov 1, 2018 at 11:32 PM Changbin Du <changbin.du@gmail.com> wrote:
>> On Thu, Nov 01, 2018 at 12:32:48PM +0900, Masahiro Yamada wrote:
>
> How about clang?
>
> For clang, -Og might be equivalent to -O1 at this moment, but I am not
> sure.
>
> In my understanding, Clang does not inline functions marked with 'static
> inline'
> for -Og (or -O1) optimization level.
>
> Theoretically, 'inline' keyword is a just hint for the compiler, after all.

I think this means that we cannot build the kernel in that configuration,
at least with CONFIG_OPTIMIZE_INLINING=y. Without that option,
every 'inline' becomes 'always_inline'.

       Arnd
