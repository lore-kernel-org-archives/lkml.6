Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61B5C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9216D20881
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 13:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="KVdEywGJ";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="T7L1w8Ic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9216D20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeJPVbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 17:31:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43628 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727002AbeJPVbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 17:31:13 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9GDZmO8007169;
        Tue, 16 Oct 2018 06:40:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=N8HJZ7FbWqRY38z7AE2ztsjQboOLbOeccXlb4H4NlR4=;
 b=KVdEywGJpHqXNEhFp2ENg+J68q7xysGvT4n///j3cuWublOv7nfWWyKDyQvTBi7wXsRN
 lAb2nsQhgNlgciSl881K4uLzzlwbxkHMD3Tb251YC2sqJ61IP03SZuqGwfBeiNj63O4C
 MEvJaa4+7DRDsA63hwAeYqWUSB6E9+2v4vc= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2n5fchg9a5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 16 Oct 2018 06:40:36 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 16 Oct 2018 06:40:35 -0700
Received: from PRN-CHUB06.TheFacebook.com (2620:10d:c081:35::15) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 16 Oct 2018 06:40:35 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.16) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 16 Oct 2018 06:40:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8HJZ7FbWqRY38z7AE2ztsjQboOLbOeccXlb4H4NlR4=;
 b=T7L1w8IcZFV8FdrsGVrRmN83TMP6P2JLxTWzjbYZ5K2K/OepngB0J6xXX2ioY/LQVQbLthq1COk9vygOYxNMM72lDoRUmWg+o9PtDHHo8z5Tg8ywsi8Ef339vaEVK/Ehmt0Y5mgrhTcoLEDKRZQNlQEHcAViicWWK5Ofd3qT82A=
Received: from SN1PR15MB0158.namprd15.prod.outlook.com (10.162.106.13) by
 SN1PR15MB0573.namprd15.prod.outlook.com (10.164.46.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24; Tue, 16 Oct 2018 13:40:33 +0000
Received: from SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::5967:393c:29d7:b5ad]) by SN1PR15MB0158.namprd15.prod.outlook.com
 ([fe80::5967:393c:29d7:b5ad%8]) with mapi id 15.20.1250.020; Tue, 16 Oct 2018
 13:40:32 +0000
From:   Dan Schatzberg <dschatzberg@fb.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: Signed-off-by missing for commit in the fuse tree
Thread-Topic: linux-next: Signed-off-by missing for commit in the fuse tree
Thread-Index: AQHUZLeh+1F+N6k+a0upicvueadC/aUhiKwAgAAWcgA=
Date:   Tue, 16 Oct 2018 13:40:32 +0000
Message-ID: <48B74319-732E-41B3-9C46-C488868F749E@fb.com>
References: <20181016054723.4dfb83f6@canb.auug.org.au>
 <CAJfpegtZF3evQnaA+LWvD8-1fqQrAkn3qbcBOzO5w1PYh0EA8g@mail.gmail.com>
In-Reply-To: <CAJfpegtZF3evQnaA+LWvD8-1fqQrAkn3qbcBOzO5w1PYh0EA8g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c091:200::5:d73f]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1PR15MB0573;20:eL2UEmyCxtE+RXz1nk8AofO11pTjoT7W6LOQYd+bGYveZ9SxtjkAgBzkJj6Vpx0hI4iMWd7huPH3Ad4pgtnrOLUT2vH87BOhI9xUiPCcdV6Sad7ANA14qaGQ0iKxST+A52piKZqwlUaBF3EAqPKuYSm0LdHaNBSCI2V/WK6lk5c=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: c52e44f5-b8c6-4c28-273e-08d6336cf1fd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:SN1PR15MB0573;
x-ms-traffictypediagnostic: SN1PR15MB0573:
x-microsoft-antispam-prvs: <SN1PR15MB05736F554F5621F0532D3390D0FE0@SN1PR15MB0573.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(201708071742011)(7699051);SRVR:SN1PR15MB0573;BCL:0;PCL:0;RULEID:;SRVR:SN1PR15MB0573;
x-forefront-prvs: 0827D7ACB9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(376002)(396003)(136003)(199004)(189003)(82746002)(81166006)(81156014)(8676002)(97736004)(6512007)(68736007)(6436002)(345774005)(316002)(8936002)(6486002)(54906003)(186003)(86362001)(76176011)(256004)(53546011)(2616005)(11346002)(99286004)(46003)(486006)(476003)(36756003)(446003)(6506007)(102836004)(5660300001)(2906002)(71190400001)(71200400001)(305945005)(7736002)(478600001)(33656002)(6916009)(6116002)(14454004)(106356001)(53936002)(83716004)(4326008)(229853002)(5250100002)(25786009)(105586002)(2900100001)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN1PR15MB0573;H:SN1PR15MB0158.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: fpsARBeyy7H1ve0yM8wxyG6S/FmhufmzKjJbEsZOP8G0D9qfBYWITTle04XRl0E+k58EsujKwZpbAAtPHY8pf+jLrPuB1qhfnjBGMtRepPRCnGMHuKN3hNwMBSoCmMd+H2V2mB/9PpsAfBa/aFTTfO3MaOSMbLwLLC6Zd7y/PmJsuyMZcDs34lFUT163lieyD9IysZfqDnK7nZHiCKzwRC8tvXqT6r2IQeyV2O1tr7ZDje3i+Ln3/2ak6Ze6WVqtrQ64+FrfCj+N3dfLjAe+1AIYHQ7k46LkZt6ne1gK1uP8ng15j9ZAJh4p74mUWZRr36yW43JF5znwldq1y0xAsqx+rr1zZCXVndakp4pq+k4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D6BE0068CC8574DA88CE23F164644FD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c52e44f5-b8c6-4c28-273e-08d6336cf1fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2018 13:40:32.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR15MB0573
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-16_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAvMTYvMTgsIDQ6MjAgQU0sICJNaWtsb3MgU3plcmVkaSIgPG1pa2xvc0BzemVyZWRpLmh1
PiB3cm90ZToNCj4NCj4gT24gTW9uLCBPY3QgMTUsIDIwMTggYXQgODo0NyBQTSwgU3RlcGhlbiBS
b3Rod2VsbCA8c2ZyQGNhbmIuYXV1Zy5vcmcuYXU+IHdyb3RlOg0KPj4gSGkgTWlrbG9zLA0KPj4N
Cj4+IENvbW1pdA0KPj4NCj4+ICAgNTU3MWYxZTY1NDg2ICgiZnVzZTogZW5hYmxlIGNhY2hpbmcg
b2Ygc3ltbGlua3MiKQ0KPj4NCj4+IGlzIG1pc3NpbmcgYSBTaWduZWQtb2ZmLWJ5IGZyb20gaXRz
IGF1dGhvci4NCj4NCj4gRGFuLA0KPg0KPiBNYXliZSB5b3UgbWlzdGFrZW5seSBsZWZ0IG9mZiB0
aGUgU09CIHRhZz8gIENhbiBJIGFkZCBpdCBmb3IgeW91Pw0KPg0KPiBUaGFua3MsDQo+IE1pa2xv
cw0KDQpPb3BzLCBwbGVhc2UgYWRkIGl0IGZvciBtZS4gVGhhbmsgeW91IGZvciBhbGwgeW91ciBo
ZWxwIQ0KDQo=
