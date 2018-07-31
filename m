Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DC6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84553208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 02:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KQEsaUIl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84553208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeGaEYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:24:30 -0400
Received: from mail-db5eur01on0041.outbound.protection.outlook.com ([104.47.2.41]:17833
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725853AbeGaEYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcOoBz3LPEauP1mHwA9ns1AWz6gLo0KCJuVXEZUuc2Y=;
 b=KQEsaUIl68IJtTJDCB6oTtv5uAb/67i+FpTTtVyQrf4Bne3AWvMzs4PMrtCdl9o1hPvr819Pqxm5ZRJhC15uEpqdTWCXFwVY8CQ8Xvd+SvCm9IzK+BLQn847AnwgyirSBwvc5JNisEUD4DFJyLG5wn7Nj7z+bwQcSmP+WhZg38Y=
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com (52.133.39.11) by
 AM0PR0402MB3521.eurprd04.prod.outlook.com (52.133.45.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.995.21; Tue, 31 Jul 2018 02:46:29 +0000
Received: from AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13]) by AM0PR0402MB3747.eurprd04.prod.outlook.com
 ([fe80::f13e:2610:6ff8:cc13%5]) with mapi id 15.20.0995.020; Tue, 31 Jul 2018
 02:46:28 +0000
From:   Pengbo Mu <pengbo.mu@nxp.com>
To:     Felipe Balbi <balbi@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: RE: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst type
 adjustment
Thread-Topic: [PATCH v6 4/4] arm: arm64: dts: add property snps incr burst
 type adjustment
Thread-Index: AQHUInCI51IGJAbi3kyLeYw0fc9hyqShXYqAgAdKjTA=
Date:   Tue, 31 Jul 2018 02:46:28 +0000
Message-ID: <AM0PR0402MB374720F0D369137620BEEEB7F42E0@AM0PR0402MB3747.eurprd04.prod.outlook.com>
References: <1532341959-3478-1-git-send-email-pengbo.mu@nxp.com>
 <1532341959-3478-4-git-send-email-pengbo.mu@nxp.com>
 <87a7qe1cds.fsf@linux.intel.com>
In-Reply-To: <87a7qe1cds.fsf@linux.intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pengbo.mu@nxp.com; 
x-originating-ip: [92.121.36.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR0402MB3521;6:eV+GYH2lNlzcMPnBB5seuyCT6kXq96Cdzw7xXLPaMpjXIBcdemA/TYq6utYKdiD+KpkvmmaF7kzeFFKyoXTITos4ZPgx/zXKsoPrcMQCsU69A1tdpy+7GDnYGMvKbgl8KG/IyVHRNlJW7L1lTCWrpI740KYueols3xKZUjEo1ULLsy+bxIqsDdUa7G3lsL/4+OjwCotsFsdJd2s/oFecoFFuMe/KBciTdeuDoZ9/+reyZlBBccDpH9ZatTUDb/4VL9NSKsyilYJ/pRA+R2gzeDCQWjl0y+aRupCT+02gu9JasUCeIh50AHH/JJzi60B6lP5yQyvcJlIbXjU2wnFtGYaRfbx4wyuo97LHq3A7/KbfsQgTy68sc80NsHjFSsgVYKAP/M3+pQga6Y4C8grxRAbQjx/lnD6YDRcpKxR6hMSg6azG27m/gajT3/ohREMtOnK/gCAm37yJdhiBfSGReQ==;5:caKOYbm+0hZ3aIR5XIWWAtZmFgPY5OZLcqKTUWAJEAOt1XVBwNbDJ8wIpz9lpRcI53wi38cj0KTZuQAYwBDPo79skICMYk2JMPgp6AUWiJsfrcFRJL2CTwrKMXMI2a1W8mUs5BjBdpKTsZrcFb6mN9IeK+lGuEOfOkBq96g10r4=;7:yrkobD+TjLlMMHhS6f/oVLe5zRQmeloGjlIH4un8yJNY4MNMj+8ekhu9pKwI72FtpsJxANF1cjHKUU0xSBrbCnxwyy9IGAMkr+eS8iOZRumiwTDpoIOimh5NqYBxSsIr6qjDjBZg6ylzwMtRmOWMT4Xqb7XntZgvWfbhj/W1jI3P/0knsIwwAFsF6EFiGDZqmPiREK1/noKZHr34fabw9RAD5W/r7clGDBi0gLv2qh/DCw3nhN8lb3YBuJKIOyZd
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e48715b1-ef54-4560-dabe-08d5f68fd0fc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM0PR0402MB3521;
x-ms-traffictypediagnostic: AM0PR0402MB3521:
x-microsoft-antispam-prvs: <AM0PR0402MB35217975331F9DFA100C678EF42E0@AM0PR0402MB3521.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(185117386973197);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:AM0PR0402MB3521;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0402MB3521;
x-forefront-prvs: 0750463DC9
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(6116002)(4326008)(9686003)(26005)(76176011)(25786009)(7696005)(86362001)(6506007)(186003)(102836004)(478600001)(66066001)(7416002)(5660300001)(53936002)(55016002)(54906003)(446003)(105586002)(106356001)(256004)(2900100001)(3846002)(6246003)(8676002)(305945005)(7736002)(81166006)(33656002)(97736004)(81156014)(486006)(11346002)(476003)(14454004)(2906002)(8936002)(99286004)(229853002)(110136005)(316002)(44832011)(68736007)(74316002)(5250100002)(6436002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0402MB3521;H:AM0PR0402MB3747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: g/4ZC4s4oPcbmkucj+t2xgQfPp/3Uj8AyUe/GHua1+JyCrHSAcAbCOrAWONkA8+NsHFSTLzPFG8h79T+SvwSb7dLrWKoeCh4S2vEd4BeM6KHeGo6TwyyqI9nC1MFkvUHsme2RVmltUKkJjqPo5uQg1AvVO8tM6jrNSWPB+35k+pAxNUFtFbgs888ITE+4rxE8D/wFkeuz+9XSBOW43FO8Gk+Fj9BZwKHOjBfkudic3umzQQe4V2zOzJ0THQ2kAbkjao+BjYTGX722XRTRSc9hJ0c4uW9EvWmUWWrnU/S4AvSC2FQAgpk66hHmfXf9Xn4T6mke49gMnS5NRJ7T23Y3y3+kh1lWp5Aqc6+g1kZiX4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48715b1-ef54-4560-dabe-08d5f68fd0fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2018 02:46:28.8740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Balbi [mailto:balbi@kernel.org] writes:
> > Property "snps,incr-burst-type-adjustment =3D <x>, <y>..." for USB3.0
> > DWC3.When only one value means INCRx mode with fix burst type.
> > When more than one value, means undefined length burst mode, USB
> > controller can use the length less than or equal to the largest
> > enabled burst length.
> >
> > While enabling undefined length INCR burst type and INCR16 burst type,
> > get better write performance on NXP Layerscape platforms: around 3%
> > improvement (from 364MB/s to 375MB/s).
> >
> > Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> > Signed-off-by: Pengbo Mu <pengbo.mu@nxp.com>
>=20
> will this go through arm64 tree or do you need me to pick it up?

Hi ,
I am sorry for I don't understand what you mean .
This patch fixed the dts files of arm32 & arm64 , so I named the title like=
 "arm: arm64: dts ***" .
Is this something wrong ? If yes , pls tell me and I will fix it !

Thanks,
Pengbo=20

