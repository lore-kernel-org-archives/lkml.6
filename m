Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAFDC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE5820859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 07:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6ytryo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfAGH7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 02:59:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33077 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfAGH7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 02:59:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id i26so29467692lfc.0;
        Sun, 06 Jan 2019 23:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dfNcB/FJ0jWZ/OQCvx8g6qL6cE/r6nHp6ge5Fq+96/4=;
        b=s6ytryo4z/5t8GoOh9tJymQfupyPefIcYyqnzjABYHM7hF03ma8b39IekEDWXZ8zwJ
         VaZl96UXeJtJTRjAFto0NwW0Pin2iZMJteNfgzBoOYzC9jnYBQ9KnzCgb2jaeMXUSOWe
         gfBwP+bTl1C8A4sp9Ra7J5H5y1rXY4OO54bG6zoI7cGkYOxgS9Y9e/XrZAMvcUNEz1Oy
         1ID78bOcPzkBVVc4fWc8RaeMafpyBPJ8q94O6tCuJSzkGYEJrxwqmttQ7fddZfVKVJp8
         hUI2pL5zmxlIqKCbcuaJXv2MGge+GnUI6S6Mi7RQq5Bo5rrtMoSyI0D0krX6llAAIUzo
         1yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dfNcB/FJ0jWZ/OQCvx8g6qL6cE/r6nHp6ge5Fq+96/4=;
        b=McnR5hLcn2Fu4OJ36272cH0lKtkhA2mujKolCo9lLDacQDMoTXWHW0zuGnwq0FbP9P
         0rxLAGnZkh5hINrC0wKdeajc62VKR7Fo47Vrma768YkSEc3MfNNNeiegdhIUscn0CLvb
         k7xwox0khgINwneYdawZjXnt18BI9nDHeTVK1WYRZB9h9H1KXoS8KwgPodmthG8IxRGP
         Pvfj8SBP/lz8oivIwlbNC96DIOyvp7QHJQwK29c+2m31VSIWos+e6dyK5i1bNSzdCJV+
         Fzw+i3mhNhDWiUz9wvcJy9Nxjw4GUhfFVVKZWDT80TeaPL5FGZjsjuJ4nEJob6qThACU
         En/w==
X-Gm-Message-State: AJcUukcE6bGPjE1pGUez74/atg6nRIpUnnukvJY5jO2szkdwXOS6PYeD
        xs+2UWZKv6zwLMY4pMTM9WBY+K74mfsVtrtdf+M=
X-Google-Smtp-Source: ALg8bN4n/A0JBP7FACJavJU83lTvN0H2RkeDBc8EtVDAzF5PQGiw6h2kh8mYUrq7lEwENZJPs1EHxwWC5s4cAAMRvi4=
X-Received: by 2002:ac2:51af:: with SMTP id f15mr5198476lfk.44.1546847938660;
 Sun, 06 Jan 2019 23:58:58 -0800 (PST)
MIME-Version: 1.0
References: <20181228175327.14863-1-kaelinphilipp@gmail.com>
In-Reply-To: <20181228175327.14863-1-kaelinphilipp@gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date:   Mon, 7 Jan 2019 08:58:46 +0100
Message-ID: <CAN+gG=HodVpN1YpXZ=zEXcFb1tMEgkVWLCOYbyLQ-8trqs699w@mail.gmail.com>
Subject: Re: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint
 for Lenovo ThinkPad notebooks.
To:     Philipp Kaelin <kaelinphilipp@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input <linux-input@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

On Sat, Dec 29, 2018 at 6:35 AM Philipp Kaelin <kaelinphilipp@gmail.com> wrote:
>
> Initial situation:
> - The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
> - It used to work on earlier versions eg. 4.14
>
> Cause:
> - The elantech driver was adapted in to support SMBus wich not all firmware versions
>   of the elantech firmware support. The SMBus is used as default.
>
> Solution:
> - Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
>   The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.

nitpick: you are using "prevois" instead of "previous" :)

>   The exact same solution fixed also the issue on the mentioned ThinkPad L580.
>
> Change:
> 1) The firmware id of the ThinkPad L580 was added to this blacklist.
> 2) To not have a half baked solution the information which firmware versions are using the same driver
>    and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
>    All these firmware versions are now also added to the blacklist.
>
> Risk assesment:
> As in prevois versions of the kernel eg. 4.14 none of the devices used to be accessed via SMBus
> (and they are reported to work at this time) it's quite safe that this blaklisting doesn't cause
> any harm on devices which have not been testes but included in the blacklist.
>
> Signed-off-by: Philipp Kaelin <kaelinphilipp@gmail.com>
> ---
>  drivers/input/mouse/elantech.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
> index 9fe075c137dc..e5fa8cfd8393 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -1772,10 +1772,25 @@ static const char * const i2c_blacklist_pnp_ids[] = {
>          * These are known to not be working properly as bits are missing
>          * in elan_i2c.
>          */
> -       "LEN2131", /* ThinkPad P52 w/ NFC */
> -       "LEN2132", /* ThinkPad P52 */
> -       "LEN2133", /* ThinkPad P72 w/ NFC */
> -       "LEN2134", /* ThinkPad P72 */
> +       "LEN2131", /* Walter-3  w/ NFC          ThinkPad P52 w/ NFC     */
> +       "LEN2132", /* Walter-3  w/o/ NFC        ThinkPad P52            */
> +       "LEN2133", /* Chiron    w/ NFC          ThinkPad P72 w/ NFC     */
> +       "LEN2134", /* Chiron    w/o/ NFC        ThinkPad P72            */
> +       "LEN2037", /* Lando     w/ NFC          ThinkPad L580 w/ NFC    */
> +       "LEN2038", /* Lando     w/o/ NFC        ThinkPad L580           */
> +       "LEN004F", /* Storm     w/o/ NFC                                */
> +       "LEN005C", /* Storm     w/ NFC                                  */
> +       "LEN2030", /* Carling                                           */
> +       "LEN2031", /* Bell                                              */
> +       "LEN2032", /* Bell-2                                            */
> +       "LEN2033", /* Storm-2                                           */
> +       "LEN2034", /* Storm-3                                           */
> +       "LEN2035", /* Solo      w/ NFC                                  */
> +       "LEN2036", /* Solo      w/o/ NFC                                */
> +       "LEN2039", /* Leia                                              */
> +       "LEN2130", /* Kylo      (Clamshell)                             */
> +       "LEN008F", /* Kolar     w/o/ NF                                 */
> +       "LEN0090", /* Kolar     w/ NFC                                  */

That is quite a list. My initial idea with this blacklist was to keep
it short and fix the initial issue to be able to remove it entirely
(or at least on the devices we can test).
So 2 questions:
- do you have the commercial names of the various PNPId you are adding?
- are you able to test all of those? Especially if we get the SMBus
driver fixed?

I am fine adding the patch as a fix for 4.21 and backport this to
stable, but I still intend to fix elan_i2c for the next cycle (4.22)
so I'd like to know if we can safely test those machine later on.

Cheers,
Benjamin

>         NULL
>  };
>
> --
> 2.19.2
>
