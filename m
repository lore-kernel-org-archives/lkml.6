Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DC8C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D420652
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D420652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbeHaBdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:33:21 -0400
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:15004 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeHaBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:33:21 -0400
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id E4F8D61421;
        Thu, 30 Aug 2018 21:29:12 +0000 (UTC)
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2353.austin.hpe.com (Postfix) with ESMTPS id AA287AC;
        Thu, 30 Aug 2018 21:29:11 +0000 (UTC)
Received: from G9W8666.americas.hpqcorp.net (16.220.49.25) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 30 Aug 2018 21:29:06 +0000
Received: from G4W10205.americas.hpqcorp.net (2002:10cf:520f::10cf:520f) by
 G9W8666.americas.hpqcorp.net (2002:10dc:3119::10dc:3119) with Microsoft SMTP
 Server (TLS) id 15.0.1367.3; Thu, 30 Aug 2018 21:29:05 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.11) by
 G4W10205.americas.hpqcorp.net (16.207.82.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3 via Frontend Transport; Thu, 30 Aug 2018 21:29:05 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.22) by
 AT5PR8401MB1091.NAMPRD84.PROD.OUTLOOK.COM (10.169.8.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.14; Thu, 30 Aug 2018 21:29:04 +0000
Received: from AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283]) by AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::ac4f:ac06:14f9:d283%2]) with mapi id 15.20.1101.007; Thu, 30 Aug 2018
 21:29:04 +0000
From:   "Kani, Toshi" <toshi.kani@hpe.com>
To:     "wufan@codeaurora.org" <wufan@codeaurora.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>
CC:     "baicar.tyler@gmail.com" <baicar.tyler@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: Re: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
Thread-Topic: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
Thread-Index: AQHUQJCWZ58rwFSfrESpFeuy7W1Ze6TYyh2A
Date:   Thu, 30 Aug 2018 21:29:04 +0000
Message-ID: <a2b7b914120f1c2e7020d18d7c7d824413e06304.camel@hpe.com>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
In-Reply-To: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=toshi.kani@hpe.com; 
x-originating-ip: [15.203.227.8]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AT5PR8401MB1091;6:jRjsvJz9C3G77A2c2efdMfck5XujmEhAw8LyJ9RtoD1zay7Cre/ldfg6y73sK7Lq+I8gqyBGlHuEiu+swwqWdRxyZbsoU6MEFoaXPgSCRK5K/ZmgPfTQyYXj5PgGEJzILnkP99HyXUwBwPIvdPfNzDeSCy4gP6Q2RK8CiY8js8XZc0KY9xqtLZWnRXEn8i6kThqs+zj2hcwMzXZ8WJhlKq2u59bNAu1MlepU/5gLCypARIiowYXIfWketRG91fRry5S6QprjiiM8wLrN8cmM0yLAR0a0Tkgoz7fI2p+6/3embwH4/VNt4AWqAtvY3quZdZMIMp63DwrCkntutoEDfoSJSfpMSmQD51o7TYAkF9Vj1Js/NivD2phpFVjirBWNZ1wlX5g6kxQBRUL0OagL4KUID/x4WSlKAlNE6o1TJ3eKIzfCBA3y3ijlNzRXWSBstA1mIuBHm6GGC71n1ed2RA==;5:R/WE41jXs7GQkzFKG+Ixo1vqgyfI455Nyb7/i5g4UWHSmrtc2/E7cu9/cGpXN//utHDMScN5iteL6nbVvrRu4gyuC7kROv3n4l7S8gDNjjFJs4hd9vYg4haGVcrqrsoO4THY5lWF6oYJHWcoWQxNdwopo+gS2Bd5yLEKpgteLkk=;7:xxBJWVV2gdynklHRD7HgHvkGz9jc1vEOQz8RubRYafXHKEMiQMzMTkoRAGXJfHD+ghvKLsnfE2ix5CETDIynGPTTDfuozHnNDg45G7G2/ne8vbC1f0aZuynvxkph4c94jYGheIC+dD601zXpQtOr3YZSSOCMPaU3f2nZ7XHqx40Z3+bBJ4OXJ9HUPuXb3bkVMticqeLdTELyM7gz++R3MZZwa5r8kTCFIoKumpd0E93XAb9sJhcJh3R/rkjkY7EU
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: bc69463e-df17-4c3c-d49d-08d60ebf9c68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AT5PR8401MB1091;
x-ms-traffictypediagnostic: AT5PR8401MB1091:
x-microsoft-antispam-prvs: <AT5PR8401MB1091CC29EEF61E6DC2B3B08482080@AT5PR8401MB1091.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:AT5PR8401MB1091;BCL:0;PCL:0;RULEID:;SRVR:AT5PR8401MB1091;
x-forefront-prvs: 07807C55DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(136003)(39860400002)(366004)(376002)(189003)(199004)(446003)(81166006)(97736004)(486006)(6246003)(6486002)(6436002)(66066001)(53936002)(229853002)(26005)(118296001)(2906002)(86362001)(4326008)(476003)(8676002)(8936002)(478600001)(39060400002)(2616005)(6512007)(68736007)(36756003)(5660300001)(81156014)(25786009)(11346002)(6506007)(99286004)(54906003)(6116002)(2501003)(3846002)(110136005)(186003)(305945005)(76176011)(256004)(14444005)(5250100002)(316002)(105586002)(106356001)(102836004)(2900100001)(14454004)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:AT5PR8401MB1091;H:AT5PR8401MB1121.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: hpe.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: h8YWaWn9avpWc80XeAuCEd7lpJIXzsoOQN3GXo7nzyd8kEBKvaD3ZISVmrb8Wm9C6QfLDFsk/F3JdL1ISlp8wGr+qqhuPaLNDuElziPQorfW9R56gqAeYb/kwMFM2fi8cDSVGDnzl/zrqou/4mBYROjcVL2peTbUkFJPaJUg4ZZK01CHhQy5WdyLcx1UaYenY8n+kNbysICoXHhYro86ZiON87+0DKyX3goca8OkK6uOuZaFmKmTpFsB0/U2y91HDYaoplBMY0h39DsW0O3sXiaK9l4Y8173LbVZ8zvLnNolMoxaCxeUBH//8L1gVIkuR6Yql2OhduxQS96Wg8X7tMP0ewJ41eSzWDXq4P65tfY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <5117E89D6C1951408710673B04A25B29@NAMPRD84.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bc69463e-df17-4c3c-d49d-08d60ebf9c68
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2018 21:29:04.3755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AT5PR8401MB1091
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDE4LTA4LTMwIGF0IDE4OjM3ICswMDAwLCBGYW4gV3Ugd3JvdGU6DQo+IEZvciBw
bGF0Zm9ybXMgd2hvc2UgZmlybXdhcmVzIHByb3ZpZGUgdmFsaWQgbW9kdWxlIGhhbmRsZXMNCj4g
KFNNQklPUyB0eXBlIDE3KSBpbiBlcnJvciByZWNvcmRzLCB0aGlzIHBhdGNoIHVzZXMgdGhlIG1v
ZHVsZQ0KPiBoYW5kbGVzIHRvIGxvY2F0ZSBjb3JyZXNwb25kaW5nIERJTU1zIGFuZCBlbmFibGVz
IHBlci1ESU1NDQo+IGVycm9yIGNvdW50ZXIgdXBkYXRlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
RmFuIFd1IDx3dWZhbkBjb2RlYXVyb3JhLm9yZz4NCg0KVGVzdGVkIG9uIGFuIEhQRSB4ODYgc2Vy
dmVyLiBJdCB0dXJucyBvdXQgdGhhdCBtZW1fZXJyLT5tZW1fZGV2X2hhbmRsZQ0Kd2FzIHNldCB0
byAgMCB3aXRoIHRoaXMgRlcsIGFuZCBnZXRfZGltbV9zbWJpb3NfaW5kZXgoKSByZXR1cm5lZCAt
MS4gQnV0DQp0aGUgY29kZSBoYW5kbGVzIHRoaXMgY2FzZSBmaW5lLiBkaW1tLT5zbWJpb3NfaGFu
ZGxlJ3Mgd2VyZSBpbml0aWFsaXplZA0KcHJvcGVybHkuIFNvOg0KDQpUZXN0ZWQtYnk6IFRvc2hp
IEthbmkgPHRvc2hpLmthbmlAaHBlLmNvbT4NCg0KVGhhbmtzLA0KLVRvc2hpDQoNCg==
