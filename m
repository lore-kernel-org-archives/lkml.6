Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD6AC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761BD2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 00:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSE3JlLu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 761BD2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753952AbeFTAYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 20:24:49 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35358 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752787AbeFTAYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 20:24:47 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so2221585lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 17:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RB5dAJM59KU+PUIFQr/5zNTPxP71H4sasVulZ5nB3x4=;
        b=LSE3JlLueiVR0HBA3YJTF6PkpDS1XQMv1u7BeD56TmFuZLUp9tgW3hxCYVp1AnC4i+
         Bdm2sx+I0IiF+RFlxBEtxlbv5zS9Z9xtleHms+tzQhVJIfqfElysINCm2gveqg2DnFo5
         uzixsbsOcVxqTpCgFQ0VTQJ+FihhU1VGEUn4GdMbVNd8kwZkpg8l5OLgOW8KZUcHUg20
         3msfA4EJpvBgi5JSz830a9aQQpuwUinQytC5QUUfQwfghNN3nTMj7H/W+0UH3RnR9JL0
         VuT/dQQXNtMzhVJkxP5UJ9QBALrt6Ln3ImoqbtoTrqzkxdpSCnkEKPciHlGt9uxwzY41
         zhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RB5dAJM59KU+PUIFQr/5zNTPxP71H4sasVulZ5nB3x4=;
        b=e7yJ9WxG+3q2jxAOCIH6GdOf/VehMuC0+E6z9P9WaTqzJXPQV4Bydu3VizFEkvhR2l
         /jZQahLb5sWsYz2N2yhLzX6W+zq0VpzhWJK4YYwhjoan5AEXmafYk4XXWo9Y+nM4d0ft
         byrkuEbrPYC6TdEcSANPaoJkL6O2sHqJPtjbSCRO3Gyccc10QzN6SCl/M+qxs8V6ANnH
         xYt62GfMlSW7pphFAebPn5638o+vVUb5/NIYYcnqNeQlXMdxkCXXkb9poZRCnjVGb4sb
         6qhhDx2PFSe8yPViARDya/opSnCFIyfAg+ts2HXO5/Ikcf/mPQF3ArKzS3EkEv8gQRKa
         C8YQ==
X-Gm-Message-State: APt69E1YiHIga4Z+iSDX1T4juxLpnJrIKovZv02E76PE5+YhBtVlPgKp
        R4ZjLopop1zdCRH6vZlbNpG0xqhr1o8aZymGNPRZ1Ag7g10=
X-Google-Smtp-Source: ADUXVKLFqbDy9plqWI92jEPWPhue46B+eXilO//LE4tN5P72iG9492seqTh71yH5Mmt7S/1+h5RGOC9hii5jcSfxBbg=
X-Received: by 2002:a2e:28b:: with SMTP id y11-v6mr12138588lje.27.1529454286237;
 Tue, 19 Jun 2018 17:24:46 -0700 (PDT)
MIME-Version: 1.0
References: <E64899AA-23A5-49D7-8C91-B94A095290E0@crocodile.org>
 <1268034117.3819.1.camel@jlt3.sipsolutions.net> <36779F26-DB1B-46ED-8635-01B03E559B55@crocodile.org>
 <20100310062227.GB2445@core.coreip.homeip.net> <87k4o234lx.fsf@depni.sinp.msu.ru>
 <1281196050.4431.4.camel@jlt3.sipsolutions.net> <1281313223.2168.46.camel@pasglop>
 <9D74DA20-E3C8-43BC-B529-82605F64637F@crocodile.org> <1281325390.2168.64.camel@pasglop>
In-Reply-To: <1281325390.2168.64.camel@pasglop>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Tue, 19 Jun 2018 17:24:34 -0700
Message-ID: <CAKdAkRTEOZpLm7K3_VQzoUBntLz8Gz0NATjhNCvJsO1Rh09WHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] integer overflow issue in 'appletouch' driver
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     lord@crocodile.org, Johannes Berg <johannes@sipsolutions.net>,
        belyshev@depni.sinp.msu.ru, lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 1:23 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Sun, 2010-08-08 at 18:24 -0700, Vadim Zaliva wrote:
> > I have tested the patch on device I had
> > I will have an access to it to retest later thus week. We can wait for my
> > test to try to identify how my PowerBook is different from yours. Or you
> > can roll the patch back.
>
> I'd rather roll the patch back for now. I'll send the revert as part of
> the next powerpc update. We'll sort things out then.
>

Hmm, I just got this blast form the past and looking by the headers it
might be coming form Mauro?

Received: from mchehab by bombadil.infradead.org with local (Exim
4.90_1 #2 (Red Hat Linux)) id 1fVN9i-0002G4-I9; Tue, 19 Jun 2018
20:23:10 +0000
Received: from vger.kernel.org ([209.132.180.67]) by
bombadil.infradead.org with esmtp (Exim 4.72 #1 (Red Hat Linux)) id
1OiJGy-0000U8-Lw; Mon, 09 Aug 2010 03:43:36 +0000

Thanks.

-- 
Dmitry
