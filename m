Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932737AbeCMXJn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:09:43 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:32178
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752729AbeCMXJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:09:40 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?iso-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/7] x86/hyper-v: define struct hv_enlightened_vmcs and
 clean field bits
Thread-Topic: [PATCH v3 5/7] x86/hyper-v: define struct hv_enlightened_vmcs
 and clean field bits
Thread-Index: AQHTt69aoAhoRVacbkqMk7p4g5Icj6PO0Sbg
Date: Tue, 13 Mar 2018 23:09:38 +0000
Message-ID: <DM5PR2101MB10305D2EE33539488FFE20DEDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-6-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-6-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-13T23:09:37.0786219Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0934;7:QeRu99nx9aK5DDpzdWBK4i57TdRvQgjmu4VG69IGqNv8GtlS6y4UBPyNUC3HOEIKsCTMN8oiorx+CJeg6Taz06bxlsvOpoTjXkHGElDlND8HzDkGfw2Qp9QN47p2KQw3IuNPgc6UuiQTy7cdxfHj/+/w0zYV8slqBil5DSrKFUz4X8v5J1I2A0sOtWSmsb0fxzFfkRlLs+es4D7U1VzBAEHzRJZx57VyedX5jHPsSx8w/4Hnrae/8rvi0jM2nQme;20:ueky+xz65oBhUyc0cSmgNyiBn8ZdMwmJZtE93Z35gsyHxnzGfRSnvXxrsOqIoHkKJKW/jfwhe1bFGdj29RwHgbpttITBLJ6t0QCJgfGT3quWyq6EnUysNm3lfqCo2vMl/vaiRyjP+sXJLWkfSzh+nyZNIKuuMIz+roLf3GKYlfA=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4dcbc3f-39e7-450b-311d-08d589377ec9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0934;
x-ms-traffictypediagnostic: DM5PR2101MB0934:
x-microsoft-antispam-prvs: <DM5PR2101MB0934E9FCF75D7E232F41CC98DCD20@DM5PR2101MB0934.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0934;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0934;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(13464003)(199004)(189003)(76176011)(55016002)(5660300001)(10290500003)(53936002)(10090500001)(7696005)(9686003)(106356001)(6246003)(2950100002)(102836004)(53546011)(3660700001)(7736002)(26005)(6346003)(6506007)(478600001)(66066001)(3280700002)(72206003)(86612001)(186003)(99286004)(229853002)(81166006)(110136005)(8936002)(25786009)(97736004)(316002)(105586002)(54906003)(5250100002)(2906002)(2900100001)(81156014)(74316002)(6436002)(33656002)(8990500004)(305945005)(14454004)(86362001)(6116002)(22452003)(2501003)(3846002)(4326008)(68736007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0934;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: uOzO59v2oJkEJUygpjxTMNXfYoORkUvuoKT23fd2iQlq0lkMSArHBbz1w0jVRHt9hpBa2EzuzcGI4VRE5VQrU5JMUGqLQ91y5XeulxLQKd2sc0biyXQzF00KiK/Sm7w+oGTuIhFFjQ0JiapAcDMLImOwUnzG/dXPrmeHj4sPMs5wzROj8M9F/nQEovsQMVD5gWVXgkgdJ2101lrINT9qgIzL303nVqVK43IFJ4ekxlaTyOc1A05oPOlUfWc8r+f8y6TkMan/a0W9mUiTuqe4hui5jP/Ojo6vY1n4b2yXNIbSlqgD21yw82FpUZkstfEAuNOYYxLNjIHLGX9vCGrCPQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4dcbc3f-39e7-450b-311d-08d589377ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 23:09:38.4443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0934
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DNBImA005876

> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, March 9, 2018 6:03 AM
> To: kvm@vger.kernel.org
> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krèmáø
> <rkrcmar@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; Bandan Das <bsd@redhat.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 5/7] x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
> 
> The definitions are according to the Hyper-V TLFS v5.0. KVM on Hyper-V will
> use these.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
