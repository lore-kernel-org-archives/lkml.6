Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD040C677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FA832064E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZsznRMod"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA832064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbeJIBOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:14:49 -0400
Received: from mail-dm3nam03on0076.outbound.protection.outlook.com ([104.47.41.76]:10958
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726383AbeJIBOt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:14:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whL6MBwe6Oz/PuoTOfyD1HWW4drfyW7haGzg4SYVMgM=;
 b=ZsznRModkKlGC5jrI/eTq+5BaJwIs9ku2GG6Qq/SlUGvUJfopGn6GWKd9pZfuBXDeH9wNGGOBJb5T/tG480Nis4mXsNk3mL0h/TunuUCYCLeXo9n+SKaaicoM4wXMVFw8eqJoWOKP+/DCX9Ghl4A2qSxHCWTCLvD7bSqMOdceR0=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1844.namprd12.prod.outlook.com (10.175.96.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.23; Mon, 8 Oct 2018 18:01:52 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 18:01:50 +0000
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
Thread-Index: AQHUVARg2MOAZvRixUSipQEGskb4iKUVfsWAgAAD/oCAABSD8IAAFIiAgAANhaA=
Date:   Mon, 8 Oct 2018 18:01:50 +0000
Message-ID: <BN6PR12MB1809AAC678E020F33E189C92F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144421.GB15968@kroah.com>
 <BN6PR12MB180971CA88D1B8D580512A71F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008171115.GB29418@kroah.com>
In-Reply-To: <20181008171115.GB29418@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1844;20:uefxODo5dyzWl2AqEu34cTMulW6SsFz4oI5fKV94ngGmRUtwrjhnC3AqooHBLr9CoyE5tssBrjqMIJfMntdHn4rs0SQIBjazpFOW9F19eoJef5UDtWyOmItVHh/ptAZ4MynZGKWrlLU2khVOaLGSb+qFtnFbjrL8GQ/dVLESj3GD94MORZVWGcidLeXf23FzkO+7ysmEQq2AsxZj8tBCzX2t7ZB1yq7wd8v9DO0yWZn6FMYh/9/pr3S7DEeHCCAy
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(366004)(376002)(396003)(346002)(13464003)(189003)(199004)(2900100001)(186003)(105586002)(26005)(11346002)(476003)(74316002)(106356001)(25786009)(7736002)(305945005)(486006)(33656002)(53936002)(446003)(66066001)(102836004)(54906003)(4326008)(6916009)(2906002)(99286004)(256004)(966005)(6506007)(53546011)(6246003)(7696005)(76176011)(71190400001)(71200400001)(6306002)(14454004)(229853002)(3846002)(6116002)(8936002)(5250100002)(68736007)(81166006)(81156014)(8676002)(9686003)(5660300001)(86362001)(55016002)(72206003)(97736004)(478600001)(6436002)(93886005)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1844;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: 763518dc-a6f0-4f51-d7bf-08d62d481f77
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1844;
x-ms-traffictypediagnostic: BN6PR12MB1844:
x-microsoft-antispam-prvs: <BN6PR12MB184413F8B1A07A081F2CCFEBF7E60@BN6PR12MB1844.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051)(76991055);SRVR:BN6PR12MB1844;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1844;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: wT5yiRNuJIVnnXJ3aOzWqqIaJISxBumO1+hBWoZdX3PukeYMN/SM8Sc+gixoGuRxA3WDwaJJkHZHgEnsOjdfyevci2XWTxUfjzVDLhYz6uXPA8Dmg0Pw6oNOWEKE6RudQ/5nX74FKdF0pZUr5MiCTpZJSCkMAK1KzUWJ4r6xKRNnNKqicoYGhdLDb3D1Dr6q5Fosl9vTrwhcSiC/UUv9aA7wENcAqMZ1p1srnrafd3FfCFD03FCUTQ92uCsre+0OcaE9WHTDmTq00VndG1oBdhAB70TjtoVtvhUL8mtcmq54BUhuQQVHqG4wpKmQbH1cX+qE5R0+Z5H8KzM/Zu8tm1GW/f3B5zhcZsZWrQQ8Tmo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763518dc-a6f0-4f51-d7bf-08d62d481f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 18:01:50.7096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1844
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Monday, October 8, 2018 1:11 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
> <alexander.levin@microsoft.com>
> Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> for smu7/8
>=20
> On Mon, Oct 08, 2018 at 04:02:19PM +0000, Deucher, Alexander wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Monday, October 8, 2018 10:44 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland,
> > > Harry <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>;
> Sasha
> > > Levin <alexander.levin@microsoft.com>
> > > Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values
> > > to DC for smu7/8
> > >
> > > On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
> > > > > -----Original Message-----
> > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Sent: Monday, September 24, 2018 7:53 AM
> > > > > To: linux-kernel@vger.kernel.org
> > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > > stable@vger.kernel.org; Wentland, Harry
> > > > > <Harry.Wentland@amd.com>; Deucher, Alexander
> > > > > <Alexander.Deucher@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>;
> Sasha
> > > > > Levin <alexander.levin@microsoft.com>
> > > > > Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values
> > > > > to DC for
> > > > > smu7/8
> > > > >
> > > > > 4.18-stable review patch.  If anyone has any objections, please
> > > > > let me
> > > know.
> > > > >
> > > >
> > > > This regresses power usage on 4.18.  Please revert.
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D201275
> > >
> > > Is it reverted in "upstream" as well?  If not, please get the fix in
> > > there and then I will be glad to backport it here.
> > >
> >
> > There's no breakage in upstream.  This patch addressed breakages in
> > 4.19 specifically due to some other refactoring we did in the driver.
> > I'll try and dig out the exact series of patches this addressed.
>=20
> So there is no problem in 4.19-rc7?  That contridicts the statement of lo=
oking
> in drm-next for the fixes.

Sorry, what statement about drm-next?  This patch was for 4.19 and was not =
intended for 4.18.  It was picked up by Sasha's auto select system for stab=
le.

Alex

