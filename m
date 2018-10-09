Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C011C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A472086D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 13:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lip7GzG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A472086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeJIVMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 17:12:55 -0400
Received: from mail-sn1nam02on0077.outbound.protection.outlook.com ([104.47.36.77]:52192
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726476AbeJIVMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 17:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a4s+/ci1pVAcku4yuyfVrltJOVY2rAEwIP41/ygSIkg=;
 b=lip7GzG5ycM1rYqPA247DVhoin0MAUbGDC5CKKx/e0HQHK7+kprhqlp6ear9slMHSZioz4reLkVc8rMueOpD9jr4vkfWJHI2mn5Mt/I1RwOLK0O2FghHlBnYGxykD8I3kQmKpw5r+JockfCg8vpRzL87Ji98t7ovxQPowspM04Y=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1171.namprd12.prod.outlook.com (10.168.226.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.21; Tue, 9 Oct 2018 13:55:09 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Tue, 9 Oct 2018
 13:55:06 +0000
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
Thread-Index: AQHUVARg2MOAZvRixUSipQEGskb4iKUVfsWAgAAD/oCAABSD8IAAFIiAgAANhaCAATqEAIAAE1kQ
Date:   Tue, 9 Oct 2018 13:55:06 +0000
Message-ID: <BN6PR12MB1809C04BB67BD6D95822E3EFF7E70@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144421.GB15968@kroah.com>
 <BN6PR12MB180971CA88D1B8D580512A71F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008171115.GB29418@kroah.com>
 <BN6PR12MB1809AAC678E020F33E189C92F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181009124520.GA1633@kroah.com>
In-Reply-To: <20181009124520.GA1633@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1171;20:bTIEyuTfsdLNDG1wD8+eLrw8Ck2oiovtW1vuHLestz7SMaULInWvkpKDyBT5aMYmC4OPN2kgETa11VHDgUQ9TBH1XLv7xdIzn91BK+vQYIv7BHZwz1OODJJE6SO2xSTNuI+8AWvAElny7fktG3ZHBasCaBD0SPNH6XEZMHe3w9mkbxnXkWVi7O13Xi+lZ/PRsx3r++vFpt6zlU9Y3pKmY0y5vdVJcKPtP7dUsQCT8EHmofZFbsR3x30CBZ/wXqBo
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(13464003)(66066001)(68736007)(25786009)(8936002)(7736002)(76176011)(6506007)(53546011)(99286004)(256004)(316002)(305945005)(478600001)(74316002)(71200400001)(2906002)(93886005)(54906003)(7696005)(71190400001)(6246003)(6116002)(5660300001)(55016002)(9686003)(6306002)(6436002)(86362001)(33656002)(53936002)(4326008)(72206003)(966005)(5250100002)(229853002)(97736004)(8676002)(186003)(14454004)(102836004)(81156014)(3846002)(105586002)(2900100001)(106356001)(486006)(6916009)(476003)(81166006)(446003)(11346002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1171;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-office365-filtering-correlation-id: f1cf445e-76f2-4dec-4cae-08d62deed1ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1171;
x-ms-traffictypediagnostic: BN6PR12MB1171:
x-microsoft-antispam-prvs: <BN6PR12MB11717A7EE510397BBF22BC65F7E70@BN6PR12MB1171.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699051);SRVR:BN6PR12MB1171;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1171;
x-forefront-prvs: 08200063E9
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Cym/09G3B83pWKkE/d/LJBQ+B+opKZJSA4iyyJ1kUCzusLBx6VJqUZEJJSGkhf957kmBGY4BYcT713DUz173q6/H9RKDygXucJRMC77TeDd5tjrCT0FKa0ZgVbC89urziT66cf2ExUCFTcG1JRB7380GRkqbdYLSaUzxo29Ek1rLE/mNjLLE4/QRAJuLitRoZl5ILVnVAoNwzRuTE1Vc0WLJf9ltYImiinx/hIr+BPQQJhyJJofVjHpNW/DMnRc0lNPJDPb67alEUbWuIW2cjET8u3pJ1VUZdf7bTDxnGSUgreOKo97Q07Ra4DikatNXXZixv240jCVOxiu+y0Hl9+9FgG/4N42IykLEDbp72Gc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1cf445e-76f2-4dec-4cae-08d62deed1ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2018 13:55:06.3728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Tuesday, October 9, 2018 8:45 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
> <alexander.levin@microsoft.com>
> Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> for smu7/8
>=20
> On Mon, Oct 08, 2018 at 06:01:50PM +0000, Deucher, Alexander wrote:
> > > -----Original Message-----
> > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Sent: Monday, October 8, 2018 1:11 PM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org; Wentland,
> > > Harry <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>;
> Sasha
> > > Levin <alexander.levin@microsoft.com>
> > > Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values
> > > to DC for smu7/8
> > >
> > > On Mon, Oct 08, 2018 at 04:02:19PM +0000, Deucher, Alexander wrote:
> > > > > -----Original Message-----
> > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > Sent: Monday, October 8, 2018 10:44 AM
> > > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > > Cc: linux-kernel@vger.kernel.org; stable@vger.kernel.org;
> > > > > Wentland, Harry <Harry.Wentland@amd.com>; Zhu, Rex
> > > > > <Rex.Zhu@amd.com>;
> > > Sasha
> > > > > Levin <alexander.levin@microsoft.com>
> > > > > Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock
> > > > > values to DC for smu7/8
> > > > >
> > > > > On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander
> wrote:
> > > > > > > -----Original Message-----
> > > > > > > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > > > > Sent: Monday, September 24, 2018 7:53 AM
> > > > > > > To: linux-kernel@vger.kernel.org
> > > > > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> > > > > > > stable@vger.kernel.org; Wentland, Harry
> > > > > > > <Harry.Wentland@amd.com>; Deucher, Alexander
> > > > > > > <Alexander.Deucher@amd.com>; Zhu, Rex
> <Rex.Zhu@amd.com>;
> > > Sasha
> > > > > > > Levin <alexander.levin@microsoft.com>
> > > > > > > Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock
> > > > > > > values to DC for
> > > > > > > smu7/8
> > > > > > >
> > > > > > > 4.18-stable review patch.  If anyone has any objections,
> > > > > > > please let me
> > > > > know.
> > > > > > >
> > > > > >
> > > > > > This regresses power usage on 4.18.  Please revert.
> > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=3D201275
> > > > >
> > > > > Is it reverted in "upstream" as well?  If not, please get the
> > > > > fix in there and then I will be glad to backport it here.
> > > > >
> > > >
> > > > There's no breakage in upstream.  This patch addressed breakages
> > > > in
> > > > 4.19 specifically due to some other refactoring we did in the drive=
r.
> > > > I'll try and dig out the exact series of patches this addressed.
> > >
> > > So there is no problem in 4.19-rc7?  That contridicts the statement
> > > of looking in drm-next for the fixes.
> >
> > Sorry, what statement about drm-next?  This patch was for 4.19 and was
> not intended for 4.18.  It was picked up by Sasha's auto select system fo=
r
> stable.
>=20
> I thought this thread said that.
>=20
> Ok, so I should just revert it?

Yes, please.

Thanks,

Alex
