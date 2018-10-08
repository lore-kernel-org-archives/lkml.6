Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30227C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D16C22089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NHINjzjI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16C22089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbeJHXaT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:30:19 -0400
Received: from mail-cys01nam02on0062.outbound.protection.outlook.com ([104.47.37.62]:35072
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726348AbeJHXaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZAAU15oUl9RQuoASt6aZc/9q0I0v6KeWQK56f+sYN4=;
 b=NHINjzjI59lFk3BcjFayub7U6mhdrpDxW9/aZrzIt36isk+qtu0eMkN2br0XbYk4x9EYmq6/JkKqoHufwoT3jP8G2eyrEW2sMSzv+o6ffqFKZydPWJjkWEsj9RhGRD4aaXHVRHfJ2tBNzXPXbP+LBDIKSyas2cYUWn23CmljaL4=
Received: from BN6PR12MB1809.namprd12.prod.outlook.com (10.175.101.146) by
 BN6PR12MB1747.namprd12.prod.outlook.com (10.175.101.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.27; Mon, 8 Oct 2018 16:17:47 +0000
Received: from BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee]) by BN6PR12MB1809.namprd12.prod.outlook.com
 ([fe80::9df7:7ad5:5b10:aeee%5]) with mapi id 15.20.1207.024; Mon, 8 Oct 2018
 16:17:46 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Zhu, Rex" <Rex.Zhu@amd.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: RE: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Topic: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC for
 smu7/8
Thread-Index: AQHUVARg2MOAZvRixUSipQEGskb4iKUVfsWAgAAFX4CAABRr8A==
Date:   Mon, 8 Oct 2018 16:17:46 +0000
Message-ID: <BN6PR12MB1809FA86B039B8EAE460BB49F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
References: <20180924113103.999624566@linuxfoundation.org>
 <20180924113125.488862921@linuxfoundation.org>
 <BN6PR12MB18092FFEF5BB3861912C8535F7E60@BN6PR12MB1809.namprd12.prod.outlook.com>
 <20181008144917.GE32006@sasha-vm>
In-Reply-To: <20181008144917.GE32006@sasha-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Deucher@amd.com; 
x-originating-ip: [71.219.49.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR12MB1747;20:33ETEjNA1pcPY5FWV8f8+sqfIeSpcFd+/H1jZ7JZ0lS9vSj0yfsceqGWJ3lDOk/3Qh7UZ1MnmhffaMGdULVWwkjB2Q6xDiheZOwltl510luQFDxF9acl/KlFNCmTmCeUv5Z2FDXcsVONPPsunqYqe+SbIQ8Ft3EEX7oZNETYYvoC1LZYbOyuda3Pw9W4m92q/08IeSdgnORvsyhSrmYVlV0Ee/Z9JJA1mcyR3zVoTDz1jOdjDqd34v+zFREujVv7
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(366004)(13464003)(199004)(189003)(86362001)(316002)(2906002)(93886005)(256004)(97736004)(229853002)(7736002)(6436002)(6116002)(3846002)(2900100001)(6916009)(6306002)(305945005)(55016002)(9686003)(68736007)(106356001)(105586002)(5250100002)(53936002)(74316002)(486006)(53546011)(6506007)(81166006)(81156014)(102836004)(25786009)(76176011)(6246003)(7696005)(33656002)(446003)(4326008)(476003)(11346002)(99286004)(72206003)(54906003)(8676002)(5660300001)(66066001)(345774005)(8936002)(14454004)(26005)(186003)(478600001)(71200400001)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1747;H:BN6PR12MB1809.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 0a4c294b-c08f-4b8f-154c-08d62d39957a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1747;
x-ms-traffictypediagnostic: BN6PR12MB1747:
x-microsoft-antispam-prvs: <BN6PR12MB17476D0AF7997BB8BF7779BEF7E60@BN6PR12MB1747.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(767451399110)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:BN6PR12MB1747;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1747;
x-forefront-prvs: 081904387B
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: bquvOzUjlWWP7AN4ua7ep8Jx5jb7FlfHE+jVCYNZIXeJVc+4GoczaiZduQ8CNs287jygD3ezlB+zs1gEKZdjcT7rrH7uS/5tcl2Rp22TGYCWgIWACNm6wPki5xuOlq4wwoKth/sddegv9my7TKMoRLeSzzDShjh0teqiuxE041QYr3eish/9du9T9O5Aeox6QtrrAZbzWWXc8CpsbDbyaMsf4IbBN5qAzeK3PvC/+o0AG6OqcAD7bGVpo6BzuwSMXG6azlzdqwzgDfbI9GNPvC0NDXq1/poTCfZT9QIcB5O7UD2wxh6I45+ASF1+pwVC65QOFUMhYJauHCaKStJpzz4Q/N+pQ04vbhEZ9yYrhDE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4c294b-c08f-4b8f-154c-08d62d39957a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2018 16:17:46.2133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1747
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Sasha Levin <sashal@kernel.org>
> Sent: Monday, October 8, 2018 10:49 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-
> kernel@vger.kernel.org; stable@vger.kernel.org; Wentland, Harry
> <Harry.Wentland@amd.com>; Zhu, Rex <Rex.Zhu@amd.com>; Sasha Levin
> <alexander.levin@microsoft.com>
> Subject: Re: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> for smu7/8
>=20
> On Mon, Oct 08, 2018 at 02:33:56PM +0000, Deucher, Alexander wrote:
> >> -----Original Message-----
> >> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> Sent: Monday, September 24, 2018 7:53 AM
> >> To: linux-kernel@vger.kernel.org
> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>;
> >> stable@vger.kernel.org; Wentland, Harry <Harry.Wentland@amd.com>;
> >> Deucher, Alexander <Alexander.Deucher@amd.com>; Zhu, Rex
> >> <Rex.Zhu@amd.com>; Sasha Levin <alexander.levin@microsoft.com>
> >> Subject: [PATCH 4.18 222/235] drm/amd/pp: Send khz clock values to DC
> >> for
> >> smu7/8
> >>
> >> 4.18-stable review patch.  If anyone has any objections, please let me
> know.
> >>
> >
> >This regresses power usage on 4.18.  Please revert.
> >https://bugzilla.kernel.org/show_bug.cgi?id=3D201275
>=20
> Hi Alex,
>=20
> Thank you for the report.
>=20
> I'm working on improving this process, I'd be very grateful if you could
> answer a few questions about this:
>=20
> 1. Is the same breakage seen upstream? (if so, it should be reverted ther=
e as
> well and we can grab the revert into -stable).

No regression in 4.19 or -next.

> 2. Does the issue reported by this patch ("pipes seem to hang with a 4k D=
P
> and 1080p HDMI display") exist in the 4.18 stable tree?

I don't think so, but I'm not 100% sure.  Harry, Rex do you know if this is=
 a general issue or was it just fall out from the changes to the interface?

> 3. If not, could you briefly explain why?

We refactored the interface between the power and display components and th=
is patch fixed up some of that fallout due to the differences in units used=
 in each component.

>=20
>=20
> The algorithm I use was very confident about this patch being stable mate=
rial,
> and when I looked at it back then (and again now) I was very confident of=
 the
> same. If I can understand where I was wrong I could improve my process.

There are some other dependent patches required that were not flagged in th=
e patch itself.  IIRC, they were a bit big for stable.

Alex

