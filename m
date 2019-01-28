Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F384C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130D421736
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfKHUTWq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1JyG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:54:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33790 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfA1JyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:54:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so7791043pfb.0;
        Mon, 28 Jan 2019 01:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fi6O1mMV9fCh6s7tRdcXTLbJkI2knMnRFYfcxEyaGfY=;
        b=KfKHUTWqPlyNkbo3urh4Ov/783pod97HO+XOtcioDhrPnpzdrTz5kYtBV/OQTXm+Ko
         c58xtsCXRqxcEUSo+Gypnef3hteUl5BZ4NJVd5ehKN5A5iGmqr6roWSMmBXEWP67bFCd
         H2FYAwXP7qoWMNV6e7+n4wjcjInU9R8Wdkmmff8tFnEuA7ydhB+OCDC2p7+fb0NKCg2s
         Ri6tAdsCRb9RngV25z+X+E8fPVtteO0A536cH9rlURXWPpGX/P1uoQdy8PbysiYR2Jnf
         ogJo132ks9UXA0sMkdVTMArQepnU0Dl2j21RnmPbwZvLi0SAZXu3jeDOgertcV0PBBnf
         6fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fi6O1mMV9fCh6s7tRdcXTLbJkI2knMnRFYfcxEyaGfY=;
        b=QK+3Yx8ipmGjUDu95gUSMfD/abZagDgW5B6Q5uu577cz0IKA0aCIwPjCgcLIKUbVdE
         vLQ1DnCS2hzAV80UASEMe05tb2sTnZIqCCO5JQ5KxnFvrvsL09wLPPrXpBlhb9TbaSe7
         TkDQVILauFCp3HLNdIi4duQiSGSlK1sF9mmCXnKaLkz74MwvEJPjvlxovlyjjkURPGZC
         D7bVQjXwnSuWgzlbvanvXovpy1zW3C+aDrac4jNu2E3fbvz6maGettCT85SOOOCkHc9O
         PfWhx3TyJdc3o/6sMDf5mUEVcI0ccDfurFQGfhDRBbTEaJDJoiG0a8K7b7CPDM0GTwAi
         IAjg==
X-Gm-Message-State: AJcUukfTxD3CBJMbSmEYYYhzLGBDhmrX/irQxNIsDq3I4Lm3qQhylmQ9
        781fHVLSQbp2gfLm4/dcGTMdQCIBLTFEhyyRF4Q=
X-Google-Smtp-Source: ALg8bN4NVNKwP5DUUVHB+zu+b71W+6rS+KwZeHhABexeorURrWUYHe8QVibd99+Way1tZTiEnvaRsj4l2gFCcR53nLE=
X-Received: by 2002:a63:20e:: with SMTP id 14mr19145509pgc.161.1548669245576;
 Mon, 28 Jan 2019 01:54:05 -0800 (PST)
MIME-Version: 1.0
References: <20190125131519.88416-1-heikki.krogerus@linux.intel.com> <20190125131519.88416-5-heikki.krogerus@linux.intel.com>
In-Reply-To: <20190125131519.88416-5-heikki.krogerus@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 28 Jan 2019 11:53:54 +0200
Message-ID: <CAHp75VfG9LDOfz9K0jYvGOK=j1uDmyg=eeRMur7hnw2rF9qx+Q@mail.gmail.com>
Subject: Re: [PATCH 4/8] usb: typec: mux: Find the muxes by also matching
 against the device node
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 3:17 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> When the connections are defined in firmware, struct
> device_connection will have the fwnode member pointing to
> the device node (struct fwnode_handle) of the requested
> device, and the endpoint will not be used at all in that
> case.

>  static void *typec_mux_match(struct device_connection *con, int ep, void *data)
>  {
> +       const struct typec_altmode_desc *desc = data;
>         struct typec_mux *mux;

> +       bool match = !con->id;

I don't see how this assignment is used.

> +       size_t nval;
> +       u16 *val;
> +       int i;
> +
> +       if (!con->fwnode) {
> +               list_for_each_entry(mux, &mux_list, entry)
> +                       if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
> +                               return mux;
> +               return ERR_PTR(-EPROBE_DEFER);
> +       }
> +
> +       if (match)
> +               goto find_mux;
> +
> +       /* Accessory Mode muxes */
> +       if (!desc) {
> +               match = fwnode_property_present(con->fwnode, "accessory");
> +               if (match)
> +                       goto find_mux;
> +               return NULL;
> +       }
> +
> +       /* Alternate Mode muxes */
> +       nval = fwnode_property_read_u16_array(con->fwnode, "svid", NULL, 0);
> +       if (nval <= 0)
> +               return NULL;
> +
> +       val = kcalloc(nval, sizeof(*val), GFP_KERNEL);
> +       if (!val)
> +               return ERR_PTR(-ENOMEM);
> +
> +       nval = fwnode_property_read_u16_array(con->fwnode, "svid", val, nval);
> +       if (nval < 0) {
> +               kfree(val);
> +               return ERR_PTR(nval);
> +       }
> +
> +       for (i = 0; i < nval; i++) {
> +               match = val[i] == desc->svid;
> +               if (match) {
> +                       kfree(val);
> +                       goto find_mux;
> +               }
> +       }
> +       kfree(val);
> +       return NULL;
>
> +find_mux:
>         list_for_each_entry(mux, &mux_list, entry)
> -               if (!strcmp(con->endpoint[ep], dev_name(mux->dev)))
> +               if (dev_fwnode(mux->dev) == con->fwnode)
>                         return mux;
>
> -       /*
> -        * We only get called if a connection was found, tell the caller to
> -        * wait for the switch to show up.
> -        */
> -       return ERR_PTR(-EPROBE_DEFER);
> +       return match ? ERR_PTR(-EPROBE_DEFER) : NULL;
>  }

-- 
With Best Regards,
Andy Shevchenko
