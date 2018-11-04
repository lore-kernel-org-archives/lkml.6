Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E821C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577842086C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="P+v44hbE";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="BV1Pz77E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 577842086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730641AbeKEC2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:28:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33366 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729529AbeKEC2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:28:13 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA4HAqLB021960
        for <linux-kernel@vger.kernel.org>; Sun, 4 Nov 2018 09:12:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=jAai9lQQAcoZHI1avhTQWE5MvqLOWnriqchDAcjAixc=;
 b=P+v44hbEIwwH2pXrX/tEkh6pDIBQAZCDlEEweW99usZnwdqqH1/7pGxZIhhkA2Hi3Fqu
 gCtDFZ5DoszKf/9/1MNO0C41LHmdUmj1lf26kqBTOzY9UoPm+wygl6oFKlwKxvliC0Lr
 NLjMAjKbxTz7Q4nTuBbGF9bK8HPKHsk8W5E= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nh9cdaq0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 09:12:34 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Sun, 4 Nov 2018 09:12:33 -0800
Received: from PRN-CHUB10.TheFacebook.com (2620:10d:c081:35::19) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Sun, 4 Nov 2018 09:12:33 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.20) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Sun, 4 Nov 2018 09:12:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAai9lQQAcoZHI1avhTQWE5MvqLOWnriqchDAcjAixc=;
 b=BV1Pz77E8hHFnsULDvRFJ2JI/5o8mlahQC5QYMBG5uQbdAW3rdAFlm5pIt30+3rVY7eQacdVczyTPyylFVBZLkYNqsQy1uTwbSWgYVYOWRH4+gh6kS0UHAkYKkVraC+KQqiPBxUwjrTHvrCpXpDdI38diztKfRAmCsZ5hfJ+pVE=
Received: from DM5PR15MB1883.namprd15.prod.outlook.com (10.174.247.135) by
 DM5PR15MB1948.namprd15.prod.outlook.com (10.173.215.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.27; Sun, 4 Nov 2018 17:12:31 +0000
Received: from DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::6023:3276:3d78:5943]) by DM5PR15MB1883.namprd15.prod.outlook.com
 ([fe80::6023:3276:3d78:5943%2]) with mapi id 15.20.1294.028; Sun, 4 Nov 2018
 17:12:31 +0000
From:   Chris Mason <clm@fb.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Thread-Topic: Linux Foundation Technical Advisory Board Elections -- Call for
 nominations
Thread-Index: AQHUdGGRTs3MvRmclk2gtFlxlBFfAw==
Date:   Sun, 4 Nov 2018 17:12:30 +0000
Message-ID: <340499F8-3113-4C8E-946B-3C33A1C4E3A7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: MailMate (1.10r5443)
x-clientproxiedby: BN6PR08CA0077.namprd08.prod.outlook.com
 (2603:10b6:404:b6::15) To DM5PR15MB1883.namprd15.prod.outlook.com
 (2603:10b6:4:4f::7)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c091:180::1:b60b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR15MB1948;20:eQye0GJ4jjIqDdZHZ4FxaJpvDmmD7Ixx3/Ez4WQKBgkpPDCP8kMNait9uYV2kKOjkZWvUjjwEZsftkX6B9hRU3GA0E8tuQgWlOvWaYIRtlXOfSFNjt0hYTBYTlFZ0NuzswhyTL+rg8AFRMSSw7bAUMvSOpWBnRS//1+kWJ7h0FU=
x-ms-office365-filtering-correlation-id: 797b73d2-b604-430c-47c8-08d64278b408
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM5PR15MB1948;
x-ms-traffictypediagnostic: DM5PR15MB1948:
x-microsoft-antispam-prvs: <DM5PR15MB1948952B6A8D473D4703D066D3C90@DM5PR15MB1948.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(148501403981450);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:DM5PR15MB1948;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1948;
x-forefront-prvs: 084674B2CF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(53754006)(36756003)(33656002)(5660300001)(68736007)(71200400001)(2906002)(83716004)(2900100001)(71190400001)(81156014)(50226002)(81166006)(25786009)(14454004)(46003)(486006)(6116002)(8936002)(14444005)(256004)(82746002)(316002)(102836004)(106356001)(7736002)(2616005)(6512007)(6306002)(6506007)(305945005)(386003)(6436002)(478600001)(105586002)(186003)(6486002)(99286004)(86362001)(8676002)(6916009)(966005)(52116002)(97736004)(53936002)(476003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1948;H:DM5PR15MB1883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VANhEE8E43AZdEPIjtN0dCFsJdv7IKvb0Ugb6AfkeggohVfvy8sbTFCJiP/QNARrc/DEiD5bZl8loxyOAYCcJ857OQQBoYnGcr/dURXsLKX2pSw9WJr562Rt+wZjcEuMb1KriHKO3DBNew0ZxN8uSs8ejWNkURHrBuwf008CQFnU0W43MzfyI1zVrtFT+bh+/HapDm/6FcWxtV/fomNqPGn6IbA0ituYGEOTOFPHK3xH10GcmG3bTkvhKe72xEM6DGQUE0tij2HN3iMCte1G77llxiBbhkZBPOIeM9HQNG4BN/ZME8njtSism1cBxnElI7vubIwBz/jZxEfy+CkeGIiSy00kgxD3n/zhP9/ngdA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 797b73d2-b604-430c-47c8-08d64278b408
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2018 17:12:30.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1948
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-04_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

Friendly reminder that the TAB elections are coming soon.

The Linux Foundation Technical Advisory Board (TAB) serves as the=20
interface between the kernel development community and the Linux=20
Foundation. The TAB advises the Foundation on kernel-related matters,=20
helps member companies learn to work with the community, and works to=20
resolve community-related problems before they get out of hand.  We're=20
also working with kernel maintainers to help refine the new code of=20
conduct, and serving as the initial point of contact for code of conduct=20
issues.

The board has ten members, one of whom sits on the Linux Foundation=20
board of directors.

The election to select five TAB members will be held at the 2018 Kernel=20
Summit in Vancouver, Canada.  The elections will take place at the=20
conference center on Tuesday November 13th, at 5:30pm.

The election will be open to all attendees of all of the Linux=20
Foundation events taking place that week in Vancouver.  Anyone is=20
eligible to stand for election, simply send your nomination to:

tech-board-discuss at lists.linux-foundation.org

The deadline for receiving nominations is up until the beginning of the=20
event where the election is held.

In past years, everyone running for the TAB has given a short speech=20
before the voting began.  We've received feedback that the speeches add=20
logistical complexity for the election, and may not be the best=20
indicator of how well qualified someone is for the TAB.

Instead of speeches, this year we're asking candidates to include=20
statements about why they would like to participate in the TAB.  These=20
will be combined into a slideshow running during the election, and=20
available via a public google doc at this location:

https://goo.gl/rPEc2v

Even though the deadline for nominations is right before voting begins,=20
any statements must be received by Monday November 12th at 5PM Pacific,=20
so that we have time to setup the slideshow.

Current TAB members, and their election year:

Chris Mason 2016
H. Peter Anvin 2016
Olof Johansson 2016
Rik van Riel	2016
Dan Williams 2016

Jon Corbet 2017
Greg Kroah-Hartman 2017
Steven Rostedt 2017
Ted Tso	2017
Tim Bird	2017

The five slots from 2016 are all up for election.  As always, please let=20
us know if you have questions, and please do consider running.

Chris Mason, TAB Chair

[1] TAB members sit for a term of two years, and half of the board is up
for election every year. Five of the seats are up for election now.
The other five are halfway through their term and will be up for
election next year.
