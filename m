Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F628C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A8023DEF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHG/e9Eg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A8023DEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937030AbeF2TaS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:30:18 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:44271 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936958AbeF2T3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:29:41 -0400
Received: by mail-ua0-f196.google.com with SMTP id v15-v6so6466261ual.11;
        Fri, 29 Jun 2018 12:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hz7z2dBUxRuAZ/qh7K0wl4kE7KiPvoDxlDLn/0uP588=;
        b=nHG/e9EglTTONeuoZA3FmUbz8La2mG6QcilN6IIxGfeFB0RjvfPBI7om4Umng8gpw5
         ocHxZrWvxsq/VLPIMDgADEol+4Xk/wU21H27PykrxOiGWFFt9tBocskrE5j6V6c/2Uww
         1vwc5qhVBWJK9u2HoAvSGrzU0AzimFfmFD1NrFzuvTd6XtEnCQbRbWNqlbcDTh3Tkhbh
         L8rx1yBOUUYvD7Cp4PReWo5EqdqQ+7ibuvKOG9J8VxrNDDI1xE+HDWVPaMsUIz20BlYH
         59L0gjvNcDtBiSx8pO6eq/Zj7hat+hB8LnalQQ3r5klZkahAd+3XL4Zs8ZdUWGiDbsPX
         SMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hz7z2dBUxRuAZ/qh7K0wl4kE7KiPvoDxlDLn/0uP588=;
        b=TgcHZ14cKMyfhRpfZQdLTyp3FKmtNoS/asJvA/PmkkdyK0EIYsHuIT2KcEI4V1C58P
         mfsTsrSztylnz2p8G3HK8S+PvFidkgIhiwvD2lHyCUOYtoUQ+vqk8ycP051pRATn1Ejc
         zuccbgTnNjXY2zq1Zdx0ucRMHPbkHTZYZHHPHj10ZH16QuksWyQqL9dMQgTZNHMolKkt
         DW98cEqPTOa/0WriQiAnhY/R2Fda+wNktH/D2pwLeEWCNiuIzXVrE3wCDC9M2P+VbEmj
         Xbhi9vQ7Gwx4xWYRJsU5uWd8H8dGK/vQbcezcP2siC7vk5DZEnLjJn+SEqkMHw/tAkfM
         10pA==
X-Gm-Message-State: APt69E2ebEZvD/G6DDA9PUBun2DNUeVBu6nBEv4ML1JCsY0mwEeM73V2
        hrhaB0yosjLhxfHlLmIIRJAK0KZBD0ac+30H++I+MEzu
X-Google-Smtp-Source: AAOMgpfZc2KZUwOs+ePqYpzNPWna5/mrwQ+LiK96Xm4vaQgbVVb8NwYrbv4ZbqKb3hq0xnKOWONsbl/MC52+j7F779A=
X-Received: by 2002:ab0:15ad:: with SMTP id i42-v6mr10058871uae.199.1530300580592;
 Fri, 29 Jun 2018 12:29:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 12:29:39
 -0700 (PDT)
In-Reply-To: <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com> <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com> <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
 <b5652ed8-5fff-4f8b-ec0f-467bce853bf8@gmail.com> <CAHp75VfL3v8U6o36-e3+XPL53sb9wMUOXsL6gn3XE4=-kJjuKQ@mail.gmail.com>
 <367a12e9-7d10-98e4-4791-69cdc7d01129@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 22:29:39 +0300
Message-ID: <CAHp75VdSVLzNHnrOzzrBMf4X2Cg4QACRrnxKNkQzcYJ0h5W+tw@mail.gmail.com>
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 9:56 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> On 06/27/2018 06:52 PM, Andy Shevchenko wrote:
>> On Fri, Jun 15, 2018 at 1:31 AM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>> On 6/14/2018 12:25 PM, Andy Shevchenko wrote:
>>>> On Thu, Jun 14, 2018 at 5:22 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>>>>> On 6/13/2018 3:54 AM, Andy Shevchenko wrote:

>>>> Thanks, but here I meant += 1 vs += 16 step.

> I did realize that the debug code that printed the address of the EPS table was not
> working right, and the table on my system is actually 16-byte aligned.  However,
> the documentation on the EPS does not specify that it will be 16-byte aligned, so I
> don't think the driver should make that assumption, especially since scanning a 64K
> region byte by byte should take very little extra time over scanning every 16th byte.

> I guess this isn't needed since the table on my system actually is 16-byte aligned.

I think the 16 byte is a natural alignment applicable to all tables like a such.
I would rather go with it until we will get a (weird) BIOS which does
not support that.

(I believe this alignment just comes by definition of C ABIs for the
structures / types. So, each defined type is located on an aligned
boundaries)

>>> [ 4680.194012] dcdbas dcdbas: WSMT found, using firmware-provided SMI buffer.
>>> [ 4680.195327] dcdbas dcdbas: Dell Systems Management Base Driver (version 5.6.0-3.3)
>>
>> OK, now the most important question, did you investigate "SMM
>> Communication ACPI Table"?
>> Can you utilize information in it?

> Dell BIOS does not provide a "SMM Communication ACPI Table", just the EPS.  It appears
> that the "SMM Communication ACPI Table" is deprecated in the UEFI 2.7 spec.  Also, the
> dcdbas driver is for Dell systems only.

> The EPS table isn't an ACPI table,
> it's just a Dell-defined table.

Hmm... It's either strange or has some background why is so.
OK it has a note that there is no use case, but here it is!

Mario, can we consider this as a BIOS bug which doesn't provide SMM
Communication ACPI table?

Can it be escalated on UEFI committee?

-- 
With Best Regards,
Andy Shevchenko
