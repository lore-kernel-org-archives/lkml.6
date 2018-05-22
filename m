Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751538AbeEVS3z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:29:55 -0400
Received: from mail-sg2apc01on0139.outbound.protection.outlook.com ([104.47.125.139]:27488
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751336AbeEVS3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:29:53 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
CC: KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tools: hv: lsvmbus: convert to Python3
Thread-Topic: [PATCH] tools: hv: lsvmbus: convert to Python3
Thread-Index: AQHT8alBxYccTPRY3E6cqXEwCprsraQ8Egqw
Date: Tue, 22 May 2018 18:29:47 +0000
Message-ID: <KL1P15301MB0006B58D5247F9EF2D9C6B8ABF940@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <20180522084527.29254-1-vkuznets@redhat.com>
In-Reply-To: <20180522084527.29254-1-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-22T18:29:45.3587358Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:5dfd:5a7b:7ee7:e115]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0040;7:T9yFqjrU3iMvrKv5ZBHtun7/RZD50YCVfrJd185Y/39h/hs4+JGYZ4FEcjwFCAKVv16pl8Hdd8Wh2MP4JbR9E8+pxxc1ESMIj76BYfryTedNPfCAim59zsD2mhPI694z6m2jD5AnG5szigkVRob8vEp8teqf66cTqm1hELZQsBmoW3b9NiZllNroCPrGL8IQPvRBlth1122LXV+gKDFPKEPrDFhhsQjXG1m8fp5Std/D/NVKPXdW2xrudveIzO02;20:lBNKGu/aKKa9PmSqm7C1YzPDkDBz1dkoS8us9U6y/S1mzXWYsEY0RRUujbIzbx3zgXKmninREchV8jfrzWgEneceL3NOmPOPW2/gICZbRbvvQVaNHTQ/SSvPQqd71+RRpQgcALiRqhSY2HDLjHjwej83c7PvpBIVjuoaC3xK5ok=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0040;
x-ms-traffictypediagnostic: KL1P15301MB0040:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-microsoft-antispam-prvs: <KL1P15301MB00401AC330E97B058F705793BF940@KL1P15301MB0040.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0040;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0040;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39860400002)(376002)(346002)(396003)(199004)(189003)(81166006)(81156014)(8676002)(7736002)(305945005)(6246003)(3660700001)(8936002)(8990500004)(74316002)(106356001)(105586002)(53936002)(46003)(11346002)(2501003)(86362001)(476003)(446003)(86612001)(6116002)(10090500001)(9686003)(102836004)(77096007)(486006)(186003)(7696005)(99286004)(2900100001)(5660300001)(68736007)(4326008)(6506007)(76176011)(478600001)(14454004)(10290500003)(25786009)(33656002)(316002)(110136005)(54906003)(229853002)(6436002)(55016002)(22452003)(97736004)(2906002)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0040;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: eNgbc+/UyXAwyB+CLnTFnVVM5nTcSiATwi1tjyr5hDsD8t1uLm0JKwVbVBtini3pb2qHpKPQyXxCVkFpWw1Apkf1NFF7kMQIXdxLlUI5yTW2r+NMBcOQZQdS8RtOMhQTSqvnZ7ZQZxvljZHcCmxE2svWD7c4a7EmSzt+KPrFF8MVGTFgTfXI1oqEY+R0Byi5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 8e496802-250d-4d73-7fc5-08d5c011ff87
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e496802-250d-4d73-7fc5-08d5c011ff87
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 18:29:47.1766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0040
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4MIU1n6023972

> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Tuesday, May 22, 2018 01:45
> 
> Use '2to3' tool to make lsvmbus work with both Python2 and Python3.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  tools/hv/lsvmbus | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
> index 353e56768df8..c184aac33d5c 100644
> --- a/tools/hv/lsvmbus
> +++ b/tools/hv/lsvmbus
> @@ -17,7 +17,7 @@ if options.verbose is not None:
> 
>  vmbus_sys_path = '/sys/bus/vmbus/devices'
>  if not os.path.isdir(vmbus_sys_path):
> -	print "%s doesn't exist: exiting..." % vmbus_sys_path
> +	print("%s doesn't exist: exiting..." % vmbus_sys_path)
>  	exit(-1)
> 
>  vmbus_dev_dict = {
> @@ -93,11 +93,11 @@ format2 = '%2s: Class_ID = %s - %s\n\tDevice_ID
> = %s\n\tSysfs path: %s\n%s'
> 
>  for d in vmbus_dev_list:
>  	if verbose == 0:
> -		print ('VMBUS ID ' + format0) % (d.vmbus_id, d.dev_desc)
> +		print(('VMBUS ID ' + format0) % (d.vmbus_id, d.dev_desc))
>  	elif verbose == 1:
> -		print ('VMBUS ID ' + format1) %	\
> -			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping)
> +		print(('VMBUS ID ' + format1) %	\
> +			(d.vmbus_id, d.class_id, d.dev_desc, d.chn_vp_mapping))
>  	else:
> -		print ('VMBUS ID ' + format2) % \
> +		print(('VMBUS ID ' + format2) % \
>  			(d.vmbus_id, d.class_id, d.dev_desc, \
> -			d.device_id, d.sysfs_path, d.chn_vp_mapping)
> +			d.device_id, d.sysfs_path, d.chn_vp_mapping))
> --
> 2.14.3

Looks good to me. Thanks!

Acked-by: Dexuan Cui <decui@microsoft.com>
