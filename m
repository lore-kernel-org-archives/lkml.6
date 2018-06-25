Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944D0C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7712565C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 09:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDh9UJmw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7712565C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeFYJGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 05:06:33 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34404 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754682AbeFYJGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 05:06:32 -0400
Received: by mail-vk0-f66.google.com with SMTP id q135-v6so7423934vkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uJYg3/X5K2cyhFHGJPMox4BlGsRfuTOgxSHS0ci6EMA=;
        b=QDh9UJmwXhk05J8MT0mCqF2/MPlmsyZHYauYeEOQ7JW3zidFILg4hbgCniFnRaYRfB
         USvYlDvOax9Osw/JaEPuejEKvpSn0HxTKAPYqPHyNl4kl5kb6FkebCTFrpLeiPuEhmwl
         w/wPa59Q9wRoOk3VksmrwA+3L36SNMytJ2DnFwE3+eZD8Wwh6C49wlo1C8rCBk8s6+Mb
         u22a8oyrKyWw1AYYLv5TVHEqhZVktCSOzLsD7QwfOneH5k+4mIwsIyFe06d3YwC5ZlUi
         VIg7i22IogyPRZUu82AnJCYSWdKt0JtzA6mMsERpKeNWyIKkBxRwnO0u4ydNElp0+vdM
         PpYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uJYg3/X5K2cyhFHGJPMox4BlGsRfuTOgxSHS0ci6EMA=;
        b=kwspkTCOUxbHOVQOMNGtJgcQGbGAe7Ql5PqRP/xePNoocyqvi7GezrZbKTOjvji9gL
         bR6rgu/EMw6QOEh9XL6m89U0XpYKmNNEc23DiAgqfXMD2Tmt6AS7cR4xJMGy3bAv4AP/
         5mJEVPGNNA3hshRf0h0Z87hSHL+uruAYEUi0DCZCGutWXwoYM++gTDetHGTDDsm8hyBV
         r+adG0va+EkidR516x5KtbQWGg/QsNEK9q+oJCn0Dp6ZLvUF0T+KYYFV/AIKpw0OFPXY
         xe24ZlS7DyfaNol0H/Sf7oDazRKITGW2IXX61AB8ak4WKYJBNNZBcZErDX7ySdZRostP
         rfEw==
X-Gm-Message-State: APt69E3mrKU9RqNzn5G1gunlO5P6OwZzcmsMv5NqK0+kM8Ms5iD8cTsr
        G+Tq4baUZ0ky8E+GcKmqvXtFNxjs2fG0p+peFRc=
X-Google-Smtp-Source: ADUXVKIGENoZACERC6Lg9OMdUaiRwUm+FlGMI9fUpxL7STSVT30EHjXzEGuJ8LMQpbqZhkpJ4JNJOOu8vBt5asedJ5Q=
X-Received: by 2002:a1f:a8d6:: with SMTP id r205-v6mr6776376vke.129.1529917591377;
 Mon, 25 Jun 2018 02:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 02:06:30
 -0700 (PDT)
In-Reply-To: <20180624153454.27356-4-johnfwhitmore@gmail.com>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com> <20180624153454.27356-4-johnfwhitmore@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jun 2018 12:06:30 +0300
Message-ID: <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
To:     John Whitmore <johnfwhitmore@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
>

Suggested-by ?

> Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> index 4bfadb49c363..ccb7bdf5ad5d 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> @@ -742,8 +742,6 @@ void HTConstructRT2RTAggElement(struct ieee80211_device *ieee, u8 *posRT2RTAgg,
>   */
>  static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
>  {
> -       u8                                      i;
> -
>         if (!pOperateMCS) {
>                 IEEE80211_DEBUG(IEEE80211_DL_ERR, "pOperateMCS can't be null in HT_PickMCSRate()\n");
>                 return false;
> @@ -756,8 +754,7 @@ static u8 HT_PickMCSRate(struct ieee80211_device *ieee, u8 *pOperateMCS)
>                 //legacy rate routine handled at selectedrate
>
>                 //no MCS rate
> -               for (i = 0; i <= 15; i++)
> -                       pOperateMCS[i] = 0;
> +               memset(pOperateMCS, 0, 16);
>                 break;
>
>         case IEEE_N_24G:        //assume CCK rate ok
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
