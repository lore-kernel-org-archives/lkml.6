Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81692C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472A6208B3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VP3M5dHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472A6208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeI1UkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:40:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38114 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeI1UkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:40:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so4437745pfh.5;
        Fri, 28 Sep 2018 07:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rSit97sBG7MAP3SecOqU14k0fOOvrQaIlIM7uZsz8SM=;
        b=VP3M5dHb2dRtSkgcSE4o2DkC0q0riaLROdLi5MRldFEfvI4CY8vzqX07aGO8aDc/8E
         nuZyTThCiZVIerg4Gp7hDPU1P7UXqndU2y+/uk280RHJYUWxhJCrsVmtafFE2t+cmoCG
         gVjaNFvIUXLVp0D0nByY08tiU1AZSA/7hxrmoQy9KViMari3t0Vrl1uHcfON06um+c6V
         0+YnYM4zwMcmtccteho1qPayux7AT6PBq48avp1bjuH/17OeP6+ZKnJsnLjguE+An85L
         iCWtwOtvSPw/tOW0CyVquP7fnj+VM79tM+IQYWcEVb7H7l7GQPQ3Qou60d2Y4zx91exn
         n/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rSit97sBG7MAP3SecOqU14k0fOOvrQaIlIM7uZsz8SM=;
        b=Q3WGDsRidI8F4rynBkSL9t29OuYmGhHL9HvMgoZY8gN9kDRXjCnp5blb0krD3im8pq
         y2D4c+OSILHBkOFDT2uuCcAf9XzX188VQGHvnDlNHJij7wgWQWFoak9ZtZq1A3xhcbGe
         oyvshMGgOlt6Ey3WiqRI7bRSp0ZyXiMywiaaUVZibhpi8Vm3ay/j6MEnrGiubXytSjvG
         gBhlhpzWeMR/PzwalTeVzdk4X1AWhzEpzns/TrfV4p4gxLMaO6qd4SHbDRxRmkPVKgVc
         0mqE524zMCQV0BT8H1y3YDaEG7k4Xxq4x5dt1Tw+0wZNtgp00j8e34IfCRNOtqaNg1VJ
         c6uw==
X-Gm-Message-State: ABuFfog7l5bd+V1sdcygqOthhLwMtb7QKcA4+dGxj0Dc0nXfS/utwPzH
        gX4T/D7mQKPIUUYBlKKbbR4=
X-Google-Smtp-Source: ACcGV62M/981OWU8xZpDiXCQVu2likTAh/2xmzokaMIOGuHaQgdte/vMEx2p5HdmwipK24fP7c2xZw==
X-Received: by 2002:a62:4613:: with SMTP id t19-v6mr17043682pfa.118.1538144181980;
        Fri, 28 Sep 2018 07:16:21 -0700 (PDT)
Received: from localhost (c-24-4-232-171.hsd1.ca.comcast.net. [24.4.232.171])
        by smtp.gmail.com with ESMTPSA id n79-v6sm5147784pfk.19.2018.09.28.07.16.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Sep 2018 07:16:21 -0700 (PDT)
Date:   Fri, 28 Sep 2018 07:16:19 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Cc:     "Y.b. Lu" <yangbo.lu@nxp.com>, Andrew Lunn <andrew@lunn.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] net: dpaa2: move DPAA2 PTP driver out of staging/
Message-ID: <20180928141619.eojho3rxdjzb24jq@localhost>
References: <20180927111228.46118-1-yangbo.lu@nxp.com>
 <20180927132507.GB23375@lunn.ch>
 <VI1PR0401MB223737CACE4E4064AE8325A4F8EC0@VI1PR0401MB2237.eurprd04.prod.outlook.com>
 <DBXPR04MB3490DB9A1EF2D814568843B94EC0@DBXPR04MB349.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBXPR04MB3490DB9A1EF2D814568843B94EC0@DBXPR04MB349.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 10:20:55AM +0000, Ioana Ciocoi Radulescu wrote:
> Generally speaking, I think it's better to remove unused code from the current
> driver and re-add it along with the feature actually using it.

+1

Thanks,
Richard
