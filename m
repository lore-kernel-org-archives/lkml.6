Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACCFC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E73B6217F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 19:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550518661;
	bh=dKJFZhgKaF3ZjOJoV7H5KpQtQ5rzlI9AUPS+XxWAv54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=edaC1F+sTQ+O+iCWjtVj2V3OsDvf856Gf/bOmSqGrwFdcCuGBAbrNowHjKQtKnAql
	 I8dNrtKI2y8+nvHED4qiiu2RfJfeM8zSJhXyhfbSQhv7LkEHz08OouluxszmLXVtnR
	 EXLNYU9t3/D2nKU6DAblqEDQ2/esWygdVbUk75Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbfBRThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 14:37:39 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42862 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfBRThi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 14:37:38 -0500
Received: by mail-ot1-f66.google.com with SMTP id i5so30175146oto.9;
        Mon, 18 Feb 2019 11:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HZYyv6QHhVB0Xpri574rIRYsBzQ01ahIU8M9e8voXXE=;
        b=VnmrxA+HctRVrYkdMVlcSzZhD1LF+Stl4/deCIdZa7idud3M/gFF3PYIglHtsnjYFl
         idXagNPaGCzgdM/B2Og1nZ8YxXx7jPYTeAwdxZJuPkwD/rr/OrhmDXCzhpywBS+wNAJ3
         NK38XFGniZz8Eu7xxYD94ZBo3rOBwYdvyL+lnR9T3Nwy9HDBUlnKrCSYPCQimnPRGJcL
         gVLIDD7d67QZ4qHhUCZFSjQqzc6sntswc3/KV0NxHJ+3CEn2HGSwyYYisYs6F4znkLoq
         HXvAUtxeakZCuELUsMKHZFDZYF3FOTIYeKl9Qv+/UzQ8YHIOJ2VLeZ3abt3Wg8dvwVJy
         dSKg==
X-Gm-Message-State: AHQUAuYSE9s2etfEPGuXg2h6V7res149OsySDULewB7jToyF9k7DZcp1
        GIqosOmrOzf7ujMIFosXLw==
X-Google-Smtp-Source: AHgI3IboS3N+ViZpaqGY15wDRvtQzT7Te0o1eXOTluUff3TajR7DSngqOpr5h9FcaigjVylSIBmG0w==
X-Received: by 2002:aca:cd0c:: with SMTP id d12mr278988oig.49.1550518657487;
        Mon, 18 Feb 2019 11:37:37 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n185sm6432450oih.18.2019.02.18.11.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 11:37:36 -0800 (PST)
Date:   Mon, 18 Feb 2019 13:37:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        laurent.pinchart@ideasonboard.com, sre@kernel.org,
        dri-devel@lists.freedesktop.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH v2 2/2] dt-bindings: panel: td028ttec1: add backlight
 property
Message-ID: <20190218193736.GA22600@bogus>
References: <20190205063813.14873-1-andreas@kemnade.info>
 <20190205063813.14873-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205063813.14873-3-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Feb 2019 07:38:13 +0100, Andreas Kemnade wrote:
> This adds an additional backlight property as described
> in panel-common.txt
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
