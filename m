Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4949ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6913E20874
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:55:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYnhFNKH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6913E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388092AbeGWJzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:55:11 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41912 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387933AbeGWJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:55:11 -0400
Received: by mail-lf1-f65.google.com with SMTP id v22-v6so5837949lfe.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 01:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=heQmfnAIPPwagmaGmVM/zZGJPgV0BYJtp4a/07oC/68=;
        b=AYnhFNKHTXM76XNrmknOvJREQGamaLb+Sbq+cTIRj6RI6AD+kXOTBLUYgLws95NBbZ
         aGteMjhJDlw7PbAaFTW1RxRZKsmUOiNvuXQ/nXKlnXv2sZsZ79xmdMZgjqGfbKyqGTUj
         b8GPl2CCGorYI58s3tQMLtzKdfOzOog7RyXdCrjZUIOO7cVVLWkOUSQ1B7eqBxF5F3nd
         oEPt3mVWHNApbc/B73aw7Ld/zT6MEhTYtTm0fb/Hdb5Tk2peBCIERXcu6hDNnXwrbmJs
         dnDKgF3bBgy94gVkMgO5vue3MRWfSNbV8nx9JKPNePe87HWKPYFLhJdHml/5IsTR72XQ
         FQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=heQmfnAIPPwagmaGmVM/zZGJPgV0BYJtp4a/07oC/68=;
        b=d01B0K4Xb/sqLTrsWMZYxvGeQ/TGzmUpo8wOnIkWM6zkDoS/eTVd8KYFF+C24Skt8z
         nOls1cTzSAgp1W54zGuP9613eRh9Bt8TmTz2kt0KHUOYglKKweb7T8KwL7HN5mwyjdQn
         Q0uf1TphpNdX91TM82dP4z9RM9/4/I8F6h9z+I99xhKXr7wO9zoL+9aGPKNB51E6TAIR
         qQ71yd5Xo+ghT+69/GH5YV5bsSRQGDHn/ao4+G94D5RlbwOZ9folBSzz3J9Pm6kfpW2M
         Aw8CHbh/S8Nu3cY80a5LoPUaRBAGHoXqBLwkoO18xpSUOrgUxD4daRaI0Y9eHaZeOrLY
         Apag==
X-Gm-Message-State: AOUpUlGzbAJNYOilGwqF3vI6PUgksKg46dB1yJR1Dj6syG9ZFQMUE+xn
        tApRo/I6dqIGTho8ScghYplclqDq9WkZrh6sVXM=
X-Google-Smtp-Source: AAOMgpfBCTqfUpY8qA54lr4Cb+W5fvJ8z2Gul0Zub5WRJ1jZTcu53gmvMDaEC8euw2A/+mU+LfsxEopLbYH+SgyH0ME=
X-Received: by 2002:a19:8f10:: with SMTP id r16-v6mr6633818lfd.92.1532336100582;
 Mon, 23 Jul 2018 01:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180723085327.49134-1-yuleopen@gmail.com>
In-Reply-To: <20180723085327.49134-1-yuleopen@gmail.com>
From:   Yue Wang <yuleopen@gmail.com>
Date:   Mon, 23 Jul 2018 01:54:49 -0700
Message-ID: <CA+C1juZXWV7EfYd9_cMB+bny=+cRp_O-2GRob3WxarJNGryXdw@mail.gmail.com>
Subject: Re: [PATCH] alsa/usb-audio: Generic DSD detection for Thesycon-based implementations
To:     Sherry Zhang <yuleopen@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jussi Laako <jussi@sonarnerd.net>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Mack <daniel@zonque.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please ignore this commit. there's something wrong. My apologies again.
On Mon, Jul 23, 2018 at 1:53 AM Yue Wang <yuleopen@gmail.com> wrote:
>
> Thesycon provides solutions to XMOS chips, and has its own device vendor id.
>
> In this patch, we use generic method to detect DSD capability of Thesycon-based UAC2
> implementations in order to support a wide range of current and future devices.
>
> The patch will enable the SNDRV_PCM_FMTBIT_DSD_U32_BE bit for the DAC
> hence enable native DSD playback up to DSD512 format.
>
> Signed-off-by: Yue Wang <yuleopen@gmail.com>
> ---
>  sound/usb/quirks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
> index 02b6cc02767f..c51e2dee3075 100644
> --- a/sound/usb/quirks.c
> +++ b/sound/usb/quirks.c
> @@ -1374,6 +1374,7 @@ u64 snd_usb_interface_dsd_format_quirks(struct snd_usb_audio *chip,
>                 break;
>
>         case USB_ID(0x0d8c, 0x0316): /* Hegel HD12 DSD */
> +       case USB_ID(0x152a, 0x8750): /* Topping DX7s */
>         case USB_ID(0x16b0, 0x06b2): /* NuPrime DAC-10 */
>         case USB_ID(0x16d0, 0x0733): /* Furutech ADL Stratos */
>         case USB_ID(0x16d0, 0x09db): /* NuPrime Audio DAC-9 */
> --
> 2.18.0
>
