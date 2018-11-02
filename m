Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,T_DKIMWL_WL_MED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F765C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2FB2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 16:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="TntE+tD1";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="MXxkE6r8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2FB2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbeKCBay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:30:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47074 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726085AbeKCBay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:30:54 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA2GHIYC012656;
        Fri, 2 Nov 2018 09:22:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=kPknhUpqM9yPHryuRHF/BESVZM8Vteq7yw7Gr+UlssI=;
 b=TntE+tD1Lm1GehAQwbF3Z/dXLDyiGA79TBBy8192NzkP77IGWm5hkruiFErmxVJ6KAa/
 2XcSSss7S9RiHhnidrzGHsSjLKDN17FaW5+v7cyLgSIR1k8arPqJSbIaBPSu/6VkeRSQ
 q/Ini+Z4bn+zguNPEyUgFr2eMzWcqZ3zFpM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2ngnpyrsqf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 02 Nov 2018 09:22:47 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 2 Nov 2018 09:22:47 -0700
Received: from FRC-CHUB12.TheFacebook.com (2620:10d:c021:18::31) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 2 Nov 2018 09:22:47 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.32) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 2 Nov 2018 12:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPknhUpqM9yPHryuRHF/BESVZM8Vteq7yw7Gr+UlssI=;
 b=MXxkE6r8yfpE83ynb48+Hnxn/Wz1FAFsNijTpnh8fkhVyz8xBxwvQwi3lJZGHkMdM6IqwDYDJnxS2H+XZIn0XtyePPwiG+fPHVfs0FPYWFB2BhKShjkKX7hdwfwkyhJbnKLh/SaC8wFyvO3+qHfHy55A7imgwDgcFHioEIttWqI=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0741.namprd15.prod.outlook.com (10.164.170.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.20; Fri, 2 Nov 2018 16:22:42 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.030; Fri, 2 Nov 2018
 16:22:42 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Dexuan Cui <decui@microsoft.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAFjogIAADIgAgAB8LwCAAAKfgA==
Date:   Fri, 2 Nov 2018 16:22:41 +0000
Message-ID: <20181102162237.GB17619@tower.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102073009.GP23921@dhcp22.suse.cz>
 <20181102154844.GA17619@tower.DHCP.thefacebook.com>
 <20181102161314.GF28039@dhcp22.suse.cz>
In-Reply-To: <20181102161314.GF28039@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1301CA0013.namprd13.prod.outlook.com
 (2603:10b6:301:29::26) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::4:b8f1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0741;20:BVXEDdJLcCI6Z7AUrlChu4050yrNg4N91cKAfhOBIA7FdyONFTzLAiSWsTGlQwakHWf/bfMV3N3wQvJzdvqSN5yF+N84+RZ+qvoSdQO/Qi7KYkYEnAl1yyTgObVM1RecvFdk18SoA/bvo2GCUPOXxIMpiWCg2XMBYA/xJkrGpG4=
x-ms-office365-filtering-correlation-id: 04424261-4bd8-4079-4966-08d640df6990
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0741;
x-ms-traffictypediagnostic: BY2PR15MB0741:
x-microsoft-antispam-prvs: <BY2PR15MB07412D36FD348B0F1BC00FBFBECF0@BY2PR15MB0741.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(3231382)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0741;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0741;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(39860400002)(396003)(366004)(189003)(199004)(14444005)(99286004)(76176011)(6486002)(5660300001)(478600001)(33656002)(14454004)(6506007)(386003)(33896004)(68736007)(6436002)(102836004)(25786009)(52116002)(4326008)(6246003)(186003)(486006)(106356001)(446003)(105586002)(39060400002)(11346002)(476003)(81166006)(97736004)(46003)(8676002)(81156014)(316002)(1076002)(2906002)(54906003)(6116002)(256004)(2900100001)(305945005)(7736002)(9686003)(229853002)(6512007)(86362001)(93886005)(6916009)(7416002)(8936002)(71200400001)(53936002)(71190400001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0741;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ro/ryAuvIHhAq4LnAAufbcUKAFleJzTIsAgGjztwpGbp8Bbp0P9S2/TIXSXed+O5FgNGyryO5FIQfvD83Hb8c7GBSVSZLiljz/eHF2I3+PITzFblfHnAsNPQxBNxhdaUAg04wqFzc+lu7GAjpxuGsnAVPND9shiO4/YESrWqs8Lc8YTgYem5Sa6ym88e4WPuspdM6wnV29FzXVogOeJ3YnXsAPXXJX/1aVlXv4RYMa1TicJenGxou4EDFeuLdR6Uz+fK8EwYoMsqbqdzvqubiRw6yq5JNnC6/VuVscEN4Pk2Cyr5BJHnRn9Fhs0ArCvPzRt1LqxKRhGfaXXOzsnMqwqA+iF9KpJGiiefJROgCzE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8E3D8C511A8DFD479C3FB43838995FC2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 04424261-4bd8-4079-4966-08d640df6990
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 16:22:41.8087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0741
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 05:13:14PM +0100, Michal Hocko wrote:
> On Fri 02-11-18 15:48:57, Roman Gushchin wrote:
> > On Fri, Nov 02, 2018 at 09:03:55AM +0100, Michal Hocko wrote:
> > > On Fri 02-11-18 02:45:42, Dexuan Cui wrote:
> > > [...]
> > > > I totally agree. I'm now just wondering if there is any temporary w=
orkaround,
> > > > even if that means we have to run the kernel with some features dis=
abled or
> > > > with a suboptimal performance?
> > >=20
> > > One way would be to disable kmem accounting (cgroup.memory=3Dnokmem k=
ernel
> > > option). That would reduce the memory isolation because quite a lot o=
f
> > > memory will not be accounted for but the primary source of in-flight =
and
> > > hard to reclaim memory will be gone.
> >=20
> > In my experience disabling the kmem accounting doesn't really solve the=
 issue
> > (without patches), but can lower the rate of the leak.
>=20
> This is unexpected. 90cbc2508827e was introduced to address offline
> memcgs to be reclaim even when they are small. But maybe you mean that
> we still leak in an absence of the memory pressure. Or what does prevent
> memcg from going down?

There are 3 independent issues which are contributing to this leak:
1) Kernel stack accounting weirdness: processes can reuse stack accounted t=
o
different cgroups. So basically any running process can take a reference to=
 any
cgroup.
2) We do forget to scan the last page in the LRU list. So if we ended up wi=
th
1-page long LRU, it can stay there basically forever.
3) We don't apply enough pressure on slab objects.

Because one reference is enough to keep the entire memcg structure in place=
,
we really have to close all three to eliminate the leak. Disabling kmem
accounting mitigates only the last one.

>=20
> > > Another workaround could be to use force_empty knob we have in v1 and
> > > use it when removing a cgroup. We do not have it in cgroup v2 though.
> > > The file hasn't been added to v2 because we didn't really have any
> > > proper usecase. Working around a bug doesn't sound like a _proper_
> > > usecase but I can imagine workloads that bring a lot of metadata obje=
cts
> > > that are not really interesting for later use so something like a
> > > targeted drop_caches...
> >=20
> > This can help a bit too, but even using the system-wide drop_caches kno=
b
> > unfortunately doesn't return all the memory back.
>=20
> Could you be more specific please?

Sure, because problems 1) and 2) exist, echo 3 > /proc/sys/vm/drop_caches c=
an't
reclaim all memcg structures in most cases.

Thanks!
