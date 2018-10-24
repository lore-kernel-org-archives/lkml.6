Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5427DC67863
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106D0205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 15:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TnziHx+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106D0205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbeJYA1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 20:27:14 -0400
Received: from merlin.infradead.org ([205.233.59.134]:38890 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeJYA1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 20:27:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=O11qiJ0gzVl4wOk+E2a9MXxPgn1zDvu3UCfLn+yLiF4=; b=TnziHx+Ml77rpidSj+QD+AvS2S
        WpuSI9vwHp6gRVXHm8qdZMhlz8OaUJBxxYumy0hInI376igE6OsNJ8oql6Y9EXtfNVmqgzPdrjekh
        qU18c9vGgiyrzBFA19Xv/sNJbDQ5vWftD7eZZXRBhU7cZv85MGHUaFrPQ5msqdp7zE84rC4JQ0UdX
        AqRMU3pEG+Fm1YdJwVDyC14A1yMzKMwFtUHtvK5HJZ3GrtlplSAeHBmYynirNq/W0BmpKrPLLbKH0
        a9IdBMgvrq6bu6dtYC1W5mlBloZW8H4TS5WKdj/e/Isvo5ZJlbk3/I+pmiSQhLBoJIt7AvPqGaRC2
        e1vHy0yA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gFLY7-0000ne-1A; Wed, 24 Oct 2018 15:58:23 +0000
Subject: Re: [PATCH anybus v1 4/4] misc: support HMS Profinet IRT industrial
 controller.
To:     Sven Van Asbroeck <svendev@arcx.com>, lee.jones@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, gregkh@linuxfoundation.org, john.garry@huawei.com,
        andriy.shevchenko@linux.intel.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        yuanzhichang@hisilicon.com, stuyoder@gmail.com,
        linus.walleij@linaro.org, maxime.ripard@bootlin.com,
        bogdan.purcareata@nxp.com
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20181024142456.10084-1-svendev@arcx.com>
 <20181024142456.10084-5-svendev@arcx.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cbc42346-4b67-dd3a-ddca-4c0e0ba6929a@infradead.org>
Date:   Wed, 24 Oct 2018 08:58:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024142456.10084-5-svendev@arcx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/24/18 7:24 AM, Sven Van Asbroeck wrote:
> The Anybus-S PROFINET IRT communication module provides instant integration
> to any Ethernet based LAN via SMTP, FTP, HTTP as well as PROFINET and
> Modbus-TCP. Additional protocols can be implemented on top of TCP/IP
> or UDP using the transparent socket interface.
> 
> Official documentation:
> https://www.anybus.com/docs/librariesprovider7/default-document-library
> /manuals-design-guides/hms-hmsi-168-52.pdf
> 
> This implementation is an Anybus-S client driver, designed to be
> instantiated by the Anybus-S bus driver when it discovers the Profinet
> card.
> 
> If loaded successfully, the driver creates a /dev/profinet%d devnode,
> and a /sys/class/misc/profinet%d sysfs subdir:
> - the card can be configured with a single, atomic ioctl on the devnode;
> - the card's internal dpram is accessed by calling read/write/seek
>     on the devnode.
> - the card's "fieldbus specific area" properties can be accessed via
>     the sysfs dir.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
> ---
>  drivers/misc/Kconfig              |  11 +
>  drivers/misc/Makefile             |   1 +
>  drivers/misc/hms-profinet.c       | 747 ++++++++++++++++++++++++++++++
>  include/uapi/linux/hms-common.h   |  14 +
>  include/uapi/linux/hms-profinet.h | 101 ++++
>  5 files changed, 874 insertions(+)
>  create mode 100644 drivers/misc/hms-profinet.c
>  create mode 100644 include/uapi/linux/hms-common.h
>  create mode 100644 include/uapi/linux/hms-profinet.h
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3726eacdf65d..377fea2e3003 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -406,6 +406,17 @@ config SPEAR13XX_PCIE_GADGET
>  	 entry will be created for that controller. User can use these
>  	 sysfs node to configure PCIe EP as per his requirements.
>  
> +config HMS_PROFINET
> +	tristate "HMS Profinet IRT Controller (Anybus-S)"
> +	select HMS_ANYBUSS_HOST
> +	default n

Please drop the "default n".

> +	help
> +	 If you say yes here you get support for the HMS Industrial
> +	 Networks Profinet IRT Controller.
> +	 This driver can also be built as a module. If so, the module
> +	 will be called hms-profinet.
> +	 If unsure, say N.
> +
>  config VMWARE_BALLOON
>  	tristate "VMware Balloon Driver"
>  	depends on VMWARE_VMCI && X86 && HYPERVISOR_GUEST

> diff --git a/drivers/misc/hms-profinet.c b/drivers/misc/hms-profinet.c
> new file mode 100644
> index 000000000000..7338a49cbddd
> --- /dev/null
> +++ b/drivers/misc/hms-profinet.c

Please check multi-line comment style in this source file.



> diff --git a/include/uapi/linux/hms-profinet.h b/include/uapi/linux/hms-profinet.h
> new file mode 100644
> index 000000000000..4ae5eab8ab43
> --- /dev/null
> +++ b/include/uapi/linux/hms-profinet.h
> @@ -0,0 +1,101 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2018 Archronix Corp. All Rights Reserved.
> + *
> + */
> +
> +#ifndef _UAPILINUX_PROFINET_H_
> +#define _UAPILINUX_PROFINET_H_
> +
> +#include <asm/types.h>
> +#include <linux/hms-common.h>
> +
> +#define PROFI_CFG_STRLEN	64
> +
> +struct ProfinetConfig {
> +	struct {
> +		/* addresses IN NETWORK ORDER! */
> +		__u32 ip_addr;
> +		__u32 subnet_msk;
> +		__u32 gateway_addr;
> +		__u8  is_valid:1;
> +	} eth;
> +	struct {
> +		__u16 vendorid, deviceid;
> +		__u8  is_valid:1;
> +	} dev_id;
> +	struct {
> +		char name[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} station_name;
> +	struct {
> +		char name[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} station_type;
> +	struct {
> +		__u8 addr[6];
> +		__u8 is_valid:1;
> +	} mac_addr;
> +	struct {
> +		char hostname[PROFI_CFG_STRLEN];
> +		char domainname[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} host_domain;
> +	struct {
> +		__u8 enable:1;
> +		__u8 is_valid:1;
> +	} hicp;
> +	struct {
> +		__u8 enable:1;
> +		__u8 is_valid:1;
> +	} web_server;
> +	struct {
> +		__u8 disable:1;
> +	} ftp_server;
> +	struct {
> +		__u8 enable:1;
> +	} global_admin_mode;
> +	struct {
> +		__u8 disable:1;
> +	} vfs;
> +	struct {
> +		/* one of HMS_SMA_CLEAR/FREEZE/SET */
> +		int action;
> +		__u8 is_valid:1;
> +	} stop_mode;
> +	struct {
> +		char description[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} snmp_system_descr;
> +	struct {
> +		char description[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} snmp_iface_descr;
> +	struct {
> +		char description[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} mib2_system_descr;
> +	struct {
> +		char contact[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} mib2_system_contact;
> +	struct {
> +		char location[PROFI_CFG_STRLEN];
> +		__u8 is_valid:1;
> +	} mib2_system_location;
> +	/* use non-volatile defaults for any properties not specified.
> +	 * when in doubt, keep this OFF.
> +	 */
> +	__u8 use_nv_defaults:1;
> +};
> +
> +#define PROFINET_IOC_MAGIC 'l'
> +
> +/*
> + * Configures profinet according to the ProfinetConfig structure, and
> + * switches the card on if it was previously off.
> + */
> +#define PROFINET_IOCSETCONFIG   _IOW(PROFINET_IOC_MAGIC, 1,\
> +						struct ProfinetConfig)

ioctl magic numbers should be added to
Documentation/ioctl/ioctl-number.txt, please.

> +
> +#endif /* _UAPILINUX_PROFINET_H_ */
> 


-- 
~Randy
