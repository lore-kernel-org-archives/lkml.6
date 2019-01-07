Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5461FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167C32087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6O6B0nn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfAGK00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:26:26 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42879 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfAGK00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:26:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so20682000plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 02:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BhUYY6773QmlWqza7ARM5IBEdmekbrAfRihSgcTvrnk=;
        b=Q6O6B0nnDMK0ygR3df11tlObdgECNYlZg5iuGwPTayGLX2HR87is9TMFaoDU2azyYn
         8zsQHBjiQGwwKDNoRAPto7G3S3OwGKjWQhywOFmSXcIbod9Yv33fubMN4Yf/5A3evhlx
         svSA7gF1RrXx0YWui0oegjIVgICelBCSSsqiE6/k8jQAh836a8PGFte1eG4+3sTyH2rZ
         D4ilFYTqcYzp/KedZHqHzZXevVTtpGDPtieT9BiBFxaBkU3i9MVRGnAqCUfGeiy9wCyx
         VfraHbrcNJeUU16sKC7Uf1yXUzhvRWYzCh8l+vkOLkyTiJBHVxeIEpC9XaS2De1iYaN8
         MjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BhUYY6773QmlWqza7ARM5IBEdmekbrAfRihSgcTvrnk=;
        b=ng4WmMOxV+HGZXlz8n94+SwUJH1NOKPSRzG9XSvqlHshfFoW9B1TRyn9s3cSIKDGoe
         eAyLH1Neu76kXsgnJdJLC2RAiBVL06vpTDzM9OXO+NMsIalC4hfD28PDcpFo+apsRubz
         wWSzkxLvoL8GFBPrNX6543FESL/zw9+vrMG2OR+kT5a7ruAX5ObvcbPEaqZIGtn5/eJJ
         k1ozQdQqzBzpYNr16bquvpT9tYh+S0JEgLXZ5W8XVaEFhy1t6fFjjISZQFjf+Uw3ZaUW
         96938mKKj8BuVG2tsSz7XF/FN3YOodB+xEdRWWDDW01rfXxWvkXw5lgccWKBfX2/jdEp
         ZBig==
X-Gm-Message-State: AJcUukdpFUoaaeslSLyuDhnDLljqMvso54w3Y3/6dWSokJDZaEjBBlNC
        vTSZdfl4a1FBSHb9gaDF0iAaVVCz/715FthzO5M=
X-Google-Smtp-Source: ALg8bN4VcGV7rFDPXY56v6bz6AXaCP5zYWuqKnGMKUGZrqQjHAERpTrc90qvV1VFMCHaiNHamwr+TPS9ypQ+RMDSHXw=
X-Received: by 2002:a17:902:4124:: with SMTP id e33mr60371016pld.236.1546856785627;
 Mon, 07 Jan 2019 02:26:25 -0800 (PST)
MIME-Version: 1.0
References: <1533620414-3332-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <20181221091750.GA19470@hp-probook-450> <20190102093338.3b4a8c69@xps13> <MWHPR02MB26237BE35B07E8930B5E2AB2AF8C0@MWHPR02MB2623.namprd02.prod.outlook.com>
In-Reply-To: <MWHPR02MB26237BE35B07E8930B5E2AB2AF8C0@MWHPR02MB2623.namprd02.prod.outlook.com>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Mon, 7 Jan 2019 11:26:13 +0100
Message-ID: <CABgxDoKgC_oYkKf5hsyDnH6USeqbjSFGV6R4rxpTDAYUiQcBkg@mail.gmail.com>
Subject: Re: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver for arm
 pl353 smc nand interface
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "peterpandong@micron.com" <peterpandong@micron.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le mer. 2 janv. 2019 =C3=A0 10:23, Naga Sureshkumar Relli
<nagasure@xilinx.com> a =C3=A9crit :
>
> Hi,
>
> > -----Original Message-----
> > From: Miquel Raynal [mailto:miquel.raynal@bootlin.com]
> > Sent: Wednesday, January 2, 2019 2:04 PM
> > To: Romain Perier <romain.perier@gmail.com>
> > Cc: Naga Sureshkumar Relli <nagasure@xilinx.com>; Boris Brezillon
> > <bbrezillon@kernel.org>; linux-mtd@lists.infradead.org; peterpandong@mi=
cron.com;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [LINUX PATCH v12] mtd: rawnand: pl353: Add basic driver fo=
r arm pl353
> > smc nand interface
> >
> > Hi Romain,
> >
> > Switching Boris address.
> >
> > Romain Perier <romain.perier@gmail.com> wrote on Fri, 21 Dec 2018
> > 10:17:50 +0100:
> >
> > > Hello,
> > >
> > > I have rebased this patch onto 4.19.11. I use it on a Zynq7000-based
> > > board with a NAND chip Micron MT29F4G08ABADAH4, since ~2 weeks now.
> > > The only problem I have to report is that when I boot with an
> > > unchanged driver on my board, I get the following logs:
> > >
> > > [    1.988797] nand: device found, Manufacturer ID: 0x2c, Chip ID: 0x=
dc
> > > [    1.995184] nand: Micron MT29F4G08ABADAH4
> > > [    1.999187] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 20=
48, OOB size: 64
> > > [    2.402661] nand: timeout while waiting for chip to become ready
> > > [    2.408665] nand: timing mode 5 not acknowledged by the NAND chip
> > > [    2.416251] Bad block table not found for chip 0
> > > [    2.422278] Bad block table not found for chip 0
> > > [    2.426903] Scanning device for bad blocks
> > > [    2.431024] Bad eraseblock 0 at 0x000000000000
> > > [    2.435509] Bad eraseblock 1 at 0x000000020000
> > > [    2.439978] Bad eraseblock 2 at 0x000000040000
> > > [    2.444465] Bad eraseblock 3 at 0x000000060000
> > > [    2.448936] Bad eraseblock 4 at 0x000000080000
> > > [    2.453423] Bad eraseblock 5 at 0x0000000a0000
> > > [    2.457893] Bad eraseblock 6 at 0x0000000c0000
> > > [    2.462354] Bad eraseblock 7 at 0x0000000e0000
> > > [    2.466841] Bad eraseblock 8 at 0x000000100000
> > > [    2.471304] Bad eraseblock 9 at 0x000000120000
> > > [    2.475793] Bad eraseblock 10 at 0x000000140000
> > > [    2.480349] Bad eraseblock 11 at 0x000000160000
> > >
> > > [...]
> > >
> > >
> > > After investigation, it seems that during the nand_scan phase, the
> > > NAND subsystem tests different timing modes on the NAND chip (mode 0
> > > seems to be apply during reset, and then it tries to detect the best
> > > mode supported by the NAND chip). Only the mode 0 works here, trying
> > > the use the mode 5 resuls in an error (as you can see in the log) and
> > > a bad BBT detection. Both modes are supported by the NAND chip. In
> > > order to fix this, I had to put the nfc timing into the device node o=
f the nfc, inside the DT
> > (that's not a real fix, ihmo).
> >
> > Thanks for testing! Indeed, the ->setup_data_interface() callback shoul=
d be fixed.
> Ok, let me check.
> Meanwhile, can you share the timings that you put inside the DT?

Sure, I have simply added an array in the DT:

pl353,nand-controller-timings=3D<4 4 2 2 1 1 2>;

Then, I pass this array directly to pl353_smc_set_cycles().  (I got
these value from the hdf originally, then
I ported the DT to a mainline format, written by hand).

Hope this helps,
Regards,
Romain

> >
> > > Except this, everything is working as expected. Everything is stable
> > > with correct performances.
> > >
> > > If I can provide more informations, feel free to ask.
> >
> > [...]
> >
> > > > +static int pl353_setup_data_interface(struct mtd_info *mtd, int cs=
line,
> > > > +                                const struct nand_data_interface *=
conf) {
> > > > + struct nand_chip *chip =3D mtd_to_nand(mtd);
> > > > + struct pl353_nand_controller *xnfc =3D
> > > > +         container_of(chip, struct pl353_nand_controller, chip);
> > > > + const struct nand_sdr_timings *sdr;
> > > > + u32 timings[7], mckperiodps;
> > > > +
> > > > + if (csline =3D=3D NAND_DATA_IFACE_CHECK_ONLY)
> > > > +         return 0;
> > > > +
> > > > + sdr =3D nand_get_sdr_timings(conf);
> > > > + if (IS_ERR(sdr))
> > > > +         return PTR_ERR(sdr);
> > > > +
> > > > + /*
> > > > +  * SDR timings are given in pico-seconds while NFC timings must b=
e
> > > > +  * expressed in NAND controller clock cycles.
> > > > +  */
> > > > + mckperiodps =3D NSEC_PER_SEC / clk_get_rate(xnfc->mclk);
> > > > + mckperiodps *=3D 1000;
> > > > + if (sdr->tRC_min <=3D 20000)
> > > > +         /*
> > > > +          * PL353 SMC needs one extra read cycle in SDR Mode 5
> > > > +          * This is not written anywhere in the datasheet but
> > > > +          * the results observed during testing.
> > > > +          */
> > > > +         timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps) + =
1;
> > > > + else
> > > > +         timings[0] =3D DIV_ROUND_UP(sdr->tRC_min, mckperiodps);
> > > > +
> > > > + timings[1] =3D DIV_ROUND_UP(sdr->tWC_min, mckperiodps);
> > > > + /*
> > > > +  * For all SDR modes, PL353 SMC needs tREA max value as 1,
> > > > +  * Results observed during testing.
> > > > +  */
> > > > + timings[2] =3D PL353_TREA_MAX_VALUE;
> > > > + timings[3] =3D DIV_ROUND_UP(sdr->tWP_min, mckperiodps);
> > > > + timings[4] =3D DIV_ROUND_UP(sdr->tCLR_min, mckperiodps);
> > > > + timings[5] =3D DIV_ROUND_UP(sdr->tAR_min, mckperiodps);
> > > > + timings[6] =3D DIV_ROUND_UP(sdr->tRR_min, mckperiodps);
> > > > + pl353_smc_set_cycles(timings);
> > > > +
> > > > + return 0;
> > > > +}
> > >
> > > If I hack this function in order to limit the timings only to mode 0,
> > > everything works. Otherwise it hangs when it tries to apply mode 5.
> > >
> >
> > Maybe Naga is not using a chip compatible with mode 5 and did not ran i=
nto this issue?
> No, these are the chips I am using, S34ML01G1 and MT29F2G16ABAEAWP.
> These are up to mode 5 compatible.
>
> Thanks,
> Naga Sureshkumar Relli
> >
> >
> > Thanks,
> > Miqu=C3=A8l
