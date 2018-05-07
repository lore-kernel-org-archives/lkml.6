Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753515AbeEGXnS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 19:43:18 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33340 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753055AbeEGXnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 19:43:15 -0400
X-Google-Smtp-Source: AB8JxZpqbQGf0tvxWUpzFIsS4jY0bwuIk/lJkXYgfKsaWuUf+6uj9ybua08LmsPY0zPgKReGP3ARiw==
Date: Mon, 7 May 2018 16:43:12 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: msm8998: Add rpm and regulators
 for MTP
Message-ID: <20180507234312.GD14924@minitux>
References: <20180428054248.22387-1-bjorn.andersson@linaro.org>
 <20180428054248.22387-2-bjorn.andersson@linaro.org>
 <152573424824.138124.9876892052732688689@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152573424824.138124.9876892052732688689@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 07 May 16:04 PDT 2018, Stephen Boyd wrote:

> Quoting Bjorn Andersson (2018-04-27 22:42:48)
> > diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > index d6665e4f801f..ccbf6347aacb 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> > @@ -220,6 +220,16 @@
> >                 method = "smc";
> >         };
> >  
> > +       rpm_glink: rpm-glink {
> > +               compatible = "qcom,glink-rpm";
> > +
> > +               interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> > +
> > +               qcom,rpm-msg-ram = <&rpm_msg_ram>;
> > +
> > +               mboxes = <&apcs_glb 0>;
> 
> Why so many newlines?
> 

No particular reason...

> > +       };
> > +
> >         soc: soc {};
> >  };
> >  
> > @@ -337,4 +347,77 @@
> >                 #interrupt-cells = <4>;
> >                 cell-index = <0>;
> >         };
> > +
> > +       rpm_msg_ram: memory@68000 {
> 
> unit address doesn't match reg property.
> 

Doh...

> > +               compatible = "qcom,rpm-msg-ram";
> > +               reg = <0x778000 0x7000>;
> > +       };
[..]
> > +&rpm_glink {
> > +       rpm_requests {
> > +               compatible = "qcom,rpm-msm8998";
> > +               qcom,glink-channels = "rpm_requests";
> > +
> > +               pm8998-regulators {
> > +                       compatible = "qcom,rpm-pm8998-regulators";
> > +
> > +                       pm8998_s1: s1 {};
[..]
> > +                       pm8998_lvs2: lvs2 {};
> 
> What's the benefit to having the nodes here instead of in each board?
> 

That's how we've done it in the previous boards, but I had a discussion
regarding this with Doug the other day and agree that it might make
sense to just leave them out.

In particular Doug wanted to use labels based on names in the schematics
for his board...

> > +               };
> > +
> > +               pmi8998-regulators {
> > +                       compatible = "qcom,rpm-pmi8998-regulators";
> > +
> > +                       pmi8998_bob: bob {};
> > +               };
> 
> These may be board specific? So each regulator container would need
> status = "disabled" and then status = "okay" in the board file.
> 

Right, we haven't really seen the need for this before, but it seems to
make more sense to move all regulators and their references to the board
file.

Regards,
Bjorn
