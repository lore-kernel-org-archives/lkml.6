Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881F6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D9120838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 18:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQQuZ36+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D9120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbeH3Wew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 18:34:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44153 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbeH3Wew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 18:34:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id v16-v6so8943529wro.11;
        Thu, 30 Aug 2018 11:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8y2gzFkzmqwPeNiS8CvRA+6heY+d7qSqwXYwtdj6xA=;
        b=BQQuZ36+ntUsz0WkZlDd3CR77e9g/qPHRYaXAa4PAG7Fo4E2jXQcwwDsv2shVPzDRA
         V8QMoDByOYFeYgIlMGKcNXoheTwtFinpj/HFs6bw0ncljGcqnD7vPFwtqM9S+HXuwggx
         ic6YYcM7ho57ZxqrHJhsxAeyd6KiM2M0BK5/6l6UCpmVU0DOF/dYv1ervFpNKN96AhU4
         QeWFGfJDvINM8Hp3iN1/MNWcLqiRvbWG3TmKX9sQsWBlKHfA/vUVMQYjZkGn58OIBnba
         3TMNCwqtB/9zQISgUZ58G0ErFymeAob9HbH/8VCQBFE9SVaKa4gZJxeMT6znvhGBVF7W
         Eilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8y2gzFkzmqwPeNiS8CvRA+6heY+d7qSqwXYwtdj6xA=;
        b=BKhbJKHN9Sz2REgn00COoHjlSGpVmYyFhdce91GbtfEgevjyHrULhZ4iFnU7t4J39x
         Qp7gzQPOuibxBpShccbyaafpUMPoYV9qMd5Tbr83197PTsyGT/REwVLYdqGYs90E33gt
         jVD/Mnc7K/Tpa1CTj0BhuIVgZc6RNzZzVi+SSdyQvxzgblaw17bF3WVBsvek6trZsOZB
         wb/OTisjqKFC/jwEOSy9SmwuFcP2/1rnYsZEuovPUkcRLtq4GF9gjUlZrRa0nPGWMird
         +v7kaGOtpbivB6kdxFw88ivnwwiTZ5y0jw8lddooJLrBucHEDstjtDXGupxu/s/ehYya
         4DhA==
X-Gm-Message-State: APzg51DgxZFqEy6DzBHbAjd1l612CrFaVnxYZw8qMH61Nat5f4Hv+NyD
        r36g3keZq9W9PeW2KQwc8O8ZDqhYhviSqjxNOW8=
X-Google-Smtp-Source: ANB0VdYui1oNGkNY+dMAkMJfKvVNP2+Lc3BIAn1HSTlDvXJlMtDUyM+AuHoObhblMfB0jioePITTux14v+8WIakPq3w=
X-Received: by 2002:adf:82c3:: with SMTP id 61-v6mr8760351wrc.131.1535653883110;
 Thu, 30 Aug 2018 11:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <1535453838-12154-1-git-send-email-sunil.kovvuri@gmail.com>
 <CAK8P3a1xC6XjwDAmocpE5TZO7j6uVGtvBtWLPVcYwKqN6Z+seQ@mail.gmail.com>
 <CA+sq2Cd3R0V5hcaF+ESfkOEBHgBwOB6b8Uwx7K+CeUN6gLFTOg@mail.gmail.com>
 <CA+sq2CfbpQKas7TbQfrcw=Drpb7yO_gqH31iXabjNEQEG4xYrQ@mail.gmail.com> <20180830132658.GA27566@lunn.ch>
In-Reply-To: <20180830132658.GA27566@lunn.ch>
From:   Sunil Kovvuri <sunil.kovvuri@gmail.com>
Date:   Fri, 31 Aug 2018 00:01:11 +0530
Message-ID: <CA+sq2CfX+BGE1Ub0H9G21Vqg+vmQSukZj4gwz=B8wsqTLgE7mg@mail.gmail.com>
Subject: Re: [PATCH 00/15] soc: octeontx2: Add RVU admin function driver
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
        olof@lixom.net, LAKML <linux-arm-kernel@lists.infradead.org>,
        linux-soc@vger.kernel.org, Sunil Goutham <sgoutham@marvell.com>,
        Linux Netdev List <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:57 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > My feeling overall is that we need a review from the network driver
> > > > folks more than the arm-soc team etc, and that maybe the driver
> > > > as a whole should go into drivers/net/ethernet.
> > >
> > > This driver doesn't handle any network IO and moreever this driver has to handle
> > > configuration requests from crypto driver as well. There will be
> > > separate network and
> > > crypto drivers which will be upstreamed into drivers/net/ethernet and
> > > drivers/crypto.
> > > And in future silicons there will be different types of functional
> > > blocks which will be
> > > added into this resource virtualization unit (RVU). Hence i thought
> > > this driver is not a
> > > right fit in drivers/net/ethernet.
>
> Hi Sunil
>
> Do you have a git branch for everything? I would like to look at the
> actual Ethernet driver, and the full API this driver exports to other
> drivers.

Hi Andrew,

I have pushed all patches into a github repo for your reference.
These are not the final patches, i still need to do some minor changes
before submitting
(i mean otherthan the ones i already submitted).

AF driver & CGX drivers:
https://github.com/sunilkovvuri/rvu_drivers/tree/master/drivers/soc/marvell/octeontx2

Ethernet drivers PF and VF
https://github.com/sunilkovvuri/rvu_drivers/tree/master/drivers/net/ethernet/marvell/octeontx2

Info exported/shared by AF driver with other drivers is
# Mailbox communication APIs, message IDs, message structs e.t.c
   https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/mbox.c
   https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/mbox.h
# Other structs and APIs
    https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/common.h
    https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/soc/marvell/octeontx2/rvu_struct.h

>
> I think there real question here is, do you have split between this
> driver and the actual device drivers in the right place? For me, link
> up/down detection should be in the Ethernet driver, since it is not
> shared with the crypto driver.
>

As mentioned in the patch '[PATCH 13/15] soc: octeontx2: Add support
for CGX link management',
link up/down is detected by firmware. And firmware triggers a IRQ to
CGX driver, which then
takes the new status and sends a update to ethernet driver via a
mailbox communication.

Ethernet driver detects the link change and does the necessary stuff.
https://github.com/sunilkovvuri/rvu_drivers/blob/master/drivers/net/ethernet/marvell/octeontx2/otx2_pf.c#L116


>        Thanks
>         Andrew
