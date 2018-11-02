Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3B0C6786F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03C0920666
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 03:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="VCahRdyI";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="UdegawIg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C0920666
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbeKBMWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 08:22:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45718 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726241AbeKBMWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 08:22:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA23EdTC017125;
        Thu, 1 Nov 2018 20:16:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=OE2AkAobv/9ovFhGzwjd/Vbob40G5abjw7z2HfEX/zc=;
 b=VCahRdyIeEdqHrebP7v+N0OdZ4u7GF4eRjrLsCqSZgyX1PSAlm3KVy0tTRJesUyKE8bU
 ffpVaV1S02rgDFnuNLMfR/+gKjboqf//5oFR4Y/WBLTUYGf4qF6bCRGvhuhn3W/g2Gry
 Qx5nVoEczC7jHmaVM7x2M6HiEGRrTBnlYCQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ngeerr0d4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 01 Nov 2018 20:16:16 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 1 Nov 2018 20:16:14 -0700
Received: from FRC-CHUB08.TheFacebook.com (2620:10d:c021:18::27) by
 frc-hub01.TheFacebook.com (2620:10d:c021:18::171) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Thu, 1 Nov 2018 20:16:14 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.28) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 1 Nov 2018 23:16:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE2AkAobv/9ovFhGzwjd/Vbob40G5abjw7z2HfEX/zc=;
 b=UdegawIg40IthOvbjebX+q1iAE+1lbbFRVhAHX4M9ufq3X0GzrhMNAHLk/jfWnOkoaa3/2gVchdgKG+9lLJvzH3mL9TL2uB+811zmW5Upx3F/9smjELjnMXu8MvbuDfsC6c14t0I1TzpAjEMR9ZZre/LKWBijFXnEKu7ln1zapI=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0808.namprd15.prod.outlook.com (10.164.171.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Fri, 2 Nov 2018 03:16:08 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Fri, 2 Nov 2018
 03:16:08 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Dexuan Cui <decui@microsoft.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "Shakeel Butt" <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Stable@vger.kernel.org" <Stable@vger.kernel.org>
Subject: Re: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Topic: Will the recent memory leak fixes be backported to longterm
 kernels?
Thread-Index: AdRyQEG5VIfdELkdR3eQ5BGm0rZVc///mGwAgACTWwCAAAh7gA==
Date:   Fri, 2 Nov 2018 03:16:08 +0000
Message-ID: <20181102031600.GA15013@castle.DHCP.thefacebook.com>
References: <PU1P153MB0169CB6382E0F047579D111DBFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
 <20181102005816.GA10297@tower.DHCP.thefacebook.com>
 <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <PU1P153MB0169FE681EF81BCE81B005A1BFCF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR21CA0047.namprd21.prod.outlook.com
 (2603:10b6:300:129::33) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:b6e9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0808;20:PMAWzcaVQFr/L7Zl8/cxGiYtHNPypdOjjYgXjDln578PNNKZ0zCKLRhuvfi3HN6Hg04B5FYrcz+jrqXRsPI18GawXPkKoKD5dZqGgMmjX0+r8f/zvHlPDsT26XR1dgESMBlV4C7zrGo7IDEGNnxt/N4k/Un7b8yRRXUvYeAu+hs=
x-ms-office365-filtering-correlation-id: dfabeb83-979d-409b-6de8-08d640718834
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0808;
x-ms-traffictypediagnostic: BY2PR15MB0808:
x-microsoft-antispam-prvs: <BY2PR15MB080868CD408F50AFB480BC43BECF0@BY2PR15MB0808.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(10201501046)(3231382)(11241501184)(944501410)(52105095)(3002001)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0808;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0808;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(136003)(346002)(376002)(366004)(51914003)(189003)(199004)(25786009)(14454004)(2900100001)(476003)(478600001)(4326008)(486006)(11346002)(6916009)(33896004)(6506007)(7416002)(102836004)(386003)(5660300001)(7736002)(6116002)(106356001)(71200400001)(52116002)(186003)(2906002)(68736007)(105586002)(71190400001)(8676002)(46003)(81156014)(8936002)(1511001)(81166006)(76176011)(1076002)(229853002)(446003)(5024004)(305945005)(14444005)(256004)(33656002)(9686003)(6246003)(316002)(39060400002)(99286004)(6486002)(86362001)(53936002)(6512007)(97736004)(6436002)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0808;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: x45As4mM1KtPrKVU62C+Qjv0Ew3q+2mnmZPtG8b4UY2K8S9ONWUVCQ8+gB4cc4pklHyq+nprGZ6lb9LZwNV3+02sbDppjMvYbNLRcdaavVWj65nT6bYTgB8jgmD8DKJuY+fFXJ+d7vpPmljTWepJB7v3UHL5x7yBMUDpMjCH2SF3k2/Pm2PUClmuIPB7Y+TguPI75XdETiqsP71SOrwlvzPvzzQ0stwRlDomtc7jnbc9hyV/nxsamL/7gX89xgmSnVNAWlbZdeXFyeNb1qhoyJ0oKeNogChm0e7WqK08Z1LxAtIgKeGwAAgCU5QH9WOXIo73qviiyRMXEIlRVTAD/yDCOcwu6+TBzCqDApKEP0U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8D6DDE4B74DB614E97CF0C7E6120702F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dfabeb83-979d-409b-6de8-08d640718834
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 03:16:08.5858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0808
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 02:45:42AM +0000, Dexuan Cui wrote:
> > From: Roman Gushchin <guro@fb.com>
> > Sent: Thursday, November 1, 2018 17:58
> >=20
> > On Fri, Nov 02, 2018 at 12:16:02AM +0000, Dexuan Cui wrote:
> > Hello, Dexuan!
> >=20
> > A couple of issues has been revealed recently, here are fixes
> > (hashes are from the next tree):
> >=20
> > 5f4b04528b5f mm: don't reclaim inodes with many attached pages
> > 5a03b371ad6a mm: handle no memcg case in memcg_kmem_charge()
> > properly
> >=20
> > These two patches should be added to the serie.
>=20
> Thanks for the new info!
> =20
> > Re stable backporting, I'd really wait for some time. Memory reclaim is=
 a
> > quite complex and fragile area, so even if patches are correct by thems=
elves,
> > they can easily cause a regression by revealing some other issues (as i=
t was
> > with the inode reclaim case).
>=20
> I totally agree. I'm now just wondering if there is any temporary workaro=
und,
> even if that means we have to run the kernel with some features disabled =
or
> with a suboptimal performance?

I don't think there is any, except not using memory cgroups at all.
Limiting the amount of cgroups which are created and destroyed helps too:
a faulty service running under systemd can be especially painful.

Thanks!
