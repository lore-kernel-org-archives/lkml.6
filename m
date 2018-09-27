Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90430C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FB521708
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 20:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FB521708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeI1CXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 22:23:18 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41468 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbeI1CXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 22:23:18 -0400
Received: by mail-ot1-f68.google.com with SMTP id e18-v6so3793971oti.8;
        Thu, 27 Sep 2018 13:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8t3KiJmwQHGuBWuHEvbWUpD+xHUq5CRK3pPSCZZnWPU=;
        b=T/lmXgb5zbehn7nXqf5FGZ1jH6VQHt/57005qj1+Fpa2nEax3/ria3fgWhHiExp1sG
         nQh3TimX1ROGhmI4Wr3yhKgLk6PCVGwG66wcEDBI/fjFC6Iwx6VxMakkKj64MuKmxbwB
         eN5vL9J6i6HjMZslGS44vwJ7I4ORrnYB+R1BhXgrHAD7byqVIvrZtJcfjoEOu+2nJe/j
         BoUCUoBShALEVglRNdS61sY+qgrdSFwDelzn+oWrMwHJhNeUC1HLFatOpEK3ZD8IhF+2
         U5nLg8Egl05yXsPnxhjIshQPFgruasTr1UAEJ1oDtOPo2FiRmPM6gUjgx8IjAhNy/isA
         XcsQ==
X-Gm-Message-State: ABuFfojoKtrODLxyGety/RVFQFNcsMTYeXlPqy65EME01HCNj5AiogeT
        +VU5SISgvkfJAgomhh4PtHgZrY1AqQra
X-Google-Smtp-Source: ACcGV63h2Jgvv4UGTp0QqFcXfM1YQe6rH02RkLl3MGQwjUUig3BzxrflS2UAvtvPHyRDok0MwdpKmw==
X-Received: by 2002:a9d:6456:: with SMTP id m22-v6mr8100267otl.222.1538078601120;
        Thu, 27 Sep 2018 13:03:21 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h77-v6sm1164177oig.16.2018.09.27.13.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 13:03:20 -0700 (PDT)
Date:   Thu, 27 Sep 2018 15:03:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     robh@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH v3 8/8] dt-binding: mtd: Document gpio-addr-flash
Message-ID: <20180927200319.GA5099@bogus>
References: <20180925204813.GA6450@bogus>
 <20180926063934.9229-1-ricardo.ribalda@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926063934.9229-1-ricardo.ribalda@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Sep 2018 08:39:34 +0200, Ricardo Ribalda Delgado wrote:
> Add documentation for gpio-addr-flash. This binding allow creating
> flash devices that are paged using GPIOs.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> ---
> 
> Changelog v3: 
> 
> - Changes suggested by Rob Herring (Thanks!)
>   - Add gpio description
>   - Improve partition
> 
>  .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
