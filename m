Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032859AbeCAQPK (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:15:10 -0500
Received: from mail-eopbgr670102.outbound.protection.outlook.com ([40.107.67.102]:5312
        "EHLO CAN01-TO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032539AbeCAQPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:15:07 -0500
From: "Stephen  Bates" <sbates@raithlin.com>
To: Sagi Grimberg <sagi@grimberg.me>,
        Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Topic: [PATCH v2 10/10] nvmet: Optionally use PCI P2P memory
Thread-Index: AQHTsO2FaiSytyZxbkuik0deJPQRE6O7N/eA///hvwA=
Date: Thu, 1 Mar 2018 16:15:04 +0000
Message-ID: <A95AE6BF-1CAC-48F5-B676-DA7BD6D5BF24@raithlin.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-11-logang@deltatee.com>
 <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
In-Reply-To: <749e3752-4349-0bdf-5243-3d510c2b26db@grimberg.me>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.a.0.180210
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=sbates@raithlin.com;
x-originating-ip: [70.65.224.121]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;YTXPR0101MB0974;7:VFFmutQodJtY+LvUZkkp3yaJmbetdgj6zFkXKl3lazqzZsJ/3RohdauSP8m43ExsCOuC7Z4nVSpSusdS3T2kyxvoq3O0AxOZHI1sUJoPp4mTkuHi7ivg5TNvzBydmgOLVIstshTzL01QQ1lnnaQufLzFBEdeGXBgKBFCBX9E9lqc0u3VxU8avZAkp2wOv3ZF++qQrhADpB6iS/+njVFfElbF0yWPe2GqIoieTwygs47445vI3/3zsTBuPdg0Ytk4
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 6856509f-14b9-412b-282b-08d57f8f97d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:YTXPR0101MB0974;
x-ms-traffictypediagnostic: YTXPR0101MB0974:
x-microsoft-antispam-prvs: <YTXPR0101MB0974574105AAA9439F30C698AAC60@YTXPR0101MB0974.CANPRD01.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231220)(944501227)(93006095)(93001095)(3002001)(10201501046)(6041288)(20161123564045)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:YTXPR0101MB0974;BCL:0;PCL:0;RULEID:;SRVR:YTXPR0101MB0974;
x-forefront-prvs: 05986C03E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(376002)(39830400003)(346002)(396003)(199004)(189003)(51914003)(2906002)(6486002)(6306002)(99286004)(26005)(33656002)(106356001)(478600001)(6512007)(305945005)(186003)(6436002)(68736007)(5660300001)(4326008)(110136005)(2950100002)(58126008)(97736004)(6506007)(229853002)(25786009)(105586002)(102836004)(59450400001)(316002)(54906003)(966005)(2201001)(86362001)(83716003)(6246003)(8676002)(8936002)(5250100002)(2501003)(36756003)(53936002)(14454004)(81156014)(6116002)(3846002)(82746002)(7736002)(3660700001)(76176011)(7416002)(2900100001)(66066001)(81166006)(3280700002);DIR:OUT;SFP:1102;SCL:1;SRVR:YTXPR0101MB0974;H:YTXPR0101MB2045.CANPRD01.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: nlxOCaIn1nGJ/1jzgxhUTV179+wbjP4CAlJKycvsjWyzCNzahyfSnEQx2XyicUYHeKvCuKrMVoVgPI2/tn0dARR1DHJK7MjiO7P+hcG3pjGVvlPIVDUeuNDM+iD9fVmlrDubLD8VrKaIx1NwRKWhNMQl7Tt7AJi2bHMoeyae1Zg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <196AA3290052DF43BEE7534D9534469B@CANPRD01.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: raithlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6856509f-14b9-412b-282b-08d57f8f97d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2018 16:15:04.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 18519031-7ff4-4cbb-bbcb-c3252d330f4b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YTXPR0101MB0974
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w21GFHFe020581

> > Ideally, we'd want to use an NVME CMB buffer as p2p memory. This would
> > save an extra PCI transfer as the NVME card could just take the data
> > out of it's own memory. However, at this time, cards with CMB buffers
> > don't seem to be available.

> Can you describe what would be the plan to have it when these devices
> do come along? I'd say that p2p_dev needs to become a nvmet_ns reference
> and not from nvmet_ctrl. Then, when cmb capable devices come along, the
> ns can prefer to use its own cmb instead of locating a p2p_dev device?

Hi Sagi

Thanks for the review! That commit message is somewhat dated as NVMe controllers with CMBs that support RDS and WDS are now commercially available [1]. However we have not yet tried to do any kind of optimization around this yet in terms of determining which p2p_dev to use. Your suggest above looks good and we can look into this kind of optimization in due course.

[1] http://www.eideticom.com/uploads/images/NoLoad_Product_Spec.pdf
    
>> +	ctrl->p2p_dev = pci_p2pmem_find(&ctrl->p2p_clients);

> This is the first p2p_dev found right? What happens if I have more than
> a single p2p device? In theory I'd have more p2p memory I can use. Have
> you considered making pci_p2pmem_find return the least used suitable
> device?
    
Yes pci_p2pmem_find will always return the first valid p2p_dev found. At the very least we should update this allocate over all the valid p2p_dev. Since the load on any given p2p_dev will vary over time I think a random allocation of the devices makes sense (at least for now). 

Stephen
