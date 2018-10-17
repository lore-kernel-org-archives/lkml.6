Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599ABECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:15:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5AC2087A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:15:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A5AC2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeJREMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:12:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46257 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725737AbeJREMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:12:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id o21so27492348otb.13;
        Wed, 17 Oct 2018 13:15:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FVNq7Um6Q9Xhi6t5aMFd2UpQIEimCO5z4fv1r3LmNHA=;
        b=WSGZzaxRYPrKSP4dRcTSV4lACovRTyfIamoyYjG97qs30E29/Sd0oGmtKCnEJoiP0k
         W6LjkS9F8uybRS6H9ZNneuqCK9uT82sOvcVFKpurMrqooDd1N1WIQ0NCNAnoubRFlkth
         OjZPqyTkpDeq+gAy0pS0BfETTP6j1+CE22y7c7Pe1u2tj/zuf30QRQYAe7D3GTQoDvu0
         ae2OE5bTFMmC5IoNKWc1T1zVEaJPGbHhKBWXB0XveuYbaTdDRab0pmox9XLKaR9Wmj3r
         r4DOpkmTv1CjP4BiWeiamhNPbU/xPavfPtSc3eWED/oV4tMVKuz5zJ0yx2XjRIlGARyS
         4DIQ==
X-Gm-Message-State: ABuFfoheaQ9Lq+M60kZt6sdrHdkRbm3NQiTLvmv66/37fVEal8FSUBFD
        /IBLQ5zQsCNuSpImoxYDWEyEPTg=
X-Google-Smtp-Source: ACcGV63YubM7aGCGR3TSsiM0bzPZHeco4uL3U1l8PsvUcy5CrTw/WRoiEmART2rqKh/rLnxmVXcRPA==
X-Received: by 2002:a9d:339a:: with SMTP id u26mr18726503otc.81.1539807324339;
        Wed, 17 Oct 2018 13:15:24 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k24sm6156262otd.57.2018.10.17.13.15.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 13:15:23 -0700 (PDT)
Date:   Wed, 17 Oct 2018 15:15:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        KT Liao <kt.liao@emc.com.tw>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: add more optional properties for
 elan_i2c touchpads
Message-ID: <20181017201522.GA26525@bogus>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
 <20181012142413.26107-4-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012142413.26107-4-benjamin.tissoires@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 04:24:11PM +0200, Benjamin Tissoires wrote:
> Some new touchpads IC are connected through PS/2 and I2C. On some of these
> new IC, the I2C part doesn't have all of the information available.
> We need to be able to forward the touchpad parameters from PS/2 and
> thus, we need those new optional properties.
> 
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  Documentation/devicetree/bindings/input/elan_i2c.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/elan_i2c.txt b/Documentation/devicetree/bindings/input/elan_i2c.txt
> index 797607460735..ace6bcb0b4eb 100644
> --- a/Documentation/devicetree/bindings/input/elan_i2c.txt
> +++ b/Documentation/devicetree/bindings/input/elan_i2c.txt
> @@ -13,6 +13,14 @@ Optional properties:
>    pinctrl binding [1]).
>  - vcc-supply: a phandle for the regulator supplying 3.3V power.
>  - elan,trackpoint: touchpad can support a trackpoint (boolean)
> +- elan,clickpad: touchpad is a clickpad (the entire surface is a button)

> +- elan,max_x: the maximum reported value on the X axis
> +- elan,max_y: the maximum reported value on the Y axis
> +- elan,min_x: the minimum reported value on the X axis
> +- elan,min_y: the minimum reported value on the Y axis
> +- elan,x_res: the resolution of the X axis (in units per mm)
> +- elan,y_res: the resolution of the Y axis (in units per mm)
> +- elan,width: max reported width of a blob

Can't we use standard touchscreen properties here? (Yes, I get this is a 
touchpad, not touchscreen).

Rob
