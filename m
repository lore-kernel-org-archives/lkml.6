Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53031C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A16222D2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ejKiObQr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393748AbfBMS3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:29:49 -0500
Received: from mout.web.de ([217.72.192.78]:37581 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405025AbfBMS3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1550082563;
        bh=xednqIM0+6ktMolVDfAbIwTjTvD2JeT7usXBxgKSzME=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ejKiObQr01xO5AFKOy19t0b0o52aUELFK7lqaWK2+H7r43YIy4pZU65za15FhT4ST
         u97L6QnCcmfbVb2S1oDhKiUybIrPJGp/UFnvWxHd61YkYrafynMSJ8lmJxua+hUrAb
         vp81/WTGDCnBcjNg2H2PErULD6WJsNazJpzKtDi4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.74.172]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MddBI-1ghql44AUG-00PIio; Wed, 13
 Feb 2019 19:29:23 +0100
Subject: Re: [PATCH v3] Coccinelle: semantic patch for missing put_device()
To:     Wen Yang <wen.yang99@zte.com.cn>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Wen Yang <yellowriver2010@hotmail.com>,
        Xue Zhihong <xue.zhihong@zte.com.cn>,
        Yi Wang <wang.yi59@zte.com.cn>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c10e0bf1-4830-7ee4-5b21-70b521dd6c36@web.de>
Date:   Wed, 13 Feb 2019 19:29:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550039015-5587-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Hgm8gBs46GbiLsOpsBJwrQeXu8ns3gU2/znnZYe1ffbDyXXi2Xv
 DJBPSdQkQTYygp1w1L5enlC9qNvzwHPX1qIkMMFdC3LdKU5z3hAYUAV6UKBceG8slJsznRJ
 fYhB8901YnBltFebjnzK6f+27dlmbMOsfvp2aVvx85nqAYIZSnLrhBApu3h2/BBg3ZJOLfT
 2L/E2dr29o++68efGNIww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LD0Nyk4gm/s=:d0hZXlAiGwZv+XZ9hnmucz
 UEAI5bBNv+hYwbO+uMxp0lldsxcrRnea7Tx9SzN4aGqqV600vmvWUBjDVrdQK80llAvnPCEXk
 H+2kxEtQ67HBWqOEP1Tu7BoZ7BNZ7ypK8L7Jg22aaP4SI2ojpV288FfXrHxBbFzvjUE5iM+55
 SdUTOGNTIb8CVL+DT6QDC6M111oY09jCGhPZgQcASqqL6qSlLWg4SNGZvFKqy8FU5S4a8TooC
 XdSTJAhDPryeA3s6L/ngJcv9Yl0OzvI2sry7wfomJIBprH+O+RPNNl9qN4dxDdNxCtPvFeyIf
 bWz1hixEEs+srVEkl/Zx5NZx3HD/Jd75wY6pOnfVnQyemjhEe77yv/EVWAkUp2YViT3mJqIXz
 Sl4zQrziHBwcAaXEGAruXjRPvb2Z0nSH8BL6n1HUCxOUB8THR1Gpt2GtM7thONJV4XoNa6anf
 rJjp4uDf+XofkvQ4vS2ikG+kf/F1RA4ZtZIXRcEN/S49PVdTlj310/DDmuGRcsCIvz4oOwnlH
 7KnVhUsrPcj7BOJOgiJfuI6KZ9PYiqnHxbRzlQHUvNg70TSM0a8RZ62m55lUMYBfJZMkBOrnI
 AUFI+pS0vUYp8/QSk1qEIQVBNyDkK2hKEbTRFsLrW7/UDmW6i4ug34Brtg40P+OhYYKSmCfnP
 MlG7YY1GAAycg7rSWy1+0FOL0iManekuKnS/n1ukWzu51EI46qyGG2P3qwMhoyHrVoTw1VO10
 M7xQLuV1LmKH3dCUX4XTKL+vp1Y3HsP3PcbnAnYHkF3psI2FK+Hcnnx+qu3EDfsFkthUWEqQG
 MOvRWn0JMDwXFOFmy1KCi60l3Kcw2k2bytoKEAPlBVRkLDoZdW2SlT5045BPf+ocB3F3EGU8d
 MKDsCdyUNJUoNWD7UgSWouAVKiVj5zUc+6EHta/y04q+f4OiD0yi5IXN1o9mPcBd6GTkNDF3r
 lQCMk7PxmRQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.

I have got another concern for further software development considerations.

How do you think about to describe here if it can be determined
by source code analysis that the desired release should be performed
only in the same function implementation (or not)?

How much does this aspect influence the source code search confidence?


> +    when != e1 = (T)id
> +    when != e2 = &id->dev
> +    when != e3 = get_device(&id->dev)
> +    when != e4 = (T1)platform_get_drvdata(id)

I have got another idea for a bit of software fine-tuning at such a place.
I am unsure if it can become relevant to reduce the number of metavariables
here by introducing a SmPL disjunction.

+    when != ex = \( (T)id \| &id->dev \| get_device(&id->dev) \| (T1)platform_get_drvdata(id) \)


Regards,
Markus
