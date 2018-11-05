Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:00:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC8620700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Irjs0dFe";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="eam88AZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC8620700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbeKFEVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:21:33 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43157 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726932AbeKFEVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:21:33 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.22/8.16.0.22) with SMTP id wA5IxJ5b011336;
        Mon, 5 Nov 2018 11:00:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Jk+LNdgrGjRWkIYa+GtObABYMdtWmtuo2IJ+gdlTnN4=;
 b=Irjs0dFeiuo3nbb+dXHrZGinDJHU8F1TkXwKmGOoINEsRDt8vpUF00XWL3xjiOCjA7ig
 oV9vB7732fRufUuzomXaQ4caBR4TU4rW8Mqo736qJ8TyL9eaZ8tJsfFIeLjsbAaEi5m8
 fzpoPHGX6angn09r61wFqGp5dvfaJBN+ZN4= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2njt4d8f0d-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 11:00:14 -0800
Received: from prn-hub05.TheFacebook.com (2620:10d:c081:35::129) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 5 Nov 2018 11:00:09 -0800
Received: from PRN-CHUB07.TheFacebook.com (2620:10d:c081:35::16) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 5 Nov 2018 11:00:09 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.17) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 5 Nov 2018 11:00:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jk+LNdgrGjRWkIYa+GtObABYMdtWmtuo2IJ+gdlTnN4=;
 b=eam88AZT+g8xPpA/f4ZgWJDKSDQ65Sw2vnV3pOl359ah0uepMOJ/OeC/dkjg7ZsnzbZ7KXvLXMTN9ICUhUQtvSm7Fuhj9Xnv9OZN/MCV1dhvT+WZASDBn8NMSuvwaaKYAbSfKowEBOrwC2kInMuDhG7vWv4A+/Cc3fbQioUAXY8=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1344.namprd15.prod.outlook.com (10.175.3.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.21; Mon, 5 Nov 2018 19:00:06 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 19:00:06 +0000
From:   Tao Ren <taoren@fb.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>,
        Yu Lei <mine260309@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Topic: [PATCH v2] clocksource/drivers/fttmr010: fix invalid interrupt
 register access
Thread-Index: AQHUW2On9LNQ+pmvkkW+1bSF6wxqO6UUS5aAgCzmeQCAAIgDgP//fJCA
Date:   Mon, 5 Nov 2018 19:00:06 +0000
Message-ID: <7284BEA6-FAE9-4293-94E0-FC29304AA36D@fb.com>
References: <20181003215350.3550926-1-taoren@fb.com>
 <CACRpkdbbUO9_VOtnZL+Xf_0nTTgSruaaPOLnvZ4M+NQfPLzvWQ@mail.gmail.com>
 <BC1ADE3F-F31F-4E1E-A6EE-3BD83C5F2634@fb.com>
 <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
In-Reply-To: <279e6a06-3f2f-e736-f28e-4d099729a517@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.0.180812
x-originating-ip: [2620:10d:c090:200::6:40e9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1344;20:93XHDzsjqKajUC6PopTV0GMb/pQgx0VP/OEIPPzWhamC3nf+1bP5jODa5OFy5EugxR90Fq6J+Manej7dlx4jDlZXqV9QtcKlQb6+6hYkGeGQlhVCPFeMRGoCz7Ai5NFtyHbUcHV3WoAoWrc7oGeIGGlCQzqiDIFqUgufduOLicU=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: eecab603-9682-46a4-045d-08d64350e6cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1344;
x-ms-traffictypediagnostic: MWHPR15MB1344:
x-microsoft-antispam-prvs: <MWHPR15MB13443BBA42F5DA6EA88FF0FFB2CA0@MWHPR15MB1344.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231382)(11241501184)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1344;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1344;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(6116002)(316002)(558084003)(6506007)(110136005)(82746002)(54906003)(102836004)(5660300001)(58126008)(6436002)(6512007)(305945005)(39060400002)(97736004)(36756003)(6486002)(53546011)(53936002)(33656002)(68736007)(81156014)(6246003)(81166006)(76176011)(105586002)(2906002)(106356001)(8676002)(7736002)(99286004)(8936002)(93886005)(256004)(14444005)(478600001)(486006)(2900100001)(2616005)(186003)(446003)(11346002)(14454004)(476003)(46003)(71200400001)(229853002)(4326008)(86362001)(25786009)(71190400001)(83716004);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1344;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: RstT9z0nhq/+FW7EsfbXCPnVoKQUdih9ZENE7iV3Ij8d6AMaHwnwWAN1CsR71MK+8Y8CJq+LH17kEIrNUHQDAPcp3MfTvfVBzpJbL3+S/fTfu3oOzyZfa5lH0oCdBIMUvyi1bshzMtZRpfkeAPv0r9pjBggfmCjHGaknFiAX0ZsvliJZKQ1QZ+e+WYKBDmathYNhHYiPvLTIea4iMLu1HLUsFDkCOpqrUsPkd7jaE+nPm+/EoFc6TxDPOtSySCHZR0dXX55wT92FqnIWVtknMQ0Pr9wV1HPmViBXzD+vMXp1P22Tbv6B+/VfLOVOqV68KqOh2K35IgHqWZuIUM+UNEvJmqpsyNqxPVwud9FssJA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC8783FFFEC95948A59009E0005BAFC1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: eecab603-9682-46a4-045d-08d64350e6cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 19:00:06.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1344
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8xOCwgMTA6NTEgQU0sICJEYW5pZWwgTGV6Y2FubyIgPGRhbmllbC5sZXpjYW5vQGxp
bmFyby5vcmc+IHdyb3RlOg0KDQo+IE9oIHJpZ2h0LCBzb3JyeS4gU2hvdWxkIGl0IGdvIHRvIHN0
YWJsZSBhbHNvID8gSXMgdGhlcmUgYSBGaXhlcyB0YWcgaXQgY2FuIGFwcGx5ID8NCg0KUGVyc29u
YWxseSBJIGRvbid0IHRoaW5rIGl0IG5lZWRzIHRvIGdvIHRvIHN0YWJsZSwgYmVjYXVzZSBJIGRv
bid0IHNlZSBhbnkgZnVuY3Rpb25hbCBmYWlsdXJlcyBjYXVzZWQgYnkgdGhpcyBpbnZhbGlkIHJl
Z2lzdGVyIGFjY2Vzcy4NCg0KVGhhbmtzLA0KVGFvIFJlbg0KDQo=
