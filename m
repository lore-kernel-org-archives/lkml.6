Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB14BC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8772123E49
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMDdgydg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8772123E49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752641AbeGBNyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:54:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45063 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeGBNyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:54:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id m2-v6so8564762oim.12;
        Mon, 02 Jul 2018 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M8l+uad6sZO1dUMfQdDqB5Vk+4j0+qikrl1pzFsBPv8=;
        b=ZMDdgydgJ32l2xSrGpP+CLdLEDyIUrwup6DTWoUjxVAAS8wQW6/3DS09WCHi5lH66p
         j09FT1eV6I37zjGsKgCDgk8E+ogHzXtsRYL7l66LofU57fxYGJH8xnWRpLy6t7CwfNc4
         z7a/5otVmEuFb0TfIHjHppqjjw3W8CyeanHR9nY+UxI041bU70+yFCzioZgeKUENJtm7
         v/ipUQawLnBlzFpleAQhUNBOtSlU1qjJup1iZd34Ya5Am5LJ/ASPjUs8CetXIV7Uj5oU
         Z599aS7/BpbBSoI6EerIGb46xyB6MLffovq0gGR9vWLK0XWMHxXgAW0KfVG+0zBzMOFV
         3NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M8l+uad6sZO1dUMfQdDqB5Vk+4j0+qikrl1pzFsBPv8=;
        b=IOlVYHp93KXesxexFmNy94+yQgNi1SzQwHeBR/SS9L2vsd61Jcs4ZBLMrjOGKGK/jF
         90cIZZMKfJy43Bq84h35G5NKfylvHhxEBYKJeEpoqOd9/vnnz4gXwYLokm8emye3N4e9
         2Nt/PHoqfRJIfQ7QoAe746m64hjYC3kkE1nrbqEhCOlwHdYlid2uG1ssLl3UasWK7a2Y
         O2m+CnsN5SOb8w50mn1/khhcSh9wUFlUiPMj3ZPtFgXPmJUEaWTl0e7IGWOfWZ8wTPZR
         VCnrQ4LTOH0uvTh55aqgYNOTsoCfK1BJx7AKLEwm3s9JjLOK9Gl4k0wv1BY/Wde/8zud
         ekmQ==
X-Gm-Message-State: APt69E2IV0yx/JROzk8BSIDMchnMUgZ64n07anvFg0CAoHGMQvkog3mg
        43YATiNYrdLZT3YWwWNoHIfW0MCjKnGIiD323Uc=
X-Google-Smtp-Source: AAOMgpfH1qsnN/oijlT54zzVcZtvOVcJsjsnu14IpNvD+o0JmkxOnIywpIUnttbdAvCkqml84cHV1nP/7CezzXsFUv4=
X-Received: by 2002:aca:b641:: with SMTP id g62-v6mr4770293oif.71.1530539646948;
 Mon, 02 Jul 2018 06:54:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:ea3:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 06:54:06 -0700 (PDT)
In-Reply-To: <CACRpkdbbbbO-94i-ZTSunzuUQcJ8dQpuPHBYODrvdWQyuri7yw@mail.gmail.com>
References: <1530243004-10529-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdbbbbO-94i-ZTSunzuUQcJ8dQpuPHBYODrvdWQyuri7yw@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 2 Jul 2018 10:54:06 -0300
Message-ID: <CAOMZO5Bw8u_rkY9iow=ypDvG4+9OE77b8hDneOxFHxNO54m9Aw@mail.gmail.com>
Subject: Re: [PATCH] bindings: add clocks optional binding for imx gpio
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 10:45 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Jun 29, 2018 at 5:34 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
>> Some i.MX SoCs have GPIO clock gate in CCM, accessing
>> GPIO registers needs to enable GPIO clock gate first,
>> i.MX GPIO driver will enable clock gate if there is
>> clock property in GPIO node of dtb, add optional property
>> to i.MX GPIO binding doc.
>>
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>
> Make sense since the gpio-mxc driver already supports this :)
>
>> +Optional properties:
>> +- clocks: the clocks used by gpio bank
>
> Should the text be "the clock for clocking the GPIO silicon"
> I guess that is what it is. And singularis?
>
> Does it hurt to give the clock a name? Like the common
> "pclk" for peripheral clock or something similar that other
> i.MX silicon uses?
>
> Fabio: can we have your ACK on this too.

In case a respin will be made for this one I would suggest to add the
name of the SoCs that need to pass the GPIO clock like imx6ul, imx6sll
in the commit log.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
