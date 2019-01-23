Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA039C282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3A218A1
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 00:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XyhH6SK2";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="XqkR6Ejq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfAXAAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 19:00:21 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbfAXAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 19:00:20 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0NNo7iZ014441;
        Wed, 23 Jan 2019 16:00:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=/9t7OEFvsG0cSpEi+AXxSKwWnZCHSLbY3GJM2iPUcEc=;
 b=XyhH6SK28loqdEJA5sojB1Ek/ABezwOw84ERvmilVzwHGNfhOdJn1foR2Tbx00gEcjRI
 pVu+NZjDxKoOoiK+Iq6z5ZSPMfVOhBkWDZVRHlFHzhTai72PTUw1lSdQOZ2xClSaoEJ7
 49jD8WODFR3RgmH0wOFsEBB8SWYo4lm3g1Q= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2q714ng816-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Jan 2019 15:59:59 -0800
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 23 Jan 2019 15:59:49 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Wed, 23 Jan 2019 15:59:49 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1531.3
 via Frontend Transport; Wed, 23 Jan 2019 15:59:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9t7OEFvsG0cSpEi+AXxSKwWnZCHSLbY3GJM2iPUcEc=;
 b=XqkR6EjqDS9CGE2Pkptu4JQK5dViUt8lfNSMF5E7kCg2ocivLtbko2YJplItO5L7e9w6TxGjnGP+KtHDXU+TVy+LMRfhJYjWoaA3x/67pR+PSE4aQdeD6kte0MgCF4aryNhxORpeXjRr2Wd12MCCXg4+oZX7l2MQAjw0jLGiLb4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2197.namprd15.prod.outlook.com (52.135.196.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.17; Wed, 23 Jan 2019 23:59:48 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::7459:36fe:91f2:8b8a%6]) with mapi id 15.20.1558.016; Wed, 23 Jan 2019
 23:59:48 +0000
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
Subject: Re: [PATCH 1/2] mm: Rename ambiguously named memory.stat counters and
 functions
Thread-Topic: [PATCH 1/2] mm: Rename ambiguously named memory.stat counters
 and functions
Thread-Index: AQHUs2tO1mqCgldVPkGPF2YyEn0b6KW9iJSA
Date:   Wed, 23 Jan 2019 23:59:47 +0000
Message-ID: <20190123235940.GA21563@castle.DHCP.thefacebook.com>
References: <20190123223049.GA9149@chrisdown.name>
In-Reply-To: <20190123223049.GA9149@chrisdown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0088.namprd04.prod.outlook.com
 (2603:10b6:301:3a::29) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:223c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2197;20:iypRO7eykWnvnFdQPq7nGpV4o9ME1sUCzKHBnBoskY0MNy4exsEjruvlm8zqgGuxkqvhVrtOhLlMx2g4dPtp4vUWs72aL/1wjH071ZszvXZQoZJsFiTLQjrmQwwWMzlxx6no2gZNV3fSYYp4R8+kfPwPgjOi4bXStKe7fbgQL14=
x-ms-office365-filtering-correlation-id: 66df31dd-cdc1-40a3-e3da-08d6818edae1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2197;
x-ms-traffictypediagnostic: BYAPR15MB2197:
x-microsoft-antispam-prvs: <BYAPR15MB21979E59FA3BE50749B69816BE990@BYAPR15MB2197.namprd15.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(376002)(366004)(346002)(199004)(189003)(486006)(386003)(81156014)(14454004)(446003)(52116002)(81166006)(11346002)(8676002)(33656002)(8936002)(46003)(476003)(229853002)(102836004)(54906003)(33896004)(186003)(6116002)(256004)(105586002)(106356001)(76176011)(6506007)(478600001)(99286004)(6436002)(6486002)(6246003)(53936002)(25786009)(6916009)(71200400001)(71190400001)(7736002)(9686003)(68736007)(2906002)(97736004)(1076003)(316002)(6512007)(86362001)(305945005)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2197;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6HXRxx0tOtzuOSikFlZvlhrtWU1m+N26b1Gn9b9vWyA6mZE+oxByqWHRWeEFPx3zKG1YjBDZWLmrjfFGUlKQOyxhkAViVc8rIBiM0HfJhMfVL/HlvX5bR0cFg7rgqndePpS6ZCSAVxFTwq1L7Q/NyLk1oVomfQwcCQJsHQjdIe35G/5B/iMDCG+iVl7pxa8Tf/EV2+a31xMgio66L7HY+w56BWbDdHqKXb5msRsrcnI8j67FxCOUpVUxXUz8HD6j5MVxXR+zrXgmYo2+WVaFR8G3PACtOpYrcrn4JskZcVu+ymA/GXXGf4kGvHeOm7dOrNoROIKPTPmf8K3TL40jg55olAcmNACyXM3cNTpTOYNRI0FhMGdLOLMUHVXxLXGb+NigN0ttFX8sxHzlgqfCPJRKrzoqxE/I2zrhMm+timw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2982AC1C3D33348A4FC8F9CC8E0A110@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 66df31dd-cdc1-40a3-e3da-08d6818edae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 23:59:46.8363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2197
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-23_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 05:30:49PM -0500, Chris Down wrote:
> I spent literally an hour trying to work out why an earlier version of
> my memory.events aggregation code doesn't work properly, only to find
> out I was calling memcg->events instead of memcg->memory_events, which
> is fairly confusing.
>=20
> This naming seems in need of reworking, so make it harder to do the
> wrong thing by using vmevents instead of events, which makes it more
> clear that these are vm counters rather than memcg-specific counters.
>=20
> There are also a few other inconsistent names in both the percpu and
> aggregated structs, so these are all cleaned up to be more coherent and
> easy to understand.
>=20
> This commit contains code cleanup only: there are no logic changes.
>=20
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> To: Andrew Morton <akpm@linux-foundation.org>

s/To/Cc

> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Dennis Zhou <dennis@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: cgroups@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: kernel-team@fb.com
> ---
> include/linux/memcontrol.h |  24 +++----
> mm/memcontrol.c            | 137 +++++++++++++++++++------------------
> 2 files changed, 82 insertions(+), 79 deletions(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index b0eb29ea0d9c..380a212a8c52 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -94,8 +94,8 @@ enum mem_cgroup_events_target {
> 	MEM_CGROUP_NTARGETS,
> };
>=20
> -struct mem_cgroup_stat_cpu {
> -	long count[MEMCG_NR_STAT];
> +struct memcg_vmstats_percpu {
> +	long stat[MEMCG_NR_STAT];

I'd personally go with memcg_vmstat_percpu. Not insisting,
but you end up using both vmstat and vmstats, which isn't very
consistent.

Other than that looks good to me. Please, feel free to add
Acked-by: Roman Gushchin <guro@fb.com>

Thanks!
