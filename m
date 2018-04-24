Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756517AbeDXJ5w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 05:57:52 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:41664
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754189AbeDXJ5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 05:57:48 -0400
From: Alan Douglas <adouglas@cadence.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "kishon@ti.com" <kishon@ti.com>,
        "niklas.cassel@axis.com" <niklas.cassel@axis.com>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC 10/10] tools: PCI: Add MSI-X support
Thread-Topic: [RFC 10/10] tools: PCI: Add MSI-X support
Thread-Index: AQHT0O92Kvfyq11NjUeE5n5ZBlzNrKQPt6aA
Date: Tue, 24 Apr 2018 09:57:45 +0000
Message-ID: <SN6PR07MB45126298F09735193B0F0F00D8880@SN6PR07MB4512.namprd07.prod.outlook.com>
References: <cover.1523379766.git.gustavo.pimentel@synopsys.com>
 <9865822fb89ea84cb55fe93e151295afcd5c96b3.1523379766.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <9865822fb89ea84cb55fe93e151295afcd5c96b3.1523379766.git.gustavo.pimentel@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWRvdWdsYXNcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1mMDdiZTA3YS00N2E1LTExZTgtODZlNS1mNDk2MzQ4NmY0ZWNcYW1lLXRlc3RcZjA3YmUwN2ItNDdhNS0xMWU4LTg2ZTUtZjQ5NjM0ODZmNGVjYm9keS50eHQiIHN6PSIxNDc3IiB0PSIxMzE2OTAzNzQ2NzQ5NzAxNjAiIGg9IjhJYW1sUGQ1NG5TMHIvQ05ieW1zdUdPSVZYND0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=adouglas@cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN6PR07MB4718;7:BvtSOcbVr8RXA5rtbRVqFfrlvdUbxRnzNew/57xKGuiOesZ5U991WEYm6d4FxmlaGn5XwIwpInHWDEI5BdpuEqAdWzz7mN0HMxRUlm2zubKtirzEQcRrl2ULPm8O/VXyLx8MgZJCTvheoZNNlA0RuVd174xEWfS4nQ97EvFDS3vaQ+DGTLglZHRukYQvpBKZzfjd0CzfPzb3e3lqV7T2M23je44T+JC2Onq7Wo2voVuM/Xs2S/Owrh82YaoXoqNL;20:yn1hx3RqdPV/JeYqV/jtxaplGZcao1uXkxN+yGfMYj51wYFeQbU0Jx1lB/Nu6+7Sv/tsRrGuevcA37xn3JpM1+eXKwmmZy8qEsK9ii6coCFGe1GaDSketMWwbGz3qejCE20lqFShgiQY4diMYxusZ7LXsqYLovIKVNh2NuF/uyz7gvpY8ij2KQgWN3Y/6kG7ERIKMUZ7jBtUmhbIeiNmNmKZ7DDjYgwhxne0GvjV8FgpS/NLuP3VHyQPZ9DYYM3D
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR07MB4718;
x-ms-traffictypediagnostic: SN6PR07MB4718:
x-microsoft-antispam-prvs: <SN6PR07MB4718C64560030F5EF0F439BAD8880@SN6PR07MB4718.namprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:SN6PR07MB4718;BCL:0;PCL:0;RULEID:;SRVR:SN6PR07MB4718;
x-forefront-prvs: 0652EA5565
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(36092001)(199004)(189003)(7696005)(26005)(68736007)(9686003)(14454004)(6246003)(53936002)(55016002)(4326008)(478600001)(186003)(7416002)(39060400002)(6436002)(3846002)(76176011)(86362001)(59450400001)(105586002)(2201001)(106356001)(25786009)(229853002)(11346002)(446003)(74316002)(53546011)(99286004)(486006)(476003)(5660300001)(2501003)(5250100002)(3280700002)(81166006)(8676002)(81156014)(2900100001)(6506007)(6116002)(3660700001)(7736002)(66066001)(102836004)(2906002)(305945005)(97736004)(54906003)(8936002)(316002)(110136005)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR07MB4718;H:SN6PR07MB4512.namprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 2M2Z2dfat7gb+9TAgnr3NYHNaAJU1viaLwcBHbyHCQz4131EoOokDMha7JyfsUD8lKlVrocO//bZ9IUpBmuNqlSjTKYygdMhJAvRe168XJKDBt8jStvQQZ202iEvvuPpHWcjpNey74Aao9Vbk21rtVFJ8aKnyr9kNa2nsa5Z7A9/duCCKQaaf3PuB7AmTrm0PeimeQWz1MygCOByHtu/Jw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 41d866cc-3da5-4f73-b0cd-08d5a9c9d41a
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d866cc-3da5-4f73-b0cd-08d5a9c9d41a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2018 09:57:45.3582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4718
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3O9vvbA024003

Hi Gustavo,

On 10 April 2018 18:15, Gustavo Pimentel wrote:
> Adds MSI-X support to the pcitest tool and modified the pcitest.sh script to
> accomodate this new type of interruption test.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  include/uapi/linux/pcitest.h |  1 +
>  tools/pci/pcitest.c          | 18 +++++++++++++++++-
>  tools/pci/pcitest.sh         | 25 +++++++++++++++++++++++++
>  3 files changed, 43 insertions(+), 1 deletion(-)
I found some possible problems when testing with the Cadence EP driver.  The problem
is that pcitest uses the BARs for tests, but we also use one for the MSI-X tables

In Cadence core the MSI-X table is in BAR0 by default, but this is configured to a size
of 0x80 in the test driver, since it is used as the test_reg_bar.  So, I changed the 
configuration to use BAR4 instead, which is configured to a size of 131072 
in pci-efp-test.c, and this gives me enough space.

However, if I run the BAR tests in pcitest before running the MSI-X tests, the
MSI-X tests fail, since the BAR content is overwritten.  It's not a problem with the 
scenario in pcitest.sh, but it would be if the module wasn't re-loaded.

So, wondering if we need to come up with some mechanism to specify that a specific
BAR will be used for MSI-X, and that its size and content shouldn't be modified by
pcitest?

Regards,
Alan
