Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966899AbeEYLnc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:43:32 -0400
Received: from mail-sn1nam02on0124.outbound.protection.outlook.com ([104.47.36.124]:41367
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966518AbeEYLn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:43:29 -0400
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        "'Lorenzo Pieralisi'" <lorenzo.pieralisi@arm.com>,
        "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Topic: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwBQxMBg
Date: Fri, 25 May 2018 11:43:25 +0000
Message-ID: <BN6PR21MB0161399BFB7B0A7DCBB0691FCA690@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T21:11:58.7383302Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0835;7:JLTKW6Dzui3mps6lCCMhJk03XAUYR62RJzRxy9C+I3r3EtFhNmCQrt4Ynf5/rgKUsMmWxoEqQNSDrnsP13Y078W80rQctYG9LHyYzYwkre27SpUrbScxNXyTj/1xY+T8cLglHCkXn5QslPZuvKnmPcZaqBT7gmaQboZqDSh9VHhYOtNM4/b+/rXkBtp8EiZwIvXjTTtrd1i8ITMAz8UE17b/QUNTqP/E6t4vpkKTvLNZ6PHkOj3GFl4OpoApal55;20:ZipxqsryFryvPVOjoZksa4aa8qU3SbT6LrfTeshIwN0il+8BDz4aSFaRnfVIxeAo30clrpvUe6yWhhNd7uvIq1Z+ELu/fhwUsFq2Be8gqTePhzV0sP59QP/gKqH69NoerUJNS91eKOOmarNCs+gH40fKfuJIk98BpK7Bvu4P0IA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BN6PR21MB0835;
x-ms-traffictypediagnostic: BN6PR21MB0835:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BN6PR21MB0835AC827C1D4CD416D31A73CA690@BN6PR21MB0835.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(244540007438412)(89211679590171)(9452136761055)(211936372134217)(153496737603132)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR21MB0835;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0835;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(396003)(39860400002)(199004)(189003)(13464003)(86362001)(478600001)(99286004)(2906002)(486006)(6436002)(76176011)(1511001)(26005)(476003)(3660700001)(7696005)(3280700002)(11346002)(86612001)(8990500004)(10290500003)(66066001)(59450400001)(53546011)(102836004)(6506007)(14454004)(68736007)(10090500001)(2900100001)(446003)(5250100002)(22452003)(55016002)(7416002)(5660300001)(4326008)(54906003)(316002)(110136005)(25786009)(8676002)(9686003)(33656002)(6116002)(3846002)(6246003)(7736002)(53936002)(74316002)(305945005)(8936002)(97736004)(81156014)(81166006)(106356001)(105586002)(229853002)(491001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0835;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 6LsMnjctrIh4Di/vODg1Pwt7pWu/K/5WytMr+un9YfYPN5h+JRqBSxMofFfuhuxhhdip3OauITwJzPtnHl5hD5wSm0P+i38pSd5CIwoGYKyVyvt6nDTtfrNAHssFkppQyezyZ/sGCLo1t/eo/LoJJFbTddDNy0pMTEGy/Rvzx7B+RfS/grcg3w5jw+iYJTY6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: de0cb928-c68c-42c9-e03d-08d5c234ba3e
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0cb928-c68c-42c9-e03d-08d5c234ba3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 11:43:26.0092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0835
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PBhc08015250



> -----Original Message-----
> From: Dexuan Cui
> Sent: Wednesday, May 23, 2018 5:12 PM
> To: 'Lorenzo Pieralisi' <lorenzo.pieralisi@arm.com>; 'Bjorn Helgaas'
> <bhelgaas@google.com>; 'linux-pci@vger.kernel.org' <linux-
> pci@vger.kernel.org>; KY Srinivasan <kys@microsoft.com>; Stephen
> Hemminger <sthemmin@microsoft.com>; 'olaf@aepfle.de' <olaf@aepfle.de>;
> 'apw@canonical.com' <apw@canonical.com>; 'jasowang@redhat.com'
> <jasowang@redhat.com>
> Cc: 'linux-kernel@vger.kernel.org' <linux-kernel@vger.kernel.org>; 'driverdev-
> devel@linuxdriverproject.org' <driverdev-devel@linuxdriverproject.org>;
> Haiyang Zhang <haiyangz@microsoft.com>; 'vkuznets@redhat.com'
> <vkuznets@redhat.com>; 'marcelo.cerri@canonical.com'
> <marcelo.cerri@canonical.com>
> Subject: [PATCH] PCI: hv: Do not wait forever on a device that has disappeared
> 
> 
> Before the guest finishes the device initialization, the device can be removed
> anytime by the host, and after that the host won't respond to the guest's
> request, so the guest should be prepared to handle this case.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 46 ++++++++++++++++++++++++++++++++-------
> ----

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thank you!
