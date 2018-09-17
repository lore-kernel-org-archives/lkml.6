Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3396BECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA9C1214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vb1ulmsO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA9C1214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIQXgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:36:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40031 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:36:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id s13-v6so7926424pfi.7;
        Mon, 17 Sep 2018 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JP+pPiQIFeLYsTQPRlf3aEDdQBOASGoofWFOQqKh/CI=;
        b=vb1ulmsOP6GOP6rHuBlYaQwKKkf5G7eMx0YmtavqSADEjGUmL7raxFBNi4FEqKRwJK
         sHAsC7vY5OnUClAhDUm6y42k30x1kZpw6NQxrA3Sse2CkGotzX0YeytL236R+e2gQ8gL
         +QV6Gm1+EzeLTXb1zwsUOaQFhlbk7clEWfzq/pdfXC8OQWIl/4MK+00zZmGI9l8X3Z2e
         2fvbsuK8sEfrJgqtV/dy8NkhvbNLkKTHExtMCCwp2XKnr6wnv7uhWhor/O0seU6wJx9D
         JIlL7GACDoXIVRAPq6SD34xPsj8502FgCoaMpvvUZCmN2MnUotQ7CKie8e2Y9Uj9no/i
         v3BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JP+pPiQIFeLYsTQPRlf3aEDdQBOASGoofWFOQqKh/CI=;
        b=B6F540vras48tYBp4IGxaLVrJksvs7UUVaxcj4wzBcgprrOOWcrFOxuF9MXGUaJYGq
         zk4p6R/roAptE5KriHvbMYVSCsQKmGbZShHGvPne4jxuE+ZTOI1WJxcBUK/OZFp15SUx
         Sdtr0By/4GNjFUmHut/mAjSoflSRI54x6d+VP9hyuA/GEflwr2dL01pi9nWfP15vq8UV
         Z6yGi4SxMxp0CKa1mOGw+66INmYaVkNOsvBHWrrQPP+moJCC52b8j+7t/psKt2WT/TmN
         vSVu/XJrVDTJk1WYka6XriK9n3NsCE0aDEzXn3PS468cf3ASZZVK6eWVBcryzMJmowRh
         8u2Q==
X-Gm-Message-State: APzg51BTymZ34rfVWNpOaSNEPR8d5/tz4LcRbcjpNOHM7rDLubt9wdQe
        xdeansDmMlIkykuPBijiW8w=
X-Google-Smtp-Source: ANB0VdY9MweRtJT9bCO8np2mlYKFID7a71lHM400s67/CcENmNv0K1chc+9ovA1q3M2R5Xg1pBPVMw==
X-Received: by 2002:a63:de4b:: with SMTP id y11-v6mr24452597pgi.435.1537207667884;
        Mon, 17 Sep 2018 11:07:47 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id w12-v6sm25223856pfd.110.2018.09.17.11.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:07:46 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:07:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, mark.rutland@arm.com,
        marco.franchi@nxp.com, fabio.estevam@nxp.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH 2/2] dt-bindings: egalax-ts: add support for wakeup event
 action
Message-ID: <20180917180744.GB104770@dtor-ws>
References: <1536139607-16848-1-git-send-email-Anson.Huang@nxp.com>
 <1536139607-16848-2-git-send-email-Anson.Huang@nxp.com>
 <5b9f3f5d.1c69fb81.bca6d.cdee@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9f3f5d.1c69fb81.bca6d.cdee@mx.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 05:54:33PM -0500, Rob Herring wrote:
> On Wed, Sep 05, 2018 at 05:26:47PM +0800, Anson Huang wrote:
> > Add support for wakeup event action, this would allow the device
> > to configure whether to be a wakeup source of system suspend.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > index 92fb262..296a9cd 100644
> > --- a/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > +++ b/Documentation/devicetree/bindings/input/touchscreen/egalax-ts.txt
> > @@ -6,6 +6,7 @@ Required properties:
> >  - interrupts: touch controller interrupt
> >  - wakeup-gpios: the gpio pin to be used for waking up the controller
> >    and also used as irq pin
> 
> If the wakeup gpio is the same as the irq, then this should be removed 
> since wakeup-source replaces it.

No, it does not: it is GPIO that we need to toggle to wake up the
controller, not host, and we do not have generic API to map from IRQ to
GPIO.

This is also existing binding...

> 
> > +- wakeup-source: boolean, touch screen can wake-up the system
> >  
> >  Example:
> >  
> > @@ -15,4 +16,5 @@ Example:
> >  		interrupt-parent = <&gpio1>;
> >  		interrupts = <9 2>;
> >  		wakeup-gpios = <&gpio1 9 0>;
> > +		wakeup-source;
> >  	};
> > -- 
> > 2.7.4
> > 
> 

-- 
Dmitry
