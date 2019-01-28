Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AC4C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E0E20880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbfA1J1r convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:27:47 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:42091 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1J1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:27:46 -0500
X-Originating-IP: 90.88.29.206
Received: from xps13 (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id BD00F1BF206;
        Mon, 28 Jan 2019 09:27:41 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:27:39 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Naga Sureshkumar Relli <nagasure@xilinx.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "martin.lund@keep-it-simple.com" <martin.lund@keep-it-simple.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "nagasuresh12@gmail.com" <nagasuresh12@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [LINUX PATCH v12 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20190128102720.70a52da7@xps13>
In-Reply-To: <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
References: <1541739641-17789-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <20181120120244.7d2442b5@bbrezillon>
        <20181120133624.3fa4742d@xps13>
        <MWHPR02MB26238A2271B33470ABFA1023AFD40@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB26239C2B2A7050310BEF1E9CAFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212091135.1d0cc9a6@xps13>
        <MWHPR02MB26236CEF8A2110B20C825198AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212100931.149b0cac@xps13>
        <MWHPR02MB2623EDA15BE59304795F3034AFA70@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181212141825.69711c57@xps13>
        <MWHPR02MB26235AE6567A06EF4C6362E6AFBC0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181217174114.24196d17@xps13>
        <MWHPR02MB26237B932D7F3CCEE0476FE0AFBD0@MWHPR02MB2623.namprd02.prod.outlook.com>
        <20181219152647.76f77711@xps13>
        <MWHPR02MB262396FFF946A95D7821D61BAFB80@MWHPR02MB2623.namprd02.prod.outlook.com>
        <MWHPR02MB262328DF62906C01DCDF18E5AF960@MWHPR02MB2623.namprd02.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

Naga Sureshkumar Relli <nagasure@xilinx.com> wrote on Mon, 28 Jan 2019
06:04:53 +0000:

> Hi Boris & Miquel,
> 
> Could you please provide your thoughts on this driver to support HW-ECC?
> As I said previously, there is no way to detect errors beyond N bit.
> I am ok to update the driver based on your inputs.

We won't support the ECC engine. It simply cannot be used reliably.

I am working on a generic ECC engine object. It's gonna take a few
months until it gets merged but after that you could update the
controller driver to drop any ECC-related function. Although the ECC
engine part is blocking, raw access still look wrong and the driver
still needs changes.


Thanks,
Miquèl
