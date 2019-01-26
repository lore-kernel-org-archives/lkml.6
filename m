Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BIGNUM_EMAILS,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5407C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7106D2184B
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ohmlinxelectronics-com.20150623.gappssmtp.com header.i=@ohmlinxelectronics-com.20150623.gappssmtp.com header.b="1VCMeIML"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfAZVZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 16:25:45 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32982 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfAZVZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 16:25:45 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so11190347ljd.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Jan 2019 13:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ohmlinxelectronics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=17QPtge0zwBGFu5RCUYgRXmfC83merOxa4qb4hL1cg4=;
        b=1VCMeIMLhb1q/tVS14KgAo+B1oZXXWMXhcxQEwWLFCmIcPdccKQ4eHXD8kcPWG+c19
         4eTmQI9wk6AmMGDSdRioBUq0OYMjBtzVW+INItQO/FuPDwx5yFyTqENzPjuWUrqaTRkH
         AncifJ9giGbTsWU5xZ6PATK4oQeC3m0d7tjxQZlmvP3wUY1WQHH2zRQDoVQVGbTvINn7
         bff0Ah4/UHF5I7x4qfa1l68lHnP+gDSZVsujqxoYPuFfG4wKGT03JTlZJD/tQN4+XDdd
         MqKeAy3GjCT0EkahqFlGlFk1udzC5tMCP8dcepD8f2vyX9aYawc/8GNIF0P44gBaNcNS
         Xbhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=17QPtge0zwBGFu5RCUYgRXmfC83merOxa4qb4hL1cg4=;
        b=PmdcwuLMWXiO9A2SulmVKy8oHnd4MAqk95QJnyE+ESLGuXAp1mnN7xZXABERks/Bn5
         E0c6ldSJL0XwCIKpdAUNSDdw2yfuayxAROdQ9xUTgcRGNGl8UdcW+agkqtyFrWu2w0Nk
         JVsd1qYGj+bnrk3/eM+ZXH20lTDPo+VUWGTkrhUxZwvH9wcAQMlNEsvcXE4ku2s+GgVf
         8U5vAeQJWJc/OLatdnexOg0CMfNZSEu1IyRkgLmOFU5/UJCEN2S9+yb000wko5HZ6jBP
         kHAqS3Autcl91cc6mybVakWJu2+wNQ6QKCMKenE0T/T+gxK6U4bQT4BvlJ0GQzULWj86
         uVHg==
X-Gm-Message-State: AJcUukepI6qCR9ROhqux1vW5vV7fcG/r6chLU5sJ/QIUr12Qq2+LkSy/
        ufxoGZDkw+00MhtxstsBflF/zht4wVOxKq+3iH/ZZw==
X-Google-Smtp-Source: ALg8bN4mcS015nAhZjh2zwtaLmSeTCYSb2phxJPgJ2EA+Ev2W/kP4qUVX8NM3GuBsB5r0qpe9mBVgIiCIV2qyUIXnMo=
X-Received: by 2002:a2e:6595:: with SMTP id e21-v6mr12559932ljf.123.1548537942238;
 Sat, 26 Jan 2019 13:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20190122185351.GA28627@kadam>
In-Reply-To: <20190122185351.GA28627@kadam>
From:   Ken Sloat <ken.sloat@ohmlinxelectronics.com>
Date:   Sat, 26 Jan 2019 16:25:32 -0500
Message-ID: <CAPo_4QB+ozVESD85d2qxuitgvgPgLvrjx9SyEMfFTGvkz4MjWg@mail.gmail.com>
Subject: Re: [bug report] Input: add st-keyscan driver
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-input <linux-input@vger.kernel.org>,
        Ken Sloat <Ken.sloat@ohmlinxelectronics.com>,
        gabriel.fernandez@st.com, dmitry.torokhov@gmail.com,
        linux-kernel@vger.kernel.org,
        Nate Drude <nate.drude@ohmlinxelectronics.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:53 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hello Gabriel FERNANDEZ,

Hello Dan,

I have added CCs for the maintainers as well as Gabriel Fernandez as
currently you just have the linux-input mailing list

> The patch 062589b13991: "Input: add st-keyscan driver" from Apr 12,
> 2014, leads to the following static checker warning:
>
>         drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
>         error: potential zalloc NULL dereference: 'keypad_data->input_dev'
>
> drivers/input/keyboard/st-keyscan.c
>     125 static int keyscan_probe(struct platform_device *pdev)
>     126 {
>     127         struct st_keyscan *keypad_data;
>     128         struct input_dev *input_dev;
>     129         struct resource *res;
>     130         int error;
>     131
>     132         if (!pdev->dev.of_node) {
>     133                 dev_err(&pdev->dev, "no DT data present\n");
>     134                 return -EINVAL;
>     135         }
>     136
>     137         keypad_data = devm_kzalloc(&pdev->dev, sizeof(*keypad_data),
>     138                                    GFP_KERNEL);
>     139         if (!keypad_data)
>     140                 return -ENOMEM;
>     141
>     142         input_dev = devm_input_allocate_device(&pdev->dev);
>     143         if (!input_dev) {
>     144                 dev_err(&pdev->dev, "failed to allocate the input device\n");
>     145                 return -ENOMEM;
>     146         }
>     147
>     148         input_dev->name = pdev->name;
>     149         input_dev->phys = "keyscan-keys/input0";
>     150         input_dev->dev.parent = &pdev->dev;
>     151         input_dev->open = keyscan_open;
>     152         input_dev->close = keyscan_close;
>     153
>     154         input_dev->id.bustype = BUS_HOST;
>     155
> --> 156         error = keypad_matrix_key_parse_dt(keypad_data);
>                                                    ^^^^^^^^^^^
I agree with you this would be a problem
to clarify the NULL derefence would occur here within keypad_matrix_key_parse_dt

struct device *dev = keypad_data->input_dev->dev.parent;

> This assumes we have set "keypad_data->input_dev = input_dev;" but we
> don't do that until...
>
>     157         if (error)
>     158                 return error;
>     159
>     160         error = matrix_keypad_build_keymap(NULL, NULL,
>     161                                            keypad_data->n_rows,
>     162                                            keypad_data->n_cols,
>     163                                            NULL, input_dev);
>     164         if (error) {
>     165                 dev_err(&pdev->dev, "failed to build keymap\n");
>     166                 return error;
>     167         }
>     168
>     169         input_set_drvdata(input_dev, keypad_data);
>     170
>     171         keypad_data->input_dev = input_dev;
>                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
> this line here.  This driver has never worked and it was included almost
> five years ago.  Is it worth fixing?
>
>     172
>     173         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>     174         keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
>     175         if (IS_ERR(keypad_data->base))
>     176                 return PTR_ERR(keypad_data->base);
>     177
>
> regards,
> dan carpenter
>

Here is the interesting thing, I was looking on patchwork, and several
of the patches including what appears to be the latest actually set
"keypad_data->input_dev = input_dev" before calling
"keypad_matrix_key_parse_dt"

From v4 on patchwork
+ if (IS_ERR(keypad_data->clk)) {
+ dev_err(&pdev->dev, "cannot get clock");
+ return PTR_ERR(keypad_data->clk);
+ }
+
+ keypad_data->input_dev = input_dev;
+
+ input_dev->name = pdev->name;
+ input_dev->phys = "keyscan-keys/input0";
+ input_dev->dev.parent = &pdev->dev;
+ input_dev->open = keyscan_open;
+ input_dev->close = keyscan_close;
+
+ input_dev->id.bustype = BUS_HOST;
+
+ error = keypad_matrix_key_parse_dt(keypad_data);

According to patchwork, these aren't listed as accepted, so I'm not
sure where the exact accepted patch came from. Looking at the commit
log, it looks like the issue you showed above was made in the original
commit 062589b1399176a9c14bc68e16169f40439d658c so I'm not quite sure
what is going on here. Maybe the maintainer can chime in with the
original patch/mailing list discussion on this. For reference, I've
added the patchwork links below
https://patchwork.kernel.org/patch/3854341/
https://patchwork.kernel.org/patch/3968891/
https://patchwork.kernel.org/patch/3969991/

Thanks,
Ken Sloat
