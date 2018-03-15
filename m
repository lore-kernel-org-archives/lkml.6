Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeCOPPV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:15:21 -0400
Received: from mail-ve1eur01on0072.outbound.protection.outlook.com ([104.47.1.72]:45673
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752391AbeCOPPS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:15:18 -0400
From: York Sun <york.sun@nxp.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>
Subject: Re: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Topic: [PATCH RFC 1/2] drivers/edac: Add L1 and L2 error detection for
 A53 and A57
Thread-Index: AQHTu/Mc+CsInsRsN0uQgig0C2tI2A==
Date: Thu, 15 Mar 2018 15:15:14 +0000
Message-ID: <VI1PR04MB20786EE9B3FB70B7FCCA88789AD00@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1521073067-24348-1-git-send-email-york.sun@nxp.com>
 <20180315150702.5yqauxj3z6exdl65@lakrids.cambridge.arm.com>
Reply-To: York Sun <york.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com;
x-originating-ip: [66.235.47.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;VI1PR04MB3983;7:dgJvAqR9yUWV6ebpnFjPfzGfVAENyMa7aslCNpiwlI7sUhBojOF40vsPga88DfxDtzbanD+44kmAa6AVhym5Rme5sNNw6lE8rZW+ddzeAvN0qMiXz58tNxwj567wz7nayuUPgHgk+kpZWc4Mfh/VSNdck00n+YQ7wNj4htK2q2s/hhYrQIKj7eNFm5ya8vmtlEZOvnu0gant8snMSxGN1RkDAjC2SZ9U3PEzpVtMvDUlQOnJGE9i34PeVO6PxW/E
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71fe9b8d-7b27-44c4-6114-08d58a878d9d
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB3983;
x-ms-traffictypediagnostic: VI1PR04MB3983:
x-microsoft-antispam-prvs: <VI1PR04MB3983DD90241E3D919EAF422A9AD00@VI1PR04MB3983.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR04MB3983;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB3983;
x-forefront-prvs: 0612E553B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(51444003)(66066001)(3450700001)(105586002)(81156014)(8676002)(8936002)(81166006)(2900100001)(316002)(3660700001)(5660300001)(68736007)(55016002)(6116002)(5250100002)(86362001)(3846002)(9686003)(102836004)(6506007)(229853002)(53936002)(6436002)(6246003)(53546011)(3280700002)(97736004)(59450400001)(54906003)(2906002)(478600001)(99286004)(43066004)(25786009)(106356001)(6916009)(7736002)(305945005)(14454004)(7696005)(74316002)(26005)(186003)(33656002)(76176011)(4326008)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB3983;H:VI1PR04MB2078.eurprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xY1YxWKs3zaSQlR9TAhJRlKPAoeJDs1bm1pkfdHX8+7NazrYs0l9N7IF3i94yOAiTyL53Zvz2hc8v1VQJd7mWT/bo1vqKvDw67efzQU7Hdx5wSXLbJrr6JlP969elx8TnZFX0MLIijFbHVQ7Y696FmX9NsRVDpT2FtxgX0LjpFr2bPTW02FISfHqzHMz6RqCL+2+e49oBQqKFHZvuCElHcwEnHw3ozZIik+8aTA67oKqs+wYdYtARIMIeLUSrN/QQK0+/f+PM7sPcTJc62bPTqpEV6cW2iXjI4w7GbjODYHjyShrut5lmp6Sss0k+R/kJbBOw/We+RDtGTpTBPm41A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71fe9b8d-7b27-44c4-6114-08d58a878d9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2018 15:15:14.2350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3983
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2FFFQHw014833

On 03/15/2018 08:07 AM, Mark Rutland wrote:
> Hi York,
> 
> On Wed, Mar 14, 2018 at 05:17:46PM -0700, York Sun wrote:
>> Add error detection for A53 and A57 cores. Hardware error injection
>> is supported on A53. Software error injection is supported on both.
>> For hardware error injection on A53 to work, proper access to
>> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This
>> is done by making an SMC call in the driver. Failure to enable access
>> disables hardware error injection. For error interrupt to work,
>> another SMC call enables access to L2ECTLR_EL1. Failure to enable
>> access disables interrupt for error reporting.
> 
> Further to James's comments, I'm very wary of the prospect of using
> IMPLEMENTATION DEFINED functionality in the kernel, since by definition
> this varies from CPU to CPU, and we have no architected guarantees to
> rely upon.
> 
> I'm concerned that allowing the Non-secure world to access these
> IMPLEMENTATION DEFINED registers poses a security risk (as it allows the
> Non-secure world to change properties that the secure world may be
> relying upon, among other things).
> 
> I'm also concerned by the SMC interface, which uses a SIP-specific ID
> (i.e. it's NXP-specific). Thus, this driver can only possibly work on
> particular CPUs as integrated by NXP.
> 
> The general expectation is that IMPLEMENTATION DEFINED functionality is
> for the use of firmware, which can provide common abstract interfaces.
> 
> From ARMv8.2 onwards, EDAC functionality is architected as part of the
> RAS extensions, and in future, that's what I'd expect we'd support in
> the kernel.
> 
> Given all that, I don't think that we should be poking this
> functionality directly within Linux, and I think that firmware should be
> in charge of managing EDAC errors on these systems.
> 
> I've left some general comments below, but the above stands regardless.
> 

Points taken. I only made this driver under our customer's request.
Even this may meet our customer's need in short term, it doesn't look
like a generic solution for the architecture. Let's stop here.

I really appreciate your other comments in this thread.

York
