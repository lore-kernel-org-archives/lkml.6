Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BBCC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:45:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2E420830
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BHPtTkOy";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="ApicjXuB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C2E420830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbeKGFMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 00:12:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53480 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbeKGFMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 00:12:41 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA6JWujD023801;
        Tue, 6 Nov 2018 11:43:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yAV7GTxXzTyBk/edt/0lUav9s4Bw9BVvO4jT7leSS2U=;
 b=BHPtTkOyWU0zq0yTnhdIgNg/hVweP34nc6xyYu8ko1iMqmcDvXRp8ktAfZhNFl/8K4D6
 Gfa1Xqmqeqi0G9TD46DGqU8jkYMFD8FuR/SuQSyG4wja4DtEQwsTvjHBn+OtQ3tMCKzE
 3XbIigX1uvgZJJx0xOBlN6dYPS1m61vpzY8= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2nkg6888wc-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 06 Nov 2018 11:43:42 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Tue, 6 Nov 2018 11:43:34 -0800
Received: from PRN-CHUB01.TheFacebook.com (2620:10d:c081:35::10) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Tue, 6 Nov 2018 11:43:34 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Tue, 6 Nov 2018 11:42:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAV7GTxXzTyBk/edt/0lUav9s4Bw9BVvO4jT7leSS2U=;
 b=ApicjXuBThvv9H6DEbUX6atC0YlzDMZwuGtJ0vliGLWeeHH4K3FETV+B7Vz/p4RMnjS1eJWz2gM1rFXoRabGrS1af7AymeXgQkjRfStlzFjeFIJguGzQDisfoQzqQkmptEorPgtxXGM8ngy4BDL2MI+FoDgFBdhhvK+rtTZvCU8=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1245.namprd15.prod.outlook.com (10.175.3.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Tue, 6 Nov 2018 19:42:28 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.034; Tue, 6 Nov 2018
 19:42:28 +0000
From:   Tao Ren <taoren@fb.com>
To:     David Miller <davem@davemloft.net>
CC:     "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal TX/RX
 clock delay
Thread-Topic: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal
 TX/RX clock delay
Thread-Index: AQHUdVflNTAkCm00x0qybj+KK+QF1aVDIBAAgAAG74A=
Date:   Tue, 6 Nov 2018 19:42:28 +0000
Message-ID: <95fbdd90-9010-6fa2-2b9c-3acfd1708484@fb.com>
References: <20181105223540.1897084-1-taoren@fb.com>
 <20181106.111736.1149054212290410715.davem@davemloft.net>
In-Reply-To: <20181106.111736.1149054212290410715.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0038.namprd04.prod.outlook.com
 (2603:10b6:300:ee::24) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:ab38]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1245;20:mJeX+LKlp1db4ZmgufUHs8qgRq/kWuHyPPp3DGJk52xPZb80WEFeoyQ8vJ8Bmj0nQOVVcZavASOZKds9MLccn/kYdAdaavn/m7ri8m+XwwsRjGYr7bdTCsw07is0R5/wpbKNxy4+89WzHwMxBqXz9uK2RMbR+F4ef/06Lg137FU=
x-ms-office365-filtering-correlation-id: 5bb3ae16-647b-4254-7537-08d6441ffbec
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1245;
x-ms-traffictypediagnostic: MWHPR15MB1245:
x-microsoft-antispam-prvs: <MWHPR15MB1245CD1BE53EA05BED87EA3EB2CB0@MWHPR15MB1245.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1245;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1245;
x-forefront-prvs: 0848C1A6AA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(396003)(366004)(376002)(199004)(189003)(476003)(53936002)(486006)(6512007)(11346002)(39060400002)(46003)(2900100001)(76176011)(31686004)(52116002)(186003)(102836004)(53546011)(386003)(446003)(6506007)(4326008)(99286004)(106356001)(105586002)(229853002)(6916009)(6246003)(6486002)(6116002)(14454004)(68736007)(65806001)(65956001)(36756003)(8676002)(81156014)(2616005)(81166006)(8936002)(65826007)(6436002)(316002)(2906002)(5660300001)(305945005)(58126008)(7736002)(54906003)(25786009)(86362001)(478600001)(71190400001)(64126003)(71200400001)(31696002)(97736004)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1245;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: VH6X7tt2aO5fZIMraugmJFdiA8E2vFAd+nr3HopGwKPsJyIk1Pb74jfd5Cej93LGVuaPDjGjHwba6ai7bMehvxfuPzee3Pxi4o42O1eMUD6ytsrJUr8fwAget3gKj0N2oPjTpa+bCExS7ZIenkPOpLqqbJHmEbwyU91f4/741zgcjzwtr3tonXTolc6opMdIu185sSUbjG4Mehm+//xqt+K4zbHk0JMB2JqWPex2DddYnKtb2rFTuAh0PstJyMl6YUBtTb32eUBuczHSHDfVxpQK7cmaufnLfyu+zeTjd/sYpFiavZwFsvN5qncoVwNVhXL+DGRxh+eKIpSMCThj0uZhO+yGGY+F/zMPjE9byUI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <E924CD98FA927A43AD2AE20FBAF41922@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb3ae16-647b-4254-7537-08d6441ffbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2018 19:42:28.6537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-06_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNi8xOCAxMToxNyBBTSwgRGF2aWQgTWlsbGVyIHdyb3RlOg0KPiBGcm9tOiBUYW8gUmVu
IDx0YW9yZW5AZmIuY29tPg0KPiBEYXRlOiBNb24sIDUgTm92IDIwMTggMTQ6MzU6NDAgLTA4MDAN
Cj4gDQo+PiBUaGlzIHBhdGNoIGFsbG93cyB1c2VycyB0byBlbmFibGUvZGlzYWJsZSBpbnRlcm5h
bCBUWCBhbmQvb3IgUlggY2xvY2sNCj4+IGRlbGF5IGZvciBCQ001NDYxNlMgUEhZcyBzbyBhcyB0
byBzYXRpc2Z5IFJHTUlJIHRpbWluZyBzcGVjaWZpY2F0aW9ucy4NCj4+DQo+PiBPbiBhIHBhcnRp
Y3VsYXIgcGxhdGZvcm0sIHdoZXRoZXIgVFggYW5kL29yIFJYIGNsb2NrIGRlbGF5IGlzIHJlcXVp
cmVkDQo+PiBkZXBlbmRzIG9uIGhvdyBQSFkgY29ubmVjdGVkIHRvIHRoZSBNQUMgSVAuIFRoaXMg
cmVxdWlyZW1lbnQgY2FuIGJlDQo+PiBzcGVjaWZpZWQgdGhyb3VnaCAicGh5LW1vZGUiIHByb3Bl
cnR5IGluIHRoZSBwbGF0Zm9ybSBkZXZpY2UgdHJlZS4NCj4+DQo+PiBUaGUgcGF0Y2ggaXMgaW5z
cGlyZWQgYnkgY29tbWl0IDczMzMzNjI2MmIyOCAoIm5ldDogcGh5OiBBbGxvdyBCQ001NDgxeA0K
Pj4gUEhZcyB0byBzZXR1cCBpbnRlcm5hbCBUWC9SWCBjbG9jayBkZWxheSIpLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFRhbyBSZW4gPHRhb3JlbkBmYi5jb20+DQo+IA0KPiBUaGlzIGlzIGZpbmUg
Zm9yICduZXQnLCBhcHBsaWVkLCB0aGFua3MuDQoNClRoYW5rcyBEYXZpZCBmb3IgdGhlIHF1aWNr
IGFjdGlvbi4NCg0KLSBUYW8gUmVuDQo=
