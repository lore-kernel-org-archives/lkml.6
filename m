Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FC1ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22FA320869
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 22:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="rCoPR4Ho";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="WJzy2DLZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22FA320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbeJ0HTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 03:19:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55298 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726418AbeJ0HTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 03:19:49 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9QMYgdm003762;
        Fri, 26 Oct 2018 15:40:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=DQ5JRsq1mfxM+GBIc4JmaxOxHUAQV1HexT1vTfiiS3Y=;
 b=rCoPR4How2Vj6pMgqxdrxYuFwlvO4Sq+rcRiuTsPbF76r6kbiEi9rrWF26bkpojPAtvI
 48+9UgNR6QaU4ct0ESgsIFrnv6nlhkCZee+JaQ4sSV3VOrH+lI9tRxsWhVnM4UixZ2ES
 dtYCfnHuLvU/t6cqOxX6DWzCe/IGBCTGugo= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2ncbcf036g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 26 Oct 2018 15:40:47 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Fri, 26 Oct 2018 15:40:47 -0700
Received: from PRN-CHUB13.TheFacebook.com (2620:10d:c081:35::22) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 26 Oct 2018 15:40:47 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 26 Oct 2018 15:40:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQ5JRsq1mfxM+GBIc4JmaxOxHUAQV1HexT1vTfiiS3Y=;
 b=WJzy2DLZ3Pjk3bbH8AVwFRnKtQKzyzAqdKHuv2yq4rMwLPFOMfZMV3dF3B4I+DlhpNqezViRSp1/BgETwot25WPkscOW1aU6mr3xesUNLqAq783WXkOiWSKx0epJ+QLWe+dWHRsROEX6NcCWqWx6FrrUhtUXRXoR1G7oeQgRm1A=
Received: from BN6PR15MB1265.namprd15.prod.outlook.com (10.172.206.15) by
 BN6PR15MB1252.namprd15.prod.outlook.com (10.172.206.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.19; Fri, 26 Oct 2018 22:40:45 +0000
Received: from BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::d9c:ae08:492b:8197]) by BN6PR15MB1265.namprd15.prod.outlook.com
 ([fe80::d9c:ae08:492b:8197%8]) with mapi id 15.20.1273.025; Fri, 26 Oct 2018
 22:40:45 +0000
From:   Vijay Khemka <vijaykhemka@fb.com>
To:     David Miller <davem@davemloft.net>
CC:     "sam@mendozajonas.com" <sam@mendozajonas.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "Justin.Lee1@Dell.com" <Justin.Lee1@Dell.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
Thread-Topic: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
Thread-Index: AQHUbK68fT9fJ5/1+UWKPBgJowuNkKUwkcGAgAC/ugCAAHnzgP//37gA
Date:   Fri, 26 Oct 2018 22:40:44 +0000
Message-ID: <14BB7E55-C835-409E-97DE-D3F4CDA6E7E8@fb.com>
References: <20181025220413.2936698-1-vijaykhemka@fb.com>
 <20181025.155335.2132843393553452471.davem@davemloft.net>
 <F0024535-93C3-4470-98A6-F57426587474@fb.com>
 <20181026.103617.373827980255084988.davem@davemloft.net>
In-Reply-To: <20181026.103617.373827980255084988.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:200::6:75b9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR15MB1252;20:grPRHXtmUbG5/4YST4ohBraw9fn4p+oOM3h0JFync1CcIzMLZspF846JnP5elT7iVMiOk7FWxB5IZn/jV7hYdzn8T+WEkyX/TtlMDR8KOsLQFgRrsDaBDAA595HDtEL4r5tBSUxFbL2zPNK9iZbeg3jIuFHiwYCazwzT41EqIPY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ec4f4556-326b-4979-f206-08d63b94113f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1252;
x-ms-traffictypediagnostic: BN6PR15MB1252:
x-microsoft-antispam-prvs: <BN6PR15MB1252E0156066051CA05383DCDDF00@BN6PR15MB1252.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(11241501184)(944501410)(4982022)(52105095)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR15MB1252;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1252;
x-forefront-prvs: 083751FCA6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(136003)(376002)(396003)(39860400002)(199004)(189003)(256004)(25786009)(14454004)(4326008)(966005)(6246003)(478600001)(446003)(46003)(71190400001)(71200400001)(83716004)(186003)(97736004)(93886005)(316002)(5250100002)(86362001)(6306002)(6116002)(102836004)(6512007)(5660300001)(305945005)(2900100001)(53936002)(54906003)(7736002)(2616005)(486006)(11346002)(6506007)(476003)(99286004)(33656002)(105586002)(76176011)(106356001)(68736007)(6486002)(229853002)(6436002)(6916009)(81166006)(8936002)(2906002)(36756003)(81156014)(82746002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1252;H:BN6PR15MB1265.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: N4h7/Cb5AYzgGgS3+7E96L14mHavxqqNZmMnlKsDFtKrsAer8hBuCpDxdbR+SiY0mbUAZIvpN87VFcQyUUXBh3cmmhQzAKcudwhMR4aDgvB9gU98ZmAcSzbhnw9Ic7RdeQvR3Qy5M7IsV3gEUwHgSuLaQh/5GaS27pOR+UTLFVailzWpnkF7ws7IUJq/43bl5lWvENMtUJr65r9CXVGWUpLCZpHuIIj/rfkSkiHf0XFAbMT2Ivkg3BogOgHr0G8aLOld3GqbnWW0YjUPZ07oxcQQrvGpgiGw+HxdgGzsxHWtcd26FXhovUocPEWUzu3DANGYQKSFbJ6vwjshpRS52VkcnV6Elf8xqK55PwPX+WI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB92C566D161B449AA9D0456F286C3D3@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4f4556-326b-4979-f206-08d63b94113f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2018 22:40:44.9635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1252
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-26_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIERhdmlkDQoNCu+7v09uIDEwLzI2LzE4LCAxMDozNiBBTSwgIkRhdmlkIE1pbGxlciIg
PGRhdmVtQGRhdmVtbG9mdC5uZXQ+IHdyb3RlOg0KDQogICAgRnJvbTogVmlqYXkgS2hlbWthIDx2
aWpheWtoZW1rYUBmYi5jb20+DQogICAgRGF0ZTogRnJpLCAyNiBPY3QgMjAxOCAxNzoxOTo0OSAr
MDAwMA0KICAgIA0KICAgID4gRG8geW91IGhhdmUgYW55IHRpbWVsaW5lIHdoZW4gaXQgaXMgZ29p
bmcgdG8gb3BlbiBuZXh0IG9yIGhvdyBkbyBJDQogICAgPiBrbm93Lg0KICAgIA0KICAgIEkgYWx3
YXlzIGFubm91bmNlIG5ldC1uZXh0IG9wZW5uaW5nIGFuZCBjbG9zaW5nIGhlcmUgb24gdGhlIGxp
c3QuDQogICAgDQogICAgVGhlcmUgaXMgYWxzbyBhIHdlYiBzaXRlOg0KICAgIA0KICAgIAlodHRw
Oi8vdmdlci5rZXJuZWwub3JnL35kYXZlbS9uZXQtbmV4dC5odG1sDQogICAgDQogICAgVGhhbmtz
Lg0KICAgIA0KDQo=
