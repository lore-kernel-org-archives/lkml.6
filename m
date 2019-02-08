Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D02C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 765FC2075C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="S0xQTteS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbfBHP2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:28:05 -0500
Received: from mailout.micron.com ([137.201.242.129]:55845 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbfBHP2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:28:04 -0500
Received: from mail.micron.com (bowex36e.micron.com [137.201.85.221])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x18FRrpd009333;
        Fri, 8 Feb 2019 08:27:53 -0700
Received: from BOWEX36F.micron.com (137.201.84.51) by bowex36e.micron.com
 (137.201.85.221) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Fri, 8 Feb
 2019 08:27:52 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (137.201.84.23)
 by BOWEX36F.micron.com (137.201.84.51) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Fri, 8 Feb 2019 08:27:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8yyIRqNnH7q+UNBX+bxcAycfk2NpFkHWSY1UdOoY6I=;
 b=S0xQTteSnxgnGNDJ64TuzqruMkiXA4SOeqXgWcZ4oNB39xuw2O1pFam9YeDaIb9px5AikIWZil7h17xz4lh8knFEHSjePVASIwx5ntQpDgRrdnAL0JT5yBiymXUVfeb6HsHvTwWmdCYZjJRrJB7Q4pTpuRJ+SIvbOfzD2XdRv+A=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB4487.namprd08.prod.outlook.com (52.135.211.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.19; Fri, 8 Feb 2019 15:27:49 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%3]) with mapi id 15.20.1601.016; Fri, 8 Feb 2019
 15:27:49 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     "Tudor.Ambarus@microchip.com" <Tudor.Ambarus@microchip.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "richard@nod.at" <richard@nod.at>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Topic: [EXT] Re: [PATCH v2] mtd: spi-nor: Fix wrong abbreviation HWCPAS
Thread-Index: AdS/uVD1jG3UvCBSRuC2oJ8LRRcc4gAA03cAAAFVpvA=
Date:   Fri, 8 Feb 2019 15:27:49 +0000
Message-ID: <BYAPR08MB45335415CC3690816C1FD603DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <BYAPR08MB4533C8EA6B775C7514FA7F82DB690@BYAPR08MB4533.namprd08.prod.outlook.com>
 <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
In-Reply-To: <298d18cf-094b-d5d0-45d1-39c7b75ba309@microchip.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4487;6:XgZyR5VP0zNDhCau4/58SybKZNDYntdRwY5ICF1PR3E+mu3BvBpNeLm2hrJNUixd8HWDzL5JbLjHayz9ex77D6osr0wxSQ+J16Y30VDWdcZMjH6MU1v7O9iZwEZRL64sXPfw4YQgEVo95K33BTVjoGegw+vDGL078MSip93ryteMK/4r0YtQKELJ8rdXfddNsWJYRCWPeh7Rwox49OjAac231e0NLa11XnaGaa7sZZ5PIcXzwvEzSu1EDuXTbGTwv94INyrirExvJxxXqNZbbld90s8tFi7BbYBLetMqiUyZ/aTsjS5hhgHBJHQRdkluYeVMC262crUHOLVbv15VcOVLgAO1uzGni8jXF8G/CRynw+wuOBmP+4kEw7oGhB1vrfsJ44kfb+cW91xjFdPoBcl1+8d5e1z+yYBmypiIao2wxBoc91KI1SeOp6cG3NIHw3AIGL3TOHicZQYju3IWyw==;5:EA2yfNnadfMBRYPWwy3UGdH15UPLHiUYKTYPxUohZekmYpIzjL6MkbeQOh92Fh8MHyM0vGlIxISf6zSXKJjM/vjSoCwm1Ox60MCsauDg97TzpI7PBLYvbgHS8X2iQgQY82YQg19SKHP7AOMnJ6ObpxyhdX3EHz2+1Saw+39hzLsg6SLwOvUB/laUSfrzpOhOUEu4uHqaD0N8+l6cWToMPA==;7:T7oWKO+O074qcfC35sI8BzWExh2LQ44XM+6x1HEfOfxs0sOU98SCmTVx0jgNHYCJhptDaMHMc6zUoV3ipiOisfErtNs/9Pm95XJXy8DU1m2IOtRPl3dA7OGSjX/NuOPYWXaJ+NpDah7o+Yq9dailCw==
x-ms-office365-filtering-correlation-id: 9a9c0b1e-5c59-4fbc-21c9-08d68dd9fc05
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4487;
x-ms-traffictypediagnostic: BYAPR08MB4487:|BYAPR08MB4487:
x-microsoft-antispam-prvs: <BYAPR08MB44878021F26251D6FB721C15DB690@BYAPR08MB4487.namprd08.prod.outlook.com>
x-forefront-prvs: 094213BFEA
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(8936002)(81156014)(81166006)(71200400001)(86362001)(6506007)(2201001)(9686003)(71190400001)(102836004)(55236004)(256004)(14444005)(26005)(76176011)(99286004)(33656002)(3846002)(2501003)(6116002)(68736007)(186003)(8676002)(229853002)(105586002)(7696005)(106356001)(11346002)(14454004)(4744005)(2906002)(446003)(53936002)(486006)(316002)(476003)(97736004)(110136005)(54906003)(25786009)(478600001)(6436002)(305945005)(66066001)(74316002)(4326008)(6246003)(7736002)(55016002)(21314003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB4487;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0JMdaqx9SjXok5wIkKcbYFDrmb76MwrffbF23c+Y8FLFrGvGFptlerTSc3OJfGbsZNEnrcb86pUnSjz0PECIyp87z1H1F9HQKWhA6cBzRhWS3nhFkb+dzAsTpJbl3C2JsogXpVUOqmPkWVIsJPw412BdR8gkvGhtiHbHXQvYgwr0mgg2CtyKaq06T8OyJ5auSdhrZYWfB4RHKSHPxIKqAu5YBF0xgArqGD99SKz/cmH9Le70tEIcpBnvU9zwLIO9yGiMCsFX6Ad3FK8ouBJFVcTiJVcs4JEIcRccfcSiHSVsf37Zq21VHENh4l5xFtg6v9Ldmb/knQqpObqHlVfVKncgcgxFmiuoeqahnQtcnlpAtDaZ4vEPVHip9KvEgHfwRcnPmOceJb4l8Ue4MpepeLl//W85R/Km/j30NP1Q0Fg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9c0b1e-5c59-4fbc-21c9-08d68dd9fc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2019 15:27:49.4708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4487
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24416.005
X-TM-AS-Result: No--2.406400-0.000000-31
X-TM-AS-MatchedID: 150567-139010-706159-705178-703283-703179-703969-851106-7
        00752-780014-700756-106230-707210-701236-700107-148004-148007-148020-148050
        -41000-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.130.65
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Tutor

>$ ./scripts/checkpatch.pl --strict
>v2-mtd-spi-nor-Fix-wrong-abbreviation-HWCPAS.patch
>WARNING: Missing Signed-off-by: line by nominal patch author 'Bean Huo
>(beanhuo) <beanhuo@micron.com>'
>
I think, this is because of our email system, it always adds '(xxx)' betwee=
n user name=20
and email address.
If you are convenient, please help fix since it is not such hug change.
Thanks,
//Bean
