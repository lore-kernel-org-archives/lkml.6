Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E4C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1072084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 08:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mix7lz5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E1072084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeJEPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 11:50:27 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33325 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbeJEPu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 11:50:26 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so4781290pfn.0;
        Fri, 05 Oct 2018 01:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q6KQNhXaM4LDZO9ZIxVZz/FIgzZuUejeInKdsfelKB0=;
        b=mix7lz5TK33gFKhPsZDgCZknhWUrIf9fVve4Ba8yGGYu7WxnjpxhFtnNMPr0kKooH5
         AT5OAfuWmWItIB8NJONgPluPDLA2Z0wb3qlc+S4QZZEIP2KMGwhCCRQ3H26FIJJe8d93
         H/blRqBb6RYC3rpV2YZ4nUs/3sh5RbZeeRO6muihyr3XKcs2PJoYVFTxvE+OYMDOlaLy
         BopTVy203jhRSGHv0trL8ONLcTKZ5RgBRIBzKs9l0G83i04VvowH3keuggwe8lx5KPtp
         ouh6RSgJpQ/q5EfwmXYVFq85U1tKwAlocXCOargo5U/3H3e00OQHcbo3jgpKJJxSbb+K
         F/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q6KQNhXaM4LDZO9ZIxVZz/FIgzZuUejeInKdsfelKB0=;
        b=g8LXE16V3t+3dtAhBc5KakqKio3p7H1NhdoYYHZY6PMw4/8aU4eTCvX4mrfXnP3kBr
         j2P1a3/fvw9VTDyI/o6dbVzSOW7Oq8SGD4e04uiQHOeNzsP0rh2/OLii8LmeJwKXlnzz
         UetzeER1N6W6aagHTmwvu3GK9qD+xrCFqxsWTAIMoJnLwGkpjeIxAWQ7CrGImKsTts+2
         eUykezk53suWtZnhxkVUCBhDpkzm3+LDyQczNeaCIOcKhQkNudQU32b/Zk3EqtNF9Pm5
         f9dxVNgjkaFqEDwf6DcazwMTzM80UhUqhrDhufaIML2e/XINR9Q/OQc2em18fNRM3rQ2
         7C0w==
X-Gm-Message-State: ABuFfoiBcZr4euvGOmj8cPW4PSivER289VkWJExrKhcAUWmooZPIcxol
        kcJe4RyDVedvuN1g9Zmx//njC/9qNtu5rg==
X-Google-Smtp-Source: ACcGV61RyrtIguVJPBCjB+yWkxncwSLTIwqpR/cdxk69xwSWbnkbuH2pIA9ee/AMdif7RjYBypCEzA==
X-Received: by 2002:a62:21d1:: with SMTP id o78-v6mr10696410pfj.235.1538729560385;
        Fri, 05 Oct 2018 01:52:40 -0700 (PDT)
Received: from localhost ([82.102.30.219])
        by smtp.gmail.com with ESMTPSA id z26-v6sm1245748pfh.77.2018.10.05.01.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 01:52:39 -0700 (PDT)
Date:   Fri, 5 Oct 2018 01:52:35 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Message-ID: <20181005085235.GA2106@localhost>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
 <20181005082844.GT2302@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005082844.GT2302@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 11:28:44AM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:
> > On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> > > Clang warns when one enumerated type is implicitly converted to another.
> > > 
> > > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > 
> > Please remember to CC driver maintainers and authors on patch
> > submissions so they can review things, copying in Hartley and Mika.
> 
> Thanks for copying me.
> 
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > > 'dma_map_sg'
> > > \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> > >                                ~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > 3 warnings generated.
> > > 
> > > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > > driver uses dma_transfer_direction for everything. Converting to
> > > dma_data_direction would be desirable but there are a few shared
> > > structures that expect dma_transfer_direction so it is just simpler to
> > > change the parameter here. dma_transfer_direction and dma_data_direction
> > > are different sizes but this driver only uses the 1 and 2 values which
> > > mean the same thing so this change is safe.
> 
> I would rather do the conversion than passing "int" to the function even
> if both enums happen to have same value now. I would be surprised if
> there is no helper function already for the conversion :)

Hi Mika,

I will go ahead and spin up a v3 in the morning for review and copy you
and Hartley, thanks for the comments!

Nathan
