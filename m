Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1645187-1521029886-2-15554483623008572272
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521029886; b=Ek5r8ATllVIs+9pApI9EOChIlG01lu36RmnO8ZyWSLPLF5a
    lhFbrqoOshsEzTmffBrUJZqOu65LP5JVjJAmMayomIpvmn4n6yQqrsbcRc2Me6b1
    4oHnkMmcmqD1NGAX2NNL6S9+pZZSL64KvFvNtKi9DKd8afAhim6E5R+mFb9bBKAM
    XHD4N6Ju06hP6P95K1n73PRWOdfYQuw8T4CH/T5W4dArTMeULK4fQc1b9raWpahC
    82ZYEu593P3e2nGRW52/y0QD/JT0EedxQB7Z98laEkM3G6hchzxgTyDjeV9/Ertq
    68yOr29TQoQYcBLgeUROY7glU/5oZ1F2VTjQ3Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521029886; bh=Z
    VOjDpvySxUpX7HHZi+IPyb0n1tzUSZyq2boZEK9x9M=; b=B/Y6gFdQ2+ypcJ7Yr
    mI8fJWwwVH3G0FUgqObgd2pM2f5rL6grxMOTpJ53YyeR2JlttQ6Q6D0PpZYk4ELS
    f/qlU/GhLrqOauciwaKqMZ93PWm9nP17dqprCpWGZb8WG0wRP0K7x+IVDQLVJHxp
    VSaL7VH9eRQrqtZe05APWAb75LZLciBgQ08KvGfaWI0FoeTRSoxZ/ZiWo05hfCEQ
    QjVjhnhlIVqP+xAUfAm0XcRBvFiK/O1sNdfZ4RfZj7pkgcWf9F1eRVoIzLwH+b3W
    +afY/daSjRJc9xx5/k3nuEHdlYHrlFeO66BTsqR6eJnvfxN2sKimvErUNIbdx6zK
    KVbTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 13:17:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
Subject: Re: [PATCH v5 1/6] staging: fsl-dpaa2/ethsw: Add APIs for DPSW object
Message-ID: <20180314121759.GA22695@kroah.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-2-razvan.stefanescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180313135156.3322-2-razvan.stefanescu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, arnd@arndb.de,
 netdev@vger.kernel.org, alexandru.marginean@nxp.com,
 linux-kernel@vger.kernel.org, agraf@suse.de, ioana.ciornei@nxp.com,
 laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 08:51:51AM -0500, Razvan Stefanescu wrote:
> Add the command build/parse APIs for operating on DPSW objects through
> the DPAA2 Management Complex.
> 
> Signed-off-by: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> ---
> Changelog:
>  v2:
>     - use u8 for en parameter of dpsw_if_set_flooding/broadcast()
>  v3:
>     - no changes
>  v4:
>     - adjust to moving MC-bus out of staging
>     - fix sparse warnings
>  v5:
>    - no changes
> 
>  drivers/staging/fsl-dpaa2/Kconfig          |    8 +
>  drivers/staging/fsl-dpaa2/Makefile         |    1 +
>  drivers/staging/fsl-dpaa2/ethsw/Makefile   |    7 +
>  drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h |  358 +++++++++
>  drivers/staging/fsl-dpaa2/ethsw/dpsw.c     | 1116 ++++++++++++++++++++++++++++
>  drivers/staging/fsl-dpaa2/ethsw/dpsw.h     |  579 +++++++++++++++
>  6 files changed, 2069 insertions(+)
>  create mode 100644 drivers/staging/fsl-dpaa2/ethsw/Makefile
>  create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
>  create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.c
>  create mode 100644 drivers/staging/fsl-dpaa2/ethsw/dpsw.h
> 
> diff --git a/drivers/staging/fsl-dpaa2/Kconfig b/drivers/staging/fsl-dpaa2/Kconfig
> index dfff675..8a508ef 100644
> --- a/drivers/staging/fsl-dpaa2/Kconfig
> +++ b/drivers/staging/fsl-dpaa2/Kconfig
> @@ -16,3 +16,11 @@ config FSL_DPAA2_ETH
>  	---help---
>  	  Ethernet driver for Freescale DPAA2 SoCs, using the
>  	  Freescale MC bus driver
> +
> +config FSL_DPAA2_ETHSW
> +	tristate "Freescale DPAA2 Ethernet Switch"
> +	depends on FSL_DPAA2
> +	depends on NET_SWITCHDEV
> +	---help---
> +	Driver for Freescale DPAA2 Ethernet Switch. Select
> +	BRIDGE to have support for bridge tools.
> diff --git a/drivers/staging/fsl-dpaa2/Makefile b/drivers/staging/fsl-dpaa2/Makefile
> index 0836ba8..6cfd76b 100644
> --- a/drivers/staging/fsl-dpaa2/Makefile
> +++ b/drivers/staging/fsl-dpaa2/Makefile
> @@ -3,3 +3,4 @@
>  #
>  
>  obj-$(CONFIG_FSL_DPAA2_ETH)	+= ethernet/
> +obj-$(CONFIG_FSL_DPAA2_ETHSW)	+= ethsw/
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/Makefile b/drivers/staging/fsl-dpaa2/ethsw/Makefile
> new file mode 100644
> index 0000000..db137f7
> --- /dev/null
> +++ b/drivers/staging/fsl-dpaa2/ethsw/Makefile
> @@ -0,0 +1,7 @@
> +#
> +# Makefile for the Freescale DPAA2 Ethernet Switch
> +#
> +
> +obj-$(CONFIG_FSL_DPAA2_ETHSW) += dpaa2-ethsw.o
> +
> +dpaa2-ethsw-objs := dpsw.o
> diff --git a/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
> new file mode 100644
> index 0000000..36edef6
> --- /dev/null
> +++ b/drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h
> @@ -0,0 +1,358 @@
> +/* Copyright 2013-2016 Freescale Semiconductor Inc.
> + * Copyright 2017-2018 NXP
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are met:
> + *     * Redistributions of source code must retain the above copyright
> + *	 notice, this list of conditions and the following disclaimer.
> + *     * Redistributions in binary form must reproduce the above copyright
> + *	 notice, this list of conditions and the following disclaimer in the
> + *	 documentation and/or other materials provided with the distribution.
> + *     * Neither the name of the above-listed copyright holders nor the
> + *	 names of any contributors may be used to endorse or promote products
> + *	 derived from this software without specific prior written permission.
> + *
> + *
> + * ALTERNATIVELY, this software may be distributed under the terms of the
> + * GNU General Public License ("GPL") as published by the Free Software
> + * Foundation, either version 2 of that License or (at your option) any
> + * later version.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
> + * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
> + * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
> + * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
> + * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
> + * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
> + * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
> + * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
> + * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
> + * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
> + * POSSIBILITY OF SUCH DAMAGE.
> + */

Can you resend this series and just use the correct SPDX identifiers for
all of the new files, instead of all of this horrid boiler-plate code?

That will save me time when I have to go delete all of this in the near
future :)

Also, why dual license it?  Are you _SURE_ you want to do that, and are
totally aware of all of the crazy issues surrounding it?  Hint, it
almost never means what you might think it does, and I have yet to know
of anyone doing anything "real" with any dual-licensed Linux kernel
code.

Remember, BSD is not the license you want/need for GPL header files that
are exposed to userspace...


thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
