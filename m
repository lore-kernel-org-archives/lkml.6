Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1164852-1519982296-2-14928503521198997492
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: cc='iso-8859-2', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519982295; b=WIM41ErEjntvBCYQ+6f8Y6hjCBhaLqQaNapKl8eklnOhwZ9
    RhAW0GTGP23GsP4B/5TS9yXP8LMeF4yshR8mHg/1pJNM11agzYV2jIsI0u/AOIco
    kulx+vnyi3phv4NGGD6DBRKjKfnsncB0L97UZlRL9jqUSVPnb8lDFvXDdFHwWRlX
    APvZRG5k+2BzM6lVqKzxobp0sUTCE0oODIs3jT5fpsJnTB3fjvbyM0ySTCHHSJgr
    tntYNEweFKRJdtvSsGrbn72h+tbQ9lxUmwHCk0cb6EhTpGN9WYBv36m2cpENA+/m
    /GOR5glzmdgSPfDSOTUyNju6E62XVn5aLsOt9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=arctest; t=1519982295; bh=ze3x2aXluReHkFAxW/BAtRLzAG4
    iSbtZlRE6tePQ3CI=; b=ILRYvuIWWn7JVSr+o8sDyddhQjK2c86iO94yEvjqzda
    oa7B68RKnTKha0yIdPw409OKh1Ww/caqv31FCRhIa6l2X5Zy5L5kR0T00H8QpYNF
    8ejHKGSI6rtKChBDC3YX2ggVgUTGurp5QCWPM0xQB9TKPHs8Ak/eYaHLDJKkmHy/
    Tx8FhD0Oky4amldMnSg2TI+XS53MJ3f41cFXRi74wAdF6qGYYCR1ZZKoPUp+Bf1b
    HJQTOaJ/uLHwDxR+/Vt9AdBw1vr5MylBXFG4fvcAx9vwqDL+8y1VFK49/YfLBFeO
    JDlyFD0UkJcq5q7R7IIodwdQpjgOsYf3xo1SFjueeDA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=oclvgjj7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=oclvgjj7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
To: Bogdan Purcareata <bogdan.purcareata@nxp.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Ruxandra Ioana
 Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
Thread-Topic: [PATCH 2/3] staging: fsl-mc: Move DPBP out of staging
Thread-Index: AQHTsYVtNXA/GQe1iEqG6+vqel/PgaO8q6MA
Date: Fri, 2 Mar 2018 09:17:53 +0000
Message-ID: <5A9916C0.6090804@nxp.com>
References: <20180301174712.2660-1-bogdan.purcareata@nxp.com>
 <20180301174712.2660-3-bogdan.purcareata@nxp.com>
In-Reply-To: <20180301174712.2660-3-bogdan.purcareata@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; VI1PR0401MB2462;
 7:fDWpJMIxfrkuFFg0cFt3Uwncpg82lcSv+m30b+c77FKdzdMy8OQmDsrmJ6enxYjCFWqE5o1mfjOgsdO3ujT372xeWhI/kXDazdyNvljtNeJNkSlY5iUjBM5S/c0O9/1TF8hl5VcQBKiQmf12l8RD0WLnQMMymoHgguysOQAKLTk3l1eemLjbUpKAl2pkVIE23vp/HO65ZsXKHLxfsQ7YfRaV3PRx4mUWy/hwBW/mVgIREH7zAcVC7oTgJJF+KAmf
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI; SCL:-1; SFV:NSPM;
 SFS:(10009020)(366004)(39860400002)(39380400002)(376002)(346002)(396003)(199004)(189003)(80316001)(2950100002)(575784001)(86362001)(26005)(99286004)(2501003)(3846002)(6116002)(229853002)(25786009)(76176011)(5250100002)(39060400002)(65816011)(478600001)(3660700001)(53546011)(6506007)(66066001)(87266011)(4326008)(97736004)(33656002)(102836004)(59450400001)(81166006)(81156014)(8676002)(59896002)(36756003)(6636002)(8936002)(53936002)(106356001)(110136005)(3280700002)(6512007)(5660300001)(6436002)(6486002)(2906002)(316002)(7736002)(68736007)(14454004)(6246003)(54906003)(2900100001)(105586002)(305945005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR0401MB2462;
 H:VI1PR0401MB1856.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 A:1; MX:1; LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1f649831-98d8-4755-14fa-08d5801e7a6d
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);
 SRVR:VI1PR0401MB2462;
x-ms-traffictypediagnostic: VI1PR0401MB2462:
x-microsoft-antispam-prvs: <VI1PR0401MB2462DE0EDBDDCB5386BD9F8CECC50@VI1PR0401MB2462.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501237)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:VI1PR0401MB2462; BCL:0; PCL:0; RULEID:; SRVR:VI1PR0401MB2462;
x-forefront-prvs: 05991796DF
x-microsoft-antispam-message-info: ZQkM/Om5Tba/clfF0lu9p5nLq657PgJW9omWfhqjgf+OS2iA4j3aeh/vGS4ArE8p5Y9cGq9R9IPs2EYEHWzL4t0lv5WAltKotO3/hV0pUxrwIrRZapzFcCJs2vXU0UhbOxPYj3QLtBvO/lm9mQ0Pqe6OB1CjD2uw2p3Izih9o0Y=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-ID: <7FF327498B39F740AF4712EBBB79F8DA@eurprd04.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f649831-98d8-4755-14fa-08d5801e7a6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2018 09:17:53.2574 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2462
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 =?iso-8859-2?Q?Horia_Geant=E3?= <horia.geanta@nxp.com>,
 Roy Pledge <roy.pledge@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nipun Gupta <nipun.gupta@nxp.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bogdan,

On 03/01/2018 07:47 PM, Bogdan Purcareata wrote:
> Move the source files out of staging into their final locations:
> - dpbp.c goes to drivers/bus/fsl-mc/, next to the core infrastructure
> - dpbp-cmd.h gets merged into drivers/bus/fsl-mc/fsl-mc-private.h, next
>    to the other internally used APIs
> - dpbp.h gets merged into include/linux/fsl/mc.h, exposing the public
>    API
>
> Update references in the dpaa2-eth staging driver.
>
> DPBP stands for Data Path Buffer Pool - you can read more about the
> object in Documentation/networking/dpaa2/overview.rst
>
> Signed-off-by: Bogdan Purcareata <bogdan.purcareata@nxp.com>
> ---
>   drivers/bus/fsl-mc/Makefile                       |  1 +
>   drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c |  4 +-
>   drivers/bus/fsl-mc/fsl-mc-private.h               | 39 +++++++++++++++++
>   drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h    |  2 +-
>   drivers/staging/fsl-mc/bus/Makefile               |  3 +-
>   drivers/staging/fsl-mc/bus/dpbp-cmd.h             | 44 -------------------
>   drivers/staging/fsl-mc/include/dpbp.h             | 53 -----------------------
>   include/linux/fsl/mc.h                            | 42 ++++++++++++++++++
>   8 files changed, 86 insertions(+), 102 deletions(-)
>   rename drivers/{staging/fsl-mc/bus => bus/fsl-mc}/dpbp.c (98%)
>   delete mode 100644 drivers/staging/fsl-mc/bus/dpbp-cmd.h
>   delete mode 100644 drivers/staging/fsl-mc/include/dpbp.h
>
> diff --git a/drivers/bus/fsl-mc/Makefile b/drivers/bus/fsl-mc/Makefile
> index 6a97f2c..da26e52 100644
> --- a/drivers/bus/fsl-mc/Makefile
> +++ b/drivers/bus/fsl-mc/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_FSL_MC_BUS) += mc-bus-driver.o
>   mc-bus-driver-objs := fsl-mc-bus.o \
>   		      mc-sys.o \
>   		      mc-io.o \
> +		      dpbp.o \
>   		      dprc.o \
>   		      dprc-driver.o \
>   		      fsl-mc-allocator.o \
> diff --git a/drivers/staging/fsl-mc/bus/dpbp.c b/drivers/bus/fsl-mc/dpbp.c
> similarity index 98%
> rename from drivers/staging/fsl-mc/bus/dpbp.c
> rename to drivers/bus/fsl-mc/dpbp.c
> index 85735bb..31a360b 100644
> --- a/drivers/staging/fsl-mc/bus/dpbp.c
> +++ b/drivers/bus/fsl-mc/dpbp.c
> @@ -5,9 +5,9 @@
>    */
>   #include <linux/kernel.h>
>   #include <linux/fsl/mc.h>
> -#include "../include/dpbp.h"
> +#include "linux/fsl/mc.h"

I think we can use <> here, same comment for patch 3/3.

Other than that, the series looks ok to me so for all the patches:

Reviewed-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu

> -#include "dpbp-cmd.h"
> +#include "fsl-mc-private.h"
>
>   /**
>    * dpbp_open() - Open a control session for the specified object.
> diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
> index bed990c..4ef8d7e 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-private.h
> +++ b/drivers/bus/fsl-mc/fsl-mc-private.h
> @@ -379,6 +379,45 @@ int dprc_get_container_id(struct fsl_mc_io *mc_io,
>   			  u32 cmd_flags,
>   			  int *container_id);
>
> +/*
> + * Data Path Buffer Pool (DPBP) API
> + */
> +
> +/* DPBP Version */
> +#define DPBP_VER_MAJOR				3
> +#define DPBP_VER_MINOR				2
> +
> +/* Command versioning */
> +#define DPBP_CMD_BASE_VERSION			1
> +#define DPBP_CMD_ID_OFFSET			4
> +
> +#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
> +
> +/* Command IDs */
> +#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
> +#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
> +
> +#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
> +#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
> +#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
> +#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
> +
> +struct dpbp_cmd_open {
> +	__le32 dpbp_id;
> +};
> +
> +#define DPBP_ENABLE			0x1
> +
> +struct dpbp_rsp_get_attributes {
> +	/* response word 0 */
> +	__le16 pad;
> +	__le16 bpid;
> +	__le32 id;
> +	/* response word 1 */
> +	__le16 version_major;
> +	__le16 version_minor;
> +};
> +
>   /**
>    * Maximum number of total IRQs that can be pre-allocated for an MC bus'
>    * IRQ pool
> diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> index e577410..ce864ee 100644
> --- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> +++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
> @@ -35,10 +35,10 @@
>
>   #include <linux/netdevice.h>
>   #include <linux/if_vlan.h>
> +#include <linux/fsl/mc.h>
>
>   #include "../../fsl-mc/include/dpaa2-io.h"
>   #include "../../fsl-mc/include/dpaa2-fd.h"
> -#include "../../fsl-mc/include/dpbp.h"
>   #include "../../fsl-mc/include/dpcon.h"
>   #include "dpni.h"
>   #include "dpni-cmd.h"
> diff --git a/drivers/staging/fsl-mc/bus/Makefile b/drivers/staging/fsl-mc/bus/Makefile
> index b67889e..ea6479f 100644
> --- a/drivers/staging/fsl-mc/bus/Makefile
> +++ b/drivers/staging/fsl-mc/bus/Makefile
> @@ -4,8 +4,7 @@
>   #
>   # Copyright (C) 2014 Freescale Semiconductor, Inc.
>   #
> -obj-$(CONFIG_FSL_MC_BUS) += dpbp.o \
> -			    dpcon.o
> +obj-$(CONFIG_FSL_MC_BUS) += dpcon.o
>
>   # MC DPIO driver
>   obj-$(CONFIG_FSL_MC_DPIO) += dpio/
> diff --git a/drivers/staging/fsl-mc/bus/dpbp-cmd.h b/drivers/staging/fsl-mc/bus/dpbp-cmd.h
> deleted file mode 100644
> index 3340021..0000000
> --- a/drivers/staging/fsl-mc/bus/dpbp-cmd.h
> +++ /dev/null
> @@ -1,44 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/*
> - * Copyright 2013-2016 Freescale Semiconductor Inc.
> - *
> - */
> -#ifndef _FSL_DPBP_CMD_H
> -#define _FSL_DPBP_CMD_H
> -
> -/* DPBP Version */
> -#define DPBP_VER_MAJOR				3
> -#define DPBP_VER_MINOR				2
> -
> -/* Command versioning */
> -#define DPBP_CMD_BASE_VERSION			1
> -#define DPBP_CMD_ID_OFFSET			4
> -
> -#define DPBP_CMD(id)	(((id) << DPBP_CMD_ID_OFFSET) | DPBP_CMD_BASE_VERSION)
> -
> -/* Command IDs */
> -#define DPBP_CMDID_CLOSE		DPBP_CMD(0x800)
> -#define DPBP_CMDID_OPEN			DPBP_CMD(0x804)
> -
> -#define DPBP_CMDID_ENABLE		DPBP_CMD(0x002)
> -#define DPBP_CMDID_DISABLE		DPBP_CMD(0x003)
> -#define DPBP_CMDID_GET_ATTR		DPBP_CMD(0x004)
> -#define DPBP_CMDID_RESET		DPBP_CMD(0x005)
> -
> -struct dpbp_cmd_open {
> -	__le32 dpbp_id;
> -};
> -
> -#define DPBP_ENABLE			0x1
> -
> -struct dpbp_rsp_get_attributes {
> -	/* response word 0 */
> -	__le16 pad;
> -	__le16 bpid;
> -	__le32 id;
> -	/* response word 1 */
> -	__le16 version_major;
> -	__le16 version_minor;
> -};
> -
> -#endif /* _FSL_DPBP_CMD_H */
> diff --git a/drivers/staging/fsl-mc/include/dpbp.h b/drivers/staging/fsl-mc/include/dpbp.h
> deleted file mode 100644
> index 7b9f7ad..0000000
> --- a/drivers/staging/fsl-mc/include/dpbp.h
> +++ /dev/null
> @@ -1,53 +0,0 @@
> -/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> -/*
> - * Copyright 2013-2016 Freescale Semiconductor Inc.
> - *
> - */
> -#ifndef __FSL_DPBP_H
> -#define __FSL_DPBP_H
> -
> -/*
> - * Data Path Buffer Pool API
> - * Contains initialization APIs and runtime control APIs for DPBP
> - */
> -
> -struct fsl_mc_io;
> -
> -int dpbp_open(struct fsl_mc_io *mc_io,
> -	      u32 cmd_flags,
> -	      int dpbp_id,
> -	      u16 *token);
> -
> -int dpbp_close(struct fsl_mc_io *mc_io,
> -	       u32 cmd_flags,
> -	       u16 token);
> -
> -int dpbp_enable(struct fsl_mc_io *mc_io,
> -		u32 cmd_flags,
> -		u16 token);
> -
> -int dpbp_disable(struct fsl_mc_io *mc_io,
> -		 u32 cmd_flags,
> -		 u16 token);
> -
> -int dpbp_reset(struct fsl_mc_io *mc_io,
> -	       u32 cmd_flags,
> -	       u16 token);
> -
> -/**
> - * struct dpbp_attr - Structure representing DPBP attributes
> - * @id:		DPBP object ID
> - * @bpid:	Hardware buffer pool ID; should be used as an argument in
> - *		acquire/release operations on buffers
> - */
> -struct dpbp_attr {
> -	int id;
> -	u16 bpid;
> -};
> -
> -int dpbp_get_attributes(struct fsl_mc_io *mc_io,
> -			u32 cmd_flags,
> -			u16 token,
> -			struct dpbp_attr *attr);
> -
> -#endif /* __FSL_DPBP_H */
> diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
> index 765ba41..66118e1 100644
> --- a/include/linux/fsl/mc.h
> +++ b/include/linux/fsl/mc.h
> @@ -451,4 +451,46 @@ static inline bool is_fsl_mc_bus_dprtc(const struct fsl_mc_device *mc_dev)
>   	return mc_dev->dev.type == &fsl_mc_bus_dprtc_type;
>   }
>
> +/*
> + * Data Path Buffer Pool (DPBP) API
> + * Contains initialization APIs and runtime control APIs for DPBP
> + */
> +
> +int dpbp_open(struct fsl_mc_io *mc_io,
> +	      u32 cmd_flags,
> +	      int dpbp_id,
> +	      u16 *token);
> +
> +int dpbp_close(struct fsl_mc_io *mc_io,
> +	       u32 cmd_flags,
> +	       u16 token);
> +
> +int dpbp_enable(struct fsl_mc_io *mc_io,
> +		u32 cmd_flags,
> +		u16 token);
> +
> +int dpbp_disable(struct fsl_mc_io *mc_io,
> +		 u32 cmd_flags,
> +		 u16 token);
> +
> +int dpbp_reset(struct fsl_mc_io *mc_io,
> +	       u32 cmd_flags,
> +	       u16 token);
> +
> +/**
> + * struct dpbp_attr - Structure representing DPBP attributes
> + * @id:		DPBP object ID
> + * @bpid:	Hardware buffer pool ID; should be used as an argument in
> + *		acquire/release operations on buffers
> + */
> +struct dpbp_attr {
> +	int id;
> +	u16 bpid;
> +};
> +
> +int dpbp_get_attributes(struct fsl_mc_io *mc_io,
> +			u32 cmd_flags,
> +			u16 token,
> +			struct dpbp_attr *attr);
> +
>   #endif /* _FSL_MC_H_ */
>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
