Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0248AC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B055320673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYGiB24b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B055320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbeGZPRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:17:40 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40323 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbeGZPRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:17:40 -0400
Received: by mail-ua0-f195.google.com with SMTP id p22-v6so1131863uao.7
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=aoyaBYLdAR7G9qZi8MO/Kt3UvWlbOBA9anEPmOfH9A4=;
        b=bYGiB24buxTzSZNLFONeN5I7j/BYsY6hebTiv0Voj/lWM0Mfv4q9PsTX2Cg/50Qt+/
         tFsFcDPGtAY7j5I4StlsqNjR6nHiezQ7MyZlWhCoJkyNRSeJO2lGaMVT2wmfeE/Djzxl
         GSbXLdH/GqRYPLq5ZTcdvV/ea1vOPz957le33CFx+BCzJ3hZtnk/EdxLut/+3GTLESUb
         QeyDoCzAn6hIuB1/GMbsUkRYXjRYVan6I6Op0v0TPRykyQ9Y6237s0Ng79SyWwomkbL6
         nvl98s17ZPGif2lSRaxNBGE52E8H8RP4OgTTZArKGcpTbq6sYEC+ssQR7gO4Mz2ztzxn
         Srkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=aoyaBYLdAR7G9qZi8MO/Kt3UvWlbOBA9anEPmOfH9A4=;
        b=aFUR61HuIfhizfe3xLRntM1bXZZ7dKu0xnEgLWrfVXJB5inLBNwapKTOjwhPJ4gE+j
         z2Imi01YwZiKuIu8uVAnqjNzZCMKwuCYC/fvFoeUlaVSGGu9LxgkOpE8QRS51Lx8R4Jw
         wARocQSGJME9j/WIaC/J1DKsEos1xllEoWPNN7ZKarrFXnhY5+uaJvySutuaL8F79US3
         A1G0njb2gtH8I/Tp0cDdivDXMTaWjYyfwfCyaCm5LNM090EaMK5M0AybKWDckKKFbrd4
         +W56F3HT/J+ydUwJ1iPnc1YsDzcIVFbvupYTI/lHRcX81X1n0OI9qRq3VBqpV326OiLN
         SUmw==
X-Gm-Message-State: AOUpUlHiPQ5K2/HDllyvHz7m9pCJabUM8V3uc5+GSqSuY67meiNdpX8f
        k1kk0MIWWp2S3ZUUiAIA1FQjNcBGfhqMFXQucPw=
X-Google-Smtp-Source: AAOMgpdeB7HD8pwfI6uivlMFiCwzF1Kx8aHw9CRfA/Smu/V2PX3M6FmZSnDS3T97tN0s5FFwmRTnx8okG/t2jJDmc3M=
X-Received: by 2002:ab0:70a9:: with SMTP id q9-v6mr1382939ual.141.1532613639695;
 Thu, 26 Jul 2018 07:00:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 07:00:39
 -0700 (PDT)
In-Reply-To: <5B599DB7.4050700@intel.com>
References: <1532592471-21177-1-git-send-email-wei.w.wang@intel.com>
 <CAHp75VcFZ7jS-M6+O95XTfyg1m05UOQMVgdQb5wC-0bNWkyvMg@mail.gmail.com> <5B599DB7.4050700@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 17:00:39 +0300
Message-ID: <CAHp75VeTN5AmVj5knocsRFssQ9phzCz+jTXLMKoJ9WtasAPJRQ@mail.gmail.com>
Subject: Re: [PATCH] linux/bitmap.h: fix BITMAP_LAST_WORD_MASK
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yury Norov <ynorov@caviumnetworks.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dgilbert@redhat.com, Matthew Wilcox <mawilcox@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 1:08 PM, Wei Wang <wei.w.wang@intel.com> wrote:
> On 07/26/2018 04:48 PM, Andy Shevchenko wrote:
>>
>> On Thu, Jul 26, 2018 at 11:07 AM, Wei Wang <wei.w.wang@intel.com> wrote:
>>>
>>> The existing BITMAP_LAST_WORD_MASK macro returns 0xffffffff if nbits is
>>> 0. This patch changes the macro to return 0 when there is no bit needs to
>>> be masked.
>>>
>> Can you provide a practical example of what's going wrong before this
>> patch applied?
>>
>
> The reason of making this patch is that I saw some other software which
> ports this function and has possibilities to fall into bugs with usages
> which pass 0 to the macro.

No problems in the kernel, right?

> So I wonder if it would be necessary to make such
> changes in case we would get a similar bug. Or adding something to explain
> that "0" is not applicable to this macro as a reminder to people who would
> use it.

Comment can be added, yes.

-- 
With Best Regards,
Andy Shevchenko
