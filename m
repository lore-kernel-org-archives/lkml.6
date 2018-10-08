Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61ACC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906C120C0A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="3Ih7W5Cn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906C120C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbeJHXOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:14:49 -0400
Received: from mail-bn3nam01on0073.outbound.protection.outlook.com ([104.47.33.73]:39762
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJHXOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HY9hyG3ZfxyHGhTTeaPrYWQ7La8HL0s4QgdYc25b3s=;
 b=3Ih7W5CnNoM+uRuZq9oR+GQVP6elZXrp7UPaW5FGkEa9MNonN5wNT1QhPHRpA1hZKTBcjKjDhdc6bFxW6fQBu6D5DkVVFPwCGGQHYS4//D5TA+8kdZMDQedGa0iyr1enap8leiWnVwDAxHqA/VmgYOr7o9e4ff0hgiL0f3Q3enY=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1457.namprd12.prod.outlook.com (10.172.24.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Mon, 8 Oct 2018 16:02:22 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 16:02:19 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: RE: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Topic: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Index: AQHUVARg2MOAZvRixUSipQEGskb4iKUVfsWAgAAD/oCAABSD8A==
Date:   Mon, 8 Oct 2018 16:02:19 +0000
Message-ID: <BN6PR12MB180971CA88D1B8D580512A71F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144421.GB15968@kroah.com>
In-Reply-To: <20181008144421.GB15968@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1457;20:M2T58Zz28JQn0hHDfzoV28PE7NbZNQHATycOS6epYVBmaL2LKKB/7/Qe1kAtsZ/jqxaB0Ce5gS6xOgkWSLrVLzEUSL2TcdB3ICQMPaB1qIxa9eGnMCOOcUFpGHUU5Huvu8DsoqXL9aQIxPkO9jiw1p9Fh8RY2QjCy8urgaqqVQeF8Fv0UPe3N36BQIhtcAxC7E86s8RmIqBoXu9srPDNFvpA4w7GsZlBVuGD7umsnqmbun/5TgfacLpZWAhOYHdg
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(136003)(396003)(39860400002)(199004)(189003)(13464003)(4326008)(476003)(486006)(3846002)(6116002)(6506007)(53546011)(66066001)(93886005)(14454004)(966005)(106356001)(71200400001)(229853002)(5250100002)(71190400001)(68736007)(6246003)(446003)(186003)(11346002)(97736004)(26005)(102836004)(25786009)(2906002)(8936002)(54906003)(316002)(2900100001)(6306002)(53936002)(6436002)(72206003)(256004)(7696005)(33656002)(105586002)(76176011)(6916009)(55016002)(478600001)(86362001)(99286004)(81156014)(81166006)(7736002)(5660300001)(9686003)(8676002)(74316002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1457;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: df9d08ba-d19d-48cd-ced2-08d62d376d1f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1457;
x-ms-traffictypediagnostic: BN6PR12MB1457:
x-microsoft-antispam-prvs: <BN6PR12MB145737D2FA2F641007E029AAF7E60@BN6PR12MB1457.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991055);SRVR:BN6PR12MB1457;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1457;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 88STgyy0j7OPqbGJ3e19igUDxW4Jf4dLdg7R54ah9pk8X1Ivdjodct7ZsgY8X0s0eq6nzXGuJxe0SnH8C/wV5rfdrX/KzlG7D+RS3I2TOKEus24dYy4HtZjFbFzVNGyvcu5LVFP24Gokm3bHhwwn4H2IdqnIXn/Asq3C2xVHXeW3IqI7i+TlACq6/OEbWONJ6jqc2sZRq1XER+iKOFMW7zX8VbP6KF/CRiNM8Yr9jBnw2amzIM0PXiWyiT1ebNXORFG9yBrYNhdiq4rqFXjfFcMovOCg5NMzuCZJi+2d9bJlh/NqPc7mAih4hqsKB+YX+FzTyxaiH9ywmDWJtp0LFv4j1Jgb8zL78Z0AhqZGRJs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df9d08ba-d19d-48cd-ced2-08d62d376d1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 16:02:19.5506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, October 8, 2018 10:44 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
> <alexander.levin@microsoft.com>
> Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> for smu7/8
>=20
> On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Monday, September 24, 2018 7:53 AM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
> > > <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
> > > Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to
> > > DC for
> > > smu7/8
> > >
> > > 4.18-stable review patch.  If anyone has any objections, please let m=
e
> know.
> > >
> >
> > This regresses power usage on 4.18.  Please revert.
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D201275
>=20
> Is it reverted in "upstream" as well?  If not, please get the fix in ther=
e and
> then I will be glad to backport it here.
>=20

There's no breakage in upstream.  This patch addressed breakages in 4.19 sp=
ecifically due to some other refactoring we did in the driver.  I'll try an=
d dig out the exact series of patches this addressed.

Alex

> thanks,
>=20
> greg k-h
