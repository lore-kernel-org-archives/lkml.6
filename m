Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752766AbeEPMfV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 08:35:21 -0400
Received: from mail-dm3nam03on0074.outbound.protection.outlook.com ([104.47.41.74]:64795
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751389AbeEPMfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 08:35:17 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: INTMS/INTMC not being used in NVME interrupt handling
Thread-Topic: INTMS/INTMC not being used in NVME interrupt handling
Thread-Index: AdPtEUhAQBG4C/fdRa+bY9RvRvlVYg==
Date: Wed, 16 May 2018 12:35:15 +0000
Message-ID: <BLUPR0201MB1505371050ED798BE025132BA5920@BLUPR0201MB1505.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0201MB1924;7:CzXep8aIoqOw7yYipg5VR1FmDqtrbiE8gnEB1sScgIuuEXXjPU1QbZwnJWUALPVdB652G9gihBF6YYzySLKMB6I16iN3Aw+rRIEMEEcJJau7+tg69X3mkFVCjkW/hJ3LkwJ8nekaXGLAmROq6QGdBzflKHX76VWvNc/fUyOBx2/0QBEuvTqV9/4wbG27nYlkkPKOHkH2liFFB2J4rWVKBZE/TBH+Gl6Qg6aa7PK9hHl4y2qPCcirvkUObx4KoX74
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR0201MB1924;
x-ms-traffictypediagnostic: BLUPR0201MB1924:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BLUPR0201MB192418B432069660B2EB3196A5920@BLUPR0201MB1924.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BLUPR0201MB1924;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1924;
x-forefront-prvs: 0674DC6DD3
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(366004)(39860400002)(189003)(199004)(14454004)(5250100002)(2501003)(8936002)(478600001)(81156014)(66066001)(81166006)(25786009)(8676002)(54906003)(86362001)(6506007)(9686003)(55236004)(486006)(7696005)(102836004)(186003)(110136005)(53936002)(476003)(26005)(6436002)(55016002)(99286004)(316002)(97736004)(305945005)(33656002)(7736002)(68736007)(105586002)(106356001)(5660300001)(3846002)(6116002)(2900100001)(3660700001)(74316002)(4326008)(2906002)(3280700002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1924;H:BLUPR0201MB1505.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: C2qTiMOs2Hze0iNelRf6OUFOBHPEXsOA9yaFJ5WnOpssLmIaQU/5Vn1Kb1UChyr+4HLy9dQ8ruhSAwRt6m39/am62Tg8F7rN+SNCTawUgbNUfLnmiFDXnbzJhErsz77e9npNAe9XSVKKFp9XiqVdlL43rB0rilZ+8J/b4gnuKl0etEnmW+bcNNB3BBZj3JNP
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0568bd35-b193-4622-086b-08d5bb2979d4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0568bd35-b193-4622-086b-08d5bb2979d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2018 12:35:15.2373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1924
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4GCZPn0001398

Hi,

As per NVME specification: 
7.5.1.1 Host Software Interrupt Handling
It is recommended that host software utilize the Interrupt Mask Set and Interrupt Mask Clear (INTMS/INTMC) 
registers to efficiently handle interrupts when configured to use pin based or MSI messages.

In kernel 4.14, drivers/nvme/host/pci.c function nvme_isr 
doesn't  use these registers. 

Any reason why these registers are not used in nvme interrupt handler ?

Why NVMe driver is not using any bottom half and processing all completion queues
in interrupt handler ?

Regards,
Bharat
