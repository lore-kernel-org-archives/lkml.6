Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5FEC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646AD206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881226;
	bh=JbPoOLEMNx7f0dbS4Kwp4ORF05IrprleEKS34hnYJwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MnDtmhXcw51ze9LTnTYh3GR+jxLQQ3dW2LO1blJcMeCnW7/jFveNEcM1LtMb0eOcF
	 L3kE2mHfiyo07WeXjyi6l560Cg120EgF2MraWJv/PxC76ToUsk0OzrmWjPY7QEnZbT
	 hmbRQZ8s1GdpJQFrdufWOd/m2ZkWhoNThTcTAUWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfBWAUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:20:25 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38587 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWAUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:20:24 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so3147189oic.5;
        Fri, 22 Feb 2019 16:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awhoveg21DQRJQCzHFsA83VWdu7H8n6TbmI1zqLc61s=;
        b=GyHYoGCWtYzwoj7DsOuffb9HkXuxkOiM7e0IqVsAWYyUo+PdgAEpjcDvCreyftddoi
         fwjNmmhStTht56L3JYNx+ZguPWX58e4yZJ2i7NPbyHZhYr9BBqbEi3Qzo8kla4OReMjk
         oyf4uGbrJ26xI1RlmZfXB+kEJu2yZTccsbKI+MXlsrlYv5Xce25okg1/I2mZG2XD6NEP
         eMReGmrMZNGOuqR9g3DZ48wbV7rk5r/q0Xhq2mBLQvywo7Wy4G3PULFKv73wboBSSIFN
         gx7gPGfRM6Hui3YAtRzcsIE875H3geOzEwEH8tT2bMWG1GHrO9j1LeXxIdvLAfjQj3t5
         rMDQ==
X-Gm-Message-State: AHQUAubcyCHHVMmRIXRoGTm0s/2mW1K77hiaQs51S8N+qzUGC4zqAwkm
        Mu/MeT3kDDxkU0nexzsdQQ==
X-Google-Smtp-Source: AHgI3IY/Hly8Wx0Wq6csUfP/SaK9k299Ogxs9yA45/n8VPLgsnx4kMoVcnWVxM5sLWixZn4N2jz6mw==
X-Received: by 2002:a05:6808:211:: with SMTP id l17mr4173979oie.166.1550881223937;
        Fri, 22 Feb 2019 16:20:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g80sm1147688otg.38.2019.02.22.16.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:20:23 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:20:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tomi.valkeinen@ti.com, sam@ravnborg.org
Subject: Re: [PATCH v2 3/4] dt-bindings: display: Add bindings for
 OSD101T2587-53TS panel
Message-ID: <20190223002022.GA6504@bogus>
References: <20190222131618.20520-1-peter.ujfalusi@ti.com>
 <20190222131618.20520-4-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222131618.20520-4-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 15:16:17 +0200, Peter Ujfalusi wrote:
> This adds the device-tree bindings for the OSD101T2587-53TS 10.1"
> 1920x1200 panel from One Stop Displays.
> 
> Note: the panel is similar to OSD101T2045-53TS, but it needs additional
> MIPI_DSI_TURN_ON_PERIPHERAL message from the host.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../display/panel/osd,osd101t2587-53ts.txt         | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2587-53ts.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
