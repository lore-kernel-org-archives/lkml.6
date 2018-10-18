Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B37FC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4019120658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4019120658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbeJSEpN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:45:13 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46637 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSEpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:45:12 -0400
Received: by mail-oi1-f196.google.com with SMTP id k64-v6so25116934oia.13;
        Thu, 18 Oct 2018 13:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKLpLdWJaJNBeb1WN6NBk1X9dv63if2M9XwL5hb3Cgk=;
        b=rBlhluxIhn71QmyKHlXHBphlkMtLlHl59JGIYDv4moCWSZi2f5Gs+10B0TytwgnAqL
         m0FcMIHnzE1OxVX//2GIMZoUM03uOUQxUM6Bp9Nd5P7KlMDrv2cuCLTWA5+uBrWjgBiq
         f6h+5FsByEQ4xCTi/WqyIsYKeNTBig5yGEVQ+a8tqH0RV8lEtr3MsWgkW78LPb+s9wNl
         v572hz0/h1Ukgk6PC0G7kadnZFfAxZ+qgwI6x6e7O9GJhJLEK/I2vm+++YVCz8ZBr7ZT
         jEDnWBSFtZLSV5ayAf1ThHQ2uA4sA/hxw1Ad3KetK6kypv26WLhm7eOWRw3U9KJw+uam
         Hmdw==
X-Gm-Message-State: ABuFfogcW7W3XSQBKudXFEVLRSHqDKBpfrNXjIEf1fWOf/i2tGWKXrP2
        7S/LxtRb0AUn1DaZ5hrSyQ==
X-Google-Smtp-Source: ACcGV60CMMi591f8U1XpCYwtcLyrqshffJKMf6NXjr9L2Da5t8N58OwXNnYxWk5QLOd71v33Zh/P8Q==
X-Received: by 2002:aca:c743:: with SMTP id x64-v6mr16229446oif.139.1539895346335;
        Thu, 18 Oct 2018 13:42:26 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm7450772otd.57.2018.10.18.13.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 13:42:25 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:42:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v2 04/10] firmware: ti_sci: Add RM mapping table for am654
Message-ID: <20181018204224.GA31136@bogus>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018154017.7112-5-lokeshvutla@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018 21:10:11 +0530, Lokesh Vutla wrote:
> From: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Add the resource mapping table for AM654 SoC as defined
> in http://downloads.ti.com/tisci/esd/latest/5_soc_doc/am6x/resasg_types.html
> Introduce a new compatible for AM654 "ti,am654-sci" for using
> this resource map table.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> Changes since v1:
> - new patch added.
> 
>  .../bindings/arm/keystone/ti,sci.txt          |  3 ++-
>  drivers/firmware/ti_sci.c                     | 23 +++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
