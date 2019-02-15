Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DD9222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="VOZL1c3t";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="LRnvLzts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392923AbfBOWjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:39:08 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52286 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392244AbfBOWjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:39:07 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1FMYtUC021463;
        Fri, 15 Feb 2019 14:39:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=Xh2Ud04QmTgagG6kAzfgvpTjDthipouTfbp90HTnP4Y=;
 b=VOZL1c3tlCyPKVJv+fpzww0qi49+nEbpgX5O98netAa6i+zMRez3IXLEPpnEUXFeFY+4
 1rDhky9as11X8PZn11VWnE9zq0Aa6yduBX/m/wwwWKGq3pZYwH8X5Ah6sISdORdGbcp6
 7oV8nHIU7rvT1FmnwVTHcCNzQ0IDP07z+FHg9c4ZiadN5whg4NMh8VbSLenk4itXbosX
 EBDzu6c4rXfbPYOqMQSk018/OGsM0socTDB3PBS30LFIrG+EzKGw55mMoNKUpmSdGR1x
 wNvWDMxW4ZwJoCPt5yDsq5sr/DffCw0maP43KDSwj9RgLS3vKOKImFFQPtIdU+BxdIy1 WQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qp1r7gty3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 15 Feb 2019 14:39:03 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Fri, 15 Feb
 2019 14:39:02 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.56) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 15 Feb 2019 14:39:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xh2Ud04QmTgagG6kAzfgvpTjDthipouTfbp90HTnP4Y=;
 b=LRnvLztsymww1PIVwz/R/SHzaG+8SJpLFr38bxnG6iK5ALs4mFefzBWQa8MeBP/0vBp+rgort42zLtp+61vMhv/MEmk++1mNlM6PQDOEZ3j9844mjeO7FDDAAIPogsH20i9f81/ED+KbZknpP59yhXQR7XJKY0HJwGZevcVINUM=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB3085.namprd18.prod.outlook.com (20.179.21.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.19; Fri, 15 Feb 2019 22:38:59 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::ade0:6f55:b806:f853]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::ade0:6f55:b806:f853%2]) with mapi id 15.20.1622.018; Fri, 15 Feb 2019
 22:38:59 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Colin King <colin.king@canonical.com>,
        "qla2xxx-upstream@qlogic.com" <qla2xxx-upstream@qlogic.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2] scsi: qla2xxx: remove redundant null check on pointer
 sess
Thread-Topic: [PATCH][V2] scsi: qla2xxx: remove redundant null check on
 pointer sess
Thread-Index: AQHUxRQ2qdFVz2VmAUa9CwyIzC1dJKXg7jeA
Date:   Fri, 15 Feb 2019 22:38:59 +0000
Message-ID: <80C50389-AFD5-474C-8737-F13B7E4E0B9D@marvell.com>
References: <20190215095232.28852-1-colin.king@canonical.com>
In-Reply-To: <20190215095232.28852-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [199.233.58.37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5d01e3d-8298-4c65-5b1a-08d6939660d0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MN2PR18MB3085;
x-ms-traffictypediagnostic: MN2PR18MB3085:
x-microsoft-exchange-diagnostics: 1;MN2PR18MB3085;20:yEFD4PkIzEv/6YhMOqyWi9vrAXhXKWrwradOHiF7GVFwyxZJtTA5aF0Vyw30nCKh1CZhhHu9WsKFqYHzrQdeEs6pluTRkc3GJFrdN25J5oPdGhINyp/PpjHw6VEkLmJFYdux98DJL4qInmOLuCoLJXheh7Z9RlM2TTPu1LeOacI=
x-microsoft-antispam-prvs: <MN2PR18MB308518AB848A5F9D5F97E341D6600@MN2PR18MB3085.namprd18.prod.outlook.com>
x-forefront-prvs: 09497C15EB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(51914003)(6436002)(14454004)(6116002)(4326008)(25786009)(3846002)(68736007)(6512007)(478600001)(2906002)(229853002)(8676002)(81156014)(7736002)(76176011)(33656002)(81166006)(6246003)(305945005)(8936002)(53936002)(256004)(14444005)(2616005)(66066001)(11346002)(446003)(2501003)(106356001)(105586002)(476003)(36756003)(82746002)(97736004)(6486002)(102836004)(110136005)(83716004)(71200400001)(71190400001)(54906003)(6506007)(99286004)(26005)(186003)(486006)(316002)(86362001)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB3085;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eCPRUjvI1S/ypx6PNVbml29HycNjuBO7EgzM/x+zyRJlhqtZVR5MSiYNQQHV/i0Z9QHUyUBNVeSq7/yyzZSr58GQBr5qj4fpJhpORIWsbVJM3/8qsF/33wabxk9NduveQuvgOWyAetn+TTJDx7HGYilxXlnshn6UHTiZtmu+t83Y6HpI5lZ8J+I5i/JXd+MXorEGeeZ8jMirYJy4tbimMWW0XMxuRR6CoK1LYvs9kCk20gdRGFUHBUWWY84tHCN73kN8TyZ3NlC/OrXxrf6PK7y/yEKK6nofzuxiOBRvBuXnthYbbe/ybPTDELeFxI642SBxUBln3TD+BuVmlEfZKoCXS1K2nELCW/XPRtnjeZP00C8YNVfs6S99Vufb770VGt2PzsXi4TGuu0C2MVeJJvR9kGkewuimUuH2eqJ0anE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A58593F4715614CA732316808287C87@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d01e3d-8298-4c65-5b1a-08d6939660d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2019 22:38:59.7188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3085
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-15_16:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=953 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902150146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNCu+7v09uIDIvMTUvMTksIDE6NTIgQU0sICJDb2xpbiBLaW5nIiA8Y29saW4u
a2luZ0BjYW5vbmljYWwuY29tPiB3cm90ZToNCg0KICAgIEV4dGVybmFsIEVtYWlsDQogICAgDQog
ICAgRnJvbTogQ29saW4gSWFuIEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCiAgICAN
CiAgICBUaGUgbnVsbCBjaGVjayBvbiBwb2ludGVyIHNlc3MgYW5kIHRoZSBzdWJzZXF1ZW50IGNh
bGwgaXMgcmVkdW5kYW50DQogICAgYXMgc2VzcyBpcyBudWxsIG9uIGFsbCB0aGUgdGhlIHBhdGhz
IHRoYXQgbGVhZCB0byB0aGUgb3V0X3Rlcm0yIGxhYmVsLg0KICAgIEhlbmNlIHRoZSBudWxsIGNo
ZWNrIGFuZCB0aGUgY2FsbCBjYW4gYmUgcmVtb3ZlZC4gIEFsc28gcmVtb3ZlIHRoZQ0KICAgIHJl
ZHVuZGFudCBzZXR0aW5nIG9mIHNlc3MgdG8gTlVMTCBhcyB0aGlzIGlzIG5vdCByZXF1aXJlZCBu
b3cuDQogICAgDQogICAgRGV0ZWN0ZWQgYnkgQ292ZXJpdHlTY2FuLCBDSUQjMTQyMDY2MyAoIkxv
Z2ljYWxseSBkZWFkIGNvZGUiKQ0KICAgIA0KICAgIFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBL
aW5nIDxjb2xpbi5raW5nQGNhbm9uaWNhbC5jb20+DQogICAgLS0tDQogICAgDQogICAgVjI6IFJl
bW92ZSB0aGUgcmVkdW5kYW50IHNldHRpbmdzIG9mIHNlc3MgdG8gTlVMTCwgdGhhbmtzIHRvDQog
ICAgRGFuIENhcnBlbnRlciBmb3Igc3BvdHRpbmcgdGhpcy4NCiAgICANCiAgICAtLS0NCiAgICAg
ZHJpdmVycy9zY3NpL3FsYTJ4eHgvcWxhX3RhcmdldC5jIHwgNiArLS0tLS0NCiAgICAgMSBmaWxl
IGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KICAgIA0KICAgIGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfdGFyZ2V0LmMgYi9kcml2ZXJzL3Njc2kv
cWxhMnh4eC9xbGFfdGFyZ2V0LmMNCiAgICBpbmRleCA2YjhjNjU1ZDllYjQuLjMzMTMxNDQ2YjMy
NyAxMDA2NDQNCiAgICAtLS0gYS9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfdGFyZ2V0LmMNCiAg
ICArKysgYi9kcml2ZXJzL3Njc2kvcWxhMnh4eC9xbGFfdGFyZ2V0LmMNCiAgICBAQCAtNjM0Myw3
ICs2MzQzLDcgQEAgc3RhdGljIHZvaWQgcWx0X3Rtcl93b3JrKHN0cnVjdCBxbGFfdGd0ICp0Z3Qs
DQogICAgICAgICAgICBzdHJ1Y3QgYXRpb19mcm9tX2lzcCAqYSA9ICZwcm0tPnRtX2lvY2IyOw0K
ICAgICAgICAgICAgc3RydWN0IHNjc2lfcWxhX2hvc3QgKnZoYSA9IHRndC0+dmhhOw0KICAgICAg
ICAgICAgc3RydWN0IHFsYV9od19kYXRhICpoYSA9IHZoYS0+aHc7DQogICAgLSAgICAgICBzdHJ1
Y3QgZmNfcG9ydCAqc2VzcyA9IE5VTEw7DQogICAgKyAgICAgICBzdHJ1Y3QgZmNfcG9ydCAqc2Vz
czsNCiAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQogICAgICAgICAgICB1aW50OF90
ICpzX2lkID0gTlVMTDsgLyogdG8gaGlkZSBjb21waWxlciB3YXJuaW5ncyAqLw0KICAgICAgICAg
ICAgaW50IHJjOw0KICAgIEBAIC02MzY5LDcgKzYzNjksNiBAQCBzdGF0aWMgdm9pZCBxbHRfdG1y
X3dvcmsoc3RydWN0IHFsYV90Z3QgKnRndCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBn
b3RvIG91dF90ZXJtMjsNCiAgICAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgICAg
IGlmIChzZXNzLT5kZWxldGVkKSB7DQogICAgLSAgICAgICAgICAgICAgICAgICAgICAgc2VzcyA9
IE5VTEw7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBvdXRfdGVybTI7DQogICAg
ICAgICAgICAgICAgICAgIH0NCiAgICANCiAgICBAQCAtNjM3Nyw3ICs2Mzc2LDYgQEAgc3RhdGlj
IHZvaWQgcWx0X3Rtcl93b3JrKHN0cnVjdCBxbGFfdGd0ICp0Z3QsDQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcWxfZGJnKHFsX2RiZ190Z3RfdG1yLCB2aGEsIDB4ZjAyMCwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIiVzOiBrcmVmX2dldCBmYWlsICU4cGhDXG4iLA0KICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgX19mdW5jX18sIHNlc3MtPnBvcnRfbmFtZSk7
DQogICAgLSAgICAgICAgICAgICAgICAgICAgICAgc2VzcyA9IE5VTEw7DQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgZ290byBvdXRfdGVybTI7DQogICAgICAgICAgICAgICAgICAgIH0NCiAg
ICAgICAgICAgIH0NCiAgICBAQCAtNjM5Niw4ICs2Mzk0LDYgQEAgc3RhdGljIHZvaWQgcWx0X3Rt
cl93b3JrKHN0cnVjdCBxbGFfdGd0ICp0Z3QsDQogICAgICAgICAgICByZXR1cm47DQogICAgDQog
ICAgIG91dF90ZXJtMjoNCiAgICAtICAgICAgIGlmIChzZXNzKQ0KICAgIC0gICAgICAgICAgICAg
ICBoYS0+dGd0LnRndF9vcHMtPnB1dF9zZXNzKHNlc3MpOw0KICAgICAgICAgICAgc3Bpbl91bmxv
Y2tfaXJxcmVzdG9yZSgmaGEtPnRndC5zZXNzX2xvY2ssIGZsYWdzKTsNCiAgICAgb3V0X3Rlcm06
DQogICAgICAgICAgICBxbHRfc2VuZF90ZXJtX2V4Y2hhbmdlKGhhLT5iYXNlX3FwYWlyLCBOVUxM
LCAmcHJtLT50bV9pb2NiMiwgMSwgMCk7DQogICAgLS0NCiAgICAyLjIwLjENCiAgICANClRoYW5r
cyBmb3IgdGhlIFBhdGNoLiBMb29rcyBnb29kDQoNCkFja2VkLWJ5OiBIaW1hbnNodSBNYWRoYW5p
IDxobWFkaGFuaUBtYXJ2ZWxsLmNvbT4NCiAgICANCg0K
