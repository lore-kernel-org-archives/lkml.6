Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2299C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2071206BA
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550881214;
	bh=h7HuAbJp7+9SEoo9Ab/2Y8yKMrtY5yHOOcV6bSYhXkk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vRn66LlrMAFSK+UT7ArOgjBkLiwhy1cXA+Agzvn7RFSAq98gd9CbGBDDbL/sW+/gl
	 jgjS96DCiezWReVT6TYobg2Ll/KpbEl4r+dw37Ms0MnHH1JLUZVk1TIZ4PF9XjrDQx
	 F5MyCWUCFZA5QLQPZA12bl+OPhFec4MeFLxpGP0k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfBWAUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:20:09 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBWAUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:20:09 -0500
Received: by mail-ot1-f68.google.com with SMTP id v20so3400042otk.7;
        Fri, 22 Feb 2019 16:20:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QaSy9fmlvl7pmf79DgGNEBgf4HO7SYnNR40BJU/0UaM=;
        b=AgGXxa6B9NB2iqMDd+adet2CH6Ajj5YC66GqG3qskbv7uO8Y2Vv987MKvp6uuSAMXg
         6vh6cgP1iZx8osIOvQPAHLN7vGrPmFEcvTMvnduBmDWImNiXY+spgKZDyEV3wjW8854r
         bk0C1ayzHXN5iylkHo+1WjxrvPx5cAVkS8Ic7iqj15pFf8PP32Lf5gIxzpCF3H+LK/kK
         vba36J1Ny4KCoM1KwSvJEqNK+Md9GKmYJSNBgT2Xqc3lJf+fFhHiiDJM/ANmZkk0TSsY
         m1e+69MkhqOzYPYzmzKwT9YYlFGlYf3EVjk0NPy6nbvnsshKoXm+E+9fqgNBzxnI4hAR
         P8Pw==
X-Gm-Message-State: AHQUAuYvWPJinrcUZef1IMS6PwJDKNU+8Q/83sC0VLbIw5KSMB0nvau9
        F412JGyPTt3MCVtJ53JPWg==
X-Google-Smtp-Source: AHgI3IaPnDoff+jc8uYsQcPEfYDPFGGpC+J/l7eTaJiiiQmWCosgqAWTKhIJmw7sXkSvy+IkKZyD6A==
X-Received: by 2002:a05:6830:1108:: with SMTP id w8mr4313650otq.167.1550881208228;
        Fri, 22 Feb 2019 16:20:08 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j1sm1153899otl.43.2019.02.22.16.20.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 16:20:07 -0800 (PST)
Date:   Fri, 22 Feb 2019 18:20:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        tomi.valkeinen@ti.com, sam@ravnborg.org
Subject: Re: [PATCH v2 1/4] dt-bindings: display: Add bindings for
 OSD101T2045-53TS
Message-ID: <20190223002006.GA5900@bogus>
References: <20190222131618.20520-1-peter.ujfalusi@ti.com>
 <20190222131618.20520-2-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222131618.20520-2-peter.ujfalusi@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2019 15:16:15 +0200, Peter Ujfalusi wrote:
> This adds the device-tree bindings for the OSD101T2045-53TS 10.1"
> 1920x1200 panel from One Stop Displays.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../bindings/display/panel/osd,osd101t2045-53ts.txt   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/osd,osd101t2045-53ts.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
