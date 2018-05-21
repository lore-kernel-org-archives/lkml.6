Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeEUW6p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 18:58:45 -0400
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:34159
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751078AbeEUW6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 18:58:42 -0400
From: Alan Douglas <adouglas@cadence.com>
To: "bhelgaas@google.com" <bhelgaas@google.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: "cyrille.pitchen@free-electrons.com"
        <cyrille.pitchen@free-electrons.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nsekhar@ti.com" <nsekhar@ti.com>
Subject: [PATCH v2 0/4] PCI: cadence: Host and EP driver updates for PHY and
 power management
Thread-Topic: [PATCH v2 0/4] PCI: cadence: Host and EP driver updates for PHY
 and power management
Thread-Index: AdPxIG5eVt33xOedTFezPS1Ch9Pakw==
Date: Mon, 21 May 2018 22:58:39 +0000
Message-ID: <SN6PR07MB451219710FAD2C0DD9FF05F9D8950@SN6PR07MB4512.namprd07.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04NDRiMzMxNC01ZDRhLTExZTgtODZlNi1hNDRjYzhlYzVlY2RcYW1lLXRlc3RcODQ0YjMzMTUtNWQ0YS0xMWU4LTg2ZTYtYTQ0Y2M4ZWM1ZWNkYm9keS50eHQiIHN6PSIxMjA3IiB0PSIxMzE3MTQxNzEyNzM3NTM1MzMiIGg9IitJTFFCdy8xL0UxeHlTM1Awc3dYS3VZOG5Lbz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4637;7:Ho5oX/fqgQqpx2qVQquXxAPjPPeo1AokUX+kGmzt7qkiKuLB3TkFyWcfhV5YoeW6jl72xqllMK+vkABAlZ5+tbMhQhM0qoCB4B6aYKAQMdssvFzGG+xvEhSgLmG9JoRTSBsY4jOS7Rv0DnKbaffzsdBHvOQ2CWdALhqg5eQft3F4/YVpEFof59gBxSQicCy3OvaNyicc2nIywlF8ueACE4iQaLO93aJ/2hg2MGp4AA0HvKeDg3fsh9ZYetDtr/jb;20:cbbS9klEPsHcRosU17lDQLV17h/p4FiwLeGS2OLDS1tXm1BR4UX07giHOg7INM6z+/jxYfdCDPRHMxWenRz4EaLOCbJm2RGXTq7kf/qVWFIhG0RMKaKwzeEss1VmQ+DomJywaZS9JxCT8y9hkVf9K7WC0SSMTWuOx+ys5ij38pgtreMqS6yQHLz2asd5Q7XHnC9knm3b9Z79tciJRjpB7n8P0CNqDVW9S/mVvUhfIc6TK9saD2ToEkHxhy8FPc4S
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4637;
x-ms-traffictypediagnostic: SN6PR07MB4637:
x-microsoft-antispam-prvs: <SN6PR07MB46378D23D5C9D8BC342067A6D8950@SN6PR07MB4637.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN6PR07MB4637;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4637;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(36092001)(8936002)(66066001)(14454004)(6506007)(97736004)(3846002)(6116002)(2201001)(5250100002)(86362001)(6436002)(4326008)(68736007)(102836004)(53936002)(3660700001)(15650500001)(3280700002)(81156014)(2906002)(8676002)(7696005)(186003)(59450400001)(81166006)(26005)(54906003)(7736002)(305945005)(5660300001)(9686003)(74316002)(2900100001)(478600001)(25786009)(105586002)(2501003)(33656002)(106356001)(476003)(486006)(99286004)(316002)(55016002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4637;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: FCoQowJuo6ezmbeeFKmBJCIi9YoE8HVlNUjyd94Kv38ESRQvagWcVFeNpyyz9jbyr/dz0txRzznCvM6wontEhFOkceLJ7O0HodMtIV5v3s2xXGXtUBt58b+6qJc5nQl3rKGc8eQ9no/+E1DiLC0jdW8yOkyCgCwjTXUAdtq30tT/8a3x4vamhhY9puAXCX5acKFSkx0IPNO8D4t+Mv7NFg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6d5c2de0-617f-4698-5d4e-08d5bf6e6471
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d5c2de0-617f-4698-5d4e-08d5bf6e6471
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 22:58:39.4470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4637
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4LMwqXW015822

This is a series of patches for the cadence PCIe host and EP drivers, to:
 - Add optional list of generic PHYs to host and EP drivers
 - Add PHY bindings to devicetree
 - Add Power Management ops, which will enable/disable PHYs if present
- Update cdns_pcie_writel function signature

Changes in v2:
    Split commit into four patches
    Re-based on v4.17-rc1

Alan Douglas (4):
  PCI: cadence: Update cdns_pcie_writel function signature
  PCI: cadence: Add generic PHY support to host and EP drivers
  dt-bindings: PCI: cadence: Add DT bindings for optional PHYs
  PCI: cadence: Add Power Management ops for host and EP

 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.txt  |   4 +
 .../bindings/pci/cdns,cdns-pcie-host.txt           |   2 +
 drivers/pci/cadence/pcie-cadence-ep.c              |  15 ++-
 drivers/pci/cadence/pcie-cadence-host.c            |  34 ++++++
 drivers/pci/cadence/pcie-cadence.c                 | 123 +++++++++++++++++++++
 drivers/pci/cadence/pcie-cadence.h                 |  13 ++-
 6 files changed, 189 insertions(+), 2 deletions(-)

--
