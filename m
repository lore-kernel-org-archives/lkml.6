Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BB4820652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ufOowqFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB4820652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388212AbeGTT1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:27:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46194 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731939AbeGTT1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:27:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so11855883ljj.13;
        Fri, 20 Jul 2018 11:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JsWCJcXk2I5J9D+iQuR4M3uhG40dpNyDVB9MM87zk+U=;
        b=ufOowqFB6kYderNIXsh/2w8lJMWEhT50HKz1c3esgYpyOOwqzcYVPPkMtMFFX/nI/J
         bZDnDtsBUZG0QVeXaXtitJVmj249UJ06Vm2PlnYKqp9P9GKqaUugvM+VC4MSxmDKzBq+
         kKY6q+fwDP4PqHWgFKJNtGC86Erb1nxHMqM8es+aQY7WaqkfOwF1TJb/POOUQiIRYQyc
         ODiD3QTQeYmi4Z6GfPSq8kzLgGVUGzeC2J3Fbtz4f9kYSw40arAiXCPddpnvvMR+23bx
         0QQwlHJaeevwkHoVgjFsSumI88xxxxz6Y7l/FwVGIPql0bfxSzFhtgYcOnqWfXK9sh4B
         MhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JsWCJcXk2I5J9D+iQuR4M3uhG40dpNyDVB9MM87zk+U=;
        b=eDJB6KVCxbOiwhm0B7G/kzFbsH+OzPMIYjz2HpYY3TwB2wVMiQTVtWOuR2NQJt9kCL
         IBfEdwUxEb3rowPGVP735yriggAnDOXwZA9xV2NrjnINH59G7lcZ8LLgs5xsYkWQeLuW
         v/SUPPavJFzYJjOCFnNKb9KcvP8U0TMe9QJDjIHS/yyjhV+fyNKHFfjBfDbmikCIfuUE
         42nhjo6JJj0W2E5JCZ73w8EJrRzY3AKV/8FzgOY6Xh3zZ6k6pbXv769nSYMWL/pjNWtO
         OG4meACdC3b8QQJG37kw1mR/JU1vpGZCfhpiTdoCuD2CYQNDTG4/sXm4ZuKGQ9PklmOZ
         Ujgg==
X-Gm-Message-State: AOUpUlHLE6QBCq7dGqHXX2/Xs9clvA4SowbDnut67P1lbCmh/YIF4FtA
        Q+4/C+JgUliHQUVc/Dl5F/w=
X-Google-Smtp-Source: AAOMgpdax6nOBaAiZwuXfnW03xe/56py2jTUp/nknHUGjhioDBs/BCuYPj6OjOKDE+TK4SIZkkXG7w==
X-Received: by 2002:a2e:9dc7:: with SMTP id x7-v6mr2366635ljj.142.1532111854007;
        Fri, 20 Jul 2018 11:37:34 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id z7-v6sm387088lfg.89.2018.07.20.11.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:37:33 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 8/8] mtd: rawnand: ams-delta: Use GPIO callbacks for data I/O
Date:   Fri, 20 Jul 2018 20:38:15 +0200
Message-ID: <2165137.iTHcPHRtIn@z50>
In-Reply-To: <20180719084749.25ca96a6@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-9-jmkrzyszt@gmail.com> <20180719084749.25ca96a6@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 8:47:49 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:10 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > Don't readw()/writew() data directly from/to GPIO port which is under
> > control of gpio-omap driver, use GPIO chip callbacks instead.
> > 
> > Thanks to utilization of get/set_multiple() callbacks, performance
> > degrade is minor for typical data transfers.
> 
> Same comment here, don't use the gpio_chip hooks directly, use the
> consumer API instead.

I tired but performance was not acceptable.

I see your point but please understand, what I'm trying to do here is not to 
develop a shiny general purpose fully GPIO based NAND driver, I'm trying to 
resolve issues with NAND driver for Amstrad Delta I like to play with, without 
loosing much performance.

I'm going to reconsider all possible options, not only doing data I/O over 
GPIO inside the driver, to have the task completed.  Once done,  I can get 
back to the GPIO based code I developed so far and create a new generic driver 
as my free time permits, or anyone can do that if needed, the code is open 
source after all. 

Thanks,
Janusz


