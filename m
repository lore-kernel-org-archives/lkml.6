Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756657AbeDZO7Q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 10:59:16 -0400
Received: from mail-sn1nam01on0051.outbound.protection.outlook.com ([104.47.32.51]:34400
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755861AbeDZO7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 10:59:09 -0400
From: Bharat Kumar Gogada <bharatku@xilinx.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "keith.busch@intel.com" <keith.busch@intel.com>,
        "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>
Subject: NVMe Poll CQ on timeout
Thread-Topic: NVMe Poll CQ on timeout
Thread-Index: AdPdbaKnll1ikIRyRXyNIhFzf8HT4w==
Date: Thu, 26 Apr 2018 14:59:06 +0000
Message-ID: <BLUPR0201MB1505A10C31E4E3A3BDF7BDBAA58E0@BLUPR0201MB1505.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com;
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BLUPR0201MB1777;7:GQ9e/abtBhiZab/JIei2w43C08zTxjFEz/YgZkfvJNxYg5MK+CYeGojagSjekvV3bj6KDephUcwp4z74ukYHBcG6zGw73QBrZxDhLnaYRXGs89D0yvdxvPyZowd/q7vDUO9iBKAkEUfxl0ElNBYvY6jw0HITvsuIC+IMBoOADDjUYR4OibJJymytDnDy1D67iLHtDc4i4u5EEFchkukBBSTFYb8B4TUWNkefjyU3c8YyGoIBbNS0mxE6t3bVdf8w
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR0201MB1777;
x-ms-traffictypediagnostic: BLUPR0201MB1777:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-microsoft-antispam-prvs: <BLUPR0201MB1777976CBBE97A7BD097F18CA58E0@BLUPR0201MB1777.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231232)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BLUPR0201MB1777;BCL:0;PCL:0;RULEID:;SRVR:BLUPR0201MB1777;
x-forefront-prvs: 0654257CF5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(366004)(39380400002)(376002)(346002)(199004)(189003)(3660700001)(2906002)(106356001)(25786009)(6116002)(3846002)(316002)(105586002)(54906003)(9686003)(3280700002)(110136005)(55016002)(476003)(6436002)(478600001)(53936002)(97736004)(486006)(102836004)(55236004)(14454004)(74316002)(186003)(8936002)(305945005)(26005)(68736007)(86362001)(5660300001)(6506007)(7736002)(99286004)(2501003)(5250100002)(8676002)(81156014)(66066001)(2900100001)(33656002)(4326008)(81166006)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR0201MB1777;H:BLUPR0201MB1505.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 29RKqejh66qipfqsNXskBbTjgYCx7y7CukpMJIwogTZmX9NluDzbHiyGdiwBRfAkeDluXc0IMkJfka6bxb1DiIxMJhVVfUXg/EKfJeYvIMqlkdN201e5vVc7jgMuAxwbI4EPQXkcL+qv0zDVlByhBx6+n5JIdFQ4q9WcEXtcmmKkz4RVt5PelwJSTgbHh310
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 33e20fc2-8d8d-4a51-9aad-08d5ab864217
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33e20fc2-8d8d-4a51-9aad-08d5ab864217
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2018 14:59:06.3311
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR0201MB1777
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3QExMLg006694

Hi,

We are testing NVMe cards on ARM64 platform, the card uses legacy interrupts.
Intermittently we are hitting following case in drivers/nvme/host/pci.c
       /*
         * Did we miss an interrupt?
         */
        if (__nvme_poll(nvmeq, req->tag)) {
                dev_warn(dev->ctrl.device,
                         "I/O %d QID %d timeout, completion polled\n",
                         req->tag, nvmeq->qid);
                return BLK_EH_HANDLED;
        }

Can anyone tell when does nvme_timeout gets invoked ?
What does "Did we miss an interrupt mean" ? Does it mean host missing
to service a interrupt raised by EP card ?

Regards,
Bharat
