Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715E3ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2830420C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 13:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5lrBtNk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2830420C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeGQOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 10:16:18 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44756 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731774AbeGQOQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 10:16:16 -0400
Received: by mail-oi0-f65.google.com with SMTP id s198-v6so2060907oih.11;
        Tue, 17 Jul 2018 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kQjAHGuCwWOiZbj5xCHfmiNRpV5WlXNok/41JMCzrSY=;
        b=H5lrBtNkyCN4n5offXMefbkn+QitLOXbo/s7ucTS8IvqLB3QPf8ugPROz9+CY1XpYi
         ZXcn+3kF54OtI70gZpjY/xAeg7sbaDuF+Disjr7gXnhkFETCVHprywEg6BVXC/Zeez0C
         ES1KSJtfNh6pwsv0tpjsr4g2yONvXonmdrFHnGqdoYojVHvTk96gMdjeerwhVEw0pEep
         Ac6R0GlzZq5YHDUEasX4GV8HDXhHR61sZ9Hi03eDrV66j5H8HmoD8SuyUyZpo63HXa5z
         a5YEnhS4kKwwKjPT9vVR57PWTvSV57MPvNwy7PltGCs8W64qyltNcOhHo2cvB8Ma3vRa
         g+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kQjAHGuCwWOiZbj5xCHfmiNRpV5WlXNok/41JMCzrSY=;
        b=GlyDsy/d/vXwCoNV184SGX6BDB6xNKe/9tZsi/qNO9QnLGtkxhuNkwh65ZgHcN0qrf
         Pl/Y1ZmwlWsPe6wW1cWcnRFKVeNjO/pQqlili2X88av+hPJ983SRSYhsoPF4EZCQ8FKt
         6h+7TJwa1RSJChBHaHs+KhgY/Ld0hzPXKOoAFHcRqmEUKKEGnBmiHJh2Z6oZXhJExg/b
         ABgOj8T61zqMC7zEdq1wlnWqv2hJNzUPCqU20L8N9oTrvprLqPJoflccSSeuMxuwXJBs
         1MF8uIqWTdpw3fXqXuiWaeKKG663VoZ5d5JoOuYnzUW1Xdt+SEDyeNJ7kbNW4p/YhARm
         Jo8w==
X-Gm-Message-State: AOUpUlFJx9b3VTfKR/+FM1ItQm3GO3X25qDJZ11HU4gjfP8XYsxQuFLi
        fRe3agSl4wjgFDRRhWYhuFSd3YNus7p92jRUHgU=
X-Google-Smtp-Source: AAOMgpfe50z7BB5tuN11lAbTJ8WZ8Q0wqnnbl2FeDTUDveyKT+NNbGw9NL/tgqi6tOQ8lUsQdbCi5FjlHhsK7VATE6I=
X-Received: by 2002:aca:e510:: with SMTP id c16-v6mr1864551oih.44.1531835012500;
 Tue, 17 Jul 2018 06:43:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Tue, 17 Jul 2018 06:43:32
 -0700 (PDT)
In-Reply-To: <AM3PR04MB13153EB5ADEBCD57A7122B61F55D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1531208921-23342-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5BSt4jdLWmXjNmTDAegGwtRWjbMuVAwdrnRyHWvSBuU5A@mail.gmail.com>
 <AM3PR04MB131577674FDF0BC65BEF518EF55F0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <CAOMZO5DCsdwXK0eftcpwzT4my30HZLR7-H2c+V=ro+_fOMAWCw@mail.gmail.com> <AM3PR04MB13153EB5ADEBCD57A7122B61F55D0@AM3PR04MB1315.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 17 Jul 2018 10:43:32 -0300
Message-ID: <CAOMZO5BrGdX3b9wcsA=3TkoGgh4H-fvghEqmhgovk-4uhYph7w@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add power management support
To:     Anson Huang <anson.huang@nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Jul 16, 2018 at 3:14 AM, Anson Huang <anson.huang@nxp.com> wrote:

> OK, since i.MX7D has same GPIO type as i.MX35, to make it simple, I just added
> a flag to indicate whether it supports save/restore, only i.MX7D enables

In imx7s.dtsi the gpio nodes have:

compatible = "fsl,imx7d-gpio", "fsl,imx35-gpio";

If you add fsl,imx7d-gpio entry in the gpio driver, then the match
will be done against "fsl,imx7d-gpio" since it is more specific.

Then in the mx8 dts you can add:

compatible = "fsl,imx8m-gpio", "fsl,imx7d-gpio";

and it will also match the more generic "fsl,imx7d-gpio" compatible.

> the flag now, since other i.MX8 SoCs' dts is NOT upstreamed yet, so I did NOT add
> support for i.MX8 SoCs, please help review V2 patch, thanks.

I did not see the v2. Did you put me on Cc?
