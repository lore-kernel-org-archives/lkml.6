Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C115DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5781820C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 16:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="WMYVUG7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5781820C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeGKREU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:04:20 -0400
Received: from mail-sn1nam02on0137.outbound.protection.outlook.com ([104.47.36.137]:16288
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726876AbeGKREU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoHHzB70tOf7+d/yfUWdAlelGySVjFsI1yd9JNBG7dk=;
 b=WMYVUG7jKVf9zKmPCi+aDwhR/CiEJry5xCL8SYCY46z0XadNIWG7EpZfp+hG0c/4V+5JxI7EHCL8xHzK1mH4roLh6KgpnSmxtuseBokOJ+WP+4hhbvU9vnMjCpALpJtlMpomrggyvpHX0l3QrBcgw/xBv7hrEyxT8WMtS93DnU0=
Received: from DM5PR21MB0633.namprd21.prod.outlook.com (10.175.111.140) by
 DM5PR21MB0794.namprd21.prod.outlook.com (10.175.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.9; Wed, 11 Jul 2018 16:59:02 +0000
Received: from DM5PR21MB0633.namprd21.prod.outlook.com
 ([fe80::a5b0:d691:8d4b:84f]) by DM5PR21MB0633.namprd21.prod.outlook.com
 ([fe80::a5b0:d691:8d4b:84f%8]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 16:59:02 +0000
From:   Sunil Muthuswamy <sunilmut@microsoft.com>
To:     "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
Subject: RE: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Topic: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Index: AQHUFmd8sh4NyJ2VakK/W8CUOc6uZqSJOXYAgAEI0OA=
Date:   Wed, 11 Jul 2018 16:59:01 +0000
Message-ID: <DM5PR21MB06334938686C9A202BE4FEA2C05A0@DM5PR21MB0633.namprd21.prod.outlook.com>
References: <20180708025651.26922-1-kys@linuxonhyperv.com>
 <SN6PR2101MB11207780F4859B196153FF2DDC5A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
In-Reply-To: <SN6PR2101MB11207780F4859B196153FF2DDC5A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-07-11T01:04:34.2060788Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:8:dcc:248d:343c:525c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0794;6:zRJ5uvXiyMaEfJJIUhde0yvweZxSIJ+HS6lsja3dHAsBfyFdL5ra/2rRXZ94506GRHYq4ly62821mHW0flg2FSGMdneXdIyrqwt77fEH8HYE95fs+ix+JRTaXp7S2m82T4z4afMgpetSbVPG+o4Rt3WTc1QSbXhQK9ICSLl4s2MFvHLfjzfkSr0C1Hd3uwM7JOAMstcgUX/EX+IP0IwAJKt6t9m8YFnx18lI8jD91sRRhxf7CQzHjfxQq8EchxAmaQKtg5/xosxu1zxIaAGdJAyx2QqUz2Fg07cUr7rL4QyGcd0B4RzgtPsDHb/5rskrXWlNWig069hQk9ofysV+DkPkpT5/YeWfyI0gqnPAtLBRmtwdrdR/p0/+GOmr8Oh86ffZWUXxhw/ophJug3tcePb5//weVzHfMZoMqdVPK9nAsnK07fDvdUIhpyVESnlNJfhV7Ew8GkgqX1QyROM7mg==;5:SdqZFZcawFGg8xPC/YXgjdcifi6HL7SL7ymIIn2LVq5qy4SuZOLGhUyeeJmlvGDM5MgsHH9/SY4oW5ZkzQf24ckJBIpIOrsBjQucpDPRHGWxzqzmW5yNz33XaIhvysatK/OwQXCU111xqEXJ8D8kJOWY6idwV9Hm9r2hY0XI4PE=;7:ykbBdD03RrBc7CsakiAKCfOP+XpuRvjv7FtSe3nMqofhOpHO++GR8PdupjBxjgFpPQl7iu/Almzv06emgNsTG8OQ9O1PgEdgIKvg/xlHCGT+jZrlrn82S9gTPEnQxw2mPvtaxFmFU5MVIJ/2wjs5PnQtbUalWywQVwv3fRLbNaQUpJ5+jp47FS0DZoZXSf+1P/Z6HOjbqHAKBNa2zF0hYaFPqnzpNGZQ2KmKnh8nk3+bV72Ba2xZFiQWT/uP9to5
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 77def14d-df28-40a0-80a4-08d5e74f9a54
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:DM5PR21MB0794;
x-ms-traffictypediagnostic: DM5PR21MB0794:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sunilmut@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB07949F5FBB0497943A898CE9C05A0@DM5PR21MB0794.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055)(211171220733660)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DM5PR21MB0794;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0794;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(39860400002)(396003)(136003)(346002)(199004)(189003)(13464003)(7696005)(7736002)(6436002)(102836004)(561944003)(25786009)(14444005)(229853002)(53546011)(305945005)(68736007)(6506007)(55016002)(33656002)(256004)(2906002)(105586002)(106356001)(110136005)(316002)(6116002)(22452003)(74316002)(76176011)(99286004)(9686003)(14454004)(5660300001)(6246003)(2201001)(2501003)(8990500004)(8936002)(86362001)(10090500001)(2900100001)(486006)(46003)(86612001)(53936002)(478600001)(5250100002)(446003)(97736004)(10290500003)(11346002)(1511001)(8676002)(476003)(81156014)(81166006)(921003)(1121003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0794;H:DM5PR21MB0633.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: mZF1w24xmehehBBc1Np1idJmXRcEYy9HD2BOs/ju1+wOij6f71H/Vx1sXG8KrCxuQEqmu6XfVuWPzWkXcMlwlYlKu5a8p+Q1UbQS9U2loMzBoRnXa9kr8TE5ILVrsD0GoHKHzhBM/jr6BvVKpi5/XyqOpxpFzB/T4IuRqtaeYlEaR06VKteYmGfmSTN0RH/UYrF+RKeH/H978lXviEIotDFodtLnw4Kcn/IpFTOSONxwRW1GMbtY4Pb7rA2QmWxLLvybKNN7nT0Dr/LClIfqZ9le+vcjWVuAf4Ag+pNwUuaTbNR6D6A09RvYkvDdPDqdEjBEri6nDKJ7DukMbnkgH/9oDq9YyJyXtEIOXEVfd24=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77def14d-df28-40a0-80a4-08d5e74f9a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 16:59:01.8111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0794
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Michael. In which branch should I fix these now that the changes ha=
ve been
merged with the char-misc-next branch?

Comments inline.

> -----Original Message-----
> From: Michael Kelley (EOSG)
> Sent: Tuesday, July 10, 2018 6:05 PM
> To: KY Srinivasan <kys@microsoft.com>; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; devel@linuxdriverproject.org; olaf@aepfle.de;
> apw@canonical.com; jasowang@redhat.com; Stephen Hemminger
> <sthemmin@microsoft.com>; vkuznets@redhat.com
> Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
> Subject: RE: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump
> over Hyper-V during panic
>=20
> From kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Saturday,
> July 7, 2018 7:57 PM
> >
> > From: Sunil Muthuswamy <sunilmut@microsoft.com>
> >
> > In the VM mode on Hyper-V, currently, when the kernel panics, an error
> > code and few register values are populated in an MSR and the Hypervisor
> > notified. This information is collected on the host. The amount of
> > information currently collected is found to be limited and not very
> > actionable. To gather more actionable data, such as stack trace, the
> > proposal is to write one page worth of kmsg data on an allocated page
> > and the Hypervisor notified of the page address through the MSR.
> >
> > - Sysctl option to control the behavior, with ON by default.
> >
> > Cc: K. Y. Srinivasan <kys@microsoft.com>
> > Cc: Stephen Hemminger <sthemmin@microsoft.com>
> > Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> > Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> > ---
>=20
> > +	/*
> > +	 * Write dump contents to the page. No need to synchronize; panic
> should
> > +	 * be single-threaded.
> > +	 */
> > +	if (!kmsg_dump_get_buffer(dumper, true, hv_panic_page,
> > +				  PAGE_SIZE, &bytes_written)) {
> > +		pr_err("Hyper-V: Unable to get kmsg data for panic\n");
> > +		return;
>=20
> From what I can see, the return value from kmsg_dump_get_buffer()
> is not an indication of success or failure -- it's an indication of wheth=
er
> there is more data available.   There's no reason to output an error
> message.
>=20
That seems correct. Will address this.
> > @@ -1065,6 +1136,32 @@ static int vmbus_bus_init(void)
> >  	 * Only register if the crash MSRs are available
> >  	 */
> >  	if (ms_hyperv.misc_features &
> HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> > +		u64 hyperv_crash_ctl;
> > +		/*
> > +		 * Sysctl registration is not fatal, since by default
> > +		 * reporting is enabled.
> > +		 */
> > +		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
> > +		if (!hv_ctl_table_hdr)
> > +			pr_err("Hyper-V: sysctl table register error");
> > +
> > +		/*
> > +		 * Register for panic kmsg callback only if the right
> > +		 * capability is supported by the hypervisor.
> > +		 */
> > +		rdmsrl(HV_X64_MSR_CRASH_CTL, hyperv_crash_ctl);
> > +		if (hyperv_crash_ctl &
> HV_CRASH_CTL_CRASH_NOTIFY_MSG) {
>=20
> vmbus_drv.c is architecture independent code, and should not be
> referencing
> x86/x64 MSRs.   Reading the MSR (and maybe the test as well?) should go
> in a separate function in an x86-specific source file.
>=20
I will move the code.
> And just to confirm, is this the right way to test for the feature?  Usua=
lly,
> feature determination is based on one of the feature registers.  The
> NOTIFY_MSG flag seems to have a dual meaning -- on read it indicates
> the feature is present.  On write in hyperv_report_panic_msg(), it eviden=
tly
> means that the guest is sending a full page of data to Hyper-V.
>=20
As per my conversation with John, this seems to be correct and something
also he suggested. The host sets these bits depending on whether it support=
s
these features or not.

> > @@ -1081,6 +1178,11 @@ static int vmbus_bus_init(void)
> >  	bus_unregister(&hv_bus);
> > +	free_page((unsigned long)hv_panic_page);
> > +	if (!hv_ctl_table_hdr) {
>=20
> The above test is backwards.  Remove the bang.
Good call, will do.
>=20
> > @@ -1785,10 +1887,18 @@ static void __exit vmbus_exit(void)
> > +	free_page((unsigned long)hv_panic_page);
> > +	if (!hv_ctl_table_hdr) {
>=20
> Same here.  Test is backwards.
>=20
Will fix.
> Michael

