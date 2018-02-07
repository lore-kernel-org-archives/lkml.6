Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753456AbeBGIfD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:35:03 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55890 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750815AbeBGIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:35:02 -0500
X-UUID: 2f4e98dcffda43e0a8e787d2b7d8097e-20180207
Message-ID: <1517992498.9025.8.camel@mtkswgap22>
Subject: Re: [PATCH v2 06/16] arm64: dts: mt7622: add cpufreq related device
 nodes
From: Sean Wang <sean.wang@mediatek.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
CC: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Wed, 7 Feb 2018 16:34:58 +0800
In-Reply-To: <20180207061837.GM28462@vireshk-i7>
References: <cover.1517910489.git.sean.wang@mediatek.com>
         <fc5bdf53b92bd7a96e94b714d8d13deebca95c28.1517910489.git.sean.wang@mediatek.com>
         <20180207033331.GK28462@vireshk-i7> <1517984178.9025.2.camel@mtkswgap22>
         <20180207061837.GM28462@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 11:48 +0530, Viresh Kumar wrote:
> On 07-02-18, 14:16, Sean Wang wrote:
> > On Wed, 2018-02-07 at 09:03 +0530, Viresh Kumar wrote:
> > > On 06-02-18, 17:52, sean.wang@mediatek.com wrote:
> > > >  	cpus {
> > > >  		#address-cells = <2>;
> > > >  		#size-cells = <0>;
> > > > @@ -26,6 +70,10 @@
> > > >  			device_type = "cpu";
> > > >  			compatible = "arm,cortex-a53", "arm,armv8";
> > > >  			reg = <0x0 0x0>;
> > > > +			clocks = <&infracfg CLK_INFRA_MUX1_SEL>,
> > > > +				 <&apmixedsys CLK_APMIXED_MAIN_CORE_EN>;
> > > > +			clock-names = "cpu", "intermediate";
> > > > +			operating-points-v2 = <&cpu_opp_table>;
> > > >  			enable-method = "psci";
> > > >  			clock-frequency = <1300000000>;
> > > >  		};
> > > > @@ -34,6 +82,7 @@
> > > >  			device_type = "cpu";
> > > >  			compatible = "arm,cortex-a53", "arm,armv8";
> > > >  			reg = <0x0 0x1>;
> > > > +			operating-points-v2 = <&cpu_opp_table>;
> > > >  			enable-method = "psci";
> > > >  			clock-frequency = <1300000000>;
> > > >  		};
> > > 
> > > Sorry for not picking this earlier, but you should probably add the same clock
> > > related properties for both cpu nodes here. Things will break if CPU1 is used by
> > > the cpufreq core to bring the cpufreq policy online.
> > > 
> > > This can happen if cpufreq driver is a module, CPU0 is hotplugged out and then
> > > the cpufreq driver is inserted.
> > > 
> > 
> > mt7622 cpu0 does not support hotplug. do I still need to add same clock
> > related properties for both cpu nodes here?
> 
> Normally we should always add these properties to all the CPUs, as that's the
> real scenario hardware configuration wise.
> 

Agree on, I will add these missing clock properties also into the cpu1
node to reflect the hardware actually should have. 

That also is devicetree wants us to do to describe the device more
closely.

> But I am not sure if something else will break if you don't provide clocks in
> CPU1.
> 
> @Rob @Mark: What do you suggest ?
> 
