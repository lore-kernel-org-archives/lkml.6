Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A5C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A75520821
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:40:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p4ZmPrr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730471AbfBFPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:40:23 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49466 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729015AbfBFPkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:40:23 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x16Fd59f082695;
        Wed, 6 Feb 2019 15:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=HUJ3rNRoLSh47ctvImhEqKkEcUAE9tNNLgFM0r4xxLU=;
 b=p4ZmPrr0HjnHELjbbmiCSUwEJrFyTS4m6b479vx4zS/oIRY6oN5ZILSCeiFg0xLFSbRo
 oM8670ahrXfryPpAc6HAEYXFA6cGgkJqG7ImnxHQTvdpIxMXoHt72H20tbAM4s5FpWLb
 Lch0tXfWgy/v4NH+mYnVA3v2+hKVnOpUKV6Fhgyitd/uySqj19lSvcfRVALBQ7aIgtF/
 D0WPM36u4k3c2VbVO+URYJhPjPBtVvOrNVdNEIDFKUqf0bsmLo2jLA2h8kOjauQxH2x5
 hTmkM3I/CiiuaIrDZxNfFZJbXPjLWGqpnYSGBNabCsgP79+aWrttvpq/N22cQYGgHuGQ Uw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97f1qxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Feb 2019 15:40:20 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x16FeH5I010434
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Feb 2019 15:40:18 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x16FeHpd019197;
        Wed, 6 Feb 2019 15:40:17 GMT
Received: from dhcp-10-172-157-159.no.oracle.com (/10.172.157.159)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Feb 2019 15:40:17 +0000
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH] mlx4_ib: Increase the timeout for CM cache
From:   =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <13750147-482A-4F90-976A-033C52DCF85E@oracle.com>
Date:   Wed, 6 Feb 2019 16:40:14 +0100
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, netdev@vger.kernel.org,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FF460501-80BA-44B9-AD59-84F64A338D67@oracle.com>
References: <20190131170951.178676-1-haakon.bugge@oracle.com>
 <20190205223608.GA23110@ziepe.ca>
 <13750147-482A-4F90-976A-033C52DCF85E@oracle.com>
To:     Jack Morgenstein <jackm@dev.mellanox.co.il>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9158 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 6 Feb 2019, at 09:50, H=C3=A5kon Bugge <haakon.bugge@oracle.com> =
wrote:
>=20
>=20
>=20
>> On 5 Feb 2019, at 23:36, Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>=20
>> On Thu, Jan 31, 2019 at 06:09:51PM +0100, H=C3=A5kon Bugge wrote:
>>> Using CX-3 virtual functions, either from a bare-metal machine or
>>> pass-through from a VM, MAD packets are proxied through the PF =
driver.
>>>=20
>>> Since the VMs have separate name spaces for MAD Transaction Ids
>>> (TIDs), the PF driver has to re-map the TIDs and keep the book =
keeping
>>> in a cache.
>>>=20
>>> Following the RDMA CM protocol, it is clear when an entry has to
>>> evicted form the cache. But life is not perfect, remote peers may =
die
>>> or be rebooted. Hence, it's a timeout to wipe out a cache entry, =
when
>>> the PF driver assumes the remote peer has gone.
>>>=20
>>> We have experienced excessive amount of DREQ retries during =
fail-over
>>> testing, when running with eight VMs per database server.
>>>=20
>>> The problem has been reproduced in a bare-metal system using one VM
>>> per physical node. In this environment, running 256 processes in =
each
>>> VM, each process uses RDMA CM to create an RC QP between himself and
>>> all (256) remote processes. All in all 16K QPs.
>>>=20
>>> When tearing down these 16K QPs, excessive DREQ retries (and
>>> duplicates) are observed. With some cat/paste/awk wizardry on the
>>> infiniband_cm sysfs, we observe:
>>>=20
>>>     dreq:       5007
>>> cm_rx_msgs:
>>>     drep:       3838
>>>     dreq:      13018
>>>      rep:       8128
>>>      req:       8256
>>>      rtu:       8256
>>> cm_tx_msgs:
>>>     drep:       8011
>>>     dreq:      68856
>>>      rep:       8256
>>>      req:       8128
>>>      rtu:       8128
>>> cm_tx_retries:
>>>     dreq:      60483
>>>=20
>>> Note that the active/passive side is distributed.
>>>=20
>>> Enabling pr_debug in cm.c gives tons of:
>>>=20
>>> [171778.814239] <mlx4_ib> mlx4_ib_multiplex_cm_handler: id{slave:
>>> 1,sl_cm_id: 0xd393089f} is NULL!
>>>=20
>>> By increasing the CM_CLEANUP_CACHE_TIMEOUT from 5 to 30 seconds, the
>>> tear-down phase of the application is reduced from 113 to 67
>>> seconds. Retries/duplicates are also significantly reduced:
>>>=20
>>> cm_rx_duplicates:
>>>     dreq:       7726
>>> []
>>> cm_tx_retries:
>>>     drep:          1
>>>     dreq:       7779
>>>=20
>>> Increasing the timeout further didn't help, as these duplicates and
>>> retries stem from a too short CMA timeout, which was 20 (~4 seconds)
>>> on the systems. By increasing the CMA timeout to 22 (~17 seconds), =
the
>>> numbers fell down to about one hundred for both of them.
>>>=20
>>> Adjustment of the CMA timeout is _not_ part of this commit.
>>>=20
>>> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
>>> ---
>>> drivers/infiniband/hw/mlx4/cm.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> Jack? What do you think?
>=20
> I am tempted to send a v2 making this a sysctl tuneable. This because, =
full-rack testing using 8 servers, each with 8 VMs, only showed 33% =
reduction in the occurrences of "mlx4_ib_multiplex_cm_handler: =
id{slave:1,sl_cm_id: 0xd393089f} is NULL" with this commit.
>=20
> But sure, Jack's opinion matters.

Jack,

A major contributor to the long processing time in the PF driver =
proxying QP1 packets is:

create_pv_resources
   -> ib_create_cq(ctx->ib_dev, mlx4_ib_tunnel_comp_handler,
                               NULL, ctx, cq_size, 0);

That is, comp_vector is zero.

Due to commit 6ba1eb776461 ("IB/mlx4: Scatter CQs to different EQs"), =
the zero comp_vector has the intent of let the mlx4_core driver select =
the least used vector.

But, in mlx4_ib_create_cq(), we have:

        pr_info("eq_table: %p\n", dev->eq_table);
        if (dev->eq_table) {
		vector =3D dev->eq_table[mlx4_choose_vector(dev->dev, =
vector,
                                                          =
ibdev->num_comp_vectors)];
        }

        cq->vector =3D vector;

and dev->eq_table is NULL, so all the CQs for the proxy QPs get =
comp_vector zero.

I have to make some reservations, as this analysis is based on uek4, but =
I think the code here is equal upstream, but need to double check.


Thxs, H=C3=A5kon








>=20
>=20
> Thxs, H=C3=A5kon
>=20
>>=20
>>> diff --git a/drivers/infiniband/hw/mlx4/cm.c =
b/drivers/infiniband/hw/mlx4/cm.c
>>> index fedaf8260105..8c79a480f2b7 100644
>>> --- a/drivers/infiniband/hw/mlx4/cm.c
>>> +++ b/drivers/infiniband/hw/mlx4/cm.c
>>> @@ -39,7 +39,7 @@
>>>=20
>>> #include "mlx4_ib.h"
>>>=20
>>> -#define CM_CLEANUP_CACHE_TIMEOUT  (5 * HZ)
>>> +#define CM_CLEANUP_CACHE_TIMEOUT  (30 * HZ)
>>>=20
>>> struct id_map_entry {
>>> 	struct rb_node node;
>>> --=20
>>> 2.20.1

