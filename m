Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A771C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76E823F4C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 16:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd46BvVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C76E823F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbeGBQaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 12:30:17 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45955 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeGBQaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 12:30:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id z1-v6so7362995pgv.12;
        Mon, 02 Jul 2018 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Dy8bAeaIJldhTuR3HVh9xyt9LW0mcR/D8NkSOOWm4JA=;
        b=Nd46BvVeWkIYKr4o/YaXZYw7mY0+sIY2G4uDQmn3WuXkUcQ+8o2bCcUrF2EUl7FHEh
         IC5K3RgJDcSydaBRZXGsNU90rZfKrsu+iHB1h2KRECF2E6v6Bs7k5a76JXSy1XgsLMe5
         4HrXK52QAkVgYrcDLioeoilJ7ZY70tvl0zhRQjeILKMEXN+2PST88KpjPnGePUDcw3uF
         XfhSk7gW8FK9ozBD48hQSmwX6r6tui+kkaANMi8JnVDJrp9tItasGmB6OEUQh3JZvfl7
         RYWaEfgbrKm1GyYGBsnAHU4SxwIOERFVizVWsQ5Vibgtiq7a2ebe0EiwuLhSAhgEcMS6
         k+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Dy8bAeaIJldhTuR3HVh9xyt9LW0mcR/D8NkSOOWm4JA=;
        b=qLcYT9wLINC6JXKKYhX49mauF2+KRJP1Y95KeXoL5JdwS+clzcJjUooOCvWBeF/ss+
         g79To02QLjljXch/8Il4Utb8sKIgmp8zi09YvKV7VkBNwYYguO1klB9+z32ezoha/Jv7
         1KpQIg05pXJdJ92BOOx9QlQoXQc1yk5KnPm0nmmFmOGr7bcmtwYEE4lNVGsI4v04thjl
         Ud87Vitn31iB18Bem2narqpA/9U8ZnZQiLQ3ovTQfMZDqZ4MIWo5aUThWlzR5jbSElEK
         21QidsibZIHTBgsfawYKQ4R8dhBbS3vFcBGf/qvu7kfbzoVtQl9b20ZSrIQPSpq6SL9f
         CHSA==
X-Gm-Message-State: APt69E02kJlZlMF2OOKG/4amnt4brgLrRY3pmZl7yp3qIUE1MQayOqaG
        G56ipf23kZyklG2TnWtVz4o=
X-Google-Smtp-Source: AAOMgpduTgGgEtSdTWnC8OUGWvMXBBeSAZtswrY6zwZII7jxYpIxBxMLKNahu0TFWRDF4jLpVxCeSQ==
X-Received: by 2002:a65:6411:: with SMTP id a17-v6mr18480002pgv.287.1530549014158;
        Mon, 02 Jul 2018 09:30:14 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id m21-v6sm21920000pgv.27.2018.07.02.09.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 09:30:13 -0700 (PDT)
Date:   Mon, 2 Jul 2018 09:30:11 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Keerthy <j-keerthy@ti.com>, Zhang Rui <rui.zhang@intel.com>,
        linux-pm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Message-ID: <20180702163010.GA2380@localhost.localdomain>
References: <10747698.EAsn0e6Ddm@amdc3058>
 <CGME20180629161027eucas1p20846507c4f98f50d80ab58aaa1628fd1@eucas1p2.samsung.com>
 <3318201.BAqn4C3t6k@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3318201.BAqn4C3t6k@amdc3058>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keerthy,

On Fri, Jun 29, 2018 at 06:10:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> Hi,
> 
> On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
> > Majority of this code (i.e. functions from ti-bandgap.c) has been
> > introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
> > SoC thermal driver"). Just remove it altogether (in case it is needed
> > it can be easily resurrected from git repo).
> > 
> > While at it fix incorrect "not used" comments.
> > 
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
> >  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
> >  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
> >  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
> >  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
> >  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
> >  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
> >  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
> >  9 files changed, 5 insertions(+), 654 deletions(-)
> 
> Gentle ping.
> 
> It would be great to see this patch in v4.19.

Any objections on this removal / cleanup?
