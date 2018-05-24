Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969574AbeEXXzw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 19:55:52 -0400
Received: from mail-sg2apc01on0110.outbound.protection.outlook.com ([104.47.125.110]:40384
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965059AbeEXXzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 19:55:50 -0400
From: Dexuan Cui <decui@microsoft.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC: "'Bjorn Helgaas'" <bhelgaas@google.com>,
        "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "'olaf@aepfle.de'" <olaf@aepfle.de>,
        "'apw@canonical.com'" <apw@canonical.com>,
        "'jasowang@redhat.com'" <jasowang@redhat.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'driverdev-devel@linuxdriverproject.org'"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
        "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>
Subject: RE: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Topic: [PATCH] PCI: hv: Do not wait forever on a device that has
 disappeared
Thread-Index: AdPy2mt/5cq5najeS4qpn1DMFXGqNwAgg0eAABawV/A=
Date: Thu, 24 May 2018 23:55:35 +0000
Message-ID: <KL1P15301MB00064024E9BB60BF9FD48128BF6A0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
References: <KL1P15301MB0006DF4209AEE3809ABD303FBF6B0@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
In-Reply-To: <20180524124101.GB20732@e107981-ln.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=decui@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-05-24T23:55:33.1957794Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=decui@microsoft.com;
x-originating-ip: [2001:4898:80e8:a:b06a:26c8:8edd:3403]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;KL1P15301MB0085;7:uPrZFwo616yRu0h4i793YN7uqUdmEPyeE2ip7uklpvCdHhAUpp/TFMrN7a4lvCRJzkOXP7dEFmWJ4jentQ2MV7vwBGRz2WtV/tl1ghsGIDK59qc/jxhQY2FmhvTZsVjC25M8g7UThunkpYndT7Nc00y5+v3FhlkgA9UL2e6c+AlVFTiXI9YDM11MPFD8xMe+1UkQzeLxvFyc3e0T7Qs0PH5m5BVuFTtBxiHNAw0ErP/onSCiR1/ZKXlx/6nz05MI;20:cqmrV5tGx6fffQR44G9L5c4G9AEq2HWR1ZpckbITX6liCj1k5Foz4Jjt87gPgdUv3U78bjAwUGAXxK6c+zn1JJ8Pgroq5vWN7UPkflAFZo79Zb6CtghSk/cXCmLuGjepk0JbJ0+6HkcrpII3toSyNxYhkbc6vrM3FPo8h9cRiRw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:KL1P15301MB0085;
x-ms-traffictypediagnostic: KL1P15301MB0085:
x-microsoft-antispam-prvs: <KL1P15301MB0085ABC489F76E41B41AA715BF6A0@KL1P15301MB0085.APCP153.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(180628864354917)(244540007438412);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:KL1P15301MB0085;BCL:0;PCL:0;RULEID:;SRVR:KL1P15301MB0085;
x-forefront-prvs: 0682FC00E8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39380400002)(39860400002)(199004)(189003)(53936002)(6436002)(229853002)(4326008)(6916009)(8990500004)(68736007)(6246003)(74316002)(186003)(77096007)(86362001)(76176011)(102836004)(6506007)(59450400001)(86612001)(446003)(7696005)(486006)(11346002)(46003)(99286004)(476003)(54906003)(14454004)(3660700001)(5660300001)(97736004)(25786009)(7416002)(33656002)(316002)(22452003)(9686003)(2906002)(55016002)(3280700002)(305945005)(7736002)(6116002)(10090500001)(8936002)(8676002)(81156014)(81166006)(105586002)(478600001)(106356001)(10290500003)(2900100001);DIR:OUT;SFP:1102;SCL:1;SRVR:KL1P15301MB0085;H:KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Kk5hrWqAoY5U5/5/Iv5UkDpmsiuW/DsTuzsFiftvGXp3WpOZaCgNFj131HEsJzxBSLNuA6b6rCzZGhaCHmotFhz4JfxYweSQIycxwSmjmNDmK+96GxIyMrZgfDf4HuwIKiVk+C29jFUzWqnq7GFavdaarLMjtOrGUexbYZV5GIhFEG+AnNJ8LIpnCi5VJID+
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: d67632a7-d981-433a-fb0b-08d5c1d1d7ce
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67632a7-d981-433a-fb0b-08d5c1d1d7ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2018 23:55:35.0930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1P15301MB0085
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4ONtx5X005847

> From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Sent: Thursday, May 24, 2018 05:41
> On Wed, May 23, 2018 at 09:12:01PM +0000, Dexuan Cui wrote:
> >
> > Before the guest finishes the device initialization, the device can be
> > removed anytime by the host, and after that the host won't respond to
> > the guest's request, so the guest should be prepared to handle this
> > case.
> >
> > --- a/drivers/pci/host/pci-hyperv.c
> > +++ b/drivers/pci/host/pci-hyperv.c
> > @@ -556,6 +556,26 @@ static void put_pcichild(struct hv_pci_dev
> *hv_pcidev,
> >  static void get_hvpcibus(struct hv_pcibus_device *hv_pcibus);
> >  static void put_hvpcibus(struct hv_pcibus_device *hv_pcibus);
> >
> > +/*
> > + * There is no good way to get notified from vmbus_onoffer_rescind(),
> > + * so let's use polling here, since this is not a hot path.
> > + */
> > +static int wait_for_response(struct hv_device *hdev,
> > +			     struct completion *comp)
> > +{
> > +	while (true) {
> > +		if (hdev->channel->rescind) {
> > +			dev_warn_once(&hdev->device, "The device is gone.\n");
> > +			return -ENODEV;
> > +		}
> > +
> > +		if (wait_for_completion_timeout(comp, HZ / 10))
> > +			break;
> > +	}
> > +
> > +	return 0;
> 
> This is pretty racy, isn't it ? Also, I reckon you should consider the
> timeout return value as an error condition unless I am completely
> missing the point of what you are doing.
> 
> Lorenzo

Actually, this is not racy: we only exit the loop when 
1) the channel is rescinded 
or
2) the channel is not rescinded, and the event is completed.

wait_for_completion_timeout() returns 0 if timed out: in this case,
we keep spinning in the loop every 0.1 second, testing the 2 conditions.

If the chanel is not rescinded, here we should wait for the event 
forever, as the host is supposed to respond to us quickly, and the
event will be completed accordingly. This is what the current code
does. But, in case the channel is rescinded, we need to exit the loop 
immediately with an error return value: this is the only change
made by the patch.

Ideally, we should not use this ugly "polling" method, and the
rescind-handler, i.e. vmbus_onoffer_rescind(), should notify 
wait_for_response(), but as I mentioned, there is no good way
to get notified from vmbus_onoffer_rescind(), so I'm proposing
this "polling" method: it's simple and it can work correctly,
and this is not a hot path.

Thanks,
-- Dexuan
