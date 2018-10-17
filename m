Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3613AC5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF288214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="SkD8mWGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF288214AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeJQKfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:35:33 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:12478
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726988AbeJQKfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzJXMoVNtcTfoj1zXfHSD/l3FBlwpTmfw7eh5HfaNSg=;
 b=SkD8mWGJccYb9KtIeX1+BHMKHakQni3OEtn/w7f9+zcJGUdxmZ3mUWspqpSFWNy6c9L7z5gMAnmp3VS03Kd5h1GnaGikmGXbUi2hjQWuD7KgqnU4vhfp/MMoMhlthPnOx+hYH3u7YNLZleGcPhEUZGVxWp8datK1kbD65NJF5lg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYASPR01MB0037.namprd05.prod.outlook.com (52.135.239.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.12; Wed, 17 Oct 2018 02:42:04 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::49cd:7d04:35b7:b2a2%5]) with mapi id 15.20.1250.020; Wed, 17 Oct 2018
 02:42:04 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xavier Deguillard <xdeguillard@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Wang <jasowang@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 16/20] mm/balloon_compaction: list interfaces
Thread-Topic: [PATCH v3 16/20] mm/balloon_compaction: list interfaces
Thread-Index: AQHUVc2ED+mU4PcbWEmXX/O1MTP5s6UGHMKAgBy9mYA=
Date:   Wed, 17 Oct 2018 02:42:03 +0000
Message-ID: <568F35AB-E34D-42B9-8B40-D5EE1D14E180@vmware.com>
References: <20180926191336.101885-1-namit@vmware.com>
 <20180926191336.101885-17-namit@vmware.com>
 <7F67E16F-BC91-47B3-9A68-CF1EA226AB2E@vmware.com>
In-Reply-To: <7F67E16F-BC91-47B3-9A68-CF1EA226AB2E@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [208.91.2.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYASPR01MB0037;20:D5b4DPFdjgEJ7JaaGhiaUDgXmDY0zNmUpRRafxpb+dB6lsat5yZtu3Me7WeEE78TqZBnuOn5MuhLE2frfVl5SVikKYkyI7xA9LfQQk5taFd7Wm05+dFx5crs42K56Ii9Enr//pZQRcraJcOj9eM37rDf9bMZg9FMOBQqRUOfmX0=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 14e7eafa-50c9-4e16-5504-08d633da1f59
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYASPR01MB0037;
x-ms-traffictypediagnostic: BYASPR01MB0037:
x-microsoft-antispam-prvs: <BYASPR01MB0037E1C7C9979CC32F2EBCA8D0FF0@BYASPR01MB0037.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991086);SRVR:BYASPR01MB0037;BCL:0;PCL:0;RULEID:;SRVR:BYASPR01MB0037;
x-forefront-prvs: 08286A0BE2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(199004)(189003)(2900100001)(33656002)(6436002)(71190400001)(54906003)(476003)(11346002)(2616005)(76176011)(486006)(6116002)(6346003)(99286004)(2906002)(3846002)(71200400001)(105586002)(478600001)(446003)(97736004)(186003)(36756003)(83716004)(6506007)(14454004)(26005)(106356001)(102836004)(8676002)(66066001)(5250100002)(82746002)(4326008)(81166006)(53936002)(316002)(8936002)(81156014)(6486002)(305945005)(6512007)(25786009)(68736007)(6246003)(5660300001)(86362001)(7736002)(6916009)(229853002)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYASPR01MB0037;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-microsoft-antispam-message-info: k4l5ha4YCXHc+zjsqpk3+4Ka51Ak3pBiyTcuSEtcyDKypD3zJD2cMhku43gPgb7QM6b6s03Xw+Y3wkHsbyQ00J8HC45S14K/qmgeCsMRwTuujLaZuMNbBrfTEtR7KBXtMK5X7kEB41+UH//ck+4Akz0HT1xVeQamQAAQeA/A37f2YZvejo0/9hrRNef0uvnrg8KArVy8hhZMU6pe+F/vpMfPoPf+d6MNPFGYHIykhuX5xjSiOWnLzum7xgdvUjWrJCski+lt3iYvkhfpl2Pmwe950QRlHTv8XwN7qxzz0TuBtKnIpP/X0ReN1MKCjsisXVa9FacP22NNpZbofvRywHAjoFyB+B8VCe0AnNW1rbY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C3FDC10DBD04C4EBB499F79D2070D94@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e7eafa-50c9-4e16-5504-08d633da1f59
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2018 02:42:03.9037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 12:48 PM, Nadav Amit <namit@vmware.com> wrote:

> at 12:13 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
>> Introduce interfaces for ballooning enqueueing and dequeueing of a list
>> of pages. These interfaces reduce the overhead of storing and restoring
>> IRQs by batching the operations. In addition they do not panic if the
>> list of pages is empty.
>>=20
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: linux-mm@kvack.org
>> Cc: virtualization@lists.linux-foundation.org
>> Reviewed-by: Xavier Deguillard <xdeguillard@vmware.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> include/linux/balloon_compaction.h |   4 +
>> mm/balloon_compaction.c            | 139 +++++++++++++++++++++--------
>> 2 files changed, 105 insertions(+), 38 deletions(-)
>>=20
>> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_=
compaction.h
>> index 53051f3d8f25..2c5a8e09e413 100644
>> --- a/include/linux/balloon_compaction.h
>> +++ b/include/linux/balloon_compaction.h
>> @@ -72,6 +72,10 @@ extern struct page *balloon_page_alloc(void);
>> extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>> 				 struct page *page);
>> extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_=
info);
>> +extern void balloon_page_list_enqueue(struct balloon_dev_info *b_dev_in=
fo,
>> +				      struct list_head *pages);
>> +extern int balloon_page_list_dequeue(struct balloon_dev_info *b_dev_inf=
o,
>> +				     struct list_head *pages, int n_req_pages);
>=20
> <snip>
>=20
> Michael, can we get you ack for this patch (as well as 15/20)?

Ping?

