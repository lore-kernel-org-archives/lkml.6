Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA298C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA91A2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 03:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XDg+o/jE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbfAAD0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 22:26:33 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40486 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbfAAD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 22:26:32 -0500
Received: by mail-pl1-f195.google.com with SMTP id u18so13166064plq.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Dec 2018 19:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=koD8akXG6XEb6yxJFJ9jXYmiNEUmQM46EGLjAZM9WsY=;
        b=XDg+o/jEm6W4w3X40pSKjTJRQTNDZl/tJ7hOJNRwtYkl9K4YpnMJ+M/C0IhISBF5OQ
         co4XLjLJYQXaMvWnBWLJbSDHLmKmUZlJwNhyZr1Np9CWVvmELfoqlb5XnLPk0qGcD88k
         fssbI5rIbJi8/CTTZntvpNiHxL99jveWcjsOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=koD8akXG6XEb6yxJFJ9jXYmiNEUmQM46EGLjAZM9WsY=;
        b=d05aK4XXD1ormNqQfq3XPGnZqwiTyze/QrfK1DriwTxkWCvq1d8egn55tjudJ5fwUq
         +K59EoyOZBoFcIjjNxfn6rbK6NmWIjYopovOzIoW8A5FRi+UlnBkNbDA2H2P1ljttm/b
         QTGQsWa8eXaajDoROIh5xCoOsOh/l2FsqwmpBXuVWjtHGXBj/ULXpKc0f8FYBO/EQ72I
         DOF9ZFk5dkovdrzyLPMRNEE+QJsHJkWygm5HNkuS7nltOBpcWBuWSbOW5eROEYRl+Ei9
         ix0C6x9OXhobOn2o3NiTh6oWu34wSgtjSNxU5BZyDrK/t8v/s+nP9WKpSiZctQUdhPYN
         +BvQ==
X-Gm-Message-State: AJcUukdt2k0N7wFrID+MmslSAtZ1Q7yVXVp2KCLxJHQY0z1jw1DngDJL
        yYOf/kZEk6U9tjXTdCbM6WbW
X-Google-Smtp-Source: ALg8bN7q2drViqpaFZBkNnXa3aQPuJXb3ycyShgdc7LB9noeUwVcI0gtLEiZbYqSGK1mN836/z9uGg==
X-Received: by 2002:a17:902:2868:: with SMTP id e95mr39328666plb.317.1546313190867;
        Mon, 31 Dec 2018 19:26:30 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:73cf:97ca:3812:84fe:81d3:6fa8])
        by smtp.gmail.com with ESMTPSA id k24sm71662750pfj.13.2018.12.31.19.26.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 31 Dec 2018 19:26:30 -0800 (PST)
Date:   Tue, 1 Jan 2019 08:56:22 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Joe Perches <joe@perches.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, afaerber@suse.de,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 6/6] MAINTAINERS: Add linux-actions mailing list for
 Actions Semi
Message-ID: <20190101032622.GC2736@Mani-XPS-13-9360>
References: <20181231185517.18517-1-manivannan.sadhasivam@linaro.org>
 <20181231185517.18517-7-manivannan.sadhasivam@linaro.org>
 <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a7f53c58896e2a9c3115a8630040b98497e5877.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Mon, Dec 31, 2018 at 11:12:18AM -0800, Joe Perches wrote:
> On Tue, 2019-01-01 at 00:25 +0530, Manivannan Sadhasivam wrote:
> > Add the linux-actions mailing list for Actions Semi SoC architecture.
> 
> Unrelated to adding this L: entry
> 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -1240,6 +1240,7 @@ ARM/ACTIONS SEMI ARCHITECTURE
> >  M:	Andreas Färber <afaerber@suse.de>
> >  R:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > +L:	linux-actions@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> >  N:	owl
> 
> The N: entry matches too many non-owl entries like:
> 
> Documentation/parport-lowlevel.txt
> drivers/misc/ibmasm/lowlevel.c
> drivers/misc/ibmasm/lowlevel.h
> fs/udf/lowle
> vel.c
> net/ipv6/ip6_flowlabel.c
> sound/soc/samsung/lowland.c
> 
> Maybe there should be two entries
> 
> N:	/owl
> N:	-owl
> 

Thanks for letting us know. Yes, we need to change it. How about below?

N: owl-
N: -owl

Will do it as a follow-up patch if agreed!

Regards,
Mani

> 
