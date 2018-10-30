Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97963C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CA052082B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 22:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="g0jclvpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA052082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbeJaHVp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 03:21:45 -0400
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:36064
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727369AbeJaHVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 03:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXUGVTqm+Ho7lvwdcK4KahElyNQPbZLKIoXX1mV8tPI=;
 b=g0jclvpwY84zPXO0LPR6t9MlbFU/fltbIJsbbgNfWKhC8dX5qhtSmKoF4Fr2/jZfldymZdEdb6uSqBCK3HUj9jCyZEsk6Coo43V6qrmqRiOJ/9coheehIXGrpSdHYIexTmXtwTPgP+3tjaw75+McMCSlcxjBC48hkG/irWL6Gw4=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1579.namprd12.prod.outlook.com (10.172.40.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1273.26; Tue, 30 Oct 2018 22:26:22 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::4c23:f551:bc6a:554e%3]) with mapi id 15.20.1273.027; Tue, 30 Oct 2018
 22:26:22 +0000
From:   "Moger, Babu" <Babu.Moger@amd.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Fwd: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Topic: Fwd: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl file
 system operations and data
Thread-Index: AQHUbLgDlrQML4ljtECAffIL8h1TDaU2w6awgAFit6CAADyrgA==
Date:   Tue, 30 Oct 2018 22:26:22 +0000
Message-ID: <DM5PR12MB24718634BDBD91020E52218895CC0@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <1540508826-144502-1-git-send-email-fenghua.yu@intel.com>
 <1540508826-144502-3-git-send-email-fenghua.yu@intel.com>
 <DM5PR12MB2471679DD21D00A33D092A1795F30@DM5PR12MB2471.namprd12.prod.outlook.com>
 <CALBSrqDRKbth2NAUFM+emBHVv7eZPX=O9Ki-=vUxi-QQc1wVnQ@mail.gmail.com>
 <20181030183544.GA173608@romley-ivt3.sc.intel.com>
In-Reply-To: <20181030183544.GA173608@romley-ivt3.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:7ddf:c3d4:bdf8:6702]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR12MB1579;20:hPawEn7f3wWpyZpjuNkNvIlDlKqQUvYfynSXVL5yw2MrT50vnXczf5NuifMtOHFYQm5veSkf+Dlm3ZvZ4lxYKQ54Vpr6rwLs0s8dZvCQEQgv97nVS4Oq9kxYR8doxO3qrBoHkE+E4qIBYpX50ZjrN5okqgNYinJ6BV0tqbLEYUGoYYYyIu8Ve9jTy2uLYNfB5Q7moxJ4QH7jGlLKugyZnPHj2b9VYsJwg30NJbwwQEfVeHSr4SUex+E4L80FSX3/
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ce461d64-b8b3-492c-6f3c-08d63eb6b8c0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1579;
x-ms-traffictypediagnostic: DM5PR12MB1579:
x-microsoft-antispam-prvs: <DM5PR12MB157902871A251DCB977E916C95CC0@DM5PR12MB1579.namprd12.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(228905959029699)(767451399110)(180628864354917);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231382)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM5PR12MB1579;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1579;
x-forefront-prvs: 08417837C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(39860400002)(376002)(346002)(189003)(199004)(13464003)(2900100001)(478600001)(33656002)(54906003)(76176011)(71190400001)(71200400001)(7736002)(99286004)(5660300001)(2906002)(68736007)(6916009)(6246003)(7696005)(186003)(14454004)(72206003)(97736004)(229853002)(106356001)(4326008)(25786009)(86362001)(93886005)(105586002)(53936002)(256004)(6436002)(11346002)(446003)(102836004)(476003)(46003)(316002)(486006)(74316002)(8676002)(81156014)(305945005)(5250100002)(8936002)(53546011)(7416002)(6506007)(81166006)(9686003)(6116002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1579;H:DM5PR12MB2471.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: Wecn5YzchzkI8+xUXFxS7m4hfoVU11ti6dHL0JYITEtZ0SPmKF4RjAeNK5zwwasUtoyw3ZGfxwS0tDmL4X0ONuavVH1qrz2SJPXdRXNeXQKblk9s//ay8b1Qc3jjMq/IgziFurnavGsrB5kphrITUVhSxiyWv2EI06mcHnTPe69TS8F+FuRXco+tsnBceLybWomk2CLkTA4aTJPrzeAmkEDvPgZtjPc+msgaX5d7amM/XZzBGbwXTc4DaYCSONxR8TluF9nrhasuw7Tz8NA/LH+dn7I0WHjmwYf+lsjuVTAcDuKzG5yacQDIEomiP2UdvNuLcjY9CEYfL7JuL5oWta+xxWIPfslPavIpJvbZ6Ec=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce461d64-b8b3-492c-6f3c-08d63eb6b8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2018 22:26:22.3467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua,

> -----Original Message-----
> From: Fenghua Yu <fenghua.yu@intel.com>
> Sent: Tuesday, October 30, 2018 1:36 PM
> To: Moger, Babu <Babu.Moger@amd.com>; Fenghua Yu
> <fenghua.yu@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>; Ingo Molnar
> <mingo@redhat.com>; H Peter Anvin <hpa@zytor.com>; Tony Luck
> <tony.luck@intel.com>; Peter Zijlstra <peterz@infradead.org>; Reinette
> Chatre <reinette.chatre@intel.com>; James Morse
> <james.morse@arm.com>; Ravi V Shankar <ravi.v.shankar@intel.com>; Sai
> Praneeth Prakhya <sai.praneeth.prakhya@intel.com>; Arshiya Hayatkhan
> Pathan <arshiya.hayatkhan.pathan@intel.com>; linux-kernel <linux-
> kernel@vger.kernel.org>
> Subject: Re: Fwd: [PATCH v2 2/8] selftests/resctrl: Add basic resctrl fil=
e
> system operations and data
>=20
> > From: Moger, Babu <Babu.Moger@amd.com>
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > >
> > > The basic resctrl file system operations and data are added for futur=
e
> > > usage by resctrl selftest tool.
> > >
> > > +     return 0;
> > > +}
> > > +
> > > +char get_sock_num(int cpu_no)
> > > +{
> > > +     char sock_num, phys_pkg_path[1024];
> > > +     FILE *fp;
> > > +
> > > +     sprintf(phys_pkg_path, "%s%d/topology/physical_package_id",
> > > +             PHYS_ID_PATH, cpu_no);
> > > +     fp =3D fopen(phys_pkg_path, "r");
> >
> > There should corresponding fclose for this. In general, I would check a=
ll the
> > fopens in this series. I found few of the files not closed while return=
ing.
> > More comments below.
> >
> > > +     if (!fp || fscanf(fp, "%c", &sock_num) <=3D 0 || fclose(fp) =3D=
=3D EOF) {
>=20
> fclose is here.

Yes. It is there. Let's take a case(hypothetical) where fp is valid and fsc=
anf returns -1.

             If( false || true || fclose(fp))

Will this execute fclose?  Or am I missing something here?


>=20
> > > +             perror("Could not get socket number");
> > > +
> > > +             return -1;
> > > +     }
> > > +
> > > +      */
> > > +     if (!freopen("/dev/null", "w", stdout))
> > > +             PARENT_EXIT("Unable to direct BM op to /dev/null");
> >
> > Do you need fclose for this before returning from this function?
>=20
> This fclose is missing. I will add it.
>=20
> > > +     /* Write child pid to con_mon grp */
> > > +     fp =3D fopen(controlgroup, "w");
> >
> > I don't see corresponding fclose.
> >
> > > +     if (!fp || fprintf(fp, "%d\n", bm_pid) <=3D 0 || fclose(fp) =3D=
=3D EOF) {
>=20
> fclose is here:)
>=20
> > > +             perror("Failed to write child to con_mon grp");
> > > +
> > > +             return errno;
> > > +     }
> > > +
> > > +     /* Write child pid to mon grp, only for "mbm" */
> > > +     if ((strcmp(resctrl_val, "mbm") =3D=3D 0)) {
> > > +             if (mongrp) {
> > > +                     fp =3D fopen(monitorgroup, "w");
> > > +                     if (!fp || fprintf(fp, "%d\n", bm_pid) <=3D 0 |=
|
> > > +                         fclose(fp) =3D=3D EOF) {
> >
> >
> > I feel too many checks at one place.  If fprintf fails,  will it fclose=
 the
> > file? I suggest to separate these checks.
>=20
> You are right. I will separate the checks in multiple lines.
>=20
> >
> > > +
> > > +             fp =3D fopen(controlgroup, "w");
> > > +             if (!fp || fprintf(fp, "%s\n", schema) <=3D 0 ||
> > > +                 fclose(fp) =3D=3D EOF) {
> >
> > Same comment as above.. If fprintf fails,  will it fclose the file? I s=
uggest
> > to separate these checks.
>=20
> Sure.
>=20
> I will change code based on your comments.
>=20
> Thanks.
>=20
> -Fenghua
