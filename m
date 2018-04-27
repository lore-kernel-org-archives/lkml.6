Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757389AbeD0C6H (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 22:58:07 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35168 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757046AbeD0C6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 22:58:05 -0400
X-Google-Smtp-Source: AB8JxZpQQn732gZe4IV9fxqKMWvBj4jOZEd82Y3FWnxasYLjr2a6nJN4i433a+bdECmnC0wnKEKmCA==
Date: Thu, 26 Apr 2018 21:58:03 -0500
From: Rob Herring <robh@kernel.org>
To: Amelie Delaunay <amelie.delaunay@st.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: rtc: update stm32-rtc documentation for
 st,syscfg property
Message-ID: <20180427025803.mn32y5xle2p6knn6@rob-hp-laptop>
References: <1524144103-21432-1-git-send-email-amelie.delaunay@st.com>
 <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524144103-21432-4-git-send-email-amelie.delaunay@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 03:21:42PM +0200, Amelie Delaunay wrote:
> RTC driver should not be aware of the PWR registers offset and bits
> position. Furthermore, we can imagine that Disable Backup Protection (DBP)
> relative register and bit mask could change depending on the SoC. So this
> patch moves st,syscfg property from single pwrcfg phandle to pwrcfg
> phandle/offset/mask triplet.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
> ---
>  Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> index a66692a..00f8b5d 100644
> --- a/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> +++ b/Documentation/devicetree/bindings/rtc/st,stm32-rtc.txt
> @@ -14,8 +14,10 @@ Required properties:
>      It is required only on stm32h7.
>  - interrupt-parent: phandle for the interrupt controller.
>  - interrupts: rtc alarm interrupt.
> -- st,syscfg: phandle for pwrcfg, mandatory to disable/enable backup domain
> -  (RTC registers) write protection.
> +- st,syscfg: phandle/offset/mask triplet. The phandle to pwrcfg used to
> +  access control register at offset, and change the dbp (Disable Backup
> +  Protection) bit represented by the mask, mandatory to disable/enable backup
> +  domain (RTC registers) write protection.

It's fine to add this, but you are breaking compatibility in the driver 
with existing DTBs by requiring these new fields.

Rob
