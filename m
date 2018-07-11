Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F335C3279B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D2B9208FA
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 01:06:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="SOCE/u+L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D2B9208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbeGKBIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 21:08:00 -0400
Received: from mail-cys01nam02on0138.outbound.protection.outlook.com ([104.47.37.138]:60890
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732297AbeGKBH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 21:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeVETGVrJJhNmZdqC6ykSxh/1z75JtDOyN/zY5ggTzg=;
 b=SOCE/u+Lesbo0fPkEQ4ox82IDWuxibWYKh3qZ6lElMNid/93AmiOKMQ16jF/hLLo+t15jp8dUcNOKChJz4cWxYtGJKFQ20eGWHeQsci7t+yPIeuGi1MApwfWHY1BtUJKKUQ6kFsU2cWiaXkRllWZab7pXJ6KlPnYS4V3a+PahfA=
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com (52.132.117.161) by
 SN6PR2101MB0912.namprd21.prod.outlook.com (52.132.117.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.4; Wed, 11 Jul 2018 01:04:36 +0000
Received: from SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732]) by SN6PR2101MB1120.namprd21.prod.outlook.com
 ([fe80::35a3:57b:9c0:9732%4]) with mapi id 15.20.0952.017; Wed, 11 Jul 2018
 01:04:36 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     KY Srinivasan <kys@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
CC:     Sunil Muthuswamy <sunilmut@microsoft.com>
Subject: RE: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Topic: [PATCH 1/1] Drivers: HV: Send one page worth of kmsg dump over
 Hyper-V during panic
Thread-Index: AQHUFmd8DDSzl9n5TUSSYBfAmlZf/qSJMeqw
Date:   Wed, 11 Jul 2018 01:04:36 +0000
Message-ID: <SN6PR2101MB11207780F4859B196153FF2DDC5A0@SN6PR2101MB1120.namprd21.prod.outlook.com>
References: <20180708025651.26922-1-kys@linuxonhyperv.com>
In-Reply-To: <20180708025651.26922-1-kys@linuxonhyperv.com>
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
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR2101MB0912;7:njvKt2c426s5vuesaX3GJW97FlEWw/eTlCBduwJQmxzzix09RZ5/XjrYI6HRqRSV4kLKUCktpbcMh9Xr399njDxQkOrHSVQ7RfG2kzQvPMpFymDWglmfld2KCdRJIEgjAVBZbbZKi+5v1YBMtBCOfzub/m2ChrEQ7qof12ORMjaMVqc2Ao+LuHp9qUOGO8m4X3pMV1h4eLAvW+6LaHLHzlrO22lDDEp9KHFakoZqmOOpPhFLbNsH+Ak+TcmlEbMw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 8e1873b9-4a84-4ecc-b0ae-08d5e6ca4550
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(2017052603328)(7193020);SRVR:SN6PR2101MB0912;
x-ms-traffictypediagnostic: SN6PR2101MB0912:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-prvs: <SN6PR2101MB0912BBED9787051B22E91754DC5A0@SN6PR2101MB0912.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(211171220733660);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(2018427008)(3002001)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:SN6PR2101MB0912;BCL:0;PCL:0;RULEID:;SRVR:SN6PR2101MB0912;
x-forefront-prvs: 0730093765
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(376002)(346002)(199004)(189003)(6246003)(2906002)(107886003)(7696005)(102836004)(2201001)(76176011)(53936002)(99286004)(229853002)(33656002)(3846002)(66066001)(4326008)(6506007)(2900100001)(8990500004)(25786009)(11346002)(5250100002)(86612001)(10290500003)(446003)(86362001)(2501003)(14444005)(6436002)(9686003)(561944003)(305945005)(8936002)(74316002)(72206003)(81166006)(81156014)(55016002)(8676002)(486006)(26005)(478600001)(68736007)(6116002)(14454004)(5660300001)(105586002)(22452003)(110136005)(316002)(106356001)(1511001)(7736002)(256004)(10090500001)(97736004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0912;H:SN6PR2101MB1120.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: iyu0mPa7GpewfB9h+re9oF0h6/Wtn782TcBliE5qdd44QxWCKG/ElakUqPCtUlytvGAJOEEEEByhjP5AuQdXmQixYCmoRabzThTj5ZfRZSNQkULGJuoi/ysXEGM2gdxO3rtJa4GzxmfuQciq11nuMzxvO402iOvJtk2COaSdbfvKevGIX4AvrctJFfbbTaHEyOt5l6hGXOars/HjL8237PuGI1OHpvNvAfpicdt6Zo0BAIMFxjYaPoWKhAMR98KU/sZ9VK47WeBVJ4XYlV91RMGghNn+YkUVBXyverLRpZ/hEDCdW68B5hbx5yMbOkuVFwr6RCqDjJJ9iewXbr+tWglGXEEw7wXcqEzuBjaZapM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1873b9-4a84-4ecc-b0ae-08d5e6ca4550
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2018 01:04:36.1990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0912
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From kys@linuxonhyperv.com <kys@linuxonhyperv.com>  Sent: Saturday, July 7,=
 2018 7:57 PM
>=20
> From: Sunil Muthuswamy <sunilmut@microsoft.com>
>=20
> In the VM mode on Hyper-V, currently, when the kernel panics, an error
> code and few register values are populated in an MSR and the Hypervisor
> notified. This information is collected on the host. The amount of
> information currently collected is found to be limited and not very
> actionable. To gather more actionable data, such as stack trace, the
> proposal is to write one page worth of kmsg data on an allocated page
> and the Hypervisor notified of the page address through the MSR.
>=20
> - Sysctl option to control the behavior, with ON by default.
>=20
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---

> +	/*
> +	 * Write dump contents to the page. No need to synchronize; panic shoul=
d
> +	 * be single-threaded.
> +	 */
> +	if (!kmsg_dump_get_buffer(dumper, true, hv_panic_page,
> +				  PAGE_SIZE, &bytes_written)) {
> +		pr_err("Hyper-V: Unable to get kmsg data for panic\n");
> +		return;

From what I can see, the return value from kmsg_dump_get_buffer()
is not an indication of success or failure -- it's an indication of whether
there is more data available.   There's no reason to output an error
message.

> @@ -1065,6 +1136,32 @@ static int vmbus_bus_init(void)
>  	 * Only register if the crash MSRs are available
>  	 */
>  	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
> +		u64 hyperv_crash_ctl;
> +		/*
> +		 * Sysctl registration is not fatal, since by default
> +		 * reporting is enabled.
> +		 */
> +		hv_ctl_table_hdr =3D register_sysctl_table(hv_root_table);
> +		if (!hv_ctl_table_hdr)
> +			pr_err("Hyper-V: sysctl table register error");
> +
> +		/*
> +		 * Register for panic kmsg callback only if the right
> +		 * capability is supported by the hypervisor.
> +		 */
> +		rdmsrl(HV_X64_MSR_CRASH_CTL, hyperv_crash_ctl);
> +		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG) {

vmbus_drv.c is architecture independent code, and should not be referencing
x86/x64 MSRs.   Reading the MSR (and maybe the test as well?) should go
in a separate function in an x86-specific source file.

And just to confirm, is this the right way to test for the feature?  Usuall=
y,
feature determination is based on one of the feature registers.  The
NOTIFY_MSG flag seems to have a dual meaning -- on read it indicates
the feature is present.  On write in hyperv_report_panic_msg(), it evidentl=
y
means that the guest is sending a full page of data to Hyper-V.

> @@ -1081,6 +1178,11 @@ static int vmbus_bus_init(void)
>  	bus_unregister(&hv_bus);
> +	free_page((unsigned long)hv_panic_page);
> +	if (!hv_ctl_table_hdr) {

The above test is backwards.  Remove the bang.

> @@ -1785,10 +1887,18 @@ static void __exit vmbus_exit(void)
> +	free_page((unsigned long)hv_panic_page);
> +	if (!hv_ctl_table_hdr) {

Same here.  Test is backwards.

Michael

