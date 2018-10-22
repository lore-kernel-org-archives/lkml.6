Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7644A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="gghCcmMY";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ijknZn75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7644A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeJVX1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 19:27:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55747 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727763AbeJVX1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 19:27:36 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9MF0SDn022873;
        Mon, 22 Oct 2018 08:08:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YKgUOSolgCEn9OCVuOPMYov3Ps0Xp+w4mVHQyUqcS1c=;
 b=gghCcmMY1Ifc3X3Um3q/Dr4Nac4fa7QsVIMuuAqXgDo2CVkHK7kws9znNYDRRMZlIAFG
 gmqU50eBBm9MNO0POFfvAgSIPVIl1yoErxI5XVRLQfZesduqLw7oZZAccI5ZB2qVEmqi
 AImI3ZdqnK1X0CrGlJe3Uwun/SwbIenDRZs= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n9gfc04h0-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 22 Oct 2018 08:08:26 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 22 Oct 2018 08:08:25 -0700
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 22 Oct 2018 08:08:25 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 22 Oct 2018 11:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKgUOSolgCEn9OCVuOPMYov3Ps0Xp+w4mVHQyUqcS1c=;
 b=ijknZn75l3XYvaxWfCGm+iGXoTfSR/6Dp1qXzl4pntVidRoQ4q9zHgG9It36r3XYs4XQ1Z/Y1m8hKE1dt8Fc6rvWR/gw+uASSqISNjXFjlzuphn4+PlsN7DoK3inLo4nP+sThWhiFLz/eq8P1HY+W2halWCFJRQwGn7JHScgYII=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0791.namprd15.prod.outlook.com (10.164.171.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Mon, 22 Oct 2018 15:08:23 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Mon, 22 Oct 2018
 15:08:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Michal Hocko <mhocko@kernel.org>
CC:     Spock <dairinin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: Memory management issue in 4.18.15
Thread-Topic: Memory management issue in 4.18.15
Thread-Index: AQHUaeHkHk+DbEcbikCQiNZLx8ZaF6UrXl2A
Date:   Mon, 22 Oct 2018 15:08:22 +0000
Message-ID: <20181022150815.GA4287@tower.DHCP.thefacebook.com>
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
 <20181022083322.GE32333@dhcp22.suse.cz>
In-Reply-To: <20181022083322.GE32333@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0054.namprd12.prod.outlook.com
 (2603:10b6:300:103::16) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6:f889]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0791;20:c8Qk+1nmvb9qWamlsUnf/RXQxECtuiolgofiy+qIfancNhYJAuvkypwnzxdDLskgMbM1TaGH15T+QPBQJDpa7bA5JSI4lKu1SfiNdPKatPVU6XJV2DIVrkf671r8TMwJ5wSUMNEqx6PA407WYG6AiS05csZFXMd4psrR/0aolRA=
x-ms-office365-filtering-correlation-id: d0fa8820-411f-4bf3-51c1-08d638303557
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0791;
x-ms-traffictypediagnostic: BY2PR15MB0791:
x-microsoft-antispam-prvs: <BY2PR15MB079155B1A4CDB2D8B8EC4AC9BEF40@BY2PR15MB0791.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0791;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0791;
x-forefront-prvs: 08331F819E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(136003)(396003)(39860400002)(189003)(199004)(8936002)(7416002)(2900100001)(39060400002)(229853002)(99286004)(4326008)(81166006)(81156014)(25786009)(71190400001)(71200400001)(8676002)(106356001)(6486002)(105586002)(5250100002)(97736004)(33656002)(7736002)(305945005)(6436002)(9686003)(6916009)(6246003)(68736007)(478600001)(486006)(6506007)(386003)(186003)(476003)(2906002)(14454004)(46003)(446003)(11346002)(102836004)(6116002)(1076002)(5660300001)(53936002)(6512007)(54906003)(316002)(86362001)(256004)(52116002)(33896004)(76176011)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0791;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bCVpPbS9kR6oJYAPqI7i5Yw2PEChqmQYjjQmeJUnxayNT3jDlfB+tU4VvwCf5Y/P/dJP+8IxhhdXgnK9o+vHWVTqsvpZyFQfV23oduzlkOvLV9Tsj01IP8iE2o7gzJccMMWdMmUzO9TeLhhM9UEz8I58DzJNpUzcGugNBSnxOUOJEz7z9/c5pKw/dNXIE9kCcKpBjLK3QfUbmtI2bSuMiWS+ducsRsGxOHmrdrNN8TNbrbR4BnGP/d/yraTkt3u0BM7pe5osgXhWZXnBVd/eo6hu+NwoI36v02mLrpiQi3LVPhxL0OQma+Amwlz58pu/goZeTSNU1DixWR7h0rqQrS329DErNo7ohtAuWnny23E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <691E3861403A884F9C13E463795DDAC2@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fa8820-411f-4bf3-51c1-08d638303557
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2018 15:08:22.9629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0791
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 10:33:22AM +0200, Michal Hocko wrote:
> Cc som more people.
>=20
> I am wondering why 172b06c32b94 ("mm: slowly shrink slabs with a
> relatively small number of objects") has been backported to the stable
> tree when not marked that way. Put that aside it seems likely that the
> upstream kernel will have the same issue I suspect. Roman, could you
> have a look please?

Sure, already looking... Spock provided some useful details, and I think,
I know what's happening... Hope to propose a solution soon.

RE backporting: I'm slightly surprised that only one patch of the memcg
reclaim fix series has been backported. Either all or none makes much more
sense to me.

Thanks!
