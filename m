Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B3CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D775B20875
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 12:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXE92Sj9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D775B20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937758AbeFSMVy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 08:21:54 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37123 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937502AbeFSMVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 08:21:52 -0400
Received: by mail-lf0-f65.google.com with SMTP id g21-v6so29823397lfb.4;
        Tue, 19 Jun 2018 05:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=thZumHThLbN7Zp7jNU/sMMyrGSJfaAImA3M7wMuuV20=;
        b=mXE92Sj93uXBhc990NKQPOtrHKpVaYtkZRRVJoLlGsMd9bQgIE7ZfySFxWTQtTQCMJ
         g2eaGrCyPYD6xXiWQXTBJN0bYbKFucyxY9n/UeboWUHS0vTxBzxR6hB707DkU/LpodO3
         p+1h9tcZMSxxEElu/DST/zPW50Ayh7gdSIZLlmulmodb+yl34OBGRCCDpx9hUAETmeNV
         90OAV7TsOD14gsRR4IjLEOV1ffrgPnJtzIczU9l8gSgxoJLO+4HYqyeyo4AfjGhf611d
         diSKJ74i/nyfSWb/n9H4HLfH1JeH9ZQMdN7VPEleG2TXln4EvTSER6BSoYDCyllGKEr4
         h7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=thZumHThLbN7Zp7jNU/sMMyrGSJfaAImA3M7wMuuV20=;
        b=BAfnnIPiCDIakjNa4HioyCds8MnRA89kam61Pnw3rVuDBaYbSD7WJJLRk+7ywdXNWP
         ps9sAyPSI4r6WWF7d6gMLc6AmWbQXLK9eVcKgtwPrihtLLFUfHWml+e6/rwndG3uD3q9
         g6168EttYUXepD7sXkNhUcqw/FtLIpeTY5N4XUjqd/gzElhKtHg2bjncIHOqoRYem/K3
         DzRzFTKL2R+WMVaMMZPdk5aOjXnrchmXso51+5uD5F2qJBan6slnSgSHo7lwF0TLrQmo
         gONkhXSxerE9rNDdhW4UYuKRzNE5CJKQ4gTcSII8U2EOBCqHukJswfkCzYxbRMRvD/7r
         +5SQ==
X-Gm-Message-State: APt69E1YXeDKsyHNX4BmcdkKZOpoPW/XzKENdKgyTxoFv0rAvKpbgLqg
        f2zyH5gkr3mR/OaTA9wHB+vR3PGeSrWVBOT2XWw=
X-Google-Smtp-Source: ADUXVKJS86DRiABIPdXoWx4zVgD+Yj324mO+fiii4+eKIg45LA4QiW6eaRb3E+6WqggWEoF3+lFGSkujx80uFcoPqbk=
X-Received: by 2002:a2e:84d7:: with SMTP id q23-v6mr10630316ljh.126.1529410910886;
 Tue, 19 Jun 2018 05:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180612070906.5305-1-aaron.ma@canonical.com>
In-Reply-To: <20180612070906.5305-1-aaron.ma@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Tue, 19 Jun 2018 14:21:39 +0200
Message-ID: <CAN+gG=EDc8WsC3MjbY1VnYyo7G1ZBUboM2_T-Zd8r322dOvwTA@mail.gmail.com>
Subject: Re: [PATCH] Input: elan: enable middle button of touchpads on
 ThinkPad P52
To:     aaron.ma@canonical.com
Cc:     linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org, KT Liao <kt.liao@emc.com.tw>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:10 AM Aaron Ma <aaron.ma@canonical.com> wrote:
>
> PNPID is better way to identify the type of touchpads.
> Enable middle button support on 2 types of touchpads on Lenovo P52.
>
> Cc: stable@vger.kernel.org
> Cc: KT Liao <kt.liao@emc.com.tw>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>  drivers/input/mouse/elantech.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Looks good to me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Aaron, our internal tests show that the P52 shows a lot of lost
synchronization in pre-v4.18 kernels. Do you have a fix for that too?

In v4.18 we need to fix the elan_i2c module as right now the touchpad
is muted when booted with such a kernel.

Cheers,
Benjamin

>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index fb4d902c4403..67b061dd4494 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1175,6 +1175,12 @@ static const struct dmi_system_id elantech_dmi_has_middle_button[] = {
>         { }
>  };
>
> +static const char * const middle_button_pnp_ids[] = {
> +       "LEN2131", /* ThinkPad P52 w/ NFC */
> +       "LEN2132", /* ThinkPad P52 */
> +       NULL
> +};
> +
>  /*
>   * Set the appropriate event bits for the input subsystem
>   */
> @@ -1194,7 +1200,8 @@ static int elantech_set_input_params(struct psmouse *psmouse)
>         __clear_bit(EV_REL, dev->evbit);
>
>         __set_bit(BTN_LEFT, dev->keybit);
> -       if (dmi_check_system(elantech_dmi_has_middle_button))
> +       if (dmi_check_system(elantech_dmi_has_middle_button) ||
> +               psmouse_matches_pnp_id(psmouse, middle_button_pnp_ids))
>                 __set_bit(BTN_MIDDLE, dev->keybit);
>         __set_bit(BTN_RIGHT, dev->keybit);
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
