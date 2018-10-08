Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E6CC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6055213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ISlpKJhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6055213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbeJHXS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:18:29 -0400
Received: from mail-eopbgr720059.outbound.protection.outlook.com ([40.107.72.59]:47636
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726291AbeJHXS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6o4CaGmlYXX/7UauJvdIxFyxXe+RwxZzr5JpczyOOA=;
 b=ISlpKJhP4Ag20K9f2Un7iNW3TdoWtQkVg3HD9K/WKr3kbpMxnXvcpqPwUMV8Uc7QSXywA9BKQJq1EfZv6q6+q4AVwV9No7J2FknEW1/4idz6To/AAfHBIdOfSVbkw2mg4k6mg/YwgLOmFrcRYQSZFG3Rb8MBtUqyhhFjLT+VzLQ=
Received: from BYAPR12MB2775.namprd12.prod.outlook.com (20.177.126.76) by
 BYAPR12MB2805.namprd12.prod.outlook.com (20.177.126.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Mon, 8 Oct 2018 16:06:00 +0000
Received: from BYAPR12MB2775.namprd12.prod.outlook.com
 ([fe80::ec24:8f00:e74e:294b]) by BYAPR12MB2775.namprd12.prod.outlook.com
 ([fe80::ec24:8f00:e74e:294b%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 16:05:58 +0000
From:   "Zhu, Rex" <Rex.Zhu@amd.com>
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: RE: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Topic: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Index: AQHUVARgsJ65BPuexE6og14inJEYzqUVf9oAgAAC6YCAABXIgIAAADWA
Date:   Mon, 8 Oct 2018 16:05:58 +0000
Message-ID: <BYAPR12MB2775365789A38F9D81CEC45DFBE60@BYAPR12MB2775.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144421.GB15968@kroah.com>
 <BN6PR12MB180971CA88D1B8D580512A71F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
In-Reply-To: <BN6PR12MB180971CA88D1B8D580512A71F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Rex.Zhu@amd.com; 
x-originating-ip: [124.77.189.88]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR12MB2805;20:zTxhJL5xUSPvDdBPc1A6Utzv49r9ke/yo3WX6D+tSf2R2sfK34jW3+CLuU2n5bg+nkRLY3RTxANYT0VjmUk2a3+EIGYUySElgQXDtCf7t3rkaPZ/7yP7Lr8woO7jEChfnV2pA/62L/YNim6wEjql4fuK1J+lwSuh7pgn6pqT4zCSvqO28WnGysStEtfYIq8lQ6KgImKzX0bAHxY2osVU2+m+M/pwRyV22OT9Z/WSN1YVsiiQhRxWKdIL1rm1tLqL
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(396003)(346002)(366004)(13464003)(189003)(199004)(55016002)(25786009)(68736007)(53936002)(105586002)(4326008)(93886005)(9686003)(71190400001)(33656002)(6306002)(71200400001)(256004)(6436002)(966005)(5660300001)(229853002)(8936002)(6246003)(106356001)(97736004)(2900100001)(74316002)(476003)(81156014)(478600001)(7696005)(7736002)(5250100002)(486006)(305945005)(3846002)(81166006)(6506007)(53546011)(76176011)(446003)(11346002)(86362001)(102836004)(6116002)(8676002)(14454004)(2906002)(72206003)(186003)(110136005)(26005)(66066001)(54906003)(99286004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR12MB2805;H:BYAPR12MB2775.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 4fc96809-991c-4b0b-a4b7-08d62d37ef67
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BYAPR12MB2805;
x-ms-traffictypediagnostic: BYAPR12MB2805:
x-microsoft-antispam-prvs: <BYAPR12MB280522F8846AA7395F375B26FBE60@BYAPR12MB2805.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR12MB2805;BCL:0;PCL:0;RULEID:;SRVR:BYAPR12MB2805;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Ln5UzM07ew2nAciA/GhzPqCySr57Ql/4MowN6vdgBwtKW61oeAjFUsPWAOMFNYRH5cixz5tX3O72auVmw+sXg65NxoikUcW7iG+B+mvZMvOeGa1JvDuKNpqDfICpV7zV3JCFgnhVDvlrvCdje9wVCsleH3XLekKO02ufO2N7Cl/TgdO2olQfMsDtJPkKtaULjtdTC0oXiPPFL1gdzrBqzxltxjn55JfR7pSEi4n5NQr7Q0P4j8D0eow3kxS52M8PXrtvfTDmqwGHPP1pzo9Yi4IjfsaMnpT9Y0fxZTaH2ovZJzUrdXt40OFNYETdSP8Vd6WbrufEL5A7PYtB0nk39Y89S3/ZUPhuyXvIenBjMrc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc96809-991c-4b0b-a4b7-08d62d37ef67
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 16:05:58.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2805
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

Yes, we have fixed this issue in drm-next.
I am trying to dig out the patches in drm-next and will sent them out.

Regards
Rex

> -----Original Message-----
> From: Deucher, Alexander
> Sent: Tuesday, October 9, 2018 12:02 AM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
> <alexander.levin@microsoft.com>
> Subject: RE: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> for smu7/8
>=20
> > -----Original Message-----
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Sent: Monday, October 8, 2018 10:44 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland,
> > Harry <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>;
> Sasha
> > Levin <alexander.levin@microsoft.com>
> > Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to
> > DC for smu7/8
> >
> > On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Sent: Monday, September 24, 2018 7:53 AM
> > > > To: linux-kernel@vger.kernel.org
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
> > > > Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
> > > > <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
> > > > Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to
> > > > DC for
> > > > smu7/8
> > > >
> > > > 4.18-stable review patch.  If anyone has any objections, please
> > > > let me
> > know.
> > > >
> > >
> > > This regresses power usage on 4.18.  Please revert.
> > > https://bugzilla.kernel.org/show_bug.cgi?id=3D201275
> >
> > Is it reverted in "upstream" as well?  If not, please get the fix in
> > there and then I will be glad to backport it here.
> >
>=20
> There's no breakage in upstream.  This patch addressed breakages in 4.19
> specifically due to some other refactoring we did in the driver.  I'll tr=
y and dig
> out the exact series of patches this addressed.
>=20
> Alex
>=20
> > thanks,
> >
> > greg k-h
