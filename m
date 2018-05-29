Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967054AbeE2V2r (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 17:28:47 -0400
Received: from mail-sg2apc01on0093.outbound.protection.outlook.com ([104.47.125.93]:63552
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966689AbeE2V2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 17:28:45 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Topic: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwEuINyAAAAbfpA=
Date: Tue, 29 May 2018 21:28:27 +0000
Message-ID: <KL1P15301MB00062308DD0D900D9A8943FDBF6D0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <CAHp75Vd9kiyOaSbaK6c4b7ucF23kgP0yQxKpUAGrjHgKfJprXA@mail.gmail.com>
In-Reply-To: <CAHp75Vd9kiyOaSbaK6c4b7ucF23kgP0yQxKpUAGrjHgKfJprXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-29T21:28:22.9354318Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:2:79b1:3e78:f1d:8005]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0037;7:cluQQgNNZNsD/gMPq3z5qTcq/5s0wsg23HQgvTRUKVMpqSe5v+PRNYrRKIKgXkrsjRdYukFyqW7WNLyoeL48Y/Wpy4tNZZTKU1ki9z14bfDdTu2eaI/lV037WHdfdLCh2sELJ8JO3pkAWuDtLbcS4AR77AOMxarvdS1jT9YNAtnOUcOdTrarg6xfQ0cT6lGPG+nNaSJGAeXFjjMwuFs+7+5Pstd25PsaAydrwZx3tTkDSNgdrgFIUJcPPRssPAGn;20:OGReJhwJkjM5YxiEK8SFy2XtXwb7Q76ab1II61V7pGSi8D75q7hVdoSi3Yw4Qhis8WmqY7LMb0t2W+IWVLoE3XibCj00uSfIHRIskCHQG5TO12aZiZs2wpbATQf/mxGdeIh+z40qKaMy9WE3Vv0TtVZ3YHpcVYwoIk9+gwl0V5g=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0037;
x-ms-traffictypediagnostic: KL1P15301MB0037:
x-microsoft-antispam-prvs: <KL1P15301MB003766A0A7C9EA796E9B3A8ABF6D0@KL1P15301MB0037.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(28532068793085)(244540007438412)(89211679590171)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0037;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0037;
x-forefront-prvs: 0687389FB0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39380400002)(346002)(39860400002)(376002)(51914003)(199004)(189003)(39060400002)(486006)(6116002)(6246003)(446003)(11346002)(7696005)(476003)(10090500001)(86612001)(54906003)(86362001)(99286004)(6916009)(3280700002)(10290500003)(3660700001)(46003)(53936002)(22452003)(316002)(305945005)(81166006)(55016002)(186003)(6436002)(2900100001)(478600001)(74316002)(33656002)(8676002)(5660300001)(6506007)(81156014)(105586002)(106356001)(7416002)(8936002)(7736002)(2906002)(14454004)(229853002)(68736007)(25786009)(8990500004)(76176011)(53546011)(9686003)(102836004)(59450400001)(97736004)(77096007)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0037;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9T5jT/ZpyE/Xx5qXq7LVOjIy5ZDfGnaqtHfsF692eZgam+d4oCKvhjqkEy3TX+K/bk1iij2kW3rQrzPs5eOCFq2x5wzsUOk16GfrDYBvS7FroasYdnev5pETE9Qt87ZkG4z+kLFmCvnmXdf60drdCp1NNY3asaEgstEHsthORBO9oLuj6ZZXxy4sXtOGMGU4
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: fcad9084-26f4-44b2-3001-08d5c5ab1e1c
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcad9084-26f4-44b2-3001-08d5c5ab1e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2018 21:28:27.2902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0037
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4TLSq2W024181

> From: Andy Shevchenko <andy.shevchenko@gmail.com>
> Sent: Tuesday, May 29, 2018 14:21
> On Thu, May 24, 2018 at 12:12 AM, Dexuan Cui <decui@microsoft.com>
> wrote:
> >
> > Before the guest finishes the device initialization, the device can be
> > removed anytime by the host, and after that the host won't respond to
> > the guest's request, so the guest should be prepared to handle this
> > case.
> 
> > +       while (true) {
> > +               if (hdev->channel->rescind) {
> > +                       dev_warn_once(&hdev->device, "The device is
> gone.\n");
> > +                       return -ENODEV;
> > +               }
> > +
> > +               if (wait_for_completion_timeout(comp, HZ / 10))
> > +                       break;
> > +       }
> 
> Infinite loops are usually a red flags.
> 
> What's wrong with simple:
> 
> do {
>   ...
> } while (wait_...(...) == 0);
> 
> ?
Thanks for the suggestion, Andy!
The coding style you suggested looks better to me. :-)

> > +       if (!ret)
> > +               ret = wait_for_response(hdev, &comp);
> 
> Better to use well established patterns, i.e.
> 
> if (ret)
>  return ret;
Agreed.

> 
> > +               if (!ret)
> > +                       ret = wait_for_response(hdev,
> &comp_pkt.host_event);
> 
> Here it looks okay on the first glance, but better to think about it
> again and refactor.

> With Best Regards,
> Andy Shevchenko

I'll try to send out a patch to improve the coding style, after I address
Michael Kelley's concern of a race.

Thanks,
-- Dexuan
