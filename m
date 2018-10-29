Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F71DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00EB42080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 21:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="JPpwsNFO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Pm5IpJFx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00EB42080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJ3Gk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 02:40:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53012 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727427AbeJ3Gk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 02:40:26 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9TLnhka024481;
        Mon, 29 Oct 2018 14:49:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YOLyWWdifRMtsgMZoDEFYUgukWA8W4ZWuDzTSoh9CWo=;
 b=JPpwsNFOqTKgR4zDSJdK0XDi9Q8Go95LjNdmbt/P2DT8OE55P9Yah4CQXFs7LDO2nB43
 oDE+0w/JJw7pOpOqFs13EJwZZGFO1o3zGZ8Ejy3hU2sDw0qM/GfUiEEDkLRy5ST5Ch+W
 TCHk8jmkRfBqBrSPNMYdxdHkERg6CKdgkSc= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ne72y8p7s-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 29 Oct 2018 14:49:46 -0700
Received: from frc-hub04.TheFacebook.com (2620:10d:c021:18::174) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 29 Oct 2018 14:49:19 -0700
Received: from FRC-CHUB05.TheFacebook.com (2620:10d:c021:18::24) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 29 Oct 2018 14:49:19 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.25) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 29 Oct 2018 17:49:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOLyWWdifRMtsgMZoDEFYUgukWA8W4ZWuDzTSoh9CWo=;
 b=Pm5IpJFxgVo1TjBMEMEHk0NBPWYyC+OrM036f8vBVH7KZqJEL72ueIUPzIodRGaO29m+47nsZoLnsRRi82lQMX4J4HpBnA0sjBvDcwv2FPDpynr9wHzgMRhiC8Ws2lR4QlJqkOgny1IH6FhOv9k0CKgDB6V7l/0SY2xggCgNmwk=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0503.namprd15.prod.outlook.com (10.163.110.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.21; Mon, 29 Oct 2018 21:49:17 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1273.027; Mon, 29 Oct 2018
 21:49:17 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Mike Galbraith <efault@gmx.de>
CC:     Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>
Subject: Re: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Topic: memcg oops:
 memcg_kmem_charge_memcg()->try_charge()->page_counter_try_charge()->BOOM
Thread-Index: AQHUb0zSAmWtK7c9EUKkZgGOS7uZCqU2NcCAgAA2fwD//7FgAIAAlNQAgAARagA=
Date:   Mon, 29 Oct 2018 21:49:16 +0000
Message-ID: <20181029214913.GB13325@tower.DHCP.thefacebook.com>
References: <1540792855.22373.34.camel@gmx.de>
 <20181029132035.GI32673@dhcp22.suse.cz> <1540830938.10478.4.camel@gmx.de>
 <20181029185412.GA15760@tower.DHCP.thefacebook.com>
 <1540846014.4434.10.camel@gmx.de>
In-Reply-To: <1540846014.4434.10.camel@gmx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:300:13d::15) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::7:ad5c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0503;20:U+y6OxLnGTGlUpk9Mrzg8RyGKsqKxBNctxbph8p9Ozdr6cJCMiRNbkBLVQ6OZVG/cFyDAYjLfg7CM/HYwjWzXVa0YZyvqKoPmaMrPtWl2A45NwXvxY8/aSjETtoJQs7FwLUvdgIr2UpLAwsbq6pLO+t3zvft20ZrDCakUYkPGhs=
x-ms-office365-filtering-correlation-id: a1c57852-18be-4347-b7a2-08d63de85fa0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0503;
x-ms-traffictypediagnostic: BY2PR15MB0503:
x-microsoft-antispam-prvs: <BY2PR15MB0503C2E882C0AF5CFBC60607BEF30@BY2PR15MB0503.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0503;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0503;
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(376002)(396003)(189003)(199004)(8676002)(97736004)(4001150100001)(1076002)(6486002)(76176011)(6436002)(386003)(6506007)(33896004)(229853002)(33656002)(8936002)(53936002)(81156014)(6916009)(102836004)(6246003)(5250100002)(6512007)(39060400002)(9686003)(4326008)(256004)(2906002)(54906003)(71200400001)(71190400001)(478600001)(81166006)(93886005)(6116002)(316002)(25786009)(52116002)(11346002)(14454004)(7736002)(5660300001)(186003)(345774005)(46003)(486006)(2900100001)(305945005)(86362001)(476003)(106356001)(105586002)(68736007)(99286004)(446003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0503;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: gxzaipNnr5vyY4dcsIo34KRrVw70oCBWRFRWiT8lVUu9FAAIrJ3ksNSYk0Njwa8Tp5yh9X+6K3WOPelUt4UO5aQgWBuO2X+78zhy0tVdy9NaKNvUv7uSrF7ppxQkxWXdKXd9LUQjkFckhyEEkXxLlbA9bLniMpykWfigw/gH6BhUtOvoYsQpXPslKY2SYzzRtylCqV17Dx5bji3h6bY0vZvsQxNR/K1PKZcEDoB3+6Dk6iDO05u0ZhGRyO4jKhxfj+68UkgWCkME0EWpgkm1L/r9E5vkezCKrKGjZAztK/Q3Nm1Ffdc3ZQipLHjW234/D2bFtIYYrCSiovYRMxb8W8FcMvpEYpvJzMBsG+axNbQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <990D357981488C4FACC61A95FF6457E0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a1c57852-18be-4347-b7a2-08d63de85fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2018 21:49:16.9642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-29_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 09:46:54PM +0100, Mike Galbraith wrote:
> On Mon, 2018-10-29 at 18:54 +0000, Roman Gushchin wrote:
> >=20
> > Hi Mike!
> >=20
> > Thank you for the report!
> >=20
> > Do you see it reliable every time you boot up the machine?
>=20
> Yeah.
>=20
> > How do you run kvm?
>=20
> My VMs are full SW/data clones of my i7-4790/openSUSE <release> box.
>=20
> >  Is there something special about your cgroup setup?
>=20
> No, I generally have no use for cgroups.
>=20
> > I've made several attempts to reproduce the issue, but haven't got anyt=
hing
> > so far. I've used your config, and played with different cgroups setups=
.
>=20
> Ah, I have cgroup_disable=3Dmemory on the command line, which turns out
> to be why your box doesn't explode, while mine does.

Yeah, here it is. I'll send the fix in few minutes. Please,
test it on your setup. Your tested-by will be appreciated.

Thanks!
