Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B07C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B28920882
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 17:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS3SFOiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B28920882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeGDRZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 13:25:13 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:42034 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752888AbeGDRZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 13:25:10 -0400
Received: by mail-ua0-f195.google.com with SMTP id x18-v6so3849378uaj.9;
        Wed, 04 Jul 2018 10:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5rb+JNwfEW3opaDEXCHiBe0HKNEFtY30NyFrZIachw8=;
        b=TS3SFOiwd/ayZ57RsPPHq9TwuaUuPQGNCR/gag1eA9pDsENc9gVWCVNMQqd4ckWqvB
         Xu/WyIFKiJVjZ7rn4yAv5A6hO0BcPVzZCitiugJ5R7t0sv3hlsnT0MOBUCZ93Uh860eE
         LsfTyyQ8kTIY+/zJkiAFgjy3Wq4cousdqYSWESlNyf8QNho+c+EQqYugbunYNUPbP+Ol
         D4joALimGqEdu1oHIQAOl/QL4PijuoJtwlOtolJGuTU544Gp+AjBcU63tX/TkQGfWkrY
         WLBylGHHvdlZm3bfiKptG6jC4gINyACF4JrKl3fSmCu2r9V5J1zMvu0Dlq1qWNMnbr5F
         v5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5rb+JNwfEW3opaDEXCHiBe0HKNEFtY30NyFrZIachw8=;
        b=NZ+w5JfxVL/9MhDBjWKLRNZL/NkwntQvbiebanBxfKGMFU+Fnc8lXXRrW8edCarcXo
         TtY09IpcwWBFXrljt33S1Qzg4geQ6IgVcCOsynJOXlHEZNw4rauLEjzgkesaSaN4A6p2
         oeATArLfE01etjN2lYx1hAGs9oMxAqT1fyaaFBSFwGp9fqrTX8sCiuyLGlrxvgA7NgxE
         +CAllxZ/i8b0wYwSWyl3LFA83CDHDBsaTxYVgH4SEr0bFi4+QueX5niBd58eMZj6xIWP
         o2lawqZQJM/EHYCMjyZL0tFCD9f3T+aLuN0pYpbhbyQdi8nr0TCsNosQXk/74CjflnGZ
         YR9A==
X-Gm-Message-State: APt69E0YBOtfclM76z+R+0ACEaKL6mnjaMMIBfqzn3AQW2wYS4O91Ozq
        r7+F5BOI5eWQpFxV/NbrZP6GUtLhiSwzLHNucJ8=
X-Google-Smtp-Source: AAOMgpehBg6Qt/hC1HYdGNJVtAwTPoLQ7sevuZ4U3Ly9dzbqv2NKubeoX1MHWV0vV2ADYydewm4pO+f1GapuTBGg36k=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr1687941ual.28.1530725109658;
 Wed, 04 Jul 2018 10:25:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 10:25:08 -0700 (PDT)
In-Reply-To: <d633fa61-c5ef-5e0d-cac7-19adef80fe0f@deltatee.com>
References: <20180622194752.11221-1-logang@deltatee.com> <CAHp75VcDudrwV4kRnVR+vtddFhxHsU672YqOJgPPchuLvPV3nA@mail.gmail.com>
 <CAOMZO5A4bsu9dXCPb4QeSbnnLi=pr1=WYWn8p2AfU3rEG=RWXg@mail.gmail.com>
 <6e5224b9-343f-990c-19bd-fe37c6fbdc9b@deltatee.com> <CAOMZO5CJ_iG=p_+xL=Q_Rv3F5vtGggsgatar4XVTL+UFVnHBTA@mail.gmail.com>
 <7ddda181-6337-32cc-7a0d-43fc6a7ba78b@deltatee.com> <CAHp75VcN=pUkFK6=_7yErMRGNS3WsgBhkWMSwP0Cw_ZmGR=RJg@mail.gmail.com>
 <991b2298-bb3f-dad3-c93b-b43ee5f372de@deltatee.com> <VI1PR0402MB3485F76DD56D221EB256B4F698410@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <CAOMZO5C7V4_SpXOcAz0KbGYScpos0HRD-aa-Zh_6M3p9EqLsLQ@mail.gmail.com>
 <55236e2b-a2a5-493a-5696-19c5926885b3@deltatee.com> <CAHp75VfCFdFh3eMpdpNYdNtbuVKG60PbUnYVsEbCrxP5pUZwMQ@mail.gmail.com>
 <bf8df451-ddda-8c6f-ad0a-bda7f7905f69@deltatee.com> <CAHp75VdtkYRWyKnD+wXo_Z_t=EK9dAOTFzbnHmraSt80sAmyHA@mail.gmail.com>
 <CAHp75Vfd2wcUV_dY5ns28+9aC32=OiVExuxOFu7ZjMU2dYuA4Q@mail.gmail.com> <d633fa61-c5ef-5e0d-cac7-19adef80fe0f@deltatee.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 20:25:08 +0300
Message-ID: <CAHp75Ve8LjhZHho15XZVnr8tSVLzJDxGBkAO7fJmYw1=mtfkTw@mail.gmail.com>
Subject: Re: [PATCH v18 6/7] crypto: caam: cleanup CONFIG_64BIT ifdefs when
 using io{read|write}64
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Douglass <dan.douglass@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 8:23 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 7/4/2018 11:21 AM, Andy Shevchenko wrote:
>> I think it doesn't contradict with what you are saying rather supports it.
>>
>> I would expect to have lo-hi and hi-lo semantics done according to the
>> data flow, not to the address.
>
> Hmm, no, I expected the opposite...

Ah, sorry, misread you. Then it means I'm for the what I said and
opposing address flow.

-- 
With Best Regards,
Andy Shevchenko
