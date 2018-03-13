Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeCMXLz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:11:55 -0400
Received: from mail-bl2nam02on0138.outbound.protection.outlook.com ([104.47.38.138]:59211
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752729AbeCMXLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:11:53 -0400
From: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 6/7] x86/hyper-v: detect nested features
Thread-Topic: [PATCH v3 6/7] x86/hyper-v: detect nested features
Thread-Index: AQHTt69bBaxZp2jU00uv7BdlTxurS6PO0c0w
Date: Tue, 13 Mar 2018 23:11:50 +0000
Message-ID: <DM5PR2101MB10303386AACC2FE30227B7B9DCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-7-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-7-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-13T23:11:49.1129611Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:gRxvpziiYgyIQGoKlz76XwOOMCpV5V9l3Im3k3QIheXLjkuVXWGUX9onHeRN8nSgPTPzFztL5FxalZy/aMqNpK/xS5UP/kP3MFDv4vKtaI5QjoIxZWO95qTk+kw/ax52EEt9TpeUEYOhv7qYkmTVtacyj1uylEghQd+349pZZXJOFe5PSSazk74cR8a+hY67v86oNJu3WBHCB/TD8/vA0LS9xYSz1x5ED1YMmB4gvNr71091UZBhJIwQtSXmcm7C;20:e67HzMu981iDTIzCjeptAJTLxOVJkFwAlImLiWx2F0nJyg6Gx8ik2hX0stM1QbIqP6R/SNFZP4/ML2wakhzXhpOJgpWGCSbJ2AjmxJVxW5WW4O7mi5sWQX2LvPEyZfdv/H/f30W3aSMni7aecJrm1dvMEqxbv2YSyDbxaZItZjE=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa89dd4f-3b8d-4075-453a-08d58937cd92
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
x-microsoft-antispam-prvs: <DM5PR2101MB10620AD170CA873B792A4FE1DCD20@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501255)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(39860400002)(346002)(13464003)(189003)(199004)(53936002)(2501003)(9686003)(8676002)(25786009)(8936002)(4326008)(10090500001)(68736007)(7736002)(53546011)(55016002)(6506007)(186003)(3660700001)(316002)(5660300001)(86612001)(99286004)(102836004)(74316002)(6346003)(86362001)(26005)(105586002)(81156014)(5250100002)(81166006)(66066001)(6436002)(3846002)(2950100002)(110136005)(6116002)(229853002)(106356001)(8990500004)(22452003)(2906002)(2900100001)(72206003)(478600001)(7696005)(3280700002)(97736004)(59450400001)(305945005)(14454004)(6246003)(54906003)(10290500003)(33656002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: qw359hhaTiRE10+81QCrw8PR4PBats3oAjQF+5mJW0eXM5Pf5CT927a5E9pDiycHxypD8ScxI6hQKqwOxwX5GbsmBmYGsoWMMB6/4eGYErwPgl9GruC9A4USVwiyOxWP+JnmzuLN8CaXZQuJX9GkKZsfnCdCKfsLI7+JB8Hdz/bp5jiChgrVpD7mNbxVXZZbfYlJ6ODp3MFsdEeFFg03XsOSuppO+6MBz5YNJYhOEgsVBcKuXpTWXCw4Az9rjMJBm055PKe7Pm2jXuaoWrKOSm4+2bcbH37WKvvxoo0G5Gq/SE6mgjLPcreDjaUtPINuoB482U5m+v4AY5dLn7tGcg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa89dd4f-3b8d-4075-453a-08d58937cd92
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 23:11:50.6484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DNBxRc005890

> -----Original Message-----
> From: Vitaly Kuznetsov <vkuznets@redhat.com>
> Sent: Friday, March 9, 2018 6:03 AM
> To: kvm@vger.kernel.org
> Cc: x86@kernel.org; Paolo Bonzini <pbonzini@redhat.com>; Radim Krčmář
> <rkrcmar@redhat.com>; KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>; Michael
> Kelley (EOSG) <Michael.H.Kelley@microsoft.com>; Mohammed Gamal
> <mmorsy@redhat.com>; Cathy Avery <cavery@redhat.com>; Bandan Das <bsd@redhat.com>;
> linux-kernel@vger.kernel.org
> Subject: [PATCH v3 6/7] x86/hyper-v: detect nested features
> 
> TLFS 5.0 says: "Support for an enlightened VMCS interface is reported with
> CPUID leaf 0x40000004. If an enlightened VMCS interface is supported,
>  additional nested enlightenments may be discovered by reading the CPUID
> leaf 0x4000000A (see 2.4.11)."
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
