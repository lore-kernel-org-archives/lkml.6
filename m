Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BIGNUM_EMAILS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 717DAC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C98218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xu8P9oRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAZWP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 17:15:27 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40282 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbfAZWP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 17:15:27 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so14491903ita.5;
        Sat, 26 Jan 2019 14:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oN/RG/NczLuQggCzhL4uB7wLCuY4YFBKkpSelxHuQPs=;
        b=Xu8P9oRfqH+pmqjApV2ISjT0SeLXXRJuTKBoBYpEOdHRAyzo4RnM2CgUqssoBhaiIj
         C5uZotaBLp7SC4+wFM/IOtIbncU3bpj+mU9OaILrYv0yZoz8UTcHo2txrvLXeckg30HO
         U3iUU9OfaL2RCvQkEWlAwxxhR2wABaTA7+aATEkqfxaQLnQ1EbMeyW03UlTqh2xNXtdD
         Wc0rus501/sAoUkqpJjpBySMbjcxF9eMvS0PmuvwERIkVOX6j2ybGsbB/cn+Xi9uQTbC
         rSmlKagwmjONA1NPRu86d+zRvKNQwOUaLmjItNhPlIcdFEVKtFO7bBnVAdvmrlOHLVjI
         OC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oN/RG/NczLuQggCzhL4uB7wLCuY4YFBKkpSelxHuQPs=;
        b=CQkNXNcPldbkJnfbOA74sdv+5K04FaIQQKwJL5z5z7oAEA/ZAwSjhOfNv1kmanxINT
         4P/UIvZIe13KfjUOChom7ry2khU9GmR0rhpUkbYoRDmEqHnRHULEvL/rxs3PB0wd4mbQ
         znk62w+e/g79w86p5afOzQJKIM+oNfbuFgEieQGUE4KbBQMYHPjSn+76/AF1IcWOCwMI
         r3xml6gUthxssasGZmEmE6MyF4Qr4ukwxKE58zBVCOTigeIhZx39fac0spc/c7FZXVzU
         R/yyhmuV2rMFh/lASlEcos4bdblF23JxY7zWsB1wGTxzOI9MX1uw+jZnxXYDxQGkBo2x
         sdHg==
X-Gm-Message-State: AJcUukfpDsY/BRgxfIKi9LNURDw+U5WZlNJF6D5dIoKnMZ9euSMCxFBP
        AdXCBPWRFXhdpGtlvjGGl5cLkWkH0xbIUlHVUss=
X-Google-Smtp-Source: ALg8bN42aflF5DiZ+g7fJX5425h7XOgIEkg6PLbqNr6t/G7q/fSCieloiaTy7gHO6M3rnI7JG29cR4RNaPI+MuJfLpU=
X-Received: by 2002:a24:36cf:: with SMTP id l198mr7806705itl.102.1548540925131;
 Sat, 26 Jan 2019 14:15:25 -0800 (PST)
MIME-Version: 1.0
References: <20190122185351.GA28627@kadam> <CAPo_4QB+ozVESD85d2qxuitgvgPgLvrjx9SyEMfFTGvkz4MjWg@mail.gmail.com>
In-Reply-To: <CAPo_4QB+ozVESD85d2qxuitgvgPgLvrjx9SyEMfFTGvkz4MjWg@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Sat, 26 Jan 2019 14:15:12 -0800
Message-ID: <CAKdAkRT6hKywKW1NnD-hiuFn9YTZF74GZVr36ZNJqyoxQghT9Q@mail.gmail.com>
Subject: Re: [bug report] Input: add st-keyscan driver
To:     Ken Sloat <ken.sloat@ohmlinxelectronics.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-input <linux-input@vger.kernel.org>,
        Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Nate Drude <nate.drude@ohmlinxelectronics.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 1:25 PM Ken Sloat
<ken.sloat@ohmlinxelectronics.com> wrote:
>
> On Tue, Jan 22, 2019 at 1:53 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > Hello Gabriel FERNANDEZ,
>
> Hello Dan,
>
> I have added CCs for the maintainers as well as Gabriel Fernandez as
> currently you just have the linux-input mailing list
>
> > The patch 062589b13991: "Input: add st-keyscan driver" from Apr 12,
> > 2014, leads to the following static checker warning:
> >
> >         drivers/input/keyboard/st-keyscan.c:156 keyscan_probe()
> >         error: potential zalloc NULL dereference: 'keypad_data->input_dev'
> >
> > drivers/input/keyboard/st-keyscan.c
> >     125 static int keyscan_probe(struct platform_device *pdev)
> >     126 {
> >     127         struct st_keyscan *keypad_data;
> >     128         struct input_dev *input_dev;
> >     129         struct resource *res;
> >     130         int error;
> >     131
> >     132         if (!pdev->dev.of_node) {
> >     133                 dev_err(&pdev->dev, "no DT data present\n");
> >     134                 return -EINVAL;
> >     135         }
> >     136
> >     137         keypad_data = devm_kzalloc(&pdev->dev, sizeof(*keypad_data),
> >     138                                    GFP_KERNEL);
> >     139         if (!keypad_data)
> >     140                 return -ENOMEM;
> >     141
> >     142         input_dev = devm_input_allocate_device(&pdev->dev);
> >     143         if (!input_dev) {
> >     144                 dev_err(&pdev->dev, "failed to allocate the input device\n");
> >     145                 return -ENOMEM;
> >     146         }
> >     147
> >     148         input_dev->name = pdev->name;
> >     149         input_dev->phys = "keyscan-keys/input0";
> >     150         input_dev->dev.parent = &pdev->dev;
> >     151         input_dev->open = keyscan_open;
> >     152         input_dev->close = keyscan_close;
> >     153
> >     154         input_dev->id.bustype = BUS_HOST;
> >     155
> > --> 156         error = keypad_matrix_key_parse_dt(keypad_data);
> >                                                    ^^^^^^^^^^^
> I agree with you this would be a problem
> to clarify the NULL derefence would occur here within keypad_matrix_key_parse_dt
>
> struct device *dev = keypad_data->input_dev->dev.parent;
>
> > This assumes we have set "keypad_data->input_dev = input_dev;" but we
> > don't do that until...
> >
> >     157         if (error)
> >     158                 return error;
> >     159
> >     160         error = matrix_keypad_build_keymap(NULL, NULL,
> >     161                                            keypad_data->n_rows,
> >     162                                            keypad_data->n_cols,
> >     163                                            NULL, input_dev);
> >     164         if (error) {
> >     165                 dev_err(&pdev->dev, "failed to build keymap\n");
> >     166                 return error;
> >     167         }
> >     168
> >     169         input_set_drvdata(input_dev, keypad_data);
> >     170
> >     171         keypad_data->input_dev = input_dev;
> >                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> > this line here.  This driver has never worked and it was included almost
> > five years ago.  Is it worth fixing?
> >
> >     172
> >     173         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >     174         keypad_data->base = devm_ioremap_resource(&pdev->dev, res);
> >     175         if (IS_ERR(keypad_data->base))
> >     176                 return PTR_ERR(keypad_data->base);
> >     177
> >
> > regards,
> > dan carpenter
> >
>
> Here is the interesting thing, I was looking on patchwork, and several
> of the patches including what appears to be the latest actually set
> "keypad_data->input_dev = input_dev" before calling
> "keypad_matrix_key_parse_dt"
>
> From v4 on patchwork
> + if (IS_ERR(keypad_data->clk)) {
> + dev_err(&pdev->dev, "cannot get clock");
> + return PTR_ERR(keypad_data->clk);
> + }
> +
> + keypad_data->input_dev = input_dev;
> +
> + input_dev->name = pdev->name;
> + input_dev->phys = "keyscan-keys/input0";
> + input_dev->dev.parent = &pdev->dev;
> + input_dev->open = keyscan_open;
> + input_dev->close = keyscan_close;
> +
> + input_dev->id.bustype = BUS_HOST;
> +
> + error = keypad_matrix_key_parse_dt(keypad_data);
>
> According to patchwork, these aren't listed as accepted, so I'm not
> sure where the exact accepted patch came from. Looking at the commit
> log, it looks like the issue you showed above was made in the original
> commit 062589b1399176a9c14bc68e16169f40439d658c so I'm not quite sure
> what is going on here. Maybe the maintainer can chime in with the
> original patch/mailing list discussion on this. For reference, I've
> added the patchwork links below
> https://patchwork.kernel.org/patch/3854341/
> https://patchwork.kernel.org/patch/3968891/
> https://patchwork.kernel.org/patch/3969991/

It may very well be that I messed up when applying the patch. I guess
whatever platform that is using the driver has not attempted to update
their kernel since then.

Thanks.

-- 
Dmitry
