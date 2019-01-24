Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4714DC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13EC72184A
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fXU0k76W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbfAXIs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:48:57 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36589 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbfAXIs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:48:57 -0500
Received: by mail-pf1-f196.google.com with SMTP id b85so2664450pfc.3;
        Thu, 24 Jan 2019 00:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03LSyQJmK0QIsVYtAAkHYfPZhqSSFXDN2CgqTrpbjKs=;
        b=fXU0k76WiVA5PLQaH3p3fnImP36q4oEWek/mlK4lrPDxeWhA7jHR8d3SS+wCDa9TnU
         HT+jdnpzzN/JPoNyT3LD/ydTH2g0lbG2CIg2Gc0Lzv1+f4DowVbQPxPe0qWrNbYYo8w8
         iqeQOA8sZZ0Sry18FKJoEWpIPQimb6+Y/u3DRQo7+0VnE/SgxLvjNk4x2ejQlEfadzBo
         gniU5DZtR5v5HER3Ra6ZljAeJbovSDUwv5KUUOEaqsHbblDsx0HIuZHhfLG/cBZ4ZfHv
         cnc/hLSaoYVOXgcQA2aCugSwPKr3TmvblY7L5t3cyBtV+1IQGuypYtjz0mgamgBaOYHp
         hrFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03LSyQJmK0QIsVYtAAkHYfPZhqSSFXDN2CgqTrpbjKs=;
        b=HjGUZnw+3vmkodL7iWSaUDjm9PttvPuxm61csnHhBAfL/5MrCVqGG44nIzce+jOFgI
         bcR0Vd+GV7Efc41CvDhsZ7dzIU9whTHfW42F5/Zgw8JJjs6U6Vd6K4NKU9k4v/bNAApv
         i7SnPq6ULtIRbDmcUaMTOsNCC8zf4PNunGD6eEFqg0v0sA6NArYSqLev/dKlwwkez5qe
         XJuJQBAAez8LI1hllMni8PIemohrELns1I2n0ZjZd80oey3/+X9ELW2pd18Pvhcub6ej
         JrPZlmmQrsCJW5jn2EuvQm3iFWsSPsgbjNOd7oSEVnl7AkhwZzeZTBWN/XxuI/lTwlZR
         J4CA==
X-Gm-Message-State: AJcUukfF9QXonfGUhU9ViaqZOP/6SbQncS+mCEnEUj95MbC/xih4/0Vm
        qHV6IGNd9QrwQl4B4h0gG9M=
X-Google-Smtp-Source: ALg8bN7demefXZB/IhwqcZp31z7GbilDKu73ObNs42QbPIQ8SqvO243hHwDdamuFFNVxLjQHCd7I6Q==
X-Received: by 2002:a62:345:: with SMTP id 66mr5569677pfd.189.1548319736166;
        Thu, 24 Jan 2019 00:48:56 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id p6sm30310032pfn.53.2019.01.24.00.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 00:48:55 -0800 (PST)
Date:   Thu, 24 Jan 2019 00:48:53 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Martin Kepplinger <martin.kepplinger@ginzinger.com>
Cc:     Martin Kepplinger <martink@posteo.de>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, chinyeow.sim.xt@renesas.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: st1232 - add support for st1633
Message-ID: <20190124084853.GD139904@dtor-ws>
References: <20190123072651.31791-1-martink@posteo.de>
 <20190123072651.31791-2-martink@posteo.de>
 <df37b873-0641-c127-d6d8-5bd9ed155e87@ginzinger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df37b873-0641-c127-d6d8-5bd9ed155e87@ginzinger.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 11:07:55AM +0100, Martin Kepplinger wrote:
> On 23.01.19 08:26, Martin Kepplinger wrote:
> > From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> > 
> > Add support for the Sitronix ST1633 touchscreen controller to the st1232
> > driver.
> > 
> 
> FYI, here's a protocol spec:
> www.ampdisplay.com/documents/pdf/AM-320480B6TZQW-TC0H.pdf
> 
> Let me know if you want that link in the commit message.

Sure, please add it.

Thanks.

-- 
Dmitry
