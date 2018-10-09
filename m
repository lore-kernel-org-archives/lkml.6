Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C89BC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3046C214C4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZsTzpb07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3046C214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJIWSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:18:00 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46160 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbeJIWSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:18:00 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w99EwbCE038569;
        Tue, 9 Oct 2018 15:00:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=hzFePnuqT7p71/Pq56u2NqOhrWhI/Dvfknmvt3Q5hw8=;
 b=ZsTzpb071gAnsooaOiO4iimF558LOmIAszjIYGvG5syTg2OpNv0onWJ3JPWC62w3bEGT
 1BdoQMUnfbuV7cxGDQpnAODmiSgKow9Ohl7ulM1VvhYPgrlSgVtxAFRCHGm4ujEJaXxi
 oWsVoFdBk43prYan+2tExwYheu9yQeP4pfUt3g7o0Y1u/yBnm8Aq4Xhk2jcqekdfl9q4
 QlphkyMpiArDG1XBjzX4LmHsenz0xBHAxBN62osKarNNOaw6lCdiOoJ7lEnseGR66T50
 nxkqIbh6msoTcsyQGlovGxUidxDjUNVLEP2dlsni/MEf2EL3zZpb4ntyF8GvlGDKKGcK AQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2mxn0pwxsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Oct 2018 15:00:38 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w99F0bQ1015092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Oct 2018 15:00:37 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w99F0aED012578;
        Tue, 9 Oct 2018 15:00:36 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Oct 2018 15:00:36 +0000
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 711F86A013A; Tue,  9 Oct 2018 11:00:35 -0400 (EDT)
Date:   Tue, 9 Oct 2018 11:00:35 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Filippo Sironi <sironi@amazon.de>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: Start populating /sys/hypervisor with KVM entries
Message-ID: <20181009150035.GK5106@char.us.oracle.com>
References: <1539078879-4372-1-git-send-email-sironi@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539078879-4372-1-git-send-email-sironi@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9040 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810090147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2018 at 11:54:39AM +0200, Filippo Sironi wrote:
> Start populating /sys/hypervisor with KVM entries when we're running on
> KVM. This is to replicate functionality that's available when we're
> running on Xen.
> 
> Let's start with /sys/hypervisor/uuid, which users prefer over
> /sys/devices/virtual/dmi/id/product_uuid as a way to recognize a virtual
> machine, since it's also available when running on Xen HVM and on Xen PV
> and, on top of that doesn't require root privileges by default.

Yeey! Thank you for doing this. It has been on my TODO but just never
got to it.

I think you also need to update the Documentation/../sysfs file.
> 
> Signed-off-by: Filippo Sironi <sironi@amazon.de>
> ---
>  drivers/Kconfig              |  2 ++
>  drivers/Makefile             |  2 ++
>  drivers/kvm/Kconfig          | 14 ++++++++++++++
>  drivers/kvm/Makefile         |  1 +
>  drivers/kvm/sys-hypervisor.c | 26 ++++++++++++++++++++++++++
>  5 files changed, 45 insertions(+)
>  create mode 100644 drivers/kvm/Kconfig
>  create mode 100644 drivers/kvm/Makefile
>  create mode 100644 drivers/kvm/sys-hypervisor.c
> 
> diff --git a/drivers/Kconfig b/drivers/Kconfig
> index afc942c54814..597519c5f7c8 100644
> --- a/drivers/Kconfig
> +++ b/drivers/Kconfig
> @@ -135,6 +135,8 @@ source "drivers/hv/Kconfig"
>  
>  source "drivers/xen/Kconfig"
>  
> +source "drivers/kvm/Kconfig"
> +
>  source "drivers/staging/Kconfig"
>  
>  source "drivers/platform/Kconfig"
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 1056f9699192..727205e287fc 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -47,6 +47,8 @@ obj-y				+= soc/
>  obj-$(CONFIG_VIRTIO)		+= virtio/
>  obj-$(CONFIG_XEN)		+= xen/
>  
> +obj-$(CONFIG_KVM_GUEST)		+= kvm/
> +
>  # regulators early, since some subsystems rely on them to initialize
>  obj-$(CONFIG_REGULATOR)		+= regulator/
>  
> diff --git a/drivers/kvm/Kconfig b/drivers/kvm/Kconfig
> new file mode 100644
> index 000000000000..3fc041df7c11
> --- /dev/null
> +++ b/drivers/kvm/Kconfig
> @@ -0,0 +1,14 @@
> +menu "KVM driver support"
> +        depends on KVM_GUEST
> +
> +config KVM_SYS_HYPERVISOR
> +        bool "Create KVM entries under /sys/hypervisor"
> +        depends on SYSFS
> +        select SYS_HYPERVISOR
> +        default y
> +        help
> +          Create KVM entries under /sys/hypervisor (e.g., uuid). When running
> +          native or on another hypervisor, /sys/hypervisor may still be
> +          present, but it will have no KVM entries.
> +
> +endmenu
> diff --git a/drivers/kvm/Makefile b/drivers/kvm/Makefile
> new file mode 100644
> index 000000000000..73a43fc994b9
> --- /dev/null
> +++ b/drivers/kvm/Makefile
> @@ -0,0 +1 @@
> +obj-$(CONFIG_KVM_SYS_HYPERVISOR) += sys-hypervisor.o
> diff --git a/drivers/kvm/sys-hypervisor.c b/drivers/kvm/sys-hypervisor.c
> new file mode 100644
> index 000000000000..ef04ca65cf1a
> --- /dev/null
> +++ b/drivers/kvm/sys-hypervisor.c
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <asm/kvm_para.h>
> +
> +#include <linux/dmi.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +
> +static ssize_t uuid_show(struct kobject *obj,
> +			 struct kobj_attribute *attr,
> +			 char *buf)
> +{
> +	const char *uuid = dmi_get_system_info(DMI_PRODUCT_UUID);
> +	return sprintf(buf, "%s\n", uuid);
> +}
> +
> +static struct kobj_attribute uuid = __ATTR_RO(uuid);
> +
> +static int __init uuid_init(void)
> +{
> +	if (!kvm_para_available())
> +		return 0;
> +	return sysfs_create_file(hypervisor_kobj, &uuid.attr);
> +}
> +
> +device_initcall(uuid_init);
> -- 
> 2.7.4
> 
