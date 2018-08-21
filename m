Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AC0C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D78C214FF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 02:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="Hky3ozmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D78C214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbeHUF1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 01:27:18 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:45049 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725731AbeHUF1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 01:27:18 -0400
Received: from mail-vk0-f48.google.com (mail-vk0-f48.google.com [209.85.213.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id w7L294AB003810;
        Tue, 21 Aug 2018 11:09:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com w7L294AB003810
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1534817345;
        bh=gsF6h0X+fg4RCfQ2zdNsacviknEfaWWbIUWk+nFPRVQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Hky3ozmXhtnatcyDbu0oe28bqpyhENBo3NiumMSSXPmsFdrRAHLLV9L6oDqKZjRhz
         raESu3xEz8VklL2epB0UlPJ27py6ZKtJV766Jqp3SFDDCMBdZzDkp7ExWKy1z5me0s
         j0wDdZRwh4tfsSBGel4Lrxq000bJWO8J0yRN2bD4U3aclDqV4+AGstXZdAS0zhXy9E
         BqxBVrckH5E/SPOkbiKaoxBoHdjec2yXMtM4W/eWWD9G8FOC5a+mNEOeSE2WFQyuzw
         yuobUyHyLo6YMNoAvkKYovIcfailI/xzPv+isU4uUBBYDqF4VdPrfctilIQnobyo+9
         sS7L7OyG3wtxw==
X-Nifty-SrcIP: [209.85.213.48]
Received: by mail-vk0-f48.google.com with SMTP id 125-v6so7500516vke.11;
        Mon, 20 Aug 2018 19:09:04 -0700 (PDT)
X-Gm-Message-State: AOUpUlHkm/bQeYug+8lgby7HRxFBrhiZF7jPSGz4493HlcdvdFxnxoC0
        hAF++D305RelZE5sy2JMOi2xRjW5QqC6JpAWuM4=
X-Google-Smtp-Source: AA+uWPwn69RsY/qqoMshc5CBKthsHj1N6acNpWaONLeSKOBJv1zrFQWg8TNCZgUBnZbUmnt8PlEAWGknRnUx9+iHSJU=
X-Received: by 2002:a1f:2cce:: with SMTP id s197-v6mr29792116vks.106.1534817343775;
 Mon, 20 Aug 2018 19:09:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2642:0:0:0:0:0 with HTTP; Mon, 20 Aug 2018 19:08:23
 -0700 (PDT)
In-Reply-To: <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com>
References: <1530669563-32637-1-git-send-email-yamada.masahiro@socionext.com>
 <cfb66b67-f423-0c26-0b22-0d57a581b44a@gmail.com> <CAL_Jsq+iAxmKvZ+RAD-VSOWirYOxc52mJHU5f5gybhWwQn2w_g@mail.gmail.com>
 <7fba348e-9fd3-9661-248d-82917f8f6676@gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 21 Aug 2018 11:08:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
Message-ID: <CAK7LNATFbykSHcDZqovTZ0aN9kHvZw3Q4Mamb1gwMwRhg7_s-A@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: consolidate include path options in Makefile
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

2018-08-21 10:31 GMT+09:00 Frank Rowand <frowand.list@gmail.com>:
> On 08/20/18 14:32, Rob Herring wrote:
>> On Mon, Aug 20, 2018 at 1:55 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 07/03/18 18:59, Masahiro Yamada wrote:
>>>> It is tedious to specify extra compiler options for every file.
>>>> HOST_EXTRACFLAGS is useful to add options to all files in a
>>>> directory.
>>>>
>>>> -I$(src)/libfdt is needed for all the files in this directory
>>>> to include libfdt_env.h etc. from scripts/dtc/libfdt/.
>>>>
>>>> On the other hand, -I$(src) is used to include check-in headers
>>>> from generated C files.  Thus, I added it only to dtc-lexer.lex.o
>>>> and dtc-parser.tab.o .
>>>>
>>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>>> ---
>>>>
>>>>  scripts/dtc/Makefile | 18 ++++--------------
>>>>  1 file changed, 4 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>>> index 9cac65b..1c943e0 100644
>>>> --- a/scripts/dtc/Makefile
>>>> +++ b/scripts/dtc/Makefile
>>>> @@ -9,21 +9,11 @@ dtc-objs    := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>>  dtc-objs     += dtc-lexer.lex.o dtc-parser.tab.o
>>>>
>>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>>> +HOST_EXTRACFLAGS := -I$(src)/libfdt
>>>
>>> Shouldn't that be += instead of :=?
>>
>> I don't think so. The definition is local to the file (and reset
>> before each makefile is included).
>>
>> Rob
>>
>
> Every other place where HOST_EXTRACFLAGS is assigned a value, += is used
> instead of :=, including the example in Documentation/kbuild/makefiles.txt
>
> What makes scripts/dtc/Makefile different than the other makefiles?
>
> -Frank
>


:= and += work in the same way in here.


As Rob said, HOST_EXTRACFLAGS is reset in each makefile
because HOST_EXTRACFLAGS is not export'ed.
(scripts/gcc-plugins/Makefile actually export's it, but it is wrong.)


Precisely speaking, HOST_EXTRACFLAGS is immediately expanded
if it is set by :=, whereas it is lazily expanded if it is
set by +=.  But, there is no effective difference in this case.


-- 
Best Regards
Masahiro Yamada
