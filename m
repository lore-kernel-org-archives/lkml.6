Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeECUyF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:54:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39007 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751103AbeECUyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:54:03 -0400
Date: Thu, 3 May 2018 22:53:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Rob Herring <robh@kernel.org>
Cc: Amelie Delaunay <amelie.delaunay@st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
Message-ID: <20180503205351.GE10960@piout.net>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
 <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amelie,

On 26/04/2018 21:58:03-0500, Rob Herring wrote:
> On Thu, Apr 19, 2018 at 03:21:42PM +0200, Amelie Delaunay wrote:
> > RTC driver should not be aware of the PWR registers offset and bits
> > position. Furthermore, we can imagine that Disable Backup Protection (DBP)
> > relative register and bit mask could change depending on the SoC. So this
> > patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
> > phandle/offset/mask triplet.
> > 
> > Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> > ---
> >  Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > index a66692a..00f8b5d 100644
> > --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> > @@ -14,8 +14,10 @@ Required properties:
> >      It is required only on stm32h7.
> >  - interrupt-parent: phandle for the interrupt controller.
> >  - interrupts: rtc alarm interrupt.
> > -- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
> > -  (RTC registers) write protection.
> > +- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
> > +  access control register at offset, and change the dbp (Disable Backup
> > +  Protection) bit represented by the mask, mandatory to disable/enable backup
> > +  domain (RTC registers) write protection.
> 
> It's fine to add this, but you are breaking compatibility in the driver 
> with existing DTBs by requiring these new fields.
> 

I'm fine with that change but I would like confirmation that this has
been well thought. Maybe Maxime or Alexandre could give their ack.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
