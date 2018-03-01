Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031124AbeCAOCt (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:02:49 -0500
Received: from foss.arm.com ([217.140.101.70]:38914 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030922AbeCAOCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:02:48 -0500
Date: Thu, 1 Mar 2018 14:02:43 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: robh+dt@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        robin.murphy@arm.com, arnd@arndb.de, loic.pallardy@st.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 0/2] STM32 Extended TrustZone Protection driver
Message-ID: <20180301140243.3uamdvdcvmsxv6im@lakrids.cambridge.arm.com>
References: <20180301135806.19982-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301135806.19982-1-benjamin.gaignard@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2018 at 02:58:04PM +0100, Benjamin Gaignard wrote:
> On early boot stages STM32MP1 platform is able to dedicate some hardware blocks
> to a secure OS running in TrustZone.
> We need to avoid using those hardware blocks on non-secure context (i.e. kernel)
> because read/write accesses could generate illegale access exceptions.
> 
> Extended TrustZone Protection driver make sure that device is disabled if
> non-secure world can't acces to it.
> 
> version 2:
> - do not use notifier anymore
> - change status property value in device-tree if needed
> - use a list of phandle instead of hard coded array

As mentioned on v1, I don't think this should be done in Linux at all.

If you wish to handle this dynamically, please fixup the DT *before*
entering Linux.

If you want a sane default in the dts file, put status = "disabled" on
all nodes which the secure world might take ownership of.

Thanks,
Mark.

> NOTE: Those patches should be applied only on
> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> until this patch: https://lkml.org/lkml/2018/2/26/386
> find it way to mainline because KBuild will complain about them.
> 
> Benjamin Gaignard (2):
>   dt-bindings: stm32: Add bindings for Extended TrustZone Protection
>   ARM: mach-stm32: Add Extended TrustZone Protection driver
> 
>  .../bindings/arm/stm32/st,stm32mp1-etzpc.txt       |  25 +++++
>  arch/arm/mach-stm32/Kconfig                        |   7 ++
>  arch/arm/mach-stm32/Makefile                       |   1 +
>  arch/arm/mach-stm32/stm32-etzpc.c                  | 116 +++++++++++++++++++++
>  4 files changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/stm32/st,stm32mp1-etzpc.txt
>  create mode 100644 arch/arm/mach-stm32/stm32-etzpc.c
> 
> -- 
> 2.15.0
> 
