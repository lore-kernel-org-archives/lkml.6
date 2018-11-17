Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB3C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6F402080F
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F402080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbeKRCAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:00:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44958 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeKRCAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:00:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id z33so24021610otz.11;
        Sat, 17 Nov 2018 07:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7IMcX94rKHeT9YmtsHaP201Mnb6bIStWo5NVxVf+EgU=;
        b=P4Wrk2H+ZTttyM6jbG2cmZXrhn/JlNJn3g2+GhOABvvlQecYTtrNdB1iRk89NTmKSZ
         bnfWm1PG2G4jqxAea03jlKCxqiSLcrgKgtRx5PCSxE91mkNZ1fVYVwcB2Ql0Iux84OHx
         xaO3EUUFtUBnAlPnsmN2spOLxnanXhSDnGplRl79AhuQRBfkTnjx2OueWdaTIcbkV3w8
         CmIwjLfdIr+3LBBQYfuFDHdTLi1Zxay0L+FeJ1hWtl+6q+kxHZbu1MCPS50AS944RFgJ
         KWliDkqO0meYIdZQaCPHjGK8QtC/AhgFw2UqAUm0VhslLwIahTAljaoyn5ofnHwFTzDQ
         09mg==
X-Gm-Message-State: AGRZ1gKWiw1lpkQ4ajrjLf5HWhYy2GbYlaU29oubvDlT9pHIzHZKoy3J
        moU/kks4j0RDFscK1NyzeqGQvz4=
X-Google-Smtp-Source: AJdET5cZgcg7/Lt0fkAVOLUqDuQc4cPBt/bhmBzhruthCWCwGtiig108KB4nlaMYiT7ny9LeiEVDbQ==
X-Received: by 2002:a9d:26ec:: with SMTP id i41mr9266762otd.29.1542469411202;
        Sat, 17 Nov 2018 07:43:31 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id 4sm13383520otw.39.2018.11.17.07.43.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:43:30 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:43:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vignesh R <vigneshr@ti.com>
Cc:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, Vignesh R <vigneshr@ti.com>,
        linux-omap@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Message-ID: <20181117154328.GA4095@bogus>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2018 11:31:08 +0530, Vignesh R wrote:
> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  MAINTAINERS                      |  1 +
>  include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
