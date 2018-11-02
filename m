Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038DCC65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF5682081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="n0EqrpwW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF5682081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeKBULp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:11:45 -0400
Received: from mail-eopbgr30129.outbound.protection.outlook.com ([40.107.3.129]:23605
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726731AbeKBULo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36UliNA3qdNmrOk33opVBIeFYJw9d8yGH00LhoDZgEc=;
 b=n0EqrpwWMC2vpcTMgwAXfQWVGphDm6OL54oRW5yPo04d2NcLnH5xNLkWWiSfFITKnXp1JleYakmDfEye4YHfPsNDWlBnOXjGuIS9jffEAUHK3W5aofPJExJPJ65Hk48MMVOP2x8Fd0aSzidfHNnGkOVvuSO7714hBZCGl9t6N44=
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com (10.164.51.157) by
 HE1PR07MB1289.eurprd07.prod.outlook.com (10.164.51.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.14; Fri, 2 Nov 2018 11:04:55 +0000
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b]) by HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 11:04:54 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: stratix10: fix multicast filtering
Thread-Topic: [PATCH] arm64: dts: stratix10: fix multicast filtering
Thread-Index: AQHUcppkcUhvTRsJYUaof7ZKCW1t8qU8UgpP
Date:   Fri, 2 Nov 2018 11:04:54 +0000
Message-ID: <HE1PR07MB13074BFFE7E34338FA29EBFCF4CF0@HE1PR07MB1307.eurprd07.prod.outlook.com>
References: <20181102105355.18654-1-aaro.koskinen@nokia.com>
In-Reply-To: <20181102105355.18654-1-aaro.koskinen@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB1289;6:1i9SqxCnifEcAIjVCTNzq2KpFjsbpt9misZqE/FBPgklbrfGPE+g1L3i7GgfRYo1veNnZkhRhWsr1FFhWhLjtUCTjFDHJNV5tLJlO3Dbozf3Zw9ilDMJdKB0bNXkh0Nv7WaKx4+WMBXskPkrjdE4SZmGpf3XovJ+cn9vAQaujiRx7vCgSAMX5XDOFRP+hnJt4VsIhfflSAALP8BzlsOs8Nr6Eg7qaJSVO0DDh5NXiswr1kzFI8Ia0MYBqmhkIEuiqoMZN+yBmYCn6zzVnmS6mjCj4Yw6jd+jS67SmTKWTqVJ25YLieFIZ2gM4MPIZAEAZzAdXhEqzGetkQtKKlBpwjAu2DgKf4GQ2WhLa0sUEJ9WLl3r3Jvc3pO7ZnDrefCZaDn3xvb75tgvO+B/dsvVBUqZ7XjBE/Q8TU/8mE74VxWegPkIV8laU+lwKXd/cvxI20mypCuixbv/iWR9TXjbvg==;5:3D2f65Xneh5vVCe6PCSdrsJGOWtJHLjJnxGfZ64SB3jfDZ4qJaYa5E4HsgY116oGrPKGFgQDSiW8cLTjhUju0mfqpH8RgqQJYbnTVWWQV6UnIVh7rl32y+56ZU762zRFNqpzvok6RnaOHX1cAXiUygxovdFea8vS9oQ7X3VACKA=;7:A+/ClPbykMdoh1TL1rxO7OUEhQwDlNskEdI08jjH8yW/ojxEXpeplG5SxJkpErAkeN5MadkCGuoiFU5g7abZEQI46pe/90TYEId12crpORvk5FAyTyGOQYyhSGNYuJkM05F6kXMWTfm5Ex7/T2Udgg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d14533e4-ebcf-4e59-a510-08d640b30529
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB1289;
x-ms-traffictypediagnostic: HE1PR07MB1289:
x-microsoft-antispam-prvs: <HE1PR07MB1289C0EB326795B397287489F4CF0@HE1PR07MB1289.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231382)(11241501184)(806099)(944501410)(52105095)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB1289;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB1289;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(81166006)(68736007)(6246003)(486006)(106356001)(229853002)(305945005)(97736004)(54906003)(110136005)(66066001)(2900100001)(14454004)(446003)(256004)(478600001)(11346002)(186003)(26005)(476003)(86362001)(105586002)(102836004)(558084003)(9686003)(99286004)(6506007)(33656002)(316002)(25786009)(2906002)(76176011)(74316002)(4326008)(6436002)(55016002)(53936002)(6346003)(81156014)(5660300001)(8676002)(71200400001)(3846002)(8936002)(6116002)(7696005)(71190400001)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB1289;H:HE1PR07MB1307.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-microsoft-antispam-message-info: y9J78EzzCHazUn1Rgrk3/otaSJ8wkU5gmIztOOiVKq2dmqf7FF8rNJeVS9NmcOgBRw7aZr1vX0+M9c9HeMGqnM3gw67QMjAadwOs6mCkQTQOUaK+FxxFTGHkywMCvY+1uDFNZHKqArNrIO8bVTl/0egd1zHI1ULDRd9dkWeGL8Wmoi/1x3nBpxTJOmxBjNOSWPaJ5dLUa1Ntu/b2O1NxggoccBFWW4kzK2PQ3WIGeuK9P9/0GrJgGe9inj7eQvJRUganbkUZ9E4xqwjRCfVNvchzeHDdsv3pwIkr4yGjsEZpOj46eigpVSSzIBrQjbW2cxLqfxju7cytjBlsatSiZXpO0kFdE9EafmRt8iVFJlw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14533e4-ebcf-4e59-a510-08d640b30529
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 11:04:54.8271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB1289
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please don't apply this - looks like the company SMTP server mangled the Fr=
om
header. I'll try to send v2 with a workaround.

A.
