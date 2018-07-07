Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E3FC6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE44822457
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 07:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="buo2Ixu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE44822457
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeGGH2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 03:28:00 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34931 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751863AbeGGH15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 03:27:57 -0400
Received: by mail-pf0-f194.google.com with SMTP id q7-v6so9025865pff.2;
        Sat, 07 Jul 2018 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yUa2bUGn8FCR61aQFejfeap9aUU1xxuiYxbyut0ysv4=;
        b=buo2Ixu11W3g46CV6Kluz4hQGIeCwxowCW1IgmylIX8mLo+491zSJecQdzc5L8nztO
         1pS1tqjsJh8GkkwnEX2yEtw+Zq7cKYFHw10Lbu6EG2s0Ao7PD2q+R0RW1D97hR+6bSM/
         /k73YXkn7qUX90tHs5lAgER8qzcezQg5/dFqlaED2qF1tTTR3itQW2/239TzmfCbJyx8
         fVbtN0FO070cdW6Jf2H9nMF3lNj53MERdem1i4LALCS4TMC1laYXYeiaT4avy5S56bFC
         9ARx8jT4Z12+w1n3THsDaWSF1p2G3vXL9QIIwQshA+ZHsjbOqLhO5FVcFGAwrHC77wvx
         olnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yUa2bUGn8FCR61aQFejfeap9aUU1xxuiYxbyut0ysv4=;
        b=mL88xD+b0EcRjHZcYTwRAupl6HneHwZuSCXJ/vl/BbxiMJGSNOepJH0pgERR96xPkZ
         +hEwVV4vgSRR/jv8Zz/6/PXu80jKsN5Eqz4EbKf2Lu8ZG/ntDFwYBzPE2yJI/xkr05cK
         zfc2BtlvqiKE37dKwpg+zhbfAEJHhifMQHwhud4dmKlw8ZouRqN31VEoIuJ6Zk23bRFY
         EDqO/EhD/9VaqPT4Vv6AskOftCuY5LuTBItfRh2T78aE9JWVRqNfXgfWxs5PqL2mLHuf
         g8p4VjDu9nJmytLhOADqBo4o8FWTXFywXg5l5IdmyZ5E1gy5v0/VmwoYLMnooDhJobV/
         pLIQ==
X-Gm-Message-State: APt69E0BiMVlGhFUjcgiq+XAFm7gdAhuzlj2wWktmzMFx4wIheGKIPzX
        ANci/y/Ab9JA7LIHvGIiMSUkV/6ID1qBilVA4Uw=
X-Google-Smtp-Source: AAOMgpc5gS3Vhn++f7BHplnykMVrWto7Hc9QSUZkk95P0K8Uuh0jCvwZElGRf+bknZuB7D6GlfnZC2/E7sA6JvTR2g4=
X-Received: by 2002:a65:6699:: with SMTP id b25-v6mr7297578pgw.426.1530948476764;
 Sat, 07 Jul 2018 00:27:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:2604:0:0:0:0 with HTTP; Sat, 7 Jul 2018 00:27:56
 -0700 (PDT)
In-Reply-To: <1530827112.6642.2@smtp.crapouillou.net>
References: <20180703123214.23090-1-paul@crapouillou.net> <20180703123214.23090-3-paul@crapouillou.net>
 <CANc+2y4dVDQoPP4zJkous=p-HYL+nu1Cxcrv0nqEMABN_4uyZw@mail.gmail.com> <1530827112.6642.2@smtp.crapouillou.net>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Sat, 7 Jul 2018 12:57:56 +0530
Message-ID: <CANc+2y70=hp7_p3ojyWMddm42VKFHDqUbKGMz97+xakADp9PNQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 July 2018 at 03:15, Paul Cercueil <paul@crapouillou.net> wrote:
>
>
>> Paul,
>>
>> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>>
>>>  The register area of the JZ4780 DMA core can be split into different
>>>  sections for different purposes:
>>>
>>>  * one set of registers is used to perform actions at the DMA core level,
>>>  that will generally affect all channels;
>>>
>>>  * one set of registers per DMA channel, to perform actions at the DMA
>>>  channel level, that will only affect the channel in question.
>>>
>>>  The problem rises when trying to support new versions of the JZ47xx
>>>  Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
>>>  with six DMA channels, and the register sets are interleaved:
>>>  <DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>
>>>
>>>  By using one memory resource for the channel-specific registers and
>>>  one memory resource for the core-specific registers, we can support
>>>  the JZ4770, by initializing the driver once per DMA core with different
>>>  addresses.
>>
>>
>> As per my understanding device tree should be modified only when
>> hardware changes. This looks the other way around. It must be possible
>> to achieve what you are trying to do in this patch without changing
>> the device tree.
>
>
> I would agree that devicetree has an ABI that we shouldn't break if
> possible.
>
> However DTS support for all the Ingenic SoCs/boards is far from being
> complete, and more importantly, all Ingenic-based boards compile the DTS
> file within the kernel; so breaking the ABI is not (yet) a problem, and
> we should push the big changes right now while it's still possible.

Completely agree with you in this. Let's wait and see what DT maintainer's view.
