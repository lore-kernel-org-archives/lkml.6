Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965052AbeCGUdV convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 15:33:21 -0500
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:9108 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933935AbeCGUdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 15:33:19 -0500
From: "Kroening, Gary" <gary.kroening@hpe.com>
To: "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>
CC: "Kroening, Gary" <gary.kroening@hpe.com>,
        "Travis, Mike" <mike.travis@hpe.com>,
        "Banman, Andrew" <abanman@hpe.com>,
        "Sivanich, Dimitri" <dimitri.sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/1] x86/platform/x86: Fix count of CHas on multi-pci-segment
 arches
Thread-Topic: [PATCH 1/1] x86/platform/x86: Fix count of CHas on
 multi-pci-segment arches
Thread-Index: AdO2UfB8yN2vSnEwTbiLc015dBFinA==
Date: Wed, 7 Mar 2018 20:33:09 +0000
Message-ID: <CS1PR84MB01182561B15688095C4DBF30F6D80@CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=gary.kroening@hpe.com;
x-originating-ip: [192.48.179.6]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CS1PR84MB0023;7:Hfu/TfRMoE4qrEvHBMrjDPw9VP04GCkwL75L/aYmQ95QP0naqWB+PC0PRrR5i2A7Y4txU8gkyy7prYC8LMVSiyfbwD8MDs8yK8bj1PbyqQRfXhmfjmhT3pIA63kNtHfdJJEUTCy7+/HZEzU9GvUoevopPgArSXak0VmflHeMTpuv6XP3r5XIC3M4VzCQVSzPxwYw/C77ZgauPhrZwPzAb+c64B095tQHjWkNO6o7TEl4a/+5griUYkZ8pEQ8yoFQ
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(3846002)(55016002)(9686003)(6116002)(2201001)(53936002)(66066001)(86362001)(2900100001)(74316002)(2501003)(5250100002)(2906002)(6436002)(3660700001)(97736004)(7736002)(305945005)(3280700002)(105586002)(59450400001)(6506007)(5660300001)(102836004)(186003)(26005)(68736007)(14454004)(316002)(478600001)(4326008)(7696005)(33656002)(110136005)(8936002)(81156014)(106356001)(25786009)(8676002)(54906003)(99286004)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:CS1PR84MB0023;H:CS1PR84MB0118.NAMPRD84.PROD.OUTLOOK.COM;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cbd327d1-b74c-4782-021e-08d5846aa42b
x-microsoft-antispam: UriScan:(222181515654134);BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989060)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(8990040)(2017052603328)(7153060)(7193020);SRVR:CS1PR84MB0023;
x-ms-traffictypediagnostic: CS1PR84MB0023:
x-microsoft-antispam-prvs: <CS1PR84MB0023F8743DFDF0FAF707FD32F6D80@CS1PR84MB0023.NAMPRD84.PROD.OUTLOOK.COM>
x-exchange-antispam-report-test: UriScan:(227479698468861)(222181515654134);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:CS1PR84MB0023;BCL:0;PCL:0;RULEID:;SRVR:CS1PR84MB0023;
x-forefront-prvs: 0604AFA86B
x-microsoft-antispam-message-info: SvXRj0uz8o4fI4arEt4RuKXWzkB35/nwcPzzCS6bMeZi8OygX4VTt62Y2D8xkOB9Jp+aWPdRvoKdw1yd0fI5JmvlgQG9jcMGaKmvBLJw/vNbrbGg+FHdrzIteHCekn0KD7aj+VSr+i7s0lx7S5Rn87g9W8Zijd2aaz2WhBjam9H7QIKCDRBOUvkkeV02GKlsYDA2MAOzeIve7hT6SfQXfz2cQGeRdkx2ymNujp9EJeS7lzOCsaBLy7o5cBS+mtjaAzb20D79qdOq+/cklWcUR00EVtR7rLnPWNn25cqhKXnIOPihfoRND8M2GLR0PuPtEaqNk0NS7N+lZbCqV8aY0Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd327d1-b74c-4782-021e-08d5846aa42b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2018 20:33:09.7537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR84MB0023
X-OriginatorOrg: hpe.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For systems with a single PCI segment, it is sufficient to look for the
bus number to change in order to determine that all of the CHa's have
been counted for a single socket.

However, for multi PCI segment systems, each socket is given a new
segment and the bus number does NOT change.  So looking only for the
bus number to change ends up counting all of the CHa's on all sockets
in the system.  This leads to writing CPU MSRs beyond a valid range and
causes an error in ivbep_uncore_msr_init_box().

The fix is to check for either the bus number or segment number to change.

Signed-off-by: Gary Kroening <gary.kroening@hpe.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
---
 arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- linux-4.4.orig/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c
+++ linux-4.4/arch/x86/kernel/cpu/perf_event_intel_uncore_snbep.c
@@ -3525,15 +3525,19 @@ static struct intel_uncore_type *skx_msr
 static int skx_count_chabox(void)
 {
 	struct pci_dev *chabox_dev = NULL;
-	int bus, count = 0;
+	int bus, seg, count = 0;
 
 	while (1) {
 		chabox_dev = pci_get_device(PCI_VENDOR_ID_INTEL, 0x208d, chabox_dev);
 		if (!chabox_dev)
 			break;
-		if (count == 0)
+		if (count == 0) {
 			bus = chabox_dev->bus->number;
-		if (bus != chabox_dev->bus->number)
+			seg = pci_domain_nr(chabox_dev->bus);
+		}
+		/* check for change in both bus and domain/segment */
+		if (bus != chabox_dev->bus->number ||
+		    seg != pci_domain_nr(chabox_dev->bus))
 			break;
 		count++;
 	}
