Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D33C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF865245C5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDMHGNIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF865245C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934375AbeFVQ1X (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:27:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:43648 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934061AbeFVQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:27:21 -0400
Received: by mail-ot0-f194.google.com with SMTP id i19-v6so8113219otk.10;
        Fri, 22 Jun 2018 09:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YTOwI7XkivqFS60t2cdtXzjta4Bc+H3Zs08Fazh57p0=;
        b=UDMHGNIrYp1MkrjsS0wumYWKBHEMV5BcLeZyIj9elNOANl7xipVb3zriLY/CmyCufW
         0L54SCr2GSjKg8szTOufFi93DRe75ajErOkkGACtO/p3ppso07uNwa7gtsigBy/0DBoZ
         fpdCrJ6zYNCJe8OcMHdOk+8Y3wszEdeoKGyML1nInpFaqDQdkU2R+/6J/lOsqldIgu+f
         +UlHr2WIjJhxyKyDQwOUufFajSnP5yEDr3RHfEVyKGMRvLMGaMJn3F4LyovYCCzrW175
         AME2t86La+kaWlhkGXESzGukBYDaLltnvT1uFazUZntQlYY4f79MQvS5Y3dMTZ+Cuha+
         fiCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YTOwI7XkivqFS60t2cdtXzjta4Bc+H3Zs08Fazh57p0=;
        b=r01FpN7v2cvM8RYy3EHC2ZlSGTex0n441TByjvMZAPCwmC4eQUdLyyRFTWI/Mffjdq
         m39752eQBRnBo0mk5htRmQNVMHzn2kdoxSMI3zT9KDtXQqLrcDPF3IA7BGdHsi1wqM0A
         FKsn4B0/Frx9fuY/w4pxHN/2egz6hsbnSgxEnA09gl1xf5P/TVKzFMiC0XQObIXo5N0v
         kzBpme8eAZ3QSxWGV3i6u79T1sCxFfFnU7R0Y3FU2n47rIyx/jjyB23QIH55K82hF55f
         VrHq+y4rWyLdC1yXHyodMy09BpQ6UbO18CM1c1AvYtdD43gPrNaW18Okgy1vm6Z14u07
         +Aug==
X-Gm-Message-State: APt69E1fg43Lhah/NN4FHMoM3RRcjsREeFJIrKP6QtGQU5vBwe8ixkD8
        08VoRdsow2RFPhrYrxlYtuxG/RooZu4WvoNGQRI=
X-Google-Smtp-Source: ADUXVKIXzJtWu2oDfuSbtTHmnRGY3lM6gA9riJuzMBI+joYO2rCaYeO5+DHpKpRxg1FJZwyETGpH68Cr6qjSm3wY8MY=
X-Received: by 2002:a9d:62d3:: with SMTP id z19-v6mr1244853otk.159.1529684840764;
 Fri, 22 Jun 2018 09:27:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1049:0:0:0:0:0 with HTTP; Fri, 22 Jun 2018 09:27:20
 -0700 (PDT)
In-Reply-To: <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
References: <20180530173414.6121-1-andrew.smirnov@gmail.com>
 <CAOMZO5AyAegbvUtX42by99mU8yQfi91bmhJfd9iqu1Ak0dEHiw@mail.gmail.com>
 <CAOMZO5DJj=oQfsB-vNP=81HCiy-69j-5U+Km9P6LxGpnLx9xzg@mail.gmail.com>
 <CAHQ1cqHxq+RM1nNHECY75Cojd_kxu1ERLe6+MhMLUa5kb10r8w@mail.gmail.com>
 <CAOMZO5B98O9XA8GhdWxJZ6DFgS=O+smHURm8v5jEirj31tuUhg@mail.gmail.com> <CAHQ1cqELs4LaQkmPiPjXQuF17+7PBsEtbmSt8iveLqRv+4bgfQ@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 22 Jun 2018 13:27:20 -0300
Message-ID: <CAOMZO5CumdNSP6iTfgXPdmpcZwh7YmBstUpAmb3A1QAf1UWJdw@mail.gmail.com>
Subject: Re: [PATCH] usb: chipidea: Fix ULPI on imx51
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Peter Chen <peter.chen@nxp.com>,
        USB list <linux-usb@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Thu, Jun 21, 2018 at 6:44 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> I just finished experimenting with it on RDU1 and Babbage boards and I
> can't reproduce the hang that you describe against 4.18-rc1. At this
> point I wonder if it's the bootloader that is a variable that plays
> into this. I was booting both boards with 2018.06.0 version of barebox
> + the custom patches that can be found here
> https://github.com/ndreys/barebox/commits/rdu1-netboot. Note that the
> last patch in that branch/stack was added as a part of this
> investigation, but even before it, I was able to boot Linux just fine,
> albeit without working USB.

Thanks for investigating this issue.

Yes, t is possible that the difference in behaviour that we see could
be related to the fact we use different bootloaders.

In order to make things easier, I am sharing a Buildroot image for
imx51-babbage that contains U-Boot 2018.05 + kernel 4.17.2:
https://www.dropbox.com/s/yevnu4y1zdchnbt/sdcard.img?dl=0

Please flash it directly to the SD card via dd and boot it.

You will notice that it will boot normally. Then please copy a
4.18-rc1 zImage into the first SD card partition and you will notice
the hang.

Thanks
