Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbeCMXIG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 19:08:06 -0400
Received: from mail-cys01nam02on0132.outbound.protection.outlook.com ([104.47.37.132]:42752
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752729AbeCMXIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 19:08:04 -0400
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
Subject: RE: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
Thread-Topic: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor
 Assist Pages
Thread-Index: AQHTt69YPvZ7qQoRC0igMXetN5O4nqPO0KqQ
Date: Tue, 13 Mar 2018 23:08:00 +0000
Message-ID: <DM5PR2101MB103023729D2ADB71218C42EEDCD20@DM5PR2101MB1030.namprd21.prod.outlook.com>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-5-vkuznets@redhat.com>
In-Reply-To: <20180309140249.2840-5-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-03-13T23:07:59.3784987Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0934;7:pPj7GmslAYXs5ysEnP3n0kS0kVWMe3yXKCW5PsRDd24n8uy275oGi4qc+dhShD+9HYn7VQS+bw5R7TOnrJwAKGio/QwLJjY+Zv4oz2zK0VUgk43Dmsa13HbHWoc7C6AuWMZJbfIu0s73Zwkk1fTwbwK51Yhf6sURagzBilQfSrZ0Yk7ocGnRI+pT/YMl8sC8oreKIEU5MEa0WRetf5dOWzfnAMJtR4A7BbngAnouEKm8qliixBINW0vac/l2Q2c9;20:9CBdJOuXdq/Txkt4lynR5bDXjCqKL6kPmkpgy7bg4fW/k32wEfDsche2tMwWuN8sngx06nS/zKbqBVAmr18HUzm5M2T4kwTQM2HfUlo9OoRl3RbMMwXj6uCUVvbwAAj/R6mzACklI7D1JHM7lfZJbWt4RqsLnDS9t8R2voFkYbY=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c065932-8cc2-4e0c-4ffc-08d589374492
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0934;
x-ms-traffictypediagnostic: DM5PR2101MB0934:
x-microsoft-antispam-prvs: <DM5PR2101MB09341CBCF06AC2144EC9D898DCD20@DM5PR2101MB0934.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231221)(944501255)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0934;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0934;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(376002)(366004)(13464003)(199004)(189003)(76176011)(55016002)(5660300001)(10290500003)(53936002)(10090500001)(7696005)(9686003)(106356001)(6246003)(2950100002)(102836004)(53546011)(3660700001)(7736002)(26005)(6346003)(6506007)(478600001)(66066001)(3280700002)(72206003)(86612001)(186003)(99286004)(229853002)(81166006)(110136005)(8936002)(25786009)(97736004)(316002)(105586002)(54906003)(5250100002)(2906002)(2900100001)(81156014)(74316002)(6436002)(33656002)(8990500004)(305945005)(14454004)(86362001)(6116002)(22452003)(2501003)(3846002)(4326008)(68736007)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0934;H:DM5PR2101MB1030.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com;
x-microsoft-antispam-message-info: M8KU1ItJH+x+JIefsdYFmLLGy2XHBgJ0KePTIlxgasEn9FXw60MP0/1P8XiBbSZJjr95veiK89p7xa+RXoDA81P0X7+3Sf9wzZRaWMF7ySesws4XdsDmQbx33cp+GjbxOetfYlYBnwoDULnByqTRmLTmlGQ8jXTahFdjptZOvC/oE4Jy6CpT6q6Ru+tDBkX+xk/xIMpOv1XWTvM63C1hvOepBC22qSCkqFCG0ZFyEP/7np9ZwFT51ciAXDvJXYrOEfSptQZpWB/K/oCuGsDYsJPayHFASAbyFqax9tBVtPCEvbcH2nn1bcQ4+odXPAJ15YT4QnpP6rm+ItpscksoeA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c065932-8cc2-4e0c-4ffc-08d589374492
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 23:08:00.7728
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0934
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2DN8EIH005868

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
> Subject: [PATCH v3 4/7] x86/hyper-v: allocate and use Virtual Processor Assist Pages
> 
> Virtual Processor Assist Pages usage allows us to do optimized EOI
> processing for APIC, enable Enlightened VMCS support in KVM and more.
> struct hv_vp_assist_page is defined according to the Hyper-V TLFS v5.0b.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by:  Michael Kelley <mikelley@microsoft.com>
