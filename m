Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D11FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC145256C0
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EjAP3OyH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC145256C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934229AbeGARhY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:37:24 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39734 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965099AbeGARhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:37:18 -0400
Received: by mail-pg0-f67.google.com with SMTP id n2-v6so6081702pgq.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jul 2018 10:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O+qZJjMaodrobabniL/xdsk/Dn5luFOlG39JjsClAdI=;
        b=EjAP3OyHjAwRG3YC/iEyw2v8GnvPRoTLJ4JRAHc0JEoVeAaDCpa0Vi/WLkltlHkE65
         zBkKzRw4iO2pGuarnslxohKUYlqTYzoFUVraxWApuO5vF8Jk4Q5bc0hzV4GrXoB15GXY
         HVPLiYcqKxX4YZhXYZMCYDPWy3lJxjbIc3OAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O+qZJjMaodrobabniL/xdsk/Dn5luFOlG39JjsClAdI=;
        b=kGKGqLYbd/9gBARsiJcLvhIoVLkLdaVCIN7wGO7n+28LVdl4vQyQMYdMhqk7YFl03x
         vZaKw/cEFC1ftz7CprNZiGcMCzlGDLQZaLA7HVv5LR3/eRpm7Y6p4WoxPEwcSSVvaWlI
         aBq0gKypXDhfESKRDjaW+/MQW2rkPLLghY3KADA/x4mhA+L/e10SbElxc718Kd9MeQny
         igANfrZbrkjyvVPwctY5rx2ScMkvc6mR0nc5NCnCdq3jeU82NQOXgRjdb1XWyxa7y6cg
         v6ebIjHlxOKFo2+ikUc83W3QvetygRu8nyugOXZR36s681z/vo02VqK124KYDuReT+xO
         ZspA==
X-Gm-Message-State: APt69E2kOadj8HWZbHplyAjuymGoWqG7868IBFBS+i/mr5GSBB/3UcPX
        KZTp4MZgSgBB0cCxIyoEAZap
X-Google-Smtp-Source: AAOMgpeHCMGg1LZ8ViaqG9DfPwJe8HOhm45TChZy2aiK6mH93Z7xr8MtNGiElxbgtAgHyNaNTJCbiw==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr11511562pga.181.1530466637619;
        Sun, 01 Jul 2018 10:37:17 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:900:ea77:2c06:3367:1893:796])
        by smtp.gmail.com with ESMTPSA id b65-v6sm25150901pfg.34.2018.07.01.10.37.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Jul 2018 10:37:16 -0700 (PDT)
Date:   Sun, 1 Jul 2018 23:07:06 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] dt-bindings: clock: Modify Actions Soc clock
 bindings
Message-ID: <20180701173706.GA15895@Mani-XPS-13-9360>
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-4-sravanhome@gmail.com>
 <20180630093202.GB7320@Mani-XPS-13-9360>
 <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15070ea0-aebf-2b7d-89f0-b21e729c927e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 07:26:20PM +0200, Saravanan Sekar wrote:
> Hi Mani
> 
> 
> On 06/30/18 11:32, Manivannan Sadhasivam wrote:
> > Hi Saravanan,
> > 
> > I agree with modifying the existing binding to accomodate other
> > SoC's of the same family. But the binding should be
> > "actions,owl-cmu.txt" since it reflects the family name.
> 
> Agree, will modify the name
> 
> > Andreas, what do you think?
> > 
> > On Thu, Jun 28, 2018 at 09:18:05PM +0200, Saravanan Sekar wrote:
> > > Modify clock bindings common Actions Semi Soc family S700/S900.
> > > 
> > > Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> > > Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> > > ---
> > >   ...tions,s900-cmu.txt => actions,sx00-cmu.txt} | 18 ++++++++++--------
> > >   1 file changed, 10 insertions(+), 8 deletions(-)
> > >   rename Documentation/devicetree/bindings/clock/{actions,s900-cmu.txt => actions,sx00-cmu.txt} (71%)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> > > similarity index 71%
> > > rename from Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> > > rename to Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> > > index 93e4fb827cd6..8dc7edb4d198 100644
> > > --- a/Documentation/devicetree/bindings/clock/actions,s900-cmu.txt
> > > +++ b/Documentation/devicetree/bindings/clock/actions,sx00-cmu.txt
> > > @@ -1,12 +1,14 @@
> > > -* Actions S900 Clock Management Unit (CMU)
> > > +* Actions S900/S700 Clock Management Unit (CMU)
> > Same as above. Should be Actions OWL SoC's Clock Management Unit (CMU).
> 
> sure
>

During the review of I2C controller driver, Andreas pointed out that
we should use Owl instead of OWL in all places and also Actions should
be replaced by Actions Semiconductor. So, please change it in relevant
places. For this binding, title should be:

Actions Semiconductor Owl SoC's Clock Management Unit (CMU).

Thanks,
Mani

> > > -The Actions S900 clock management unit generates and supplies clock to various
> > > -controllers within the SoC. The clock binding described here is applicable to
> > > -S900 SoC.
> > > +The Actions S900/S700 clock management unit generates and supplies clock to
> > > +various controllers within the SoC. The clock binding described here is
> > > +applicable to S900/S700 SoC.
> > >   Required Properties:
> > > -- compatible: should be "actions,s900-cmu"
> > > +- compatible: should be one of this
> > Change to: compatible: should be one of the following:
> 
> sure
> 
> > Thanks,
> > Mani
> > 
> > > +	"actions,s900-cmu"
> > > +	"actions,s700-cmu"
> > >   - reg: physical base address of the controller and length of memory mapped
> > >     region.
> > >   - clocks: Reference to the parent clocks ("hosc", "losc")
> > > @@ -15,9 +17,9 @@ Required Properties:
> > >   Each clock is assigned an identifier, and client nodes can use this identifier
> > >   to specify the clock which they consume.
> > > -All available clocks are defined as preprocessor macros in
> > > -dt-bindings/clock/actions,s900-cmu.h header and can be used in device
> > > -tree sources.
> > > +All available clocks are defined as preprocessor macros in corresponding
> > > +dt-bindings/clock/actions,s900-cmu.h or s700-cmu.h header and can be used in
> > > +device tree sources.
> > >   External clocks:
> > > -- 
> > > 2.18.0
> > > 
> 
> Thanks,
> Saravanan
