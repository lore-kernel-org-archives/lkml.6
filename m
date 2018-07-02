Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E99C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D869B235FD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 22:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0MZIIOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D869B235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932404AbeGBWgV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 18:36:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54914 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeGBWgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 18:36:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id i139-v6so291930wmf.4;
        Mon, 02 Jul 2018 15:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=w1YajgAk0C3R/b2ymf2KDdl/bMnOd3CytM1D2clgIfo=;
        b=i0MZIIOVSo/vCEShkYtD0StwukbZpFr8GHZ7PSdvzU6vWjDil82TPkajcSLcJn+ujc
         fMAcd7KNBXPeGFZ1Ygj+3Z/AWscwHB4phG86bbAt6FBmWtMVxmIib0h5ukyKUVhDhmhO
         Twd3EaIPntKSX2Ad7vb8YqLiTH4sVlVrPpyMxZ81R+MBHb475X2gGeB7m+tyLW7acF7a
         zgzp2fgxEB53w27FwAzXWrwJ9doCOICZtcoPOdt11fRVabiyeMqGrMaNYb8Jkp9MHYCT
         5XAna6CiIuADsSkKXwWvkCO6DI3vNa+Hy0ErUnZu7VxZDjvpnqUpH9WDeGi6UuXw1QLn
         vpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=w1YajgAk0C3R/b2ymf2KDdl/bMnOd3CytM1D2clgIfo=;
        b=unMoVqG3LfaFDyrlE3fWJTa0cL8WzKKVUe4P/kny66mkDFz2m4yIyBdfNVO888Xg1c
         5O8WV8hsjEb89DjudoMkraHTmhB26NqNKr0LChdf5SdRYgXltFtGfjrA1OH4nQA54O8/
         UD4iyhrxOOC7wXYTo6X0McucfzMkavO7jRA2UL5l2wZQVJ7CZtY702VyVadpEHxe5gHf
         jVVe+syNmzfpuwYkZFu/vAXs11GECpjdyNMYqNHVo5zoI+zSNzBqhjpfgDR51D9EDpNH
         MtSXRJokB45GH/pP1y6P/c8lX5qoC4dwrpgj9YB6/EKhKfTgOztq3mIxN0tPDsvgbept
         PSyA==
X-Gm-Message-State: APt69E3jRo+H+kNvaR3qLld3qFwmQesdNxhrnXzn1dtUThVmIPigmy5b
        vtS4mdO+xw28VZVSkqHLsAAK2BGaV2VY1k3aasXOx2bRNXY=
X-Google-Smtp-Source: AAOMgpdiNIsAVXlIMg7H6giI+jVJzYJdPlZZR0IPhFjMPkQeGy8SR89zIrMtfbk1rUzJDpNWvo+m1LsUo4sAW+eu+y8=
X-Received: by 2002:a1c:5c82:: with SMTP id q124-v6mr9902370wmb.24.1530570978417;
 Mon, 02 Jul 2018 15:36:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:dcce:0:0:0:0:0 with HTTP; Mon, 2 Jul 2018 15:36:17 -0700 (PDT)
In-Reply-To: <20180702214647.1574-1-erosca@de.adit-jv.com>
References: <20180702214647.1574-1-erosca@de.adit-jv.com>
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date:   Tue, 3 Jul 2018 01:36:17 +0300
Message-ID: <CAB=otbQiUDtZBAn0RhtQsizqz-r0Do+8nd991rvE+DQv_71o0Q@mail.gmail.com>
Subject: Re: [PATCH] usb: gadget: f_uac2: fix endianness of 'struct cntrl_*_lay3'
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <rosca.eugeniu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:46 AM, Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> The list [1] of commits doing endianness fixes in USB subsystem is long
> due to below quote from USB spec Revision 2.0 from April 27, 2000:
>
> ------------
> 8.1 Byte/Bit Ordering
>
> Multiple byte fields in standard descriptors, requests, and responses
> are interpreted as and moved over the bus in little-endian order, i.e.
> LSB to MSB.
> ------------
>
> This commit belongs to the same family.
>
> [1] Example of endianness fixes in USB subsystem:
> commit 14e1d56cbea6 ("usb: gadget: f_uac2: endianness fixes.")
> commit 42370b821168 ("usb: gadget: f_uac1: endianness fixes.")
> commit 63afd5cc7877 ("USB: chaoskey: fix Alea quirk on big-endian hosts")
> commit 74098c4ac782 ("usb: gadget: acm: fix endianness in notifications")
> commit cdd7928df0d2 ("ACM gadget: fix endianness in notifications")
> commit 323ece54e076 ("cdc-wdm: fix endianness bug in debug statements")
> commit e102609f1072 ("usb: gadget: uvc: Fix endianness mismatches")
>        list goes on
>
> Fixes: 132fcb460839 ("usb: gadget: Add Audio Class 2.0 Driver")
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Good catch!

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

> ---
>  drivers/usb/gadget/function/f_uac2.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
> index d2dc1f00180b..540a0ce63ad4 100644
> --- a/drivers/usb/gadget/function/f_uac2.c
> +++ b/drivers/usb/gadget/function/f_uac2.c
> @@ -438,14 +438,14 @@ static struct usb_descriptor_header *hs_audio_desc[] = {
>  };
>
>  struct cntrl_cur_lay3 {
> -       __u32   dCUR;
> +       __le32  dCUR;
>  };
>
>  struct cntrl_range_lay3 {
> -       __u16   wNumSubRanges;
> -       __u32   dMIN;
> -       __u32   dMAX;
> -       __u32   dRES;
> +       __le16  wNumSubRanges;
> +       __le32  dMIN;
> +       __le32  dMAX;
> +       __le32  dRES;
>  } __packed;
>
>  static void set_ep_max_packet_size(const struct f_uac2_opts *uac2_opts,
> @@ -703,9 +703,9 @@ in_rq_cur(struct usb_function *fn, const struct usb_ctrlrequest *cr)
>                 memset(&c, 0, sizeof(struct cntrl_cur_lay3));
>
>                 if (entity_id == USB_IN_CLK_ID)
> -                       c.dCUR = p_srate;
> +                       c.dCUR = cpu_to_le32(p_srate);
>                 else if (entity_id == USB_OUT_CLK_ID)
> -                       c.dCUR = c_srate;
> +                       c.dCUR = cpu_to_le32(c_srate);
>
>                 value = min_t(unsigned, w_length, sizeof c);
>                 memcpy(req->buf, &c, value);
> @@ -742,15 +742,15 @@ in_rq_range(struct usb_function *fn, const struct usb_ctrlrequest *cr)
>
>         if (control_selector == UAC2_CS_CONTROL_SAM_FREQ) {
>                 if (entity_id == USB_IN_CLK_ID)
> -                       r.dMIN = p_srate;
> +                       r.dMIN = cpu_to_le32(p_srate);
>                 else if (entity_id == USB_OUT_CLK_ID)
> -                       r.dMIN = c_srate;
> +                       r.dMIN = cpu_to_le32(c_srate);
>                 else
>                         return -EOPNOTSUPP;
>
>                 r.dMAX = r.dMIN;
>                 r.dRES = 0;
> -               r.wNumSubRanges = 1;
> +               r.wNumSubRanges = cpu_to_le16(1);
>
>                 value = min_t(unsigned, w_length, sizeof r);
>                 memcpy(req->buf, &r, value);
> --
> 2.18.0
>
