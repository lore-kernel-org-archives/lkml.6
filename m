Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeD3Pf1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:35:27 -0400
Received: from mail-bl2nam02on0083.outbound.protection.outlook.com ([104.47.38.83]:12704
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753981AbeD3PfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:35:24 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 06/10] misc: pci_endpoint_test: Add MSI-X support
Thread-Topic: [PATCH 06/10] misc: pci_endpoint_test: Add MSI-X support
Thread-Index: AQHT3kjnoUS1owtVlUeEwdvSd4Gb5qQZc7ag
Date: Mon, 30 Apr 2018 15:35:21 +0000
Message-ID: <SN6PR07MB45124A237879C78453495C50D8820@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1524845816.git.gustavo.pimentel@synopsys.com>
 <633ea6faef782de5ea753bffe5028aceff09115a.1524845816.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <633ea6faef782de5ea753bffe5028aceff09115a.1524845816.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0xN2M3MTZiZC00YzhjLTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcMTdjNzE2YmUtNGM4Yy0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxMDc2IiB0PSIxMzE2OTU3NjEyMjMyNTIxMjkiIGg9IlFBK3dxYlNJb21hTXJoMHE3UTdobEVRVWZ3ST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4158;7:SVjw1clP2gJdZYMUdNwMWWJIaTaby/NBuR+M9x9VWqoiQPLAy1PRzzdVyDjda+DMOZq9I8ksVhuT408T8YsHz03RYhYdifMSMJFgtlnH+aYRr8ihRWkIygUjLe2d7FRj+rqYACNncw6xXLleIeJYIctnn1ZFs6C3iVXfnM+6UM0f/B/tgbwfrC9hEuRDgooCJCPMKGTVzZ9YbgRiEHWReh+VD0gw70z7/D46Pwbdvkn9cyM6w88PJw3ynSPtf6fK;20:WwAR1Oy6C7Bw1Fpx0yza0JvK0V/SYxs/LaE3TNbn7VUVxZ9AcmBgzsFUUoELAxy05V/OK3Z6bpB/XtlkBqbCgXhoPAXWuCuqp7u2QwdNeymnevWmTRxxa6v2oz6Ad4DVteAYw3oAOSSoicfg8b5Kiq44mz2hjJ6kLr5Ba70na22MVeuD8SxPCoCoYXomiiUWt8fQqrlDFC/1Tu2mD1AY0oFCeNWuNFCbGpQLsl4dwDCG+CxovJwEsyQZ2p8gqb8z
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4158;
x-ms-traffictypediagnostic: SN6PR07MB4158:
x-microsoft-antispam-prvs: <SN6PR07MB4158210B44193F7316BC6C12D8820@SN6PR07MB4158.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(10201501046)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4158;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4158;
x-forefront-prvs: 0658BAF71F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(189003)(199004)(36092001)(5660300001)(2900100001)(2201001)(6246003)(7416002)(6116002)(8676002)(74316002)(3846002)(66066001)(7696005)(2501003)(4326008)(305945005)(3280700002)(39060400002)(81156014)(8936002)(6436002)(7736002)(68736007)(81166006)(5250100002)(86362001)(99286004)(14454004)(54906003)(110136005)(102836004)(486006)(53936002)(106356001)(229853002)(6506007)(59450400001)(316002)(76176011)(9686003)(33656002)(105586002)(2906002)(186003)(26005)(25786009)(97736004)(11346002)(3660700001)(446003)(476003)(55016002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4158;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 2sK84uF9jrMhdIBNMPkgOJ3Uw8VnFwpPwqLGDbevV80qhcTDRLeLiYjoEZFdEBYaaClITNkb7yXVun9cHuVmHba5iYSaLuVOs85KgSEisvwB/CKyFv0gS0eXNISxqTcz3wYxoyjdT+sNTCMGV9rF0xDZM4R6nzIDF9xthe6Nn0bh+4XUiqaW3jTV0LX2rMOp3eTZrKlveSqOOvmecIVAUA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 54fbac87-552e-45ac-2372-08d5aeaffc3e
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fbac87-552e-45ac-2372-08d5aeaffc3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 15:35:21.6296
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4158
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3UFZWSX030831

Hi Gustavo,

On April 27, 2018, 4:57 p.m. Gustavo Pimentel wrote:
> Add MSI-X support and update driver documentation accordingly.
> 
> Add new driver parameter to allow interruption type selection.
> 
> Modify the Legacy/MSI/MSI-X test process, by:
>  - Add and use a specific register located in a BAR, which defines the interrupt
> type is been triggered.
>  - Move the interrupt ID number from the command section to a register
> located in a BAR.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  Documentation/misc-devices/pci-endpoint-test.txt |   3 +
>  drivers/misc/pci_endpoint_test.c                 | 121 +++++++++++++++--------
>  drivers/pci/endpoint/functions/pci-epf-test.c    |  78 +++++++++++----
>  3 files changed, 143 insertions(+), 59 deletions(-)
> 
In testing these changes  I found that pci_epc_raise_irq() also needs to be
updated in pci-epc-core.c, since it has interrupt_num parameter as u8

Thanks,
Alan
