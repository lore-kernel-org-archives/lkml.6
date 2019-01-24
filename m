Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90992C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5033B218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="NCF1Z9Al";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="b0h2rQqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfAXAYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:24:43 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbfAXAYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:24:43 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O0N8W4009826;
        Wed, 23 Jan 2019 16:24:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vidOgNFzpWSv+2q4f4PnFnWhyhThSoFlN1OA92UuNRU=;
 b=NCF1Z9Alea0L9UgTKKDqQuHnGX4pUEBhYAMf7xZl5UEc3tnVKqk6/NReRIa7Xbtu6i9G
 RNKCrnktT/qivbr9yhiRXftUMzmwNJ0rFDBSv1234te/WAEgvbPobxCqp2j1/CbrBDWy
 dzljSdEUma7FRwuSZW+n6pt2ApPHO2ha74c= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q71r8r69x-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Jan 2019 16:24:28 -0800
Received: from prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 23 Jan 2019 16:24:07 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx04.TheFacebook.com (2620:10d:c081:6::18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 23 Jan 2019 16:24:07 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 23 Jan 2019 16:24:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vidOgNFzpWSv+2q4f4PnFnWhyhThSoFlN1OA92UuNRU=;
 b=b0h2rQqYrJvHVdJOPPGgE6Cqde3WaMgdenleTXPsAq/AZ2Opc1bvBzHHPzbdLrQ8j20qXH43E0mkYZmekFDhssJZLHPmxUc/52AENsjUxrq0iIKMrbtpHrgdJZ3t8X0keH4bTU4Fvw0GNm6MgJOJdoiTn2YK1HKb9uv3LFiG5gM=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3254.namprd15.prod.outlook.com (20.179.57.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 00:24:05 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a%6]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 00:24:05 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Chris Down <chris@chrisdown.name>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, Tejun Heo <tj@kernel.org>,
        Dennis Zhou <dennis@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH 2/2] mm: Consider subtrees in memory.events
Thread-Topic: [PATCH 2/2] mm: Consider subtrees in memory.events
Thread-Index: AQHUs2twErhpTuX9qUy7NeIZ9vJ8laW9j10A
Date:   Thu, 24 Jan 2019 00:24:05 +0000
Message-ID: <20190124002359.GB21563@castle.DHCP.thefacebook.com>
References: <20190123223144.GA10798@chrisdown.name>
In-Reply-To: <20190123223144.GA10798@chrisdown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0067.namprd14.prod.outlook.com
 (2603:10b6:300:81::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:223c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3254;20:JGmUogjNtekPKGlQ0YWWAu9moJIpPew77DftB3SsK2xxLJmZn7bR5Wo3NI6gp6XbiaO9BZrEQQ4bqikR5njzysa4yjRg+Jzk1A9RTfbT/oxcHHfBKUYECOgrSDpDGfBDs9bj/sYOS2b91DC28rNQEotYOkInbxN6h3/dwlG7Wzc=
x-ms-office365-filtering-correlation-id: 02ee00b0-85cd-4add-329f-08d681923f5a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3254;
x-ms-traffictypediagnostic: BYAPR15MB3254:
x-microsoft-antispam-prvs: <BYAPR15MB32547E78C666682D9CBBF3E4BE9A0@BYAPR15MB3254.namprd15.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(68736007)(14454004)(86362001)(106356001)(229853002)(6246003)(97736004)(33656002)(6116002)(4326008)(53936002)(25786009)(478600001)(76176011)(99286004)(316002)(52116002)(1076003)(54906003)(7736002)(8936002)(105586002)(81166006)(486006)(81156014)(8676002)(6916009)(71200400001)(33896004)(386003)(186003)(102836004)(6506007)(446003)(9686003)(6512007)(305945005)(6486002)(6436002)(2906002)(476003)(11346002)(46003)(256004)(71190400001)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3254;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0S4SOnll7dsgziQpDAJYpZYBZeODi06qY4bYDuV4s8rCfOjgQmRrXFA7eTyBTgUlJDgkPOTWsE+6Nk1llllg4fbwXPG58iGOSV12voGAchaJk9W2V84rQLBEBtdE1R9tKLr4D1OhGoW0Bf+K7ImhHWNzK/uRypH4hfWCX5KGI7c0cs2WV5rTnYtr+JnRe1gYTp8xK0BB/tmaVUFYz1xKRJPvoe+wuCcq8n+CHdXDDl+SDjTS6cmjKVFSQoS4Df3h9VF1Dkdrox8SPrQYud+Bf3xp5HCXwh/rKKW+JnDTEDSxgzUliAT7w+7CIlniaR48YUNVKZBIbwj/oo7PXI3ayuvof1Y2BdDMEwH++3+ClvJq8FQ8VAPDrgn6BGfw3EoKvAp3AS6teVC/4gt+x0i2S6537tKELo/3fPdnDrdhLtg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4EF58E70687BCD4598BE7A330F81C27C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ee00b0-85cd-4add-329f-08d681923f5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 00:24:03.8981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3254
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:31:44PM -0500, Chris Down wrote:
> memory.stat and other files already consider subtrees in their output,
> and we should too in order to not present an inconsistent interface.
>=20
> The current situation is fairly confusing, because people interacting
> with cgroups expect hierarchical behaviour in the vein of memory.stat,
> cgroup.events, and other files. For example, this causes confusion when
> debugging reclaim events under low, as currently these always read "0"
> at non-leaf memcg nodes, which frequently causes people to misdiagnose
> breach behaviour. The same confusion applies to other counters in this
> file when debugging issues.
>=20
> Aggregation is done at write time instead of at read-time since these
> counters aren't hot (unlike memory.stat which is per-page, so it does it
> at read time), and it makes sense to bundle this with the file
> notifications.

I agree with the consistency argument (matching cgroup.events, ...),
and it's definitely looks better for oom* events, but at the same time it f=
eels
like a API break.

Just for example, let's say you have a delegated sub-tree with memory.max
set. Earlier, getting memory.high/max event meant that the whole sub-tree
is tight on memory, and, for example, led to shutdown of some parts of the =
tree.
After your change, it might mean that some sub-cgroup has reached its limit=
,
and probably doesn't matter on the top level.

Maybe it's still ok, but we definitely need to document it better. It feels
bad that different versions of the kernel will handle it differently, so
the userspace has to workaround it to actually use these events.

Also, please, make sure that it doesn't break memcg kselftests.

>=20
> After this patch, events are propagated up the hierarchy:
>=20
>    [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
>    low 0
>    high 0
>    max 0
>    oom 0
>    oom_kill 0
>    [root@ktst ~]# systemd-run -p MemoryMax=3D1 true
>    Running as unit: run-r251162a189fb4562b9dabfdc9b0422f5.service
>    [root@ktst ~]# cat /sys/fs/cgroup/system.slice/memory.events
>    low 0
>    high 0
>    max 7
>    oom 1
>    oom_kill 1
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> To: Andrew Morton <akpm@linux-foundation.org>

s/To/CC

> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
> include/linux/memcontrol.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 380a212a8c52..5428b372def4 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -769,8 +769,10 @@ static inline void count_memcg_event_mm(struct mm_st=
ruct *mm,
> static inline void memcg_memory_event(struct mem_cgroup *memcg,
> 				      enum memcg_memory_event event)
> {
> -	atomic_long_inc(&memcg->memory_events[event]);
> -	cgroup_file_notify(&memcg->events_file);
> +	do {
> +		atomic_long_inc(&memcg->memory_events[event]);
> +		cgroup_file_notify(&memcg->events_file);
> +	} while ((memcg =3D parent_mem_cgroup(memcg)));

We don't have memory.events file for the root cgroup, so we can stop earlie=
r.

Thanks!
