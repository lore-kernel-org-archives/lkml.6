Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44084ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF862151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 17:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOTDiMMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF862151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbeISWwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 18:52:23 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39448 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbeISWwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 18:52:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id w14-v6so2970868plp.6;
        Wed, 19 Sep 2018 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/bpo09+x2ZY+bc25bkzSobCL2+0iuJPV2ADOkuvmYBE=;
        b=JOTDiMMvPuzHyOKlymhYgPbxJ6hO7NUhvE9VcsNw2Xrw9MbzKoa/HZJ8hSRWe7xYkv
         iBERdh/mk6fMTOvDiLQWnDGLVjOXcyhSygiy6tykUwPgGhORlr7YSMC/svTHVpWu0a19
         ktSnwhBISmiUplGXLdpi6aCqpgLAGzB0IDmyTNyiHBbVTrArL25O5dUHdVnwSfWZkJ/b
         sr1SKIoCR7ht93Zj2U/Rg/zgOu3wjuo5xzVcE3GO1kUBHKdve1b8oLDZtHmJZtj8Ow/z
         mhH4n7RpFUkT1z9Gfw51dbPkuHp4O07tZiWrKJVn2Uq85VRyHdAe0QK9VlluovcnPA+e
         r2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/bpo09+x2ZY+bc25bkzSobCL2+0iuJPV2ADOkuvmYBE=;
        b=tadPZvHW5/i/oRQ/U7Neh4I4nMmGHAQab0KawGNIvSXhRWkqfmiMvij/rFbpOjv3DG
         thnvSBslZfHOomoempWkTnIQQHjbYK4RnFfAJiT0xqfwGDaip2PyYYn5EmPaWdc9e1ld
         tglJ8JjGnIofRzgUAHoyNET7Nnpc6Yo1ygvP9PZZ/jt6CxtiC/NMBBB9fkyQwnIM5251
         TJhCucpisTlaV/ZeAnzXNReUlqcOHY95+YMNIPz5LxuW+jzPCtn8n/y6hyMlqsteMz9Q
         r3vsVc/uaYwHIgdl8F1DJKqSVlgAaGoZtXdUZnBC87TovfCh/OlmrfFocFD/Q3kJhkYZ
         P5Ag==
X-Gm-Message-State: APzg51BXKxhxuHNe3Z5qhmWap6wF771sDlyioCSToau3X1v3A2Rmh34R
        aOu/pgkzppanoSjUjNFUO9d/mHz2
X-Google-Smtp-Source: ANB0Vda52fcLS9VoQK8KdreontadrEf3EKRnj/x6twH0MEZckGujxX43zInNoBDUV1vOEw7t+NNBFw==
X-Received: by 2002:a17:902:bd07:: with SMTP id p7-v6mr34763184pls.32.1537377210022;
        Wed, 19 Sep 2018 10:13:30 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id r17-v6sm33779763pff.50.2018.09.19.10.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 10:13:28 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:13:26 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes
 for legacy boards
Message-ID: <20180919171326.GB116719@dtor-ws>
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com>
 <20180919151026.GB11965@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919151026.GB11965@kuha.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Wed, Sep 19, 2018 at 06:10:26PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Mon, Sep 17, 2018 at 11:16:00AM -0700, Dmitry Torokhov wrote:
> > Several drivers rely on having notion of sub-nodes when describing
> > hardware, let's allow static board-defined properties also have it.
> > 
> > The board files will then attach properties to devices in the following
> > fashion:
> > 
> > 	device_add_properties(&board_platform_device.dev,
> > 			      main_device_props);
> > 	device_add_child_properties(&board_platform_device.dev,
> > 				    dev_fwnode(&board_platform_device.dev),
> > 				    child1_device_props);
> > 	device_add_child_properties(&board_platform_device.dev,
> > 				    dev_fwnode(&board_platform_device.dev),
> > 				    child2_device_props);
> > 	...
> > 	platform_device_register(&board_platform_device.dev);
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/base/pset_property.c | 110 +++++++++++++++++++++++++++++++----
> >  include/linux/property.h     |   4 ++
> >  2 files changed, 102 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/base/pset_property.c b/drivers/base/pset_property.c
> > index 08ecc13080ae..63f2377aefe8 100644
> > --- a/drivers/base/pset_property.c
> > +++ b/drivers/base/pset_property.c
> > @@ -18,6 +18,11 @@ struct property_set {
> >  	struct device *dev;
> >  	struct fwnode_handle fwnode;
> >  	const struct property_entry *properties;
> > +
> > +	struct property_set *parent;
> > +	/* Entry in parent->children list */
> > +	struct list_head child_node;
> > +	struct list_head children;
> 
> Add
> 
>         const char *name;
> 
> and you can implement also pset_get_named_child_node().

Or
	char name[];

to avoid separate allocation.

Alternatively, we can add it later when we need it, and add
device_add_named_child_properties().

I'll leave it up to Rafael to decide.

Thanks.

-- 
Dmitry
