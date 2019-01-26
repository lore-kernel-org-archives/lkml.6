Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16DB2C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB403217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 17:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qlDi8aRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbfAZRJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 12:09:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfAZRJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 12:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=/V3vJ/V4XmlImm05zmxwbkKUUN18Hwo8X6yfyM9B0tg=; b=qlDi8aRRaeoM5uZS86SbbWd5E
        0iYY2Tq6Xy+Ux/E4VGAGplqwwt7i77vysky8czHGncAhaGIjwDNAh2ijSgfha+N8CjB9x7WW7CMnv
        2Sm0Xg1JXTWn9xfsW6wrjVH4KppRkpmNDU8YjadI3jYfliKyVREjozYcWv2ftP3GE3TuWl9oFOL5n
        s3TrUwEQZa11Kq74458/0PRFuYUjlCbHeMAsxRfGE/MqMqf0YPdlHCBPGmN/EizfAWWpc6tN65Xdz
        EvL7TFewHAJOeskVM2xXyhMZ5AMxw7GJhwicrYWrCFLInS3vCNht3YpcG77nzyaaiHTyrtXaDuRac
        fz2+7Yyqg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gnRSH-0004Pd-GO; Sat, 26 Jan 2019 17:09:17 +0000
Subject: Re: [PATCH v2 1/5] drivers/accel: Introduce subsystem
To:     Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org
Cc:     linux-accelerators@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        ogabbay@habana.ai, airlied@redhat.com, jglisse@redhat.com
References: <20190125211335.65783-1-olof@lixom.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a56a9283-55ad-abd3-e45c-b72c8a676925@infradead.org>
Date:   Sat, 26 Jan 2019 09:09:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190125211335.65783-1-olof@lixom.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please see a few corrections inline...

On 1/25/19 1:13 PM, Olof Johansson wrote:
> 
>  Documentation/accelerators/README.rst | 42 +++++++++++++++++++++++++++++++++++
>  MAINTAINERS                           |  8 +++++++
>  drivers/Kconfig                       |  2 ++
>  drivers/Makefile                      |  1 +
>  drivers/accel/Kconfig                 | 16 +++++++++++++
>  drivers/accel/Makefile                |  5 +++++
>  6 files changed, 74 insertions(+)
>  create mode 100644 Documentation/accelerators/README.rst
>  create mode 100644 drivers/accel/Kconfig
>  create mode 100644 drivers/accel/Makefile
> 
> diff --git a/Documentation/accelerators/README.rst b/Documentation/accelerators/README.rst
> new file mode 100644
> index 0000000000000..79049ff99e93e
> --- /dev/null
> +++ b/Documentation/accelerators/README.rst
> @@ -0,0 +1,42 @@
> +.. _readme:
> +
> +Hardware offload accelerator subsystem
> +======================================
> +
> +This is a brief overview of the subsystem (grouping) of hardware
> +accelerators kept under drivers/accel
> +
> +Types of hardware supported
> +---------------------------
> +
> +  The general types of hardware supported are hardware devices that has

                                                                  that have

> +  general interactions of sending commands and buffers to the hardware,
> +  returning completions and possible filled buffers back, together
> +  with the usual driver pieces around hardware control, setup, error
> +  handling, etc.
> +
> +  Drivers that fit into other subsystems are expected to be merged
> +  there, and use the appropriate userspace interfaces of said functional
> +  areas. We don't expect to see drivers for network, storage, graphics
> +  and similar hardware implemented by drivers here.
> +
> +Expectations for contributions
> +------------------------------
> +
> + - Platforms and hardware that has fully open stacks, from Firmware to

                             that have

> +   Userspace, are always going to be given preferential treatment. These
> +   platforms give the best insight for behavior and interaction of all
> +   layers, including ability to improve implementation across the stack
> +   over time.
> +
> + - If a platform is partially proprietary, it is still expected that the
> +   portions that interact the driver can be shared in a form that allows

               that interact with the driver

> +   for exercising the hardware/driver and evolution of the interface over
> +   time. This could be separated into a shared library and test/sample
> +   programs, for example.
> +
> + - Over time, there is an expectation to converge drivers over to shared
> +   frameworks and interfaces. Until then, the general rule is that no
> +   more than one driver per vendor will be acceptable. For vendors that
> +   aren't participating in the work towards shared frameworks over time,
> +   we reserve the right to phase out support for the hardware.

> diff --git a/drivers/accel/Kconfig b/drivers/accel/Kconfig
> new file mode 100644
> index 0000000000000..13b36c0398895
> --- /dev/null
> +++ b/drivers/accel/Kconfig
> @@ -0,0 +1,16 @@
> +#
> +# Drivers for hardware offload accelerators
> +# See Documentation/accel/README.rst for more details
> +#
> +
> +menuconfig ACCEL
> +	bool "Hardware offload accelerator support"
> +        help

Use tab instead of spaces above.

> +	  HW offload accelerators are used for high-bandwidth workloads
> +	  where a higher-level kernel/userspace interface isn't suitable.
> +
> +if ACCEL
> +
> +comment "HW Accellerator drivers"
> +
> +endif


-- 
~Randy
