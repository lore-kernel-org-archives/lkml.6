Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E14C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4620B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 09:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=MicronCorp.onmicrosoft.com header.i=@MicronCorp.onmicrosoft.com header.b="bTgttDHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfAaJWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 04:22:46 -0500
Received: from mailout.micron.com ([137.201.242.129]:29555 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbfAaJWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 04:22:45 -0500
Received: from mail.micron.com (bowex17c.micron.com [137.201.21.211])
        by mailout.micron.com (8.14.4/8.14.6) with ESMTP id x0V9MdtY002177;
        Thu, 31 Jan 2019 02:22:39 -0700
Received: from bowex36e.micron.com (137.201.85.221) by bowex17c.micron.com
 (137.201.21.211) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Thu, 31 Jan
 2019 02:22:39 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (137.201.84.23)
 by bowex36e.micron.com (137.201.85.221) with Microsoft SMTP Server (TLS) id
 15.0.1365.1 via Frontend Transport; Thu, 31 Jan 2019 02:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=MicronCorp.onmicrosoft.com; s=selector1-micron-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Qmo7GBYwiBT8JD8b4sL+jZeXviSQ7RWPJfMU5WSg1Q=;
 b=bTgttDHIjhp0zZpI5MsHvaJ+FI14rKEq+5ga9SBVZwD2cl1uDsj2Y7v2Q/p6+oWHSpiyWHgPslrwJw6QV30/UDFDFB2PPdY47gw5MO2dwoU2bdy0xEuGnBvsOiB+sDxTal8rlrJdo+lT6gnt0kri5DElw3Okpdn0e9QY5yRPNns=
Received: from BYAPR08MB4533.namprd08.prod.outlook.com (52.135.234.15) by
 BYAPR08MB6135.namprd08.prod.outlook.com (20.178.52.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.19; Thu, 31 Jan 2019 09:22:38 +0000
Received: from BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669]) by BYAPR08MB4533.namprd08.prod.outlook.com
 ([fe80::911c:eb84:5e0d:c669%2]) with mapi id 15.20.1580.017; Thu, 31 Jan 2019
 09:22:38 +0000
From:   "Bean Huo (beanhuo)" <beanhuo@micron.com>
To:     Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>
CC:     Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: RE: [EXT] [PATCH v4 2/3] scsi: ufs: Allow reading descriptor via raw
 upiu
Thread-Topic: [EXT] [PATCH v4 2/3] scsi: ufs: Allow reading descriptor via raw
 upiu
Thread-Index: AQHUtg8lyoMJBvKg8Eepzu4+KWAhlKXH6zkQ
Date:   Thu, 31 Jan 2019 09:22:37 +0000
Message-ID: <BYAPR08MB453333F63467E4374570E2E0DB910@BYAPR08MB4533.namprd08.prod.outlook.com>
References: <1548572868-12589-1-git-send-email-avri.altman@wdc.com>
 <1548572868-12589-3-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1548572868-12589-3-git-send-email-avri.altman@wdc.com>
Accept-Language: en-150, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=beanhuo@micron.com; 
x-originating-ip: [165.225.81.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB6135;6:6TYZvmS+bDe97G1O5nvjUbB+sYHw0QB0qBJw9yAF4Ucw6Ab2ncKiFnjL2sRvEuKzyoZjKkfsjhow+ADyLz8i6fB5juwQEPLP0/7HPR4piIkXJQ2gIuUUhTBTSwU8B6x+KvghQTKY7GJWUqISmPlWKUnRjkLSvz814Dp8DH4sXCiF15oIDrX+dZUFm+lPexZ/mSbTjjR8+jr+ax+Iwbjtw63ieYzTtP2PsaTUMQkB1rUNXREbF7mYv1A3R3XB09gKgqv8FwHV/kkDZS/Gkg64YUrRyACJcoMB+Y48ehasqnsuqfb3akCf8/6OhAVHxxFrhsZkUPFbTySw6j5NW6prUN8UtNNgbSJwVzGZ2tq9/2ksf1O5hZBDbjcpeLpTU9qAtJLnNlYPa2RkI8CGMrc5E8noPuQHFaC8oKzZ84sz47TeqeXqkd3jiPp35ZrS64XaKbCHbGHYyaEqsnDqfZcUAg==;5:M9Tg8/qxzROQ7r+P/pna9h7JNZ1fAOljbJumafbDdtmhuB4cpumqaYv0AyyJGUqefsFgUr5vrdCKLtVlTD7R9V7ceXYKonvIxXMGSQPBIRt8WFs3l5Q8Q2Gg88KPmv72mdoUSp1EOAGyUTgncYvycbsfGwz7LtIHtzGYMIJyMc5TPWjY9+aVTN6d6pu40dEgpnJsp0Lez5bEsTxPbiCuEQ==;7:dg06Yj/o0wT1fnUMqHh2PmVR+6HrfFS4xIf0W6iMyktFOeneoB1LViDDroS/l7cekfMZqVJAodQY3dCbSqRGd61fX0qrzf0A6fp/0Uqmi774xTqcJd/o2D+yZ4TEiArXwWBDZCzCDcQUDz+WE84XXw==
x-ms-office365-filtering-correlation-id: 57415608-0fa5-41e9-260e-08d6875da47b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB6135;
x-ms-traffictypediagnostic: BYAPR08MB6135:|BYAPR08MB6135:
x-microsoft-antispam-prvs: <BYAPR08MB6135AF110B825A652B295BE7DB910@BYAPR08MB6135.namprd08.prod.outlook.com>
x-forefront-prvs: 09347618C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(110136005)(54906003)(86362001)(97736004)(316002)(7696005)(68736007)(14454004)(4326008)(25786009)(76176011)(105586002)(99286004)(6116002)(305945005)(2201001)(74316002)(71200400001)(106356001)(7736002)(71190400001)(478600001)(3846002)(6246003)(26005)(558084003)(2501003)(229853002)(9686003)(53936002)(81156014)(486006)(66066001)(55016002)(6436002)(2906002)(81166006)(186003)(11346002)(476003)(446003)(33656002)(102836004)(256004)(8676002)(6506007)(8936002)(55236004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR08MB6135;H:BYAPR08MB4533.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: micron.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: RPh3s2CVQ7UW0vAREi7qk0NltJCiIk1c/TNM8n8tcshIDloUk2I9rZlmT0IoR/zIU8ncuyi841VnbjJp6GWyGQXPqt4C8vdJitQG60yT7mojwvJb+j+q1KSVbNA6XyAGKV4468wZ0GOP7+Y6Pz7tFemfPuiuKV8MVJ92hq5dvOSgE4Bs7R+IKHx8sdNW/GZ8qaBclomR1ocnDK9ixkfIEizyfyYlqZF7qZGQJ7/Uwo3O4UNlBKnaqjb8u6K1IKZgKFeKvy5ZZSeFWriJ7Y2SVuQwDjfPPgj1vwz0l/W8Q1ZMK09ZNnAhFSRTeRG3OGzWr763TrhO4VwVvDGMPLpsvIV7Lk+5uTumyz+rlVFKDq6TxQi9CHRNuXj1jGou3ilCISmyE3uLCyFbT2+kXrh+ZaAyU53VgGO+1dh3BaTk++k=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57415608-0fa5-41e9-260e-08d6875da47b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2019 09:22:37.9165
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f38a5ecd-2813-4862-b11b-ac1d563c806f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB6135
X-OriginatorOrg: micron.com
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-24400.005
X-TM-AS-Result: No--2.583600-0.000000-31
X-TM-AS-MatchedID: 150567-157008-139010-701475-850702-851106-148004-148007-1
        48020-148050-10008-41000-41003-42000-42003-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
X-MT-CheckInternalSenderRule: True
X-Scanned-By: MIMEDefang 2.78 on 137.201.82.98
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Signed-off-by: Avri Altman <avri.altman@wdc.com>
>Reviewed-by: Evan Green <evgreen@chromium.org>
Reviewed-by: Bean Huo <beanhuo@micron.com>
