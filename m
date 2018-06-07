Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id b8sVFK1yGVuscQAAmS7hNA
	; Thu, 07 Jun 2018 18:00:52 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0289E606FA; Thu,  7 Jun 2018 18:00:52 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rtgx7dIZ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EC601601C3;
	Thu,  7 Jun 2018 18:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EC601601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935308AbeFGSAo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:00:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39076 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933821AbeFGSAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:00:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w57Hpcgb061196;
        Thu, 7 Jun 2018 18:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2017-10-26; bh=lIEmkAnClxa0Z46Sx03R4LiqsV+RJpLuz53vHngWEtQ=;
 b=rtgx7dIZUBl1o/T24pbx7Pog/xCMrZB3a8gCi/DwcH9ZCahkiJHjjzcBKLAHU8F8YPq6
 jvjQAqfV+unV049iFqhERPXI7CFY2hBd2q++ZikcjyTVmK4UweSTXlvTKl3c6U+1x/Kd
 bcI531CYm0lIFO68slZmbwpFnOHGDOJcSel0NChFFFyTLYLK1DaQe2ZVe64LvAEvT/Rb
 9ZQn0DE1FOEqAAhV+C9jEJgyKrAgHn5zPGL09EtirWxT+dkx07Sp+SIZzfph6wwZ1+X5
 pyaauPFgwodyWiwxcRCzQRJ0Q8S6i2Bw6vE08tj7T1CbIzkNjgh9c18IFRXUiYxDZl2R 2w==
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2jbvypj328-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jun 2018 18:00:09 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w57I09Sq031512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Jun 2018 18:00:09 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w57I0780004156;
        Thu, 7 Jun 2018 18:00:07 GMT
Received: from [192.168.10.196] (/51.175.236.248)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jun 2018 11:00:07 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v3 2/2] IB/mad: Use ID allocator routines to allocate
 agent number
From: =?utf-8?Q?H=C3=A5kon_Bugge?= <haakon.bugge@oracle.com>
In-Reply-To: <BL0PR2101MB088460CA4C97562CB311ED3ECB640@BL0PR2101MB0884.namprd21.prod.outlook.com>
Date: Thu, 7 Jun 2018 19:59:58 +0200
Cc: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7314EE01-3CCE-4C76-B7AB-C40AEC2F17E7@oracle.com>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-3-hans.westgaard.ry@oracle.com>
 <BL0PR2101MB088460CA4C97562CB311ED3ECB640@BL0PR2101MB0884.namprd21.prod.outlook.com>
To: Matthew Wilcox <mawilcox@microsoft.com>
X-Mailer: Apple Mail (2.3445.6.18)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8917 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806070192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 7 Jun 2018, at 17:37, Matthew Wilcox <mawilcox@microsoft.com> =
wrote:
>=20
> Why do you need the ID to increment like this?  Why can't you just use =
a unique ID?

Hans first patch did that, but it was "beaten" up. Turns out, MAD =
packets can be hiding and lingering in the fabric, hence, when an ID is =
released after, lets say a timeout, we want to maximize the time until =
its reuse.


Thxs, H=C3=A5kon

>=20
>> -----Original Message-----
>> From: Hans Westgaard Ry [mailto:hans.westgaard.ry@oracle.com]
>> Sent: Thursday, June 7, 2018 7:15 AM
>> To: Doug Ledford <dledford@redhat.com>; Jason Gunthorpe =
<jgg@ziepe.ca>;
>> Hakon Bugge <haakon.bugge@oracle.com>; Parav Pandit
>> <parav@mellanox.com>; Jack Morgenstein <jackm@dev.mellanox.co.il>; =
Pravin
>> Shedge <pravin.shedge4linux@gmail.com>; Matthew Wilcox
>> <mawilcox@microsoft.com>; Andrew Morton <akpm@linux-foundation.org>;
>> Jeff Layton <jlayton@kernel.org>; Wei Wang <wei.w.wang@intel.com>; =
Chris
>> Mi <chrism@mellanox.com>; Eric Biggers <ebiggers@google.com>; Rasmus
>> Villemoes <linux@rasmusvillemoes.dk>; Mel Gorman
>> <mgorman@techsingularity.net>; linux-rdma@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [PATCH v3 2/2] IB/mad: Use ID allocator routines to allocate =
agent
>> number
>>=20
>> The agent TID is a 64 bit value split in two dwords.  The least
>> significant dword is the TID running counter. The most significant
>> dword is the agent number. In the CX-3 shared port model, the mlx4
>> driver uses the most significant byte of the agent number to store =
the
>> slave number, making agent numbers greater and equal to 2^24 (3 =
bytes)
>> unusable.  The current codebase uses a variable which is incremented
>> atomically for each new agent number giving too large agent numbers
>> over time.  The IDA set of functions are used instead of the simple
>> counter approach. This allows re-use of agent numbers.
>>=20
>> The signature of the bug is a MAD layer that stops working and the
>> console is flooded with messages like:
>> mlx4_ib: egress mad has non-null tid msb:1 class:4 slave:0
>>=20
>> Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
>> ---
>> drivers/infiniband/core/mad.c | 25 +++++++++++++++++++++----
>> 1 file changed, 21 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/infiniband/core/mad.c =
b/drivers/infiniband/core/mad.c
>> index b28452a55a08..c01a2d63ffa2 100644
>> --- a/drivers/infiniband/core/mad.c
>> +++ b/drivers/infiniband/core/mad.c
>> @@ -41,6 +41,7 @@
>> #include <linux/slab.h>
>> #include <linux/module.h>
>> #include <linux/security.h>
>> +#include <linux/idr.h>
>> #include <rdma/ib_cache.h>
>>=20
>> #include "mad_priv.h"
>> @@ -59,8 +60,7 @@ module_param_named(recv_queue_size,
>> mad_recvq_size, int, 0444);
>> MODULE_PARM_DESC(recv_queue_size, "Size of receive queue in number of
>> work requests");
>>=20
>> static struct list_head ib_mad_port_list;
>> -static atomic_t ib_mad_client_id =3D ATOMIC_INIT(0);
>> -
>> +static DEFINE_IDA(ib_mad_client_ids);
>> /* Port list lock */
>> static DEFINE_SPINLOCK(ib_mad_port_list_lock);
>>=20
>> @@ -212,7 +212,7 @@ struct ib_mad_agent *ib_register_mad_agent(struct
>> ib_device *device,
>> 	int ret2, qpn;
>> 	unsigned long flags;
>> 	u8 mgmt_class, vclass;
>> -
>> +	u32 ib_mad_client_id;
>> 	/* Validate parameters */
>> 	qpn =3D get_spl_qp_index(qp_type);
>> 	if (qpn =3D=3D -1) {
>> @@ -375,9 +375,19 @@ struct ib_mad_agent =
*ib_register_mad_agent(struct
>> ib_device *device,
>> 		ret =3D ERR_PTR(ret2);
>> 		goto error4;
>> 	}
>> +	ib_mad_client_id =3D ida_simple_get_cyclic(&ib_mad_client_ids,
>> +						1,
>> +						BIT(24) - 1,
>> +						GFP_KERNEL);
>> +	if (ib_mad_client_id < 0) {
>> +		pr_err("Couldn't allocate agent tid; errcode: %#x\n",
>> +			ib_mad_client_id);
>> +		ret =3D ERR_PTR(ib_mad_client_id);
>> +		goto error4;
>> +	}
>> +	mad_agent_priv->agent.hi_tid =3D ib_mad_client_id;
>>=20
>> 	spin_lock_irqsave(&port_priv->reg_lock, flags);
>> -	mad_agent_priv->agent.hi_tid =3D
>> atomic_inc_return(&ib_mad_client_id);
>>=20
>> 	/*
>> 	 * Make sure MAD registration (if supplied)
>> @@ -428,6 +438,8 @@ struct ib_mad_agent *ib_register_mad_agent(struct
>> ib_device *device,
>> error5:
>> 	spin_unlock_irqrestore(&port_priv->reg_lock, flags);
>> 	ib_mad_agent_security_cleanup(&mad_agent_priv->agent);
>> +	ida_simple_remove(&ib_mad_client_ids, ib_mad_client_id);
>> +
>> error4:
>> 	kfree(reg_req);
>> error3:
>> @@ -576,6 +588,7 @@ static void unregister_mad_agent(struct
>> ib_mad_agent_private *mad_agent_priv)
>> {
>> 	struct ib_mad_port_private *port_priv;
>> 	unsigned long flags;
>> +	u32 ib_mad_client_id;
>>=20
>> 	/* Note that we could still be handling received MADs */
>>=20
>> @@ -587,6 +600,8 @@ static void unregister_mad_agent(struct
>> ib_mad_agent_private *mad_agent_priv)
>> 	port_priv =3D mad_agent_priv->qp_info->port_priv;
>> 	cancel_delayed_work(&mad_agent_priv->timed_work);
>>=20
>> +	ib_mad_client_id =3D mad_agent_priv->agent.hi_tid;
>> +
>> 	spin_lock_irqsave(&port_priv->reg_lock, flags);
>> 	remove_mad_reg_req(mad_agent_priv);
>> 	list_del(&mad_agent_priv->agent_list);
>> @@ -602,6 +617,7 @@ static void unregister_mad_agent(struct
>> ib_mad_agent_private *mad_agent_priv)
>>=20
>> 	kfree(mad_agent_priv->reg_req);
>> 	kfree(mad_agent_priv);
>> +	ida_simple_remove(&ib_mad_client_ids, ib_mad_client_id);
>> }
>>=20
>> static void unregister_mad_snoop(struct ib_mad_snoop_private
>> *mad_snoop_priv)
>> @@ -3347,4 +3363,5 @@ int ib_mad_init(void)
>> void ib_mad_cleanup(void)
>> {
>> 	ib_unregister_client(&mad_client);
>> +	ida_destroy(&ib_mad_client_ids);
>> }
>> --
>> 2.14.3
>=20
> =
N=C2=8B=C2=A7=C4=93=C3=A6=C4=97r=C4=BC=C2=9By=C3=BA=C4=8D=C2=9A=C3=98b=C4=93=
X=C5=BD=C4=B7=C4=AE=C2=A7v=C3=98^=C2=96)=C3=9E=C5=A1{.n=C4=AE+=C2=89=C2=B7=
=C4=A8=C2=8A{=C4=85=C2=AD=C5=B2=C2=9A=C2=8A{ay=C5=A1=1D=C4=98=C2=87=C3=9A=C2=
=99=C3=AB,j=07=C2=AD=C4=92f=C4=A2=C4=92=C2=B7h=C2=9A=C2=8B=C4=81z=C4=91=1E=
=C5=AAw=C4=A8=C4=92=C4=BC=0C=
=C4=92=C2=B7=C4=B6j:+v=C2=89=C4=BB=C2=8Aw=C4=8Dj=C3=98m=C4=B7=C2=9F=C4=B8=C5=
=AB=07=C5=A6=C2=91=C4=99=C4=AFzZ+=C2=83=C5=B3=C2=9A=C2=8E=C2=8A=C3=9D=C4=92=
j"=C2=9D=C3=BA!
