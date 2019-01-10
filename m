Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB33214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iWBIZLBr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfAJMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:00:29 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:40076 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfAJMA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:00:29 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0ABwwSg122111;
        Thu, 10 Jan 2019 12:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=GWqeNjykrBmumfAFDBHANaR0ima2Sl2zZcSGnQ8ONmU=;
 b=iWBIZLBrhCrsOI7OYtbwW0Q5u7cRK4J3NxFAqOyKhxu2kQ7LOom/dUKecOT6MrWRKPcc
 UscqFxl27UtYao3lDLj7Qp45tnS4H042+fGy2rbi0HI1R48897Uo6VXVx96qQz6vRkdE
 vQjuGdaqY95LgLM4lhONOa8Kybn6qTimdnaJpB0lhVlzh9e1QfYdQ10w1ZFBzjFE0deu
 byHVSpbtXoqnCyO7UMYBz9gUfa+WHU3LLMrDC+GJj9fEegvPvnlPVvUDRfITCsCrP70N
 jGKWoSAaM4fGoAilow0YSMQyTARtWyylFeTeTeYykUc0Q2wes6vSN5R2plysBvqORW9L qg== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2ptn7r6m8v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:00:17 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0AC0GxX024006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Jan 2019 12:00:16 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x0AC0Ee1029162;
        Thu, 10 Jan 2019 12:00:15 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Jan 2019 04:00:14 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [v3 PATCH 5/5] doc: memcontrol: add description for
 wipe_on_offline
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <1547061285-100329-6-git-send-email-yang.shi@linux.alibaba.com>
Date:   Thu, 10 Jan 2019 05:00:13 -0700
Cc:     Michal Hocko <mhocko@suse.com>, hannes@cmpxchg.org,
        shakeelb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0746F690-2C0C-4041-842A-19CEB28A5E45@oracle.com>
References: <1547061285-100329-1-git-send-email-yang.shi@linux.alibaba.com>
 <1547061285-100329-6-git-send-email-yang.shi@linux.alibaba.com>
To:     Yang Shi <yang.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9131 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901100099
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few grammar corrections since this is going into Documentation:


> On Jan 9, 2019, at 12:14 PM, Yang Shi <yang.shi@linux.alibaba.com> =
wrote:
>=20
> Add desprition of wipe_on_offline interface in cgroup documents.
Add a description of the wipe_on_offline interface to the cgroup =
documents.

> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> Documentation/admin-guide/cgroup-v2.rst |  9 +++++++++
> Documentation/cgroup-v1/memory.txt      | 10 ++++++++++
> 2 files changed, 19 insertions(+)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst =
b/Documentation/admin-guide/cgroup-v2.rst
> index 0290c65..e4ef08c 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -1303,6 +1303,15 @@ PAGE_SIZE multiple when read back.
>         memory pressure happens. If you want to avoid that, =
force_empty will be
>         useful.
>=20
> +  memory.wipe_on_offline
> +
> +        This is similar to force_empty, but it just does memory =
reclaim
> +        asynchronously in css offline kworker.
> +
> +        Writing into 1 will enable it, disable it by writing into 0.
Writing a 1 will enable it; writing a 0 will disable it.

> +
> +        It would reclaim as much as possible memory just as what =
force_empty does.
It will reclaim as much memory as possible, just as force_empty does.

> +
>=20
> Usage Guidelines
> ~~~~~~~~~~~~~~~~
> diff --git a/Documentation/cgroup-v1/memory.txt =
b/Documentation/cgroup-v1/memory.txt
> index 8e2cb1d..1c6e1ca 100644
> --- a/Documentation/cgroup-v1/memory.txt
> +++ b/Documentation/cgroup-v1/memory.txt
> @@ -71,6 +71,7 @@ Brief summary of control files.
>  memory.stat			 # show various statistics
>  memory.use_hierarchy		 # set/show hierarchical account enabled
>  memory.force_empty		 # trigger forced page reclaim
> + memory.wipe_on_offline		 # trigger forced page reclaim =
when offlining
>  memory.pressure_level		 # set memory pressure =
notifications
>  memory.swappiness		 # set/show swappiness parameter of =
vmscan
> 				 (See sysctl's vm.swappiness)
> @@ -581,6 +582,15 @@ hierarchical_<counter>=3D<counter pages> N0=3D<node=
 0 pages> N1=3D<node 1 pages> ...
>=20
> The "total" count is sum of file + anon + unevictable.
>=20
> +5.7 wipe_on_offline
> +
> +This is similar to force_empty, but it just does memory reclaim =
asynchronously
> +in css offline kworker.
> +
> +Writing into 1 will enable it, disable it by writing into 0.
Writing a 1 will enable it; writing a 0 will disable it.

> +
> +It would reclaim as much as possible memory just as what force_empty =
does.
It will reclaim as much memory as possible, just as force_empty does.

> +
> 6. Hierarchy support
>=20
> The memory controller supports a deep hierarchy and hierarchical =
accounting.
> --=20
> 1.8.3.1
>=20

