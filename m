Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72ABC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3612085A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 07:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lh89/3Xh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3612085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeJZPz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:55:27 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38667 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeJZPz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:55:26 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so517798ita.3;
        Fri, 26 Oct 2018 00:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vo5xr0xXlqTEht1OD2RhtTT0/mL6IJUbl6auexDS50Q=;
        b=lh89/3XhywHqIUBxeO+t4KCzAx5250Ca6VKB8t+tp1PxuMqCBZAj+brIjfvFLBdCGy
         sMmiXkcpvST2MkacvWBZJVy+8Mr05chY6CakeAqYwaIC3htiPgVVvA4NYXcG2cT91+EN
         NOUCgKfC+9H36Aj8tFA1hTVuCjHIiELZT4Z0ZSpLoxP/SSHGC1PLQltDzRpeBFf+MzVW
         wtDitYUeChtbKTaBKEhPC08WxrpHawdO6ATX61iN08quV7bw7CUh6TvujuID7+SEWnTJ
         ToWBRH0PEOJqfcxDgvi8SmwEoy8J5Fftn/ndf4rg1F+yYqnM9hPXiyledpAmFuh2sWYK
         HrwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vo5xr0xXlqTEht1OD2RhtTT0/mL6IJUbl6auexDS50Q=;
        b=ZsMaK9VPDrzolil7Dk+noVRAu7oCgo0OsOEjvKP0v7PfUh0wRHc4C4zTM5+4meXQVF
         hNXm3lkNWEwsbkEJ3mw7QX5DY1/UpzW3LeHVJQfBtZncIsAWbTqCSj4vu12dkgb32dYM
         vr1rnA+cZCrIjP5QkJdocgkVmv+0Co7khKR/IdiZyHWHmAfDuU6d9bK0JWjle7w4L+gu
         gWsOuwE6kr3+shAlSY0OEBUr/yUewLekGcVQU3tShO6VEwtumljGtSl/9+peJJJocygG
         V05XCJn8V4TuPpMNI2b2pLRHuokI+vqIPqa+w8lGfal1LNZ/AcDo2F8ZV0I2dieEoR7S
         yqwQ==
X-Gm-Message-State: AGRZ1gIjtOXP8NWTcHX/zbTK1cG6Xz/ik7LqwEydBUxe9Eh/f74mliak
        8hn+6ovcibG4CDnxuuvJkvY=
X-Google-Smtp-Source: AJdET5daQVM3JARIjyFaHDfnJCJ+dlXrvUohG7xkMkpXt+6YgticCkbThmpqNG0yHRysiuixs/c3Xw==
X-Received: by 2002:a24:6486:: with SMTP id t128-v6mr2982997itc.136.1540538376050;
        Fri, 26 Oct 2018 00:19:36 -0700 (PDT)
Received: from Pilot130 (211-20-114-70.HINET-IP.hinet.net. [211.20.114.70])
        by smtp.gmail.com with ESMTPSA id d8sm1596836itk.38.2018.10.26.00.19.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Oct 2018 00:19:35 -0700 (PDT)
Date:   Fri, 26 Oct 2018 12:53:16 +0530
From:   "sudheer.v" <open.sudheer@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Russell King <linux@armlinux.org.uk>,
        Dan Williams <dan.j.williams@intel.com>,
        Jiri Slaby <jslaby@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Michael Moese <mmoese@suse.de>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        Sudheer V <sudheer.veliseti@aspeedtech.com>,
        ShivahShankar Shakarnarayan rao 
        <shivahshankar.shankarnarayanrao@aspeedtech.com>
Subject: Re: [[PATCH] 0/9] *** DMA support for UART in ASPEED's AST2500  ***
Message-ID: <20181026072314.GB30088@Pilot130>
References: <1539749466-3912-1-git-send-email-open.sudheer@gmail.com>
 <20181025144841.GA21004@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025144841.GA21004@bogus>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 09:48:41AM -0500, Rob Herring wrote:
> On Wed, Oct 17, 2018 at 09:40:57AM +0530, sudheer.v wrote:
> > DMA controller driver  and UART dma client driver for aspeed's AST2500
> > 
> > sudheer.v (9):
> 
> We need a full name for author and Signed-off-by.
> 
> >   DT-changes-for-DMA-UART-of-AST2500
> >   Defconfig-changes-for-DMA-UART-of-AST2500
> >   configuration-for-DMA-of-AST2500
> >   Documentation-DTbindings-DMA-controller-of-AST2500
> >   DMA-driver-for-AST2500
> >   configuration-for-DMA-UART-of-AST2500
> >   Documentation-DTbindings-DMA-UART-of-AST2500
> >   DMA-UART-Driver-for-AST2500
> >   updating MAINTAINERS for DMA and DMA-UART drivers of AST2500
> 
> Your commit messages need some work. Use 'git log --oneline <dir>' on 
> each directory for inspiration as to what the subject should be.
> 
> DT bindings specifically are "dt-bindings: <binding dir>: ..."
> 
> Rob
Hi Rob,
As per the comments given by vinod and Ben,
we are planning to resubmit the patches, after merging these 
two drivers (dma and uart) into single driver.
While resubmitting, will ensure patches are formatted with
proper messages, following the convention.
Regards
Sudheer
