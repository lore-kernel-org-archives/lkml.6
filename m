Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C7FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D0426D60
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9NuQz4n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D0426D60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752377AbeFZPmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:42:44 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:32941 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752261AbeFZPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:42:40 -0400
Received: by mail-vk0-f67.google.com with SMTP id f200-v6so2965878vke.0;
        Tue, 26 Jun 2018 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjsfKWA5qHPSWl4OVEXczlN1pCPskFUcXwmUf3TVfgY=;
        b=U9NuQz4nlvRIKtWWd5mxRkaBmzNVh6VY3WFXHfQ5BUNmebg7UQaGOoEUU7P2clrlWv
         jQ1SFN6dPMkE4KhnmpXZ9N6u4wRWbo7TMKPagq+aHlwuSXA+DvvRPRCmpddMgdf8XUKz
         7t5FepdKj7KUN226OPjXJusXP7UmHP7mxuRpfJ/zGwhG+BwCEpLtzlJlWrHPA1V0ClX0
         KKwXeLopDkwQ/hgrXOFnzc1s6sVVUnpmGJQJzoyvqGNnNIzVIXNKXueVzz6/vXt+Rb7L
         k1Pbc+W7cTcY9QlyWFyjRFj+aePegzFamv9iwvhoIveCmeEFhqX3ZR9bJjXTyO8g22N7
         N0Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjsfKWA5qHPSWl4OVEXczlN1pCPskFUcXwmUf3TVfgY=;
        b=AeFeQqA2261jq/pLb5ztDc0o5OujyYMDdvgdc2LMKFtBPuKfCx3IP4mzv4GmCBDfH/
         Z+GPV/DjP5gBpem6STc3v9xLP41xmVJWnKGKo6S7jWfBylNOJwEBRKVfjwobu6I/b3cG
         vLuIcAWtuyElu9Lj+5u2lacohvH6MU/zSAVIDOZubGMQ6iNJ1OzUDI5U5Y2waP2A3QST
         J0lhHpmf2huPd2brcCe9PfQuO5ZkIB02CLEH6Il3HOrwZjyOZtN6jaHfbDOk/cnFN3pP
         qMIUiQOL4UsIuQv1jXRoTHqyE8pSnd7EhfXeoo6/BPBCbum6IW7aqjsCmAQyPizK4IzM
         Q6qQ==
X-Gm-Message-State: APt69E3prwfVXqxh4iniYoNZ0AWQ3g208NIEnai6zyFr10CC5OVEeyJo
        HPPwG2IxedeYrlR3j/4Be9TKeaKgS62JM2qcNX0=
X-Google-Smtp-Source: AAOMgpche7VO66/YX3n99l8NrTAhtMaM6hK/V53wGTxv3NgA0Vq+AOCLE7gi7i34yiFgVJN31mEvhTHPmFnBYRsaMT4=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr1361115vkd.161.1530027759212;
 Tue, 26 Jun 2018 08:42:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Tue, 26 Jun 2018 08:42:37
 -0700 (PDT)
In-Reply-To: <20180626154728.16e94b58@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <CAHp75Vesytovn1s-L0RQbEi6Tua=8qKc8a8yDkFmadgscW_UAw@mail.gmail.com>
 <4046ba78-b6c0-c09b-43e2-e3c2e550be9f@exceet.de> <CAHp75VfskABz+KrnLzDTYH=1cESimi++3HwQ2a1tiWkPTqf=HQ@mail.gmail.com>
 <20180626154728.16e94b58@bbrezillon>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jun 2018 18:42:37 +0300
Message-ID: <CAHp75Vda=zqOoAk955B9jLRKE0u34jrV8mMC6RG+RtvrENTbVw@mail.gmail.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 4:47 PM, Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
> Hi Andy,
>
> On Tue, 26 Jun 2018 16:18:44 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
>>
>> > What is wrong? Some newlines are missing here between the MODULE_ macr=
os,
>> > but in my original patch it seems correct.
>>
>> It should be like
>>
>> MODULE_FOO(...);
>> MODULE_BAR(...);
>> MODULE_BAZ(...);
>>
>> One macro =E2=80=94 one line.
>
> It's not Frieder's fault, it's Yogesh mailer which messed-up the
> formatting. Just look at the original patch and you'll see.

One problem less, then.
Good!


--=20
With Best Regards,
Andy Shevchenko
