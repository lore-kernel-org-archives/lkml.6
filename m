Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58087C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 226E020656
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 05:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C/iZ9PGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbeLOF6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 00:58:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43180 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbeLOF6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 00:58:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so3686212plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 21:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vLvcbvZr/qgk6hR402kBjOmWf7cUgxjiM4+Zjy39Ja0=;
        b=C/iZ9PGgG1JPeTxFBLyF/Pn7753HKANn2zKy4b5uxksOkOzrSA7x8SKh9pXgQd4Qp9
         ypDRAoRh2IMyHHz77Qa6w/ddONv8y3SfGlQNaJR3QCy+ASV0ajvtLmpTAHBL4+NUzEvi
         Vp9qsSMwVOWWpyvOWjAwuaTRMirmJ3zR91zwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vLvcbvZr/qgk6hR402kBjOmWf7cUgxjiM4+Zjy39Ja0=;
        b=jyMKQbSYNA3QDeVYwFL4nxUtrRiZsdMrYu6hz70kgrg0aGYjW+ap0Vc1QBxvENluAW
         hnD6W5PJ0NJC/IzkYIZpZBlL2g81doZpbfzmJLvQKPv8mRkXn/7uPY/v46+0icRvCFkY
         M0tS9+FF9abyDvjk13XdNv8tohJYx4rjdqFp72ZCvycrC55kjUnm+zxa3uQp+WNSbD4+
         J3DlmvKYxs146h5NLjaWxnnzfmMu8gra2aywqVKz4PWV9H9wh9LcnYfMCGfrPumwU3FV
         tTyD3vxu+AnjuAPpfzcQHk1kTsjEM+ACTljcYfp56c5+HZlw00pe7uDwsXc7/6wDoRhC
         u6Jg==
X-Gm-Message-State: AA+aEWbXGUAiN8+/yqPaMyt2wbvkFBQ/IovVoceKpCv2/FRXuKjHH5GR
        aHFbHMJOifp7xgzhABxKKJNb1ZtAwQ==
X-Google-Smtp-Source: AFSGD/XjOwFQvvJpbbwa9ZG70TPP0rhXWRf9mIFrrLepc0iW4REtUm2ysDIhnG/3JYY8NluIkk4FAA==
X-Received: by 2002:a17:902:784d:: with SMTP id e13mr5561534pln.188.1544853495673;
        Fri, 14 Dec 2018 21:58:15 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cd:dae9:f1e8:77a0:59f7:2cb5])
        by smtp.gmail.com with ESMTPSA id c7sm12667860pfa.24.2018.12.14.21.58.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 21:58:15 -0800 (PST)
Date:   Sat, 15 Dec 2018 11:28:04 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net
Subject: Re: [PATCH v4 11/15] clocksource: Add clock driver for RDA8810PL SoC
Message-ID: <20181215055804.GA9723@Mani-XPS-13-9360>
References: <20181210173550.29643-1-manivannan.sadhasivam@linaro.org>
 <20181210173550.29643-12-manivannan.sadhasivam@linaro.org>
 <0b90a179-aa4b-57f7-0874-996d5c535ea9@linaro.org>
 <20181212154748.GA28130@Mani-XPS-13-9360>
 <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <affe5ffd-66de-526a-f568-52ad5f0c0083@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 04:52:58PM +0100, Daniel Lezcano wrote:
> On 12/12/2018 16:47, Manivannan Sadhasivam wrote:
> > Hi Daniel,
> > 
> > On Wed, Dec 12, 2018 at 04:07:53PM +0100, Daniel Lezcano wrote:
> >> On 10/12/2018 18:35, Manivannan Sadhasivam wrote:
> >>> Add clock driver for RDA Micro RDA8810PL SoC supporting OSTIMER
> >>> and HWTIMER.
> >>>
> >>> RDA8810PL has two independent timers: OSTIMER (56 bit) and HWTIMER
> >>> (64 bit). Each timer provides optional interrupt support. In this
> >>> driver, OSTIMER is used for clockevents and HWTIMER is used for
> >>> clocksource.
> >>>
> >>> Signed-off-by: Andreas Färber <afaerber@suse.de>
> >>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >>
> >> The driver looks good to me. Do you want me to pick it up via my tree?
> >>
> > 
> > Yes, please do. Marc is going to pick up the irqchip driver but I'm not
> > sure about the serial driver. The rest of the patches can be picked up
> > by the ARM maintainers (I need to send another version for dropping
> > Andreas from MAINTAINERS).
> 
> Ok, applied.
>

Just to be sure before spinning next version, have you also picked up the
bindings patch? I can't find the commit(s) in your tree!

https://git.linaro.org/people/daniel.lezcano/linux.git/

Thanks,
Mani

> Thanks
> 
>   -- Daniel
> 
> 
> -- 
>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
> 
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
> 
