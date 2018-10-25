Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9F8ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D982054F
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 20:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="nkZvsiW9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="hxagEK68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D982054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJZFI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 01:08:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbeJZFI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 01:08:28 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9PKWxZl024030;
        Thu, 25 Oct 2018 13:33:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WzfFVE8/6KQBv87Je5TWLM6YTEzhbNZWop1CpBY2T1E=;
 b=nkZvsiW9Wu2XhTPv+8g3swGZaC7/vCm0k8pyRqkWZRx+fZswsvtjJwEqTTUG7z3IwqAi
 0QkSsEFKAkpM5efFsjkSjodExqk4aYRE/e2wEHwwnTl7MM3B1VmiEKZeN2AAGE74yjO1
 3svbCB9fgf8YCMPobv859W0YZ/t/cOjQuiY= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nbjhvres7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Oct 2018 13:33:44 -0700
Received: from frc-hub02.TheFacebook.com (2620:10d:c021:18::172) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Thu, 25 Oct 2018 13:33:09 -0700
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub02.TheFacebook.com (2620:10d:c021:18::172) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Thu, 25 Oct 2018 13:33:09 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Thu, 25 Oct 2018 16:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzfFVE8/6KQBv87Je5TWLM6YTEzhbNZWop1CpBY2T1E=;
 b=hxagEK683IOa8xRiG1a4c8/XLFPwEuXE0TKJ9J0EbyUFekQ0oX6kvkNnceNVOEzaM73oQz4y44a9XTITDCx+RSvSkAXT8GBk6exkOfDPkBahNScOw6PWwI50i70rkYsynBbPxzPCPjQto6EqPmphTIiFDjjQGoHqKqMoCsgqd/0=
Received: from BY2PR15MB0167.namprd15.prod.outlook.com (10.163.64.141) by
 BY2PR15MB0792.namprd15.prod.outlook.com (10.164.171.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.30; Thu, 25 Oct 2018 20:32:48 +0000
Received: from BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14]) by BY2PR15MB0167.namprd15.prod.outlook.com
 ([fe80::8e8:753:f746:ed14%2]) with mapi id 15.20.1250.028; Thu, 25 Oct 2018
 20:32:48 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Rik van Riel <riel@surriel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: Re: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Topic: [RFC PATCH] mm: don't reclaim inodes with many attached pages
Thread-Index: AQHUau+GsFRIu7vNQ0mBGnFYa9WgU6Uu+XwAgAC5iACAAK11AIAACe4AgAADfYA=
Date:   Thu, 25 Oct 2018 20:32:47 +0000
Message-ID: <20181025203240.GA2504@tower.DHCP.thefacebook.com>
References: <20181023164302.20436-1-guro@fb.com>
 <20181024151950.36fe2c41957d807756f587ca@linux-foundation.org>
 <20181025092352.GP18839@dhcp22.suse.cz>
 <20181025124442.5513d282273786369bbb7460@linux-foundation.org>
 <20181025202014.GA216405@sasha-vm>
In-Reply-To: <20181025202014.GA216405@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0063.namprd02.prod.outlook.com
 (2603:10b6:301:73::40) To BY2PR15MB0167.namprd15.prod.outlook.com
 (2a01:111:e400:58e0::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:5482]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR15MB0792;20:0KZTFxDHVe3D7EYSoTeP3q9DhODSxpuh/c4wiNbGkmP/r6JJGWkL7qBfK5Xw40oQg4UmpWJqhMfWtBWSXNYDE4N+nznaT7J7PdELWtq3DOsBdrKXBWsMmo0O663SDLG5ma2cT4umqfzx4hpiw0xoGHqM/VLaGZAXgtvzwAWGeHU=
x-ms-office365-filtering-correlation-id: d57f014d-265c-4bb1-17a4-08d63ab906aa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BY2PR15MB0792;
x-ms-traffictypediagnostic: BY2PR15MB0792:
x-microsoft-antispam-prvs: <BY2PR15MB0792E98DEDC338D265FC2A1EBEF70@BY2PR15MB0792.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823302103)(93006095)(93001095)(10201501046)(3002001)(3231355)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:BY2PR15MB0792;BCL:0;PCL:0;RULEID:;SRVR:BY2PR15MB0792;
x-forefront-prvs: 083691450C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(396003)(346002)(39860400002)(376002)(199004)(43544003)(189003)(5660300001)(99286004)(86362001)(6506007)(52116002)(2906002)(81166006)(478600001)(6486002)(76176011)(6436002)(9686003)(6512007)(53936002)(8936002)(33896004)(186003)(256004)(446003)(386003)(71200400001)(14454004)(476003)(11346002)(46003)(71190400001)(81156014)(6916009)(6116002)(54906003)(5024004)(8676002)(102836004)(1076002)(25786009)(68736007)(316002)(7736002)(97736004)(6246003)(5250100002)(486006)(33656002)(93886005)(4326008)(305945005)(2900100001)(106356001)(229853002)(105586002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR15MB0792;H:BY2PR15MB0167.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fsldGJb8xmEQBUMnL8pf8EWrl0ikNPN1a4WAmPT8yw8prQr/ag0dCjNSKUxXDjicnMTj7NihrQNnKifybRcGJcGUgKgXiVSyVUv4tD4PPC2bV1kKbv3IVkGQoCwhPei/r43wMWtwPjQIYP9WgJbiaO5NxpMnJjsB5nng8JAapKMQn9F1jaQMn72vWaPkRxdq7Y2sROpLjnrdlHyj20Q3EXIKantjFjDlhyTOjORhQeSQkfrzsVtNu1fjKl2QYLXTdflyRpNOWrU9AK/N7M3NnvQT+2eyf3ol+8LX0wuVa5BtFkCq8HefndmyWZ/YCP6zOCBngM0FRVCocAE2EMODFjbF7St5tLBa/UVoth+GfuY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AE2CA4FCA1F3B04C9616EB5070C6A232@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d57f014d-265c-4bb1-17a4-08d63ab906aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2018 20:32:47.9987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR15MB0792
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-25_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 04:20:14PM -0400, Sasha Levin wrote:
> On Thu, Oct 25, 2018 at 12:44:42PM -0700, Andrew Morton wrote:
> > On Thu, 25 Oct 2018 11:23:52 +0200 Michal Hocko <mhocko@kernel.org> wro=
te:
> >=20
> > > On Wed 24-10-18 15:19:50, Andrew Morton wrote:
> > > > On Tue, 23 Oct 2018 16:43:29 +0000 Roman Gushchin <guro@fb.com> wro=
te:
> > > >
> > > > > Spock reported that the commit 172b06c32b94 ("mm: slowly shrink s=
labs
> > > > > with a relatively small number of objects") leads to a regression=
 on
> > > > > his setup: periodically the majority of the pagecache is evicted
> > > > > without an obvious reason, while before the change the amount of =
free
> > > > > memory was balancing around the watermark.
> > > > >
> > > > > The reason behind is that the mentioned above change created some
> > > > > minimal background pressure on the inode cache. The problem is th=
at
> > > > > if an inode is considered to be reclaimed, all belonging pagecach=
e
> > > > > page are stripped, no matter how many of them are there. So, if a=
 huge
> > > > > multi-gigabyte file is cached in the memory, and the goal is to
> > > > > reclaim only few slab objects (unused inodes), we still can event=
ually
> > > > > evict all gigabytes of the pagecache at once.
> > > > >
> > > > > The workload described by Spock has few large non-mapped files in=
 the
> > > > > pagecache, so it's especially noticeable.
> > > > >
> > > > > To solve the problem let's postpone the reclaim of inodes, which =
have
> > > > > more than 1 attached page. Let's wait until the pagecache pages w=
ill
> > > > > be evicted naturally by scanning the corresponding LRU lists, and=
 only
> > > > > then reclaim the inode structure.
> > > >
> > > > Is this regression serious enough to warrant fixing 4.19.1?
> > >=20
> > > Let's not forget about stable tree(s) which backported 172b06c32b94. =
I
> > > would suggest reverting there.
> >=20
> > Yup.  Sasha, can you please take care of this?
>=20
> Sure, I'll revert it from current stable trees.
>=20
> Should 172b06c32b94 and this commit be backported once Roman confirms
> the issue is fixed? As far as I understand 172b06c32b94 addressed an
> issue FB were seeing in their fleet and needed to be fixed.

The memcg leak was also independently reported by several companies,
so it's not only about our fleet.

The memcg css leak is fixed by a series of commits (as in the mm tree):
  37e521912118 math64: prevent double calculation of DIV64_U64_ROUND_UP() a=
rguments
  c6be4e82b1b3 mm: don't miss the last page because of round-off error
  f2e821fc8c63 mm: drain memcg stocks on css offlining
  03a971b56f18 mm: rework memcg kernel stack accounting
  172b06c32b94 mm: slowly shrink slabs with a relatively small number of ob=
jects

The last one by itself isn't enough, and it makes no sense to backport it
without all other patches. So, I'd either backport them all (including
47036ad4032e ("mm: don't reclaim inodes with many attached pages"),
either just revert 172b06c32b94.

Also 172b06c32b94 ("mm: slowly shrink slabs with a relatively small number =
of objects")
by itself is fine, but it reveals an independent issue in inode reclaim cod=
e,
which 47036ad4032e ("mm: don't reclaim inodes with many attached pages") ai=
ms to fix.

Thanks!
