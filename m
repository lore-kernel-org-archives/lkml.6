Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931AEC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F7D2083B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 09:34:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVhxyUSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F7D2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbeHaNkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 09:40:52 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45695 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbeHaNkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 09:40:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id u83-v6so9526463lje.12;
        Fri, 31 Aug 2018 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WS5p00ItCHcw4rbEZG+VJ8/83UKSmQ4iDVjVkCx0Cxw=;
        b=AVhxyUSrXDFylqqMDYhaZrxHJb51O9BE8exOaGK1LmnEWwPtoc6us1iMZM4FpGS2u9
         /jAMaIvYT0S6MUKEeg098iDQXtd+r0hmRZb4Ysbdm1V0MMHsR/oEe1YVO1dwBsI8YEEW
         F3u7+oTGLZMbjCKB9R1Vmg3eAbSuPaVShnXjNONjMxqVIUbk+8pdpuOtw+x5KhbCdmUL
         3541M4phAHHcVyEKuToMYV0wXxzLg6Rw/jRByr+boT5iB1ZcyuMmox3sNQdzOLqkILNn
         rWx81fHEvYoZ2/1eWyZYQoLptWkdBLjhlKJ197l5ZRFyG8YjuJ5bGUrQ0VxYiKswk3SP
         639Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WS5p00ItCHcw4rbEZG+VJ8/83UKSmQ4iDVjVkCx0Cxw=;
        b=XhEeKb4gulP/Z///+c8JAfyOBeZ4CtQ+7OcG6klNFKvjVN7+Y/rBixfg1f5A6tl65y
         kCESubuzJzTiL2CkDkAhS7XVRsOomncTtBqREx1mEr1V5eL21p2K4IPTNj4Pg4mZdjpN
         uunIXCDoFyMtqQXrXmgEVKbj62H5K6LYyYTRT4C7+NeIgxlwID/xOEWW4gx7H4UAknZv
         di4EvpbOm2gcPuzPndI9GF9I8WFt/c2AeHYcxa5O8VCHzV0JKW3rHHW4u/XuP1WdH0hR
         /iYkUDyAaN7aWJOT0FTjyDPP/j/ewo6z/aDsGX4dY5MtqkCvfSMcZinV9LUTPkZ2Xart
         LJaw==
X-Gm-Message-State: APzg51ByZ8luzySPGwnh4RB+WMllvImS1MXlq96jEZ61Bsm8lfLToTtk
        NBYR5fJITYxTy8Oa/pYqD5E=
X-Google-Smtp-Source: ANB0VdY05xFrUWJMoT1118hCtjWeIULcLKVNlZVRn26xymJIMToGrAjaY/xwAIOL5dQuknRraoJU1w==
X-Received: by 2002:a2e:240c:: with SMTP id k12-v6mr1986873ljk.135.1535708052801;
        Fri, 31 Aug 2018 02:34:12 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r70-v6sm1745319lff.0.2018.08.31.02.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 02:34:12 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fvfoj-0006dp-GK; Fri, 31 Aug 2018 11:34:13 +0200
Date:   Fri, 31 Aug 2018 11:34:13 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Johan Hovold <johan@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: ti: fix OF child-node lookup
Message-ID: <20180831093413.GK28861@localhost>
References: <20180822090319.29167-1-johan@kernel.org>
 <153549552398.129321.2521954503276443182@swboyd.mtv.corp.google.com>
 <20180829075007.GC28861@localhost>
 <4fbdbb5d-6b56-37e2-08e1-27f71cb6de22@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fbdbb5d-6b56-37e2-08e1-27f71cb6de22@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 10:28:28AM +0300, Tero Kristo wrote:
> On 29/08/18 10:50, Johan Hovold wrote:
> > On Tue, Aug 28, 2018 at 03:32:03PM -0700, Stephen Boyd wrote:
> >> Quoting Johan Hovold (2018-08-22 02:03:19)
> >>> Fix child-node lookup which by using the wrong OF helper was searching
> >>> the whole tree depth-first, something which could end up matching an
> >>> unrelated node.
> >>>
> >>> Also fix the related node-reference leaks.
> >>>
> >>> Fixes: 5b385a45e001 ("clk: ti: add support for clkctrl aliases")
> >>
> >> Found by inspection? Or it's actively causing problems? I'm thinking
> >> it's the former so this can bake in clk-next for a while.
> > 
> > Right, through inspection. I fixed up most of these last year, but this
> > one managed to sneak in since then.
> > 
> > clk-next should be fine.
> 
> The patch looks fine to me also, just had to test this out with my 
> latest development branch as it conflicts with that one a bit.
> 
> Acked-by: Tero Kristo <t-kristo@ti.com>

Thanks for reviewing.

Johan
