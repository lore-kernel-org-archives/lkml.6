Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D54C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE2E4207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVu/Pjlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731669AbfA3QBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:01:31 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35941 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729904AbfA3QBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:01:31 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so13660pgm.3;
        Wed, 30 Jan 2019 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nVmxviDuAeeieoAndcNkCA+yQlPoK+Mq1k0G+gwtMZs=;
        b=LVu/PjljpH1qjZHJsIq3K2PHu8rbZ1aHwSyz6XMfN/dXv5ipsJ10CvUu2znPesa/3C
         MEsForVx6wv2DyeR8EKG5RWAvff+/EvtZl074Fh6Fl2H7+9Gr/00XUx2/U61t5bHK7ly
         mih3JXhzLX1qB7VA5tPgyhHq2mDLzZA59BIIa9kEpyMZA7v+XKkQEYs0BtoPFbhNVZ2V
         vKQN1CmKc67Ge0OHeCzRuMynRG5Tqzd0Tbrrip0jt9P73idpqDh48hJF3unnrREzGlEY
         QJXQ+WOYt55FQQ8n4pPNP3WT3MXzZIgkA+gIW4Vfio3sZZZP5LUPFkVFggSf1K/ZAoSu
         cb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nVmxviDuAeeieoAndcNkCA+yQlPoK+Mq1k0G+gwtMZs=;
        b=KUJgYpzZK3NMWB9AAgPG3GVZ1q0UF3uyWQwDascvBINcQBjwTNb8wr0RplZXqBH7Sl
         AGJUse/DlyMekSYKc23R0EYGQFk9Wk+rj8sgsMR8XZetp1QTIM7ivwEgefJobByDa9gC
         XGABddrFXoKIgbjBkMoC4QOW9tM5sOIZaqzjCpmPT31ViGyU2A4zq4FdWXNtXsYyCf/F
         IWNRxlCaK4s5u6R6ipXLMWtI4jqxPd/2kxhJWHYvs+7DzpzqraTPToAdtrQ3viTkdJdc
         3GbULg7Q/DGvyvN0y3SA53ycEn0qobJCN7l8yNB3GWdnIN0piVO+XfFrTrH4eGlQiUam
         hH7A==
X-Gm-Message-State: AJcUukermTKdNAHkXwIIr+XalyPrjYPxAWXkixbLyxCQygQt6n5ESbI/
        H28qXjpYkIzmkRAM0udJpWavud9ae4UOw/Xs8J8=
X-Google-Smtp-Source: ALg8bN5yLpF5FSHZdQ2GHeEmS6+MCvi7GKB0l6U9I7fPcmmSRbYIvIlBFKOmgMo6TXyWBpCtaNUdvfvmfpx1ARji1kQ=
X-Received: by 2002:a62:c711:: with SMTP id w17mr31301891pfg.50.1548864089978;
 Wed, 30 Jan 2019 08:01:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1548860212.git.2pi@mok.nu> <ae59210f24d66516a0af38c03fd0da923dd0e7da.1548860212.git.2pi@mok.nu>
In-Reply-To: <ae59210f24d66516a0af38c03fd0da923dd0e7da.1548860212.git.2pi@mok.nu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 30 Jan 2019 18:01:19 +0200
Message-ID: <CAHp75VcLizx+jtMrbc3Ev-HcJVEjH2naFC0sj=7fX5nZSCGc8Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] platform/x86: wmi: add WMI support to MODULE_DEVICE_TABLE()
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        michal.lkml@markovi.net, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 5:15 PM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> The kernel provides the macro MODULE_DEVICE_TABLE() where driver authors
> can specify their device type and their array of device_ids and thereby
> trigger the generation of the appropriate MODULE_ALIAS() output. This is
> opposed to having to specify one MODULE_ALIAS() for each device. The WMI
> device type is currently not supported.
>
> While using MODULE_DEVICE_TABLE() does increase the complexity as well
> as spreading out the implementation across the kernel, it does come with
> some benefits too;
> * It makes different drivers look more similar; if you can specify the
>   array of device_ids any device type specific input to MODULE_ALIAS()
>   will automatically be generated for you.
> * It helps each driver avoid keeping multiple versions of the same
>   information in sync. That is, both the array of device_ids and the
>   potential multitude of MODULE_ALIAS()'s.
>
> Add WMI support to MODULE_DEVICE_TABLE() by adding info about struct
> wmi_device_id in devicetable-offsets.c and add a WMI entry point in
> file2alias.c.
>
> The type argument for MODULE_DEVICE_TABLE(type, name) is wmi.
>
> Suggested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> ---
>
> What do you think about this usage of snprintf()? Now we check if there
> is an error or if the printed string tried to exceeded the buffer.
> Ideally 500 should be a macro or a parameter, but there isn't one
> available. The number 500 comes from a few lines below in the function
> do_table().

This looks better, though minor comments.

Indeed, 500 would be nicer to be defined as a constant (via preprocessor ma=
cro).

> +/* Looks like: wmi:guid */
> +static int do_wmi_entry(const char *filename, void *symval, char *alias)
> +{
> +       DEF_FIELD_ADDR(symval, wmi_device_id, guid_string);
> +       if (strlen(*guid_string) !=3D UUID_STRING_LEN) {
> +               warn("Invalid WMI device id 'wmi:%s' in '%s'\n",
> +                               *guid_string, filename);
> +               return 0;
> +       }
> +

> +       int len =3D snprintf(alias, 500, WMI_MODULE_PREFIX "%s", *guid_st=
ring);

Please, split declaration and assignment...

> +

...and drop this line.

> +       if (len < 0 || len >=3D 500) {

Would it even possible to get a negative number here?
Same for any other number than slightly bigger than 36.

You have above a check and here is the matter of either sudden
replacement of the string during the operation or how snprintf is
broken itself.
Do you have a case in mind which can bring to the above conditions?

> +               warn("Could not generate all MODULE_ALIAS's in '%s'\n",
> +                               filename);
> +               return 0;
> +       }

On top of that you have an ordinary case here and in similar ones we
don't care about buffer size at all (perhaps BUILD_BUG_ON() what is
needed here).

So, what about simple

{
 DEF_FIELD_ADDR(...);
 size_t len;

 len =3D strlen(*guid_string);
 if (len !=3D ...) {
  ...
 }
sprintf(...);
return 1;
}

?

> +       return 1;
> +}
> +
>  /* Does namelen bytes of name exactly match the symbol? */
>  static bool sym_is(const char *name, unsigned namelen, const char *symbo=
l)
>  {
> @@ -1357,6 +1378,7 @@ static const struct devtable devtable[] =3D {
>         {"fslmc", SIZE_fsl_mc_device_id, do_fsl_mc_entry},
>         {"tbsvc", SIZE_tb_service_id, do_tbsvc_entry},
>         {"typec", SIZE_typec_device_id, do_typec_entry},
> +       {"wmi", SIZE_wmi_device_id, do_wmi_entry},
>  };
>
>  /* Create MODULE_ALIAS() statements.
> --
> 2.20.1
>


--=20
With Best Regards,
Andy Shevchenko
