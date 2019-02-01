Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C36C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4630121872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ilfPxG19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbfBAPSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:18:49 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:58416 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbfBAPSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:18:48 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x11F3rBl142588;
        Fri, 1 Feb 2019 15:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=9bboZRiEp9Tf5BGxvJj+LAmZEz0Im6K6qtWf5UtBgOA=;
 b=ilfPxG19urEXH1cpSKXOPlXvdi34EbQORFTHQaGvSSbT38Lk8rnh2Y/TKU/oVHN20J1G
 XQPQdvPE8LpaN+pk51oIT8EvB/4nSoxboH55pPBHxaWX7Zw1aXXNuzW8YhH5dFkAdRwZ
 jzQZh8M7HY5f2klpbbSlbjaLlZgbVM+bSTmq4OFjzQIT61drtGRzbhHI32IPptT4TB2s
 rTcIK7xgb9BTV5MjhYbm35twW7m1z9Nie60NHp2WMEVaEIyhMrD5bBBD/GdJbIZUxa+h
 9tJ8yyUAs7Qm9g0+NvHM+ZQ4B6SJDLoSG3StlS75wIN8FWgea8nMRXMLDxbpwEuxk512 vg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2q8d2eqavj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Feb 2019 15:18:42 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x11FIbZH008129
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Feb 2019 15:18:37 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x11FIaYT008897;
        Fri, 1 Feb 2019 15:18:36 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 01 Feb 2019 07:18:36 -0800
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mlx4_ib: Increase the timeout for CM cache
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <20190131170951.178676-1-haakon.bugge@oracle.com>
Date:   Fri, 1 Feb 2019 16:18:34 +0100
Cc:     OFED mailing list <linux-rdma@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9BDCB055-BBB7-497F-BA28-F092051E4B22@oracle.com>
References: <20190131170951.178676-1-haakon.bugge@oracle.com>
To:     Doug Ledford <dledford@redhat.com>,
        Sean Hefty <sean.hefty@intel.com>,
        Hal Rosenstock <hal@dev.mellanox.co.il>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9153 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902010114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry,

I posted this as if it a net patch. It isn't, hence resend with correct =
recipients.



Thxs, H=C3=A5kon


> On 31 Jan 2019, at 18:09, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
> Using CX-3 virtual functions, either from a bare-metal machine or
> pass-through from a VM, MAD packets are proxied through the PF driver.
>=20
> Since the VMs have separate name spaces for MAD Transaction Ids
> (TIDs), the PF driver has to re-map the TIDs and keep the book keeping
> in a cache.
>=20
> Following the RDMA CM protocol, it is clear when an entry has to
> evicted form the cache. But life is not perfect, remote peers may die
> or be rebooted. Hence, it's a timeout to wipe out a cache entry, when
> the PF driver assumes the remote peer has gone.
>=20
> We have experienced excessive amount of DREQ retries during fail-over
> testing, when running with eight VMs per database server.
>=20
> The problem has been reproduced in a bare-metal system using one VM
> per physical node. In this environment, running 256 processes in each
> VM, each process uses RDMA CM to create an RC QP between himself and
> all (256) remote processes. All in all 16K QPs.
>=20
> When tearing down these 16K QPs, excessive DREQ retries (and
> duplicates) are observed. With some cat/paste/awk wizardry on the
> infiniband_cm sysfs, we observe:
>=20
>      dreq:       5007
> cm_rx_msgs:
>      drep:       3838
>      dreq:      13018
>       rep:       8128
>       req:       8256
>       rtu:       8256
> cm_tx_msgs:
>      drep:       8011
>      dreq:      68856
>       rep:       8256
>       req:       8128
>       rtu:       8128
> cm_tx_retries:
>      dreq:      60483
>=20
> Note that the active/passive side is distributed.
>=20
> Enabling pr_debug in cm.c gives tons of:
>=20
> [171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
> 1,sl_cm_id: 0xd393089f} is NULL!
>=20
> By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
> tear-down phase of the application is reduced from 113 to 67
> seconds. Retries/duplicates are also significantly reduced:
>=20
> cm_rx_duplicates:
>      dreq:       7726
> []
> cm_tx_retries:
>      drep:          1
>      dreq:       7779
>=20
> Increasing the timeout further didn't help, as these duplicates and
> retries stem from a too short CMA timeout, which was 20 (~4 seconds)
> on the systems. By increasing the CMA timeout to 22 (~17 seconds), the
> numbers fell down to about one hundred for both of them.
>=20
> Adjustment of the CMA timeout is _not_ part of this commit.
>=20
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
> drivers/infiniband/hw/mlx4/cm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
> index fedaf8260105..8c79a480f2b7 100644
> --- a/drivers/infiniband/hw/mlx4/cm.c
> +++ b/drivers/infiniband/hw/mlx4/cm.c
> @@ -39,7 +39,7 @@
>=20
> #include "mlx4_ib.h"
>=20
> -#define CM_CLEANUP_CACHE_TIMEOUT  (5 * HZ)
> +#define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
>=20
> struct id_map_entry {
> 	struct rb_node node;
> --=20
> 2.20.1
>=20

