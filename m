Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1C7C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29586223DD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 11:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29586223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=keep-it-simple.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeKLVFA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:05:00 -0500
Received: from martinlund.org ([173.255.130.145]:49530 "EHLO
        slmp-550-86.slc.westdc.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728302AbeKLVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 16:04:59 -0500
X-Greylist: delayed 988 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Nov 2018 16:04:59 EST
Received: from mail-oi1-f174.google.com ([209.85.167.174]:39630)
        by slmp-550-86.slc.westdc.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <martin.lund@keep-it-simple.com>)
        id 1gM9sh-005Ttu-TH
        for linux-kernel@vger.kernel.org; Mon, 12 Nov 2018 03:55:47 -0700
Received: by mail-oi1-f174.google.com with SMTP id 192-v6so6795514oii.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:55:47 -0800 (PST)
X-Gm-Message-State: AGRZ1gJ1iIGsnOfokgO8pX7rzDHIAplpE+X69ippyQbdZtf8VDGHegkk
        oSoFbr2dA4sxJqATwdJgR3etgfJzC6ZlfBBHGgo=
X-Google-Smtp-Source: AJdET5fI7mM9sJDXpWm3a2xroGDVvjdbMM8lhceqTdaxXjcMqrmtuL4HqSEtLJACXB142g+IFcgmKIcNCKoBcsGZRj8=
X-Received: by 2002:aca:654a:: with SMTP id j10-v6mr213773oiw.178.1542020147437;
 Mon, 12 Nov 2018 02:55:47 -0800 (PST)
MIME-Version: 1.0
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
 <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
In-Reply-To: <1541739641-17789-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
From:   Martin Lund <martin.lund@keep-it-simple.com>
Date:   Mon, 12 Nov 2018 11:55:36 +0100
X-Gmail-Original-Message-ID: <CAB7pii1WbALtH1AHjocpC976ytrCV5gM6JGXawoN--scvEx8Mw@mail.gmail.com>
Message-ID: <CAB7pii1WbALtH1AHjocpC976ytrCV5gM6JGXawoN--scvEx8Mw@mail.gmail.com>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
To:     naga.sureshkumar.relli@xilinx.com
Cc:     boris.brezillon@bootlin.com, miquel.raynal@bootlin.com,
        richard@nod.at, dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, michals@xilinx.com, nagasuresh12@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - slmp-550-86.slc.westdc.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - keep-it-simple.com
X-Get-Message-Sender-Via: slmp-550-86.slc.westdc.net: authenticated_id: martin.lund+keep-it-simple.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: slmp-550-86.slc.westdc.net: martin.lund@keep-it-simple.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Just a few review comments for the v12 version.

On Fri, Nov 9, 2018 at 6:00 AM Naga Sureshkumar Relli
<naga.sureshkumar.relli@xilinx.com> wrote:
> +#define PKT_OFST               0x00
> +#define PKT_CNT_SHIFT          12
> +
> +#define MEM_ADDR1_OFST         0x04
> +#define MEM_ADDR2_OFST         0x08

For the sake of readability I think *_OFFSET is preferred, especially
since the driver already includes short macro names. I think this is
similar to the EVNT vs EVENT point.
The majority of drivers in the Linux kernel do not shorten OFFSET -> OFST.


> +static void anfc_rw_pio_op(struct mtd_info *mtd, u8 *buf, int len,
> +                          bool do_read, int prog, int pktcount, int pktsize)
> +{
> +       struct nand_chip *chip = mtd_to_nand(mtd);
> +       struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +       struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +       u32 *bufptr = (u32 *)buf;
> +       u32 cnt = 0, intr = 0;
> +
> +       anfc_config_dma(nfc, 0);
> +
> +       if (pktsize == 0)
> +               pktsize = len;
> +
> +       anfc_setpktszcnt(nfc, pktsize, pktcount);
> +
> +       if (!achip->strength)
> +               intr = MBIT_ERROR;
> +
> +       if (do_read)
> +               intr |= READ_READY;
> +       else
> +               intr |= WRITE_READY;
> +       anfc_enable_intrs(nfc, intr);
> +       writel(prog, nfc->base + PROG_OFST);
> +       while (cnt < pktcount) {
> +               anfc_wait_for_event(nfc);
> +               cnt++;
> +               if (cnt == pktcount)
> +                       anfc_enable_intrs(nfc, XFER_COMPLETE);
> +               if (do_read)
> +                       ioread32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> +                                    pktsize / 4);
> +               else
> +                       iowrite32_rep(nfc->base + DATA_PORT_OFST, bufptr,
> +                                     pktsize / 4);
> +               bufptr += (pktsize / 4);
> +               if (cnt < pktcount)
> +                       anfc_enable_intrs(nfc, intr);
> +       }
> +       anfc_wait_for_event(nfc);
> +}

Throughout the driver all calls to anfc_wait_for_event() ignores the
timeout return value. It would be nice to see some error handling in
case it times out - at minimum consider printing out an error message
since timeout on NAND operations are fairly critical and should
generally not occur. Perhaps even an argument can be made for
returning -ETIMEDOUT in case of timeout.

I'm putting a focus on this because I see the original non-upstream
Arasan driver sometimes timeout on NAND operations when I stress test
it via the UBI stress test. Not sure what the cause for the timeout is
yet but either way an error message would have been helpful.

Br, Martin
