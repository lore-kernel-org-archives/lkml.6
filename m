Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEQLQG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 07:16:06 -0400
Received: from mail-sn1nam02on0070.outbound.protection.outlook.com ([104.47.36.70]:44352
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751061AbeEQLQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 07:16:04 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: Keith Busch <keith.busch@linux.intel.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: RE: INTMS/INTMC not being used in NVME interrupt handling
Thread-Topic: INTMS/INTMC not being used in NVME interrupt handling
Thread-Index: AdPtEUhAQBG4C/fdRa+bY9RvRvlVYgAEtuYAACoOvYA=
Date: Thu, 17 May 2018 11:15:59 +0000
Message-ID: <BLUPR0201MB1505BF5E68D05F25A53D3B96A5910@BLUPR0201MB1505.namprd02.prod.outlook.com>
References: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
 <20180516144240.GA20223@localhost.localdomain>
In-Reply-To: <20180516144240.GA20223@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0201MB1763;7:n1Ojsxs0Pmzw5/hcDxsQXrW3droTAmkoyT33LP3DeOc4YuXOnLM1JppVpYcaEpmFMnznpzTfuuj5toetn6gHU1KRJa+ZVnu81wICU4/28QpPatoDLy19lrMsmvTIQ53f2lsIq9LT0Gt4HnJ0OxAWeD6ct0UdLjT9Kt4xXgOPzAKogmz9r4COqxm0WOe5AB8EVrwp0UMrVACVJ0fSNMq61LSduecUoPQzIdmcG/jDNxu89HNClxcCGG7sRTuG94Rc
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR0201MB1763;
x-ms-traffictypediagnostic: BLUPR0201MB1763:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BLUPR0201MB17631BED7EC0CD5C016ADB44A5910@BLUPR0201MB1763.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BLUPR0201MB1763;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1763;
x-forefront-prvs: 067553F396
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(376002)(39860400002)(396003)(39380400002)(189003)(199004)(81156014)(26005)(6436002)(81166006)(229853002)(68736007)(478600001)(97736004)(6506007)(8676002)(55236004)(6916009)(186003)(102836004)(33656002)(6246003)(25786009)(3660700001)(2900100001)(3280700002)(8936002)(55016002)(66066001)(446003)(11346002)(476003)(9686003)(3846002)(486006)(6116002)(316002)(54906003)(7696005)(7736002)(74316002)(106356001)(2906002)(86362001)(53936002)(105586002)(5250100002)(99286004)(76176011)(305945005)(14454004)(4326008)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1763;H:BLUPR0201MB1505.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sIqgo+LhHtMP74MVenugo4a7AeMV3ifn6RHo1rXTgWaoQvcwZ2Eb1vytNUYYMzL0CA1AtJpRJLJrCwhXvdrTayoGMa8nLSmo7MWMGksFWIA0xXysIxLiBC5/BPnUzmqnx0S+rYrcyknyhxozgjiT0MpxEmJqIzNB/IMfj/vRDfSGZBrM+lNg9eh5KiC/+G5i
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: df0b162a-6146-4e82-5b0e-08d5bbe791d5
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0b162a-6146-4e82-5b0e-08d5bbe791d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2018 11:15:59.8358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1763
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4HBGD5q003612

> > Hi,
> >
> > As per NVME specification:
> > 7.5.1.1 Host Software Interrupt Handling It is recommended that host
> > software utilize the Interrupt Mask Set and Interrupt Mask Clear
> > (INTMS/INTMC) registers to efficiently handle interrupts when configured
> to use pin based or MSI messages.
> >
> > In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr doesn't  use
> > these registers.
> >
> > Any reason why these registers are not used in nvme interrupt handler ?
> 
> I think you've answered your own question: we process completions in the
> interrupt context. The interrupt is already masked at the CPU level in this
> context, so there should be no reason to mask them at the device level.
> 
> > Why NVMe driver is not using any bottom half and processing all
> > completion queues in interrupt handler ?
> 
> Performance.
Thanks keith. 
Currently driver isn't setting any Coalesce count.  
So the NVMe card will raise interrupt for every single completion queue ?

For legacy interrupt for each CQ 
CQ-> ASSERT_INTA-> DOORBELL-> DEASSERT_INTA is this flow correct ?

Is the following flow valid
CQ1->ASSERT_INTA->CQ2/CQ3->Doorbell->DEASSERT_INTA ?

When using legacy interrupts, if CQ1 is sent followed by ASSERT_INTA, can the EP send 
another CQ2,CQ3.. before DEASSERT_INTA of CQ1 is generated?

Regards,
Bharat
