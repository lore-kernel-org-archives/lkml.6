Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E105C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0342920652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547672967;
	bh=MLxQ6bcpl6Wle5H9cN9RisJGl3vyVW/CNFlF6pkeITk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ktJ9HyDW8fUbNjSwTXhpayl/1zkNuqg+TvOI1mft8OYDM69KC82PXUAM7bDFN+gHH
	 GLkNISbN4F9qZlRTaORwIKBTUgCUAnjlW2TM0RKEWagP8DJqEgq05lEGM+/8chqRwd
	 4HAeQcM6+8MPHrG23kX/t1vmUO6omfYKukQmgIhA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbfAPVJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:09:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40973 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbfAPVJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:09:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so9091421otk.8;
        Wed, 16 Jan 2019 13:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDr/MNAhN9HZwjVOmfxhxRD6SUqMvqJOtw/ZofLvTLk=;
        b=gPh/01u/q5DXxmmcjSu23zrVC56NXy/jso12H3SttfFy7CM4LO3hgrN3DJyxeeiP5j
         3DpM8vjhP9+IJ++kT8xhqyqk+FBErQiuW9ASlTM8Aggz+jVxOaC7RZxpfV7R4zd01Ha4
         +FipWHm2DKwpeiDYx2a2jK9s3JvpEKnKTz3heDjXCXX8yHAPhNUKAmck8ofU3gHmpiX6
         y+RRbMkaKHg/uGkHntfh75+F5jOs/vtjCcBBOYw8z531fSngRgYT3Zel3VP4Bsy1PA9/
         CsVoL+zL8zn8QFBYUIZm8nmFuGHE9UiJ2mukQfAUDBDlSEL9xwvIBJX8ZMaEa3Be3fRD
         k0NA==
X-Gm-Message-State: AJcUukdKHxxUq7ibimZFgIUOOtrh7uXg+QPrXl6xqefMgeeeIbhkmS+Y
        x0cL1Y5eb1cTEvbSmAeghw==
X-Google-Smtp-Source: ALg8bN5KojRUvLn9E60Hy1A7AZoYE4wjdzgeoipx97zK9vXP937w4r+Q6hrOHFRcnPZSEApUaDyVfQ==
X-Received: by 2002:a9d:1eea:: with SMTP id n97mr6443439otn.248.1547672964049;
        Wed, 16 Jan 2019 13:09:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h16sm2991561otl.29.2019.01.16.13.09.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 13:09:23 -0800 (PST)
Date:   Wed, 16 Jan 2019 15:09:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com, Eugen.Hristev@microchip.com,
        Cristian.Birsan@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: drm/panel: simple: add support for
 PDA  91-00156-A0
Message-ID: <20190116210922.GA24880@bogus>
References: <1547458584-29548-1-git-send-email-eugen.hristev@microchip.com>
 <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547458584-29548-3-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2019 09:43:28 +0000, <Eugen.Hristev@microchip.com> wrote:
> From: Cristian Birsan <cristian.birsan@microchip.com>
> 
> PDA 91-00156-A0 5.0 is a 5.0" WVGA TFT LCD panel.
> This panel with backlight is found in PDA 5" LCD screen (TM5000 series or
> AC320005-5).
> Adding Device Tree bindings for this panel.
> 
> Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
> [eugen.hristev@microchip.com]: specified backlight and supply bindings
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v2:
> - added binding explanations for required properties from simple-panel:
> backlight and power supply which are mandatory
> 
>  .../devicetree/bindings/display/panel/pda,91-00156-a0.txt  | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/pda,91-00156-a0.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
