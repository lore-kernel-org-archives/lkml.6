Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B0DC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B0B2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="BXc675Md";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="jUvcyoap"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B0B2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbeKFI02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:26:28 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:49238 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725726AbeKFI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:26:28 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wA5N0QuY015416;
        Mon, 5 Nov 2018 15:03:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rNSgA1jDh1uzaHOO92KRjGykHcpHlea5qNdRDSRIZRE=;
 b=BXc675MdbYIGJ9H9apadpXUMTWWvqugm12zbndzbyVRHDtAiaUy+mgf7Ak+aV/fSgp9M
 +w0kojg/8V1kpLUFEoKl+kFAdc1ywPDLOrUJIiwODLlkYqwe+Gv4oPGwWzWQa/ypt7SF
 3MRys2EP0tQB00P3+rHeDM9ruQDNitzxSOE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2njwh30b6f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 05 Nov 2018 15:03:53 -0800
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1531.3; Mon, 5 Nov 2018 15:03:48 -0800
Received: from FRC-CHUB10.TheFacebook.com (2620:10d:c021:18::29) by
 frc-hub03.TheFacebook.com (2620:10d:c021:18::173) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Mon, 5 Nov 2018 15:03:48 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.30) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Mon, 5 Nov 2018 18:03:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNSgA1jDh1uzaHOO92KRjGykHcpHlea5qNdRDSRIZRE=;
 b=jUvcyoapJigd8gbV+OS77HppAvTTaRGeqm837Zuy0sb1DtWM2PmxhnurBAJHEeXAemYLPvpVp+ZV0colbOAuroHWdMTU/8R5fnxNi0f0QANP5EFNiljszkOykJekQBMSbxjSQKul9EdbmO0vHD4T6QDiLh8UsQnzOX5GcVEfF9g=
Received: from MWHPR15MB1216.namprd15.prod.outlook.com (10.175.2.146) by
 MWHPR15MB1600.namprd15.prod.outlook.com (10.173.235.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 23:03:45 +0000
Received: from MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6]) by MWHPR15MB1216.namprd15.prod.outlook.com
 ([fe80::709f:e3cd:1db:74d6%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 23:03:45 +0000
From:   Tao Ren <taoren@fb.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal TX/RX
 clock delay
Thread-Topic: [PATCH net] net: phy: Allow BCM54616S PHY to setup internal
 TX/RX clock delay
Thread-Index: AQHUdVflNTAkCm00x0qybj+KK+QF1aVBxmiAgAAGcwA=
Date:   Mon, 5 Nov 2018 23:03:45 +0000
Message-ID: <2a3b5e95-a9d9-2fad-0fed-0c30ae462c20@fb.com>
References: <20181105223540.1897084-1-taoren@fb.com>
 <4844a371-ed1f-9f74-1674-e649a9283f12@gmail.com>
In-Reply-To: <4844a371-ed1f-9f74-1674-e649a9283f12@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1401CA0022.namprd14.prod.outlook.com
 (2603:10b6:301:4b::32) To MWHPR15MB1216.namprd15.prod.outlook.com
 (2603:10b6:320:23::18)
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5:d22b]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR15MB1600;20:S8O9zGPN5CZiZnfQ1Gr59xGGMfd900hDqiszg2JPePIbU6RQm8adceUlP8E4xkYuyByvfCsHeq1TLSq3ziLOGaXdis7b1iuCPdOmonjpPvc92/bs+fto3t0qH+pVN+TRrHmKTdbuRH7/hewIZ3NMlXIcdIqLoiZVIdRp5DM+CZo=
x-ms-office365-filtering-correlation-id: 68a475cd-6b2f-4977-c8f5-08d64372efc5
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1600;
x-ms-traffictypediagnostic: MWHPR15MB1600:
x-microsoft-antispam-prvs: <MWHPR15MB1600A4F2FB22193297433ABCB2CA0@MWHPR15MB1600.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(67672495146484)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:MWHPR15MB1600;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1600;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(136003)(346002)(396003)(39860400002)(189003)(199004)(6246003)(71200400001)(5660300001)(2501003)(36756003)(256004)(386003)(105586002)(53546011)(6506007)(106356001)(7736002)(305945005)(8676002)(86362001)(2201001)(478600001)(31696002)(6116002)(8936002)(25786009)(2906002)(31686004)(53936002)(81156014)(81166006)(39060400002)(6436002)(76176011)(4326008)(52116002)(229853002)(102836004)(2900100001)(99286004)(6512007)(71190400001)(65826007)(186003)(65956001)(65806001)(6486002)(316002)(58126008)(446003)(476003)(2616005)(64126003)(11346002)(97736004)(14454004)(486006)(46003)(110136005)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1600;H:MWHPR15MB1216.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wBvh9RjHSEMvnB+GJQ9Yu7RYKOAxBuoackSwFSB1KdgiXkQMN7B4KY5P755CnGTIZMcfBDkW0oiQwXqnFZXEz36zqAhomyZhEbABltka06N+5rFAKlqLSE9dczFHpcv2rw4nJSG593CMca7HeYqg3GNcDr2++5TTtGrCtBXmfb/7nasn4G8LhTOTpEKcetBZELNvJfycegZAhEWbTchbfSKPvZ7LvQWXO5JrSNCF5xefU29e6D6WkAxZY/qPBMuJdf9oIHNvyNgOpkw6y6W0Dstr91yRLfK0kjTlD2OptJhYVX23grh5FMEhS9EEv6MByFHSUHNkIqaZ5NZIF1qDn7VasGyKBObDtH8s8ROFDuM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <1DCAB2F839C7DE45A1EB0B15FE27C19D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a475cd-6b2f-4977-c8f5-08d64372efc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 23:03:45.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1600
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-05_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNS8xOCAyOjQwIFBNLCBGbG9yaWFuIEZhaW5lbGxpIHdyb3RlOg0KDQo+IEkgd2lsbCBs
ZXQgRGF2aWQgYmUgdGhlIGp1ZGdlIHdoZXRoZXIgdGhpcyBpcyBhcHByb3ByaWF0ZSBhcyBhIGJ1
Z2ZpeA0KPiAodGh1cyB0YXJnZXRpbmcgdGhlICJuZXQiIHRyZWUpIG9yIGEgZmVhdHVyZSwgd2hp
Y2ggd291bGQgaGF2ZSB0byB3YWl0DQo+IGZvciBuZXQtbmV4dCB0byByZS1vcGVuLg0KDQpTdXJl
Lg0KDQo+PiBTaWduZWQtb2ZmLWJ5OiBUYW8gUmVuIDx0YW9yZW5AZmIuY29tPg0KPiANCj4gUmV2
aWV3ZWQtYnk6IEZsb3JpYW4gRmFpbmVsbGkgPGYuZmFpbmVsbGlAZ21haWwuY29tPg0KDQpUaGFu
ayB5b3UgRmxvcmlhbiBmb3IgdGhlIHF1aWNrIHJldmlldyENCg0KVGhhbmtzLA0KVGFvIFJlbg0K
