Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968320AbeEYTvz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 15:51:55 -0400
Received: from mail-co1nam03on0116.outbound.protection.outlook.com ([104.47.40.116]:7344
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967823AbeEYTvx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 15:51:53 -0400
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
 hv_compose_msi_msg()
Thread-Index: AdPyKucLHxE0xn3+RTSKXedSJeHHcgCNtVtQ
Date: Fri, 25 May 2018 19:51:50 +0000
Message-ID: <BN6PR21MB016112A4E32D76EC669818C3CA690@BN6PR21MB0161.namprd21.prod.outlook.com>
References: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <KL1P15301MB0006EE546A7C2567B61EA783BF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-23T00:18:18.8931354Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [69.130.166.81]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR21MB0179;7:IDX78+Vc8hTqNZHjqU3OfV9BkbuXHNd7DXRwtD64cMA7iAVFvcYHa1OTdvJfm3Cb+HnPW5Pwr0JsDgUe1j7V9YQNco6JuLhoMnFuUgRuEnrUM5vhfLrcsMIj4yxbZJrvye16fbqCclz8m1NjBwg+syxe2bH56+5uW4hn4EcJzUXLnBYMLFJI0ftH1lI4ZfRvsHptKbBxty/AMBB6I9hkK+h3ReslXHbY50VvdBTMo9CSudxgfG6h8EURWjqt10LA;20:ZABkQYWqbAim9IISDSNwUAI3nSN0BW/yf0Hh+yrFDreFpFm09pRlJuGXDaRXQiEK9bipM8JK5d/49XbOcxLVTbtPo/gypF1sL/cB4Xmu0Ou9gRAorh+/3j7ufEzElsY468bOtEFy1vjjqG4sGoH9WeY6FO2OIA8gFOpIvLW6B3I=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7193020);SRVR:BN6PR21MB0179;
x-ms-traffictypediagnostic: BN6PR21MB0179:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=haiyangz@microsoft.com;
x-microsoft-antispam-prvs: <BN6PR21MB0179105C663E6FC8F9C11C40CA690@BN6PR21MB0179.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(9452136761055)(211936372134217)(153496737603132)(198206253151910);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(2018427008)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN6PR21MB0179;BCL:0;PCL:0;RULEID:;SRVR:BN6PR21MB0179;
x-forefront-prvs: 06833C6A67
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(39380400002)(346002)(376002)(13464003)(199004)(189003)(575784001)(86362001)(5660300001)(14454004)(68736007)(74316002)(53546011)(7736002)(6506007)(7416002)(2201001)(305945005)(8936002)(8676002)(2906002)(81166006)(81156014)(76176011)(478600001)(11346002)(446003)(7696005)(25786009)(59450400001)(86612001)(99286004)(3660700001)(486006)(3280700002)(102836004)(26005)(10290500003)(476003)(2900100001)(66066001)(33656002)(54906003)(229853002)(110136005)(316002)(22452003)(6436002)(1511001)(53936002)(97736004)(105586002)(3846002)(6116002)(6246003)(55016002)(9686003)(8990500004)(10090500001)(106356001)(2501003)(4326008)(5250100002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR21MB0179;H:BN6PR21MB0161.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Q8eO0mT5qSmw5M3lgvCKuf+zN+i2QYBHSLd69HjV+/Qb4kFbSxEFd67a6gdBk5ZOXXrj3vkc+rlC4gICbo47+VFMrJDNIePbD3oNVVseLyTgNXi83lvFqAF0UftnvA4dJkvnsmUKDpOxd4h4pZIxivm/QSQhvt5puWS7lLpsz5TtDsgqniF/Z0PZ9+gqjJd3
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d84c623c-64ab-4ba2-78b4-08d5c278f519
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84c623c-64ab-4ba2-78b4-08d5c278f519
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2018 19:51:50.5573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR21MB0179
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4PJq066017130



> -----Original Message-----
> From: Dexuan Cui
> Sent: Tuesday, May 22, 2018 8:18 PM
> To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; Stephen Hemminger <sthemmin@microsoft.com>;
> olaf@aepfle.de; apw@canonical.com; jasowang@redhat.com
> Cc: linux-kernel@vger.kernel.org; driverdev-devel@linuxdriverproject.org;
> Haiyang Zhang <haiyangz@microsoft.com>; vkuznets@redhat.com;
> marcelo.cerri@canonical.com
> Subject: [PATCH] PCI: hv: Fix a __local_bh_enable_ip warning in
> hv_compose_msi_msg()
> 
> 
> Commit de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
> uses local_bh_disable()/enable(), because hv_pci_onchannelcallback() can also
> run in tasklet context as the channel event callback.
> 
> With CONFIG_PROVE_LOCKING=y in the latest mainline, or old kernels that
> don't have commit f71b74bca637 ("irq/softirqs: Use lockdep to assert IRQs are
> disabled/enabled"), it turns out can we trigger a warning at the beginning of
> __local_bh_enable_ip(), because the upper layer irq code can call
> hv_compose_msi_msg() with local irqs disabled.
> 
> Let's fix the warning by switching to local_irq_save()/restore(). This is not an
> issue because hv_pci_onchannelcallback() is not slow, and it not a hot path.
> 
> Fixes: de0aa7b2f97d ("PCI: hv: Fix 2 hang issues in hv_compose_msi_msg()")
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Cc: <stable@vger.kernel.org>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> ---

Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>

Thanks you.
