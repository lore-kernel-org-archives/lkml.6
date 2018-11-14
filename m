Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25952C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD78C214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 10:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBoouaWL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD78C214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732227AbeKNUud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 15:50:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37239 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKNUuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 15:50:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id 131so24860432qkd.4;
        Wed, 14 Nov 2018 02:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xk20+EbBU88ieWF0fmcvo+A2u+CRx3PCsEDKQf5Rdt4=;
        b=BBoouaWLeciMSQ/VsSlqHmxX9dyf61vMMUv+2XbxogLuCa7pG6yfgI3Q26Wirx1vde
         EMXDhRAO8esaxq/r56iXwEdYoDxePJGOZH0AdxveWHbsYNaQ5UW1fREWrsJ0uaekJwnc
         phWkB5LIbQnzVimIkkSpntJzqbiKIAZQPRo+o+fleR02f5yK5AxTJjOggDo5ADIr1XsH
         Z/EXl01b26+RxE4tFCCsIC+2qwI5xBF4Dco++hbTyGz6hoMfrXcZUJWDNB4LOT8dkhy1
         W/4AHg5TTa5WhXAWAi3qCpzHLnLAAMl7jmoyFNis6FRfCgfBrr81lunGT1sz1thK27Tg
         EUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xk20+EbBU88ieWF0fmcvo+A2u+CRx3PCsEDKQf5Rdt4=;
        b=WBpoNBveR9/M0z6PCfpKkXxOEIzGv0djjlhDiE9YzAGhFRoXRuFMYn3lDPRsme5D3i
         rMGPcLEi/ZRjIaDKK0jh3Q5Ls0zv3NYH4vxf+bJ8grIVvBMVmZsmvNK04A27gMQLaljN
         Cg74DIVKoXP/r8PdXi0iCb278Wn1MuCsnEnscSCKw70ZSNSzNtVk8BTDLNVKY6eeWgJ/
         845zsWDefZOR+ecPrLHCWFFF/a7vDDUonw8PvrTxdj76lVfCoUAKnk0BhHHZPw8LwbHk
         MYIJpPcwosZy6uI03z4FJ/Fb6SFCKxqWkyDPpfOAmBIRl6iY0iuvHE9NNVKRXlz3MDq7
         czsg==
X-Gm-Message-State: AGRZ1gIGSzaZQu5S0KZWZzquFuBU6tCRzCBlzjITFRIRYTGyvvmy1mz3
        K5X0rLOB92jvyqm6xz/JA50OAlYDIF6rZspY8ek=
X-Google-Smtp-Source: AJdET5eP5In1eiQ7PlJVmMgZw5UJaVl930P4qEZiysyefagLk+aYbMQP2YnX5HaDVKCnsDNjN0TyvQeVCZHh+7XldsM=
X-Received: by 2002:aed:2d42:: with SMTP id h60mr1163699qtd.373.1542192469421;
 Wed, 14 Nov 2018 02:47:49 -0800 (PST)
MIME-Version: 1.0
References: <20181111190250.6055-1-ayman.bagabas@gmail.com>
 <20181111190250.6055-4-ayman.bagabas@gmail.com> <s5hsh04c28h.wl-tiwai@suse.de>
 <CAHp75VfH3ypEeM+kEOCsAkKmd9NRUq3Q-soYJ4aPB9+icn3Rdg@mail.gmail.com> <CAB3uXr5NrrQ4zLvpXM51EJtjJAAScDw_daj5bY40xtsUnj=RGg@mail.gmail.com>
In-Reply-To: <CAB3uXr5NrrQ4zLvpXM51EJtjJAAScDw_daj5bY40xtsUnj=RGg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 14 Nov 2018 12:47:38 +0200
Message-ID: <CAHp75VdfjSMkq0PcGjKZ_LWNoc9LgUNh3_Z4Br2n9ZpDuxYviQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ALSA: hda: add support for Huawei WMI micmute LED
To:     Ayman Bagabas <ayman.bagabas@gmail.com>
Cc:     ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Hui Wang <hui.wang@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:40 PM Ayman Bagabas <ayman.bagabas@gmail.com> wrote:
>
>
>
> On Tue, Nov 13, 2018, 1:51 PM Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>
>> On Tue, Nov 13, 2018 at 7:32 PM Takashi Iwai <tiwai@suse.de> wrote:
>> > On Sun, 11 Nov 2018 20:02:45 +0100,
>> > Ayman Bagabas wrote:
>>
>>
>> > With that fix,
>> >   Reviewed-by: Takashi Iwai <tiwai@suse.de>
>>
>> Ayman, please, send next version with requested changes and appended
>> tags. I will apply it.

> Andy, to clarify, what tags you referring to? Is it patch version?

Tags mean the special strings at the end of commit message, like
Signed-off-by or Reviewed-by.

-- 
With Best Regards,
Andy Shevchenko
