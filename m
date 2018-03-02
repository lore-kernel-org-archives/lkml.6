Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423358AbeCBQoN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 11:44:13 -0500
Received: from orcrist.hmeau.com ([104.223.48.154]:59282 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967014AbeCBQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 11:44:11 -0500
Date: Sat, 3 Mar 2018 00:44:03 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Rui Miguel Silva <rui.silva@linaro.org>
Cc: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v4 0/4] Enable CAAM on i.MX7s fix TrustZone issues
Message-ID: <20180302164403.GG21579@gondor.apana.org.au>
References: <20180222142250.31348-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222142250.31348-1-rui.silva@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:22:46PM +0000, Rui Miguel Silva wrote:
> For v4 I am taking over this patch series as all the left over patches were
> implemented by me.
> 
> V4:
> - removed patch: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
> already initialized from the series since Horia presented a better fix for the
>  endless loop in case of fail to acquire DECO:
>  225ece3e7dad4 crypto: caam - fix endless loop when DECO acquire fails
> - add Fabio Estevam reviewed by tag in PATCH 3/3.
> - removed CAAM ERA from dts since bootloader will add it - Horia.
> 
> V3:
> - Added Cc: clk driver maintainers - Fabio Estevam
> - Added Cc: i.MX arch maintainers - Fabio Estevam
> - Removed bouncing email address for Herbert Xu
> 
> V2-resend:
> - Patch 0005 lost in the ether - resending
> 
> V2:
> - Endian detection is ok with TrustZone enabled Horia.
>   Endian detection logic tested with TrustZone enabled. The register that
>   this relies on though isn't affected by the lock-down in the first page.
>   Assuming set of affected registers is actually just the 'deco' registers
>   though there is no formal statement of that, that I am aware of.
> 
> - Moving of TrustZone work-around into u-boot
>   This set actually doesn't need to deal with TrustZone at all now but, for
>   the sake of consistency keeping thread title
> 
>   https://patchwork.ozlabs.org/patch/866460/
>   https://patchwork.ozlabs.org/patch/866462/
>   https://patchwork.ozlabs.org/patch/865890/
> 
> - Reworded endless loop fix to read a bit better
> 
> - Fixes to DTS additions - Rui
> 
> - Fixes to number of clocks declared - Rui
> 
> V1:
> This patch-set enables CAAM on the i.MX7s and fixes a number of issues
> identified with the CAAM driver and hardware when TrustZone mode is
> enabled.
> 
> The first block of patches are simple bug-fixes, followed by a second block
> of patches which are simple enabling patches for the i.MX7Solo - note we
> aren't enabling for the i.MX7Dual since we don't have hardware to test that
> out but it should be a 1:1 mapping for others to enable when appropriate.
> 
> Cheers,
>     Rui
> 
> Rui Miguel Silva (4):
>   crypto: caam - Fix null dereference at error path
>   crypto: caam - do not use mem and emi_slow clock for imx7x
>   clk: imx7d: add CAAM clock
>   ARM: dts: imx7s: add CAAM device node
> 
>  arch/arm/boot/dts/imx7s.dtsi            | 30 +++++++++++++++++++++++
>  drivers/clk/imx/clk-imx7d.c             |  1 +
>  drivers/crypto/caam/ctrl.c              | 42 +++++++++++++++++++--------------
>  include/dt-bindings/clock/imx7d-clock.h |  3 ++-
>  4 files changed, 57 insertions(+), 19 deletions(-)

Patches 1 and 2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
