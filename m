Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAACC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57558214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RimMSGm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57558214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHUSKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:10:51 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:43908
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUSKu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWAwmmmrlFI+5I8b/4fO1bqh0BbLIHTipMZqeeaeYdw=;
 b=RimMSGm6aT1KbZ4JQ37rFxG/xBTsjoiSfVjm6X5I9F3hKGrPKDLxZenj5htL5amcUhxBgOzr0N9GJpROc3KTt7PPnQT2iKuK/lUZVMHHHm9TBp9ZHpXNJZtpc2Z2lKiuRBnoc3v6wLZa+ktQmEw4Vwrs9sz6VTVyl2GDd8UAkTQ=
Received: from BYAPR07MB4709.namprd07.prod.outlook.com (52.135.204.159) by
 BYAPR07MB5048.namprd07.prod.outlook.com (52.135.239.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.20; Tue, 21 Aug 2018 14:50:20 +0000
Received: from BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::199a:258c:cfc4:4704]) by BYAPR07MB4709.namprd07.prod.outlook.com
 ([fe80::199a:258c:cfc4:4704%3]) with mapi id 15.20.1059.023; Tue, 21 Aug 2018
 14:50:19 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Bin Liu <b-liu@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lukasz Tyrala <ltyrala@cadence.com>,
        Alan Douglas <adouglas@cadence.com>
Subject: RE: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Thread-Topic: [PATCH 00/31] Introduced new Cadence USBSSP DRD Driver
Thread-Index: AQHUH4o1bKndmEN6kkap8iKK8m7246TEnP8AgAXZleA=
Date:   Tue, 21 Aug 2018 14:50:19 +0000
Message-ID: <BYAPR07MB47091F95E8AB1400865E21DDDD310@BYAPR07MB4709.namprd07.prod.outlook.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
 <20180817210534.GA11144@uda0271908>
In-Reply-To: <20180817210534.GA11144@uda0271908>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctOGI4NmRiMjItYTU1MS0xMWU4LTg3MWItMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDhiODZkYjIzLWE1NTEtMTFlOC04NzFiLTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iODY2IiB0PSIxMzE3OTMzNjYyOTY5NTcwOTAiIGg9IlB1TGV4YVoxK2d5VjVpcUlPcDEvZlFZdjJ2WT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pawell@cadence.com; 
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR07MB5048;20:ZOieZy6f4ey+D9f2gjeuxGx8g2oZFdOBiQtfVDgKGHVJA3coyFVbAM6Sr9a56DMhqNEvU6YOtdr/O8TBh7GxnCAKyFS/qrlzrtHTtX7vry5llXS7coSC2oe3qRRDTzWIVcTthBtEIAbWisjpLniHvu88FHoNf4/ptMHd4bQ4CxIjQLEQb5b/xfINIVJ8SaBWSwaFs1b1IylHLC01UvqjhZ5hB65gPS/CSde80BFn7z4eHJ4W3O2EJrx8KuZ/nP18
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(39850400004)(396003)(366004)(136003)(376002)(36092001)(189003)(199004)(26005)(74316002)(305945005)(102836004)(5660300001)(316002)(99286004)(6506007)(5250100002)(7736002)(256004)(6916009)(7696005)(2906002)(54906003)(68736007)(8936002)(217873002)(105586002)(76176011)(478600001)(186003)(33656002)(476003)(14454004)(6116002)(2900100001)(486006)(446003)(229853002)(55016002)(81166006)(6246003)(97736004)(66066001)(11346002)(6436002)(106356001)(107886003)(14444005)(86362001)(9686003)(81156014)(3846002)(8676002)(53936002)(4326008)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB5048;H:BYAPR07MB4709.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: b0302a19-700c-467f-799c-08d607756a46
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB5048;
x-ms-traffictypediagnostic: BYAPR07MB5048:
x-microsoft-antispam-prvs: <BYAPR07MB504857C58A1B08F65266839EDD310@BYAPR07MB5048.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:BYAPR07MB5048;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB5048;
x-forefront-prvs: 0771670921
received-spf: None (protection.outlook.com: cadence.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 4oxsygZGt1NugmV0RmW0C0Cb6f88XLoSaJ28JVhG1Sk3SHPqFKYaixbesZhZnXIHg6lBvCNY9QGz5qt583ottgnMAsT5cVbkrB0YAUua4U7A5s9uPs5BhM9ANqAlLYr8zI8TiiQelFBO9JWod1n+8M0CrAelcY4iqSi/MW6pcjPOESt8TTws3hPsfd/REZuwwVA7etrKsFMyt8OoLSvruQKkm8mFFAmGQaDMrQAnlQ2eb7AisBYRpL007pU7C9Y9Cv31Hq53AkjPLmQ94mqRrw/mXg9kK7tGOHIKdbq0WxmqEc2CRfMKqJDfJhYS5ziNizXmuCITQMg6GeTPbgUXRe4AOoChuxrRTtno/EpoanU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0302a19-700c-467f-799c-08d607756a46
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2018 14:50:19.3044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5048
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

USBSSP it's the project name and it was the reason for such prefix.

I agree with you that the shorter prefix could be better and we could get r=
id of some warnings reported by checkpatch. Currently we have more importan=
t issues related to testing and debugging driver so decision about change I=
 leave for the feature.   Such modification could be made as separate singl=
e patch.=20

Cheers,
Pawel=20
>=20
> Hi,
>=20
> On Thu, Jul 19, 2018 at 06:57:33PM +0100, Pawel Laszczak wrote:
> > This patch set introduce new Cadence USBSSP DRD driver
> > to linux kernel.
>=20
> Does the driver have to use 'usbssp' as the controller prefix? Is 'ssp'
> acceptable? It would make the tons of variable names shorter and the
> code much cleaner to read.
>=20
> Regards,
> -Bin.
