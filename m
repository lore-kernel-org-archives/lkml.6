Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC33C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C0B206B5
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 00:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjWyuSt5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86C0B206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeIWGyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 02:54:51 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45325 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbeIWGyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 02:54:51 -0400
Received: by mail-qt1-f193.google.com with SMTP id l2-v6so5483154qtr.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 17:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3S7+o+DQ2XA2b2p23lokHvd5A8cZ2RkDDULTqNI/A9I=;
        b=IjWyuSt5oh0yhCluXc1KNkwhXFXNBD0UUFw23iSbf/+qMBF3SSpxODwaEfYJy+8Dyh
         t42/LDzundMVDpQruAt3O/dp3UwVuhjAFmW+zIIF2SaVUJi50JtAq7B5yIeUbJIxzyrz
         0Yy4cgY5vPOHI9PyqnkXWfWumKKBxhG32gGTHUVno41aJm7AfVdhe9C/y02N6WZaAXjC
         UhN/ETH04jM/7xA1wOxgrcjh0vuJdpsfwl6aGRHERewBO8Sf9mmZwy4ig7z4aZRYxN/t
         WnEo5KGfRVBaogfLNzTwVCGoMArR1/vOYdDIqESLV6M/QSfpOsMigti1WRTtd14NuHfY
         plEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3S7+o+DQ2XA2b2p23lokHvd5A8cZ2RkDDULTqNI/A9I=;
        b=CXm5cNF7yc13cJdiUFaXHoIONtIstITh77eO2w1hQa3qBIsYmb7HKYInFeAtt5O7En
         K6kTAVzZtXy0Cu1PA6zwAyeOaTE3B8b76hzKZGixsgaU5U70sT5oO7FP17M1fpUggkU7
         Q9B55HPooajVWeqr+101AgDwhU2Sx4Uy0PCy3uKQFodJJMwA2e4Iq3dFZy/zOe1klHPH
         xk5RKrT/5qxjTOpgNKsryrWSINBMyv9BHW8QX644O6PPiKNpWXoNl7krrmrG15y2C9Lj
         FGdAdoX5p+vc9nG6hnB+isKpQlrXbn9jxj930SOYY52d6PLN/7oq2eP6kj08nfuL4W+M
         dPAg==
X-Gm-Message-State: ABuFfogm0RhQszSRNFRQxyxyqwPjnUU5TlLVTQvrjdi1VCYGDgybiqnh
        f1wbw3LbsbNbPfFOYwxguLsPcYFgdFCeDBkZaao=
X-Google-Smtp-Source: ACcGV61Xa6314Pmf4pcbcV4o1kHjnAHEwOkh2YzhLuykET7hbhqBcCn3vaR8H9XdvvlYs8tCarQWPRG+3i/IQ9Xt784=
X-Received: by 2002:ac8:4304:: with SMTP id z4-v6mr2768202qtm.295.1537664357177;
 Sat, 22 Sep 2018 17:59:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:7494:0:0:0:0:0 with HTTP; Sat, 22 Sep 2018 17:58:56
 -0700 (PDT)
In-Reply-To: <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
References: <20180912035352.11191-1-diego.viola@gmail.com> <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 23 Sep 2018 02:58:56 +0200
Message-ID: <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     Diego Viola <diego.viola@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        linux-kernel <linux-kernel@vger.kernel.org>, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diego,

A few things, since it looks like this is your first patch.

On Sat, Sep 22, 2018 at 5:56 PM, Diego Viola <diego.viola@gmail.com> wrote:
> On Wed, Sep 12, 2018 at 12:54 AM Diego Viola <diego.viola@gmail.com> wrote:
>>
>> Signed-off-by: Diego Viola <diego.viola@gmail.com>
>> ---
>>  CREDITS     | 2 +-
>>  MAINTAINERS | 2 +-
>>  Makefile    | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/CREDITS b/CREDITS
>> index 5befd2d71..b82efb36d 100644
>> --- a/CREDITS
>> +++ b/CREDITS
>> @@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
>>  W: http://www.linuxdiskcert.org/
>>  D: Random SMP kernel hacker...
>>  D: Uniform Multi-Platform E-IDE driver
>> -D: Active-ATA-Chipset maddness..........
>> +D: Active-ATA-Chipset maddness...

I think the extra dots is what was intended here :)

>>  D: Ultra DMA 133/100/66/33 w/48-bit Addressing
>>  D: ATA-Disconnect, ATA-TCQ
>>  D: ATA-Smart Kernel Daemon
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d870cb57c..6567bf245 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -93,7 +93,7 @@ Descriptions of section entries:
>>            Supported:   Someone is actually paid to look after this.
>>            Maintained:  Someone actually looks after it.
>>            Odd Fixes:   It has a maintainer but they don't have time to do
>> -                       much other than throw the odd patch in. See below..
>> +                       much other than throw the odd patch in. See below.
>>            Orphan:      No current maintainer [but maybe you could take the
>>                         role as you write your new code].
>>            Obsolete:    Old code. Something tagged obsolete generally means
>> diff --git a/Makefile b/Makefile
>> index 4d5c883a9..7b5c5d634 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1109,7 +1109,7 @@ archprepare: archheaders archscripts prepare1 scripts_basic
>>  prepare0: archprepare gcc-plugins
>>         $(Q)$(MAKE) $(build)=.
>>
>> -# All the preparing..
>> +# All the preparing...
>>  prepare: prepare0 prepare-objtool
>>
>>  # Support for using generic headers in asm-generic
>> --
>> 2.19.0
>>
>
> Jonathan,
>
> can you please merge my patch? After you merge this one, I'll go
> through the rest of the documentation to make it more consistent.

Jonathan is not responsible for these files. Jiri Kosina is the
maintainer of the trivial tree.

There are 1700+ instances of a "two-stops ellipsis" in the kernel. I
am not sure they were mistakes, given their prevalence, even if they are
not formal/common English. Also, I am not sure a commit for each 3 is
really appropriate! :) Maybe do the full sweep of the Documentation
ones in a single patch?

Also, typically you would note in the subject that this is a "v2" of
your previous patch (if I am not wrong, you sent a first version
fixing only one of the 3 mistakes).

Thanks for your first patch!

Cheers,
Miguel
