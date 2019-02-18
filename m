Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1370C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8B6D20855
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550522223;
	bh=4B3eYYF0af5s8638R7TUv4CXB090pMB5T53qb+V0UFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WUcXW6OdBZInt8ueZhraES8UQVotYRNPWP+y7TTYvLiQx4p/U0Dn5OVh/fqb47r9c
	 M5ppf2Bk8v6gbPjKjhpvEljKacgwm8Pl5zwdYnjFMFuwAdNYQz4BL66PVj621s0cjS
	 3/prBjrpnytfhzLgzAP5rgT6BW4/+l7GVP1e/5ss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbfBRUhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:37:02 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41383 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfBRUhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:37:01 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so14099658otk.8;
        Mon, 18 Feb 2019 12:37:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mxTMXYrQIwaNJervkd9UktCFa4U1xZCoJrS9clPs9rc=;
        b=dy0LN+nhee3gKhbFJDUiEG70yydoDFo7Jcwv9Iqm0R02vDbdciF1LtXjZKUzgHopGZ
         ulZXlTK0DNKstFUCocLw+zKz2ui9HxDuCxqBcu3i2vJIcNlGQeWd47K++PaaMAgRYKyt
         OQco2vZzr3qiU2aPl7VH7l2lMuFU2PypFKVyX0jaMurCQl7URHmEEzVwvajYM2ufKJ51
         bU+JovecQvc0ekQEqVtqjoLQ1dgZ7ZTevKU6J1gMrh8iG9VJVXiksEGcgNqxnmEBUqtZ
         u97SM9y79qrfq7lj0uFWelo+BZzlOu5lVvPqnYH9VQTHBpVDOqWwunvBth4OTyTl3W7Z
         H2Wg==
X-Gm-Message-State: AHQUAuYa74uWasBGwNQtMqSQ4kgyZt+D0uLYsogjT1qHhwJzy7ms/Ad0
        ys2JIcf9F64N863li1JhoA==
X-Google-Smtp-Source: AHgI3IZidzAY1kaiVabOklIT35gFFtEIRuv/9Ogn0zphHxPV4aZb1e1q912vUQv4RpYplx8xgWsBOg==
X-Received: by 2002:a05:6830:1092:: with SMTP id y18mr15795045oto.125.1550522220168;
        Mon, 18 Feb 2019 12:37:00 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r132sm3524453oie.20.2019.02.18.12.36.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 12:36:59 -0800 (PST)
Date:   Mon, 18 Feb 2019 14:36:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Ryder Lee <ryder.lee@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Weijie Gao <weijie.gao@mediatek.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v1 2/5] dt-bindings: pwm: add a property
 "mediatek,num-pwms"
Message-ID: <20190218203658.GA20434@bogus>
References: <de316385a84e079d3b23891e61c959094b9fa7e5.1547781007.git.ryder.lee@mediatek.com>
 <7e1de17a43f2cde73aecd2773e2b3a5fdfd294f3.1547781007.git.ryder.lee@mediatek.com>
 <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d387d2a-74f0-c6c7-aa2d-cf9b87579682@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:44:49AM +0100, Matthias Brugger wrote:
> 
> 
> On 18/01/2019 04:24, Ryder Lee wrote:
> > This adds a property "mediatek,num-pwms" in example so that we could
> > set the number of PWM channels via device tree.
> > 
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> > Changes since v1: add a Reviewed-by tag.
> > ---
> >  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > index 991728c..f9e2d1f 100644
> > --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> > @@ -20,6 +20,7 @@ Required properties:
> >   - pinctrl-names: Must contain a "default" entry.
> >   - pinctrl-0: One property must exist for each entry in pinctrl-names.
> >     See pinctrl/pinctrl-bindings.txt for details of the property values.
> > + - mediatek,num-pwms: the number of PWM channels.
> >  
> >  Example:
> >  	pwm0: pwm@11006000 {
> > @@ -37,4 +38,5 @@ Example:
> >  			      "pwm3", "pwm4", "pwm5";
> >  		pinctrl-names = "default";
> >  		pinctrl-0 = <&pwm0_pins>;
> > +		mediatek,num-pwms = <5>;
> >  	};
> > 
> 
> Wasn't there a comment in the last version to use num-pwms instead of
> mediatek,num-pwms?
> 
> Uwe I think you requested that.

Perhaps, but why is this needed? Typically, this would be implied by the 
compatible or the driver doesn't care and we assume 'pwms' properties 
are not out of range.

Rob
