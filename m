Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874FFC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1DA206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 18:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="O6RRkt91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbfALSnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 13:43:46 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40167 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfALSnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 13:43:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so8458553pfo.7
        for <linux-kernel@vger.kernel.org>; Sat, 12 Jan 2019 10:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwlrGJmJaVXX2Ajg43HSQJmv8eCwdwbYbM71JTgxfHg=;
        b=O6RRkt911JGxGarLXNzQeyx6S6vMOmq7oQJhoCcbo65NqwrFDQly5y2rFkFQHeguXk
         KAlkw8a9YS7Q33V538WP3vOyhV13AVO6gTo4aG7ChTB+m+uAk3JL9fzPrXQJFQbRudVZ
         OD99UVJtedyU8ax9xyaOYDZ1C7Er5sR9bS+XA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwlrGJmJaVXX2Ajg43HSQJmv8eCwdwbYbM71JTgxfHg=;
        b=CKFgBSGlgSCMRiDlFstzW1+0sfM3acoD9Au9D01PzuKwNzNtzgk70M0JTV+benmnjk
         1GNVvvblsH3GbdtzAHVrcixfUHhOXbbj4TdGhm8ELiU3vAPJ3xW2v7AFkIVFN4fefYy7
         dY0x+MkBuLkhuWN9uEfOCjZgUa56qQKtkv7urMYhYWw+dfu7JoLLVjpduhn5YDzNkt5h
         LYxuaXa4NmMPZnQcuLcoO1Xw842N2hKtUKTWf6C/L6l2wrIKbQaaxveDvHow921/BW9c
         OLHHkerTbURpYLofXBZrXKEKoJsb+zSvz+ti5jBsAruqimIC0TqLjpSJp0JJvhWQqVI3
         t1TQ==
X-Gm-Message-State: AJcUukegVooTv83Qd1TcElvIil1xf3BiQukaB6NBGAFhLjBzzC5LpNov
        9Vi3FF6qYQJO5s0yZdhWbaiVbQ==
X-Google-Smtp-Source: ALg8bN5iI8p+Kk3pnRL/BsPh0Pab1O1GJO0NhssFXbIL4eoh8O3Ro1y+9PHGje0fiU+IKu5WISCzgw==
X-Received: by 2002:a62:7a8b:: with SMTP id v133mr19765825pfc.159.1547318624443;
        Sat, 12 Jan 2019 10:43:44 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o66sm156052251pgo.75.2019.01.12.10.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 10:43:43 -0800 (PST)
Date:   Sat, 12 Jan 2019 10:42:55 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        tsoni@codeaurora.org, clew@codeaurora.org, akdwived@codeaurora.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc@vger.kernel.org,
        Evan Green <evgreen@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        sricharan@codeaurora.org
Subject: Re: [PATCH v5 8/8] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
Message-ID: <20190112184255.GA28907@builder>
References: <20190109170010.15430-1-sibis@codeaurora.org>
 <CAD=FV=Xu3m5=ByHo_38T=H2cm4VqkndVjJ1rUkD2gp-2SWFXdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xu3m5=ByHo_38T=H2cm4VqkndVjJ1rUkD2gp-2SWFXdQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11 Jan 13:06 PST 2019, Doug Anderson wrote:

> Hi,
> 
> On Wed, Jan 9, 2019 at 9:00 AM Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > This patch adds Q6V5 MSS remoteproc node for SDM845 SoCs.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >
> > v5:
> >   * Use qmp_aop updated dt binding
> 
> nit: since this is now a singleton patch in v5 (because patches #1 -
> #7 landed), the general policy is to drop the "8/8" in the subject.
> AKA I believe the subject of the patch ought to have been:
> 
> [PATCH v5] arm64: dts: qcom: sdm845: Add Q6V5 MSS node
> 
> 
> > v3:
> >   * with shutdown-ack irq redesign make it mandatory,
> >     merge multiple patches into a single one
> >
> > v2:
> >   * Fixed style changes
> >   * Added missing clocks in the dt-bindings
> >   * Split mss remoteproc node into a number of patches
> >
> > This patch depends on the following bindings:
> > https://patchwork.kernel.org/patch/10662089/ - mba/mpss reserved regions
> > https://patchwork.kernel.org/patch/10657325/ - pdc reset node
> > https://patchwork.kernel.org/patch/10753659/ - rpmhpd dt node
> > https://patchwork.kernel.org/patch/10749469/ - AOP QMP dt bindings
> > https://patchwork.kernel.org/patch/10751757/ - shutdown-irq binding
> >
> >  arch/arm64/boot/dts/qcom/sdm845.dtsi | 60 ++++++++++++++++++++++++++++
> >  1 file changed, 60 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > index 5da9fa1feb8a..e021b15f87fd 100644
> > --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> > @@ -1366,6 +1366,66 @@
> >                         };
> >                 };
> >
> > +               remoteproc@4080000 {
> 
> It would be handy if you added a label here, AKA:
> 
> mss_pil: remoteproc@4080000 {
> 
> It's expected that boards will need to refer to this node so that they
> can provide a firmware-name, so you need to give them a label to grab
> onto.
> 

I agree.

> ...and actually, I wonder if boards will also need to be able to set
> status = "okay"?  Right now they don't because you don't have a status
> = "disabled" in sdm845.dtsi, but maybe you should?  Are there ever
> going to be any boards with sdm845 that don't hook up the modem?
> 

The modem is status "ok" on my SDA845 device (but haven't verified
upstream myself yet), so I think it's fine to leave it enabled.

But merging this as is will cause the modem to crash repeatedly until
rmtfs is present. Sibi is making progress on tying this to rmtfs, which
would be accompanied by the following commit:

https://lore.kernel.org/lkml/20180524192141.20323-1-ramon.fried@gmail.com/

I'm okay with merging that now, to unblock the merge of this patch.
Would appreciate an Ack on this.


Also, Sibi, the glink-edge binding doesn't define the mbox-names
property, so please drop it.

Regards,
Bjorn
