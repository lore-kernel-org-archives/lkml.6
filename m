Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB4C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2554F2082E
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 15:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSW/H2JJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2554F2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbeKDBC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 21:02:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41312 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeKDBC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 21:02:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id 189so7945639qkj.8;
        Sat, 03 Nov 2018 08:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcHiBZWa8YTRhBpdntFxarM3Tl+o53jnvejKQU47TqA=;
        b=VSW/H2JJQGrKw0ZgL35NePLXW883s6LWYsIDq9agrE6q61wHhhEcVgmuQywKbjj3hC
         shkJszjMcvaVUw96LDOXtSTQ0vkoiATs4L9CgzIfKaGB/a3PPcxGHMjiEENAg0XRaO2V
         dlwf9Q/aBjMP9irB2SaLF2y6oSP+1R5jOD/5OO3AMJFb0zQq4LyIsU2Rf0umrp/mPUt8
         7y7fLGKTiqnk/CE4KctpZswJ4ABmQGE5IPOssN7v4pH6sT8ceGG3D4Cfh4HJa4TbmxjI
         c/9mWfRcNc7f+vJeV3gfyuLB1LwbMyWhNQfLbUqCbqnROVyDAdfp+zbuM3UF12aaQNlX
         mY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcHiBZWa8YTRhBpdntFxarM3Tl+o53jnvejKQU47TqA=;
        b=qlvDbgFPACY6WJyfjMvR261umGolrnjhnfAzhN2DCb8pCgtPP3yj9CtXeg84DWOeNc
         TkjlBc3SGfQ1dwGUKo6JGWJUH1uQ8Sr63vtjXfTfktlnNi0otvsgG1UyJ5W1IfT9Bt6v
         sAfWcfWTTxROK+4YRoI986S8EhEvX+a5qJGvjoZvYthX+JswT0gDbOv9HfUNk2lRp5Q5
         8D8ss7q39belG62HkiaOwMeobW0yOiq8dZ+a3VHG6ZOmsG4seGkSpxLueRr9KLhYaHoy
         pjPEBSIW3ziS3PLfp1k524Q4XU3Mm1nr3hypgWtzk883tbhSQ4gddL8EvWJ0vTRVm7qf
         uUmA==
X-Gm-Message-State: AGRZ1gKcMOClcHxAKBN5smuIYQ2JXgfKwyUDOzXzU/XEb+/5UqnrO84F
        YMdBuSvwgUP9yLAmitRPkyjDO3i9KBPHKWKnQ7E=
X-Google-Smtp-Source: AJdET5c3PEnyoCHS5Vy78JPt3nZO7olCJtfOD6bID9VF79zzdrfgoVuhFXOhdqbp2jUMdU3whSTDeW4VSrWGinAQ2DY=
X-Received: by 2002:a0c:e202:: with SMTP id q2mr14535857qvl.180.1541260275684;
 Sat, 03 Nov 2018 08:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VfxGpR1PWaP+FbTcgxsM8sRgyuCZBjTigZWbxJShFDrxQ@mail.gmail.com>
 <201811031027242806354@zte.com.cn>
In-Reply-To: <201811031027242806354@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Nov 2018 17:51:04 +0200
Message-ID: <CAHp75Vc_Ohz9Yu6VbC3YnDTt0uNkqw5xkxusWDx9YjFYMqXGMA@mail.gmail.com>
Subject: Re: Re: [PATCH V6 3/8] misc/pvpanic: add MMIO support
To:     peng.hao2@zte.com.cn
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        hutao@cn.fujitsu.com,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 3, 2018 at 4:27 AM <peng.hao2@zte.com.cn> wrote:
>
> >>
> >> On some architectures (e.g. arm64), it's preferable to use MMIO, since
> >> this can be used standalone. Add MMIO support to the pvpanic driver.
> >>
> >
> >0day complains b/c of 1st patch in the series.
> >
> >Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> >
> >This wasn't suggested by me. It's your idea to support to MMIO.
> >
> oh, I just want to express that acpi_dev_resource_memory is your suggestion.
> I misunderstood the use of the "Suggested-by'.

No problem.

Actually there is a room for interpretation.

From my point of view Suggested-by can be used in the following cases:
- idea came from other person
- the implementation of something is heavily based on other person's
view (usually with provided code samples)

In the patch which converts to use specific API idea was mine, but
here I just reviewed one small part of the code, while idea is
completely yours IIUC.

Of course, you are free to give a credit if you would like to do so,
just be little more specific.

-- 
With Best Regards,
Andy Shevchenko
