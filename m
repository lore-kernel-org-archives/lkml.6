Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903EAC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F91D218A1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 13:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPnHy6r2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbeLRNvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 08:51:38 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37973 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeLRNvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 08:51:37 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so12335819lfg.5;
        Tue, 18 Dec 2018 05:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZnvMIjYAEZ92ZLJ+02Brs3Waw8miEaBAQU/ogngkheg=;
        b=KPnHy6r26CRrUTavwExfR9JUTT4z5pwMQdnVYrRDWnjXwIF2JkxZ6dKSHo2o8EwfuN
         onbAGs0BLMRIJ1lIO8TEm8i6qc4usU6/VetF9U9pkmEQ+fv083r/LmpU+8uijV+NUcKv
         zH++GANwRaEv15PATmUMTWvx4myek/W4/yfgf2+ZGQmMRkSwfirL2t7hsio8oLc2Re+B
         k5jYbuKERSe7dUdOl9asVJkGcUSoZrm0/RsbZiS+XMPPkcK2x09OkadZLEbIzxR53WZl
         jHJtaW0/pPlEZubn8w0QZj5mUlQ0H29/sscQkzt4A3nlpnHuRunqCf8rq4duZZ9kXtU5
         u6Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZnvMIjYAEZ92ZLJ+02Brs3Waw8miEaBAQU/ogngkheg=;
        b=TcQx7tZ5lAZCgJ1V7kKbWmSAb3YWemoZ6WPA0dgYpZ7JF5Gr9FyBmNCNsOf5amtPKG
         5TeBmjhajWU0zUSc6AkuOUWsPpZMEc2JIvzUc4NrbZClqZyEKpXcxB3jVqob2KbIw36D
         fJlXUGsOvw86MyhUk9ui0EWzhGd2UOgcvwPzfG150LX1iCgu0cwcjwMshBUi18K9EeaT
         7V8DVuFcKxtKE7zHoLQrSlKI2ig4wq+VAsjKFish95nbkpDBAma6xgvI560j8KhtrDaP
         Oy+pcCXNUP9rUp579Cbt/So93CKl3RVTLTvuH+3Q45HsyI1R1Aoll81pj+XDpb0U9pPm
         gNPQ==
X-Gm-Message-State: AA+aEWZErWtmQVK3fJniyJ4qCDoTDBVZ2+TLsvmk48BWd2/SlUPCzaHb
        H6TihQ1/mj6fJyEmYN19MqL2FuY0L/62yUyKwVw=
X-Google-Smtp-Source: AFSGD/UBd0oUKejm+BByh1spZf1wAyGPpcAQ0V9d8iz7U3Bsw6KMfkQpJTXX6joRjjkmbxR91wGlnBSocjTYOXKrUXs=
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr9761456lfa.49.1545141095038;
 Tue, 18 Dec 2018 05:51:35 -0800 (PST)
MIME-Version: 1.0
References: <CAC=mGziyi1ierhg++SUcHMrq1JQ0vH4gZCKUZgchzb8aD1Rv5Q@mail.gmail.com>
 <20181216101858.9585-7-starnight@g.ncu.edu.tw> <CAJuUDwtS3c7NhcNqijyFNtZeupO2HLQ8ZuMA1a-azEQL5yHjng@mail.gmail.com>
 <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
In-Reply-To: <8bfdccbf-fb47-daa5-fbd0-ed16a3d6d334@suse.de>
From:   Xue Liu <liuxuenetmail@gmail.com>
Date:   Tue, 18 Dec 2018 14:50:58 +0100
Message-ID: <CAJuUDwsypFMEbTXZO+NwQ_FnD1wsO3ZRc3dthZphFGJ-u0n_=Q@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] net: lorawan: List LORAWAN in menuconfig
To:     =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Cc:     Jian-Hong Pan <starnight@g.ncu.edu.tw>,
        "David S . Miller" <davem@davemloft.net>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>,
        linux-wpan - ML <linux-wpan@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

On Mon, 17 Dec 2018 at 15:19, Andreas F=C3=A4rber <afaerber@suse.de> wrote:
>
> Hello Xue Liu,
>
> Am 17.12.18 um 09:50 schrieb Xue Liu:
> > I have a question about the architecture of your module. AFAIK LoRaWAN
> > is already the MAC Layer above the LoRa technology. Why do you want to
> > make a new layer called "maclorawan" ?
>
> I had asked Jian-Hong to separate between his soft-MAC implementation
> and the common bits needed to drive hard-MAC implementations found on
> several of the hardware modules made available to me.
>
As a reference Linux 802.11 uses cfg80211 to talk with hard-MAC devices.
We may also use the name =E2=80=9Ccfglora=E2=80=9D for hard-MAC implementat=
ion.

> The prefix "mac" was copied from mac80211 and mac802154:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/n=
et
>
OK. Understood. I guess they use mac80211 and mac802154 to distinguish
physical layer and MAC layer. Since LoRa and LoRaWAN are already
separate I think
"maclorawan" is not necessary.

> If you have better ideas for how to structure this, just let us know,
> ideally as inline comment where you see it (or on the cover letter).
>
> Only comment I have for this patch at the moment is that I would prefer
> to have the Kconfig bits be in the patches adding the code, so that we
> can actually build-test them before 6/6.
>
> Been updating my lab to 4.20-rcX with some hiccups. Ben's
> regmap_noinc_write support made it into 4.20, so I expect to have Ben's
> pending branch for sx1301 merged into rebased lora-next before Christmas
> and my sx1276 conversion to follow, leaving the PF_PACKET vs. PF_LORA
> discussion from ELCE - haven't assessed yet how much this series would
> be affected by the underlying changes, but if the abstraction was done
> right then only maclorawan implementation should be affected.
>
> Regards,
> Andreas
>
> --
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
> HRB 21284 (AG N=C3=BCrnberg)
Regards,

Xue Liu


--
