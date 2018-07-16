Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8021020856
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZRH6/wPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8021020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeGPO0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:26:55 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33892 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbeGPO0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:26:55 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so74949185ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lozHBvDPE5V2PNXtmjqfT187P57lMqBskjYgiaM3Ebg=;
        b=ZRH6/wPjip/Y8P7lq5QgDWCrnyjqukfC6vnuwS514bDu/9VK5lrePIi7ikncmYI8jj
         MV2aMnS+EeTDZqBJV++BKTlwks3Zk2eXeicf7D0G9qhm8cFwtgjq3szDgmHfu500K7Ej
         FvU/MkEXQOsK9ffJ75gIDDpIQqYrdMl+W+IpYKHgxA2nbdy1rLT3tMlGbY2HLN/tXLdR
         9eWr4HaC3anugP9hQ4O1tchxV8IOL5mXWCb32xM47ZYhJa+qtX+tUkDXxjVjXjjFrENP
         r3Pc4JBz5ohBmNxyti0c/gP7llnd9ON1tSXiW7X1yGbUWrHN+jf6bv78Tx/LzUqMURnB
         c9GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lozHBvDPE5V2PNXtmjqfT187P57lMqBskjYgiaM3Ebg=;
        b=dcjikq3luRnenJBGoRKJ6pIQzIUpXivxJ4PK8kN6qAea+iiy3gDNGaLMdfF6xP7uf6
         7QeTkoF4Cqi/4lJWze903lueh2CB/VGjmeH4B0zADXZIPrlWSgQ8R3ZIjaOs/AbwZ5Kt
         jgIzkLeauJRkO3DBDn9UfCW3A7R3vN5iJayQvFhWDWRxvdBmjBe3yLzwjCjF4rR9Xgf6
         2JzclRGo3pTAqmoJi1KU7q4CvymeDzKgvFAG9ttf3waZm3fpMN7vwGJguBuQubw4fO5a
         pCDF++/v52/zDs9vG0vdyROmBtDv20KHoMJbEPtrCQeBvEeHpmQ/bVDIVp7Wbu738/3M
         YWFw==
X-Gm-Message-State: AOUpUlEHNMfCXLVIT0v++Ckc2aAQs6P4G5Joy51z9vf7GDr4BGfkp6Q7
        ajJznOIsNOEX+Up9Bue7INnqXdyVaIBhxQTxakM=
X-Google-Smtp-Source: AAOMgpf5okEs89NMT/RpCZ1CmPSg9F7qXjEIrdUTUIKBRJ74CPfcfIaY9NJhUs2g9WaVNn/B5l8riwiuMANOjMS2qBY=
X-Received: by 2002:aca:4b0d:: with SMTP id y13-v6mr18777567oia.198.1531749560234;
 Mon, 16 Jul 2018 06:59:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:6285:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 06:59:19
 -0700 (PDT)
In-Reply-To: <1531716395-21549-1-git-send-email-Anson.Huang@nxp.com>
References: <1531716395-21549-1-git-send-email-Anson.Huang@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 16 Jul 2018 10:59:19 -0300
Message-ID: <CAOMZO5Bo0_+cbC0ikd0OuVV42-z7cz+J2_EET-Rk1xpTxZCTpA@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: gpc: restrict register range for regmap access
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Mon, Jul 16, 2018 at 1:46 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> GPC registers are NOT continuous, some registers are
> reserved and accessing them from userspace will trigger
> external abort, add regmap register access table to
> avoid below abort:
>
> root@imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
> [  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
> [  108.487985] pgd = 42b54bfd
> [  108.490741] [b6db5004] *pgd=ba1b7831
> [  108.494386] Internal error: : 1406 [#1] SMP ARM
> [  108.498943] Modules linked in:
> [  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
> [  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
> [  108.521031] LR is at regmap_mmio_read+0x40/0x60
> [  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
> [  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
> [  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
> [  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
> [  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
> [  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
> [  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
> [  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Thanks for this fix.

Maybe you could add a Fixes tag, so that it can be applied to stable?

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
