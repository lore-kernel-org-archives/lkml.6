Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeD3T6v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:58:51 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:11712
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932296AbeD3T6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:58:46 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: [PATCH v4 0/2] Base enablement of IOMMU debugfs support
From: Gary R Hook <gary.hook@amd.com>
To: iommu@lists.linux-foundation.org
Cc: joro@8bytes.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Apr 2018 14:58:37 -0500
Message-ID: <152511783026.8963.5818249217042882958.stgit@taos>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CO2PR07CA0057.namprd07.prod.outlook.com (2603:10b6:100::25)
 To BLUPR12MB0691.namprd12.prod.outlook.com (2a01:111:e400:5951::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BLUPR12MB0691;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;3:EyOjG6OBmeQqv1X7S8zX4fAE9wZWCWh5DLKfAywdq5uTZPBUxFLn8AEbpbu9NAjGaXrd0nmS+jXyqC1OvB2TPlmrJn4dSRYak4FEL94og+WNa9RDOvCMkKYI69mFjoTZwnf8Xg/0krJPeR9BljtJev0RXoEy+Z4/WrAbsrJdOWnXZn4rq6k6C5r4tgKVszkkDrOO1nxEu+fUwTvmFUKa05PASQNWTSNN4qY5oQqQ99pAJ1PsSfXWoezHaKnmMuZF;25:6WFyyWV3HIzNfC+37cmAVND2WHpzoRUn62W5XeG4LztZEAUlnc6UEHghEaxyQmcHXHQxTySBijNtx8mzjjTPj2UccyGgy59FmVy1HMEyS6haHcTMtPWog5cciO9dXlwqp6+qHogOYGD5+kq12eviHZOtlVZ4ymzWtzbhAmECLv2NLo2zTvor3F3XjYWE9y8MszZv5WWRb/SjeUkhg7zCXlWBsXtebsbfGKKEh/O74z2lKBqu7as8l1jFIL0qIVIBgLLBZuIY5b0QKraEbH6GzoYUSd1Z4/ByslJ2CpL+3Z5tm0qpyXDkP4pMVRv6eyDPIBL/coMXUoLX1zKCJaILMw==;31:DrlNYPRlsc11Tz2JVo0qHYjAFV9Clmx9O0dwKIMQJ9r+Q0kwlny9E9ZGqDwn8P/sZG2ng0oewkFYaRvmvCFXnrUQC1WozMg+jN3MX/khvRJXfpjD0hL2CRCu3CvI/hnXH/qDAK7vMSsh0Eo5fwI6fte3jDeVdoYIbDO4qA2LWHljgl5lp4dc4Z/BhAuLiP+27I7KO0mtT/xivJM+j60n7yEwZMdkhJLqnYvfrqPuduQ=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0691:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;20:55FfIn02XxeTTMa7dybn/hBkvApwBWeoeBzEklTocp8trMGB8y5nkhzIbOkTDkRgpJhpjdLSRrlaP6b0h+q0LZB6EV59oXh7Gb47a+WkSQomnwVQIUcxum2xIOBMMj1djPAi61yFBN1qUOzQ7futISUdb3QyuKbloZNrNqWdYVAqQEN8AiXO1u1OCO9bCwgWmNeqxa4FYchKIvUzwaE7uopaj8qBsmE4zuWg80+qJhVvQvTWNlwSb5KyS9RQn27vvq248mNkRkDfcQOUJNFBAhjOI94xl3DWkD08Rza3Oh1yUJ57Y0tUdiGRL/jPXg8SDn8eCipYYBcnrxmSkDZX3WMrf1CzN7alJsgjeuWDBiQ5kKPi3LhIs1czp11WR650pQpdiUT6Xfh1mRoU4dgL3ao9gcI5GeGYjSYPqeTfPSXXhJbAf/G6OYwQT8fFnirk0MO4G7tFRcmXm/PnJ2CVVgNGyPjFM7VzVbDkxE2Gdj+hQ0iPD32Jnax9ZXfH+Tt0;4:7v64VeCkBkz9AMzQYhz8dzMjsg82kkE052kxGWYDtGWETcQJn4cq4IArMeKDIsEwfvrN3+68szoK9Uzyu/IgkDnf5DPTHqr/eCWwANNkAM+ag4jLF6+wtbbdvK+Ue53Xk9qkMzGrBBt9mGjeQnviWrdBnm6rgfijMzx2MsWjkpgZWtrL8tThp/x2ZUQknVCTgXNBzKHXkCTEHMz4ben0a5nDtFnUePtr9HWaPouyvMm+NWyw13XJRiA3FFeNAfdFFLu0akzQqvmqKOkWFkrFWg==
X-Microsoft-Antispam-PRVS: <BLUPR12MB0691AC925FF924DEF9A61321FD820@BLUPR12MB0691.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BLUPR12MB0691;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0691;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(7916004)(396003)(376002)(366004)(346002)(39860400002)(39380400002)(199004)(189003)(81166006)(186003)(47776003)(26005)(3846002)(9686003)(6486002)(7736002)(230700001)(77096007)(8676002)(8936002)(52116002)(305945005)(59450400001)(2361001)(81156014)(72206003)(2351001)(6666003)(105586002)(103116003)(6116002)(386003)(68736007)(106356001)(86362001)(4326008)(58126008)(486006)(16526019)(53936002)(316002)(476003)(2906002)(97736004)(478600001)(33716001)(16576012)(6916009)(2486003)(33896004)(23676004)(956004)(66066001)(5660300001)(25786009)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0691;H:[127.0.1.1];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkxOzIzOmRKTGpxM0lXTDRJMFh3VWVFbTExSXl6TXEw?=
 =?utf-8?B?RTRNbGE3UG9GaG5PdGVzZFFOejZISlJFaWwrRE9vYVplWGlrUEdoM2NLeUxH?=
 =?utf-8?B?S3JqZDZEcVNCYU5nKzZqblNaaFdVOUc5Q1ptZHd0RHlXRk9yZFB5RGFpbzZn?=
 =?utf-8?B?c21pditMQitMVm9aR1VtUzFIdVhEWndsaXhkcjA4VXhGbnV4Y0VBWEFCR0F0?=
 =?utf-8?B?eCs3bVdkekZ4c3hkbE5ZeUdzbVdFV0daWFMwazR4cE5hN3Q4d1VYay9WQ2Rx?=
 =?utf-8?B?MWFCSXVpdUhpMTdRcDV0U2pVQUhyZmNZbnZ0WVRsNkp6NHM3cGp2UCsxNFcw?=
 =?utf-8?B?amtZZlJaYUQ3S3ByWWdkVURFaVE2d0hmWng1UTVyRG8xa0FHYVV5ZC9CNVcz?=
 =?utf-8?B?bkVXd2Y5MnFIc1ZlN2VHMUJMREdydXVPTDhQd1haSTdIN1hON1ovTDJ4bkhu?=
 =?utf-8?B?UHRDWWtDSmgwYVFTYjZFWkYyUmNJZGExeityM2F2WXJlang1QzNpV1BvNzBK?=
 =?utf-8?B?cklMbGpnL2YrdzhaeEtFeDFRM3gwY29jNDIyT0d5SzRUV0FUS203MUVVakpT?=
 =?utf-8?B?VFBPYmV4MDg3TkVraXdrOFdMOHdrQzJzZHZobUVkajIwTXlkK05TY0FjRU91?=
 =?utf-8?B?eWVmc0pmdGZwemdSa01tckVBenE1V0FhYzloQ00vbjhnOXFFY1Qvd3JsUFJv?=
 =?utf-8?B?TnUvN1ZoR25SNGYxN0lhQ0pyS09ZZjYyUHBOUm5kUysvT1FmY0d2eitMSHBr?=
 =?utf-8?B?NVZqcmY4WjlQaE9RQ1BrdDZaemNiQmJBelN4L2E5RGVFM2M1NTdrenN6WWly?=
 =?utf-8?B?dnkrdWxxMFUvSHhQaFBxblUwMXA2MHBLS3ZMSkxRMXQ0NEcwaXlLR1JqdDQ2?=
 =?utf-8?B?MndaSktyOFJEM1lacFlRZjY0dFRKRTE2Y1h3N2pFbno5bXYrWlBIRjhHWEh1?=
 =?utf-8?B?YW14ZnFmaEZKN3h4TWk4amNUN1l1SEpQckdxY2huSFZmT00zbE1Ud1FKckkv?=
 =?utf-8?B?SC9VWFZuOFNuZzZYdTVhUG5RSmhqUTB5NkFtS3cwVkg3WHY0UXNLTmdnNTJx?=
 =?utf-8?B?U05xRXFLTTBORWxOSDQxOVorKys0dUdwVlFHamFPdStuOURaRENCbVUvWEpt?=
 =?utf-8?B?QlF2WGxDSVR1aExTTWNOalN0ajAxMGt3bnJBMkxjd1l4RVc1UmVnUEJkZHUv?=
 =?utf-8?B?VloyN2dmVmNOUVZPSWdIeitpKzVyZlI4SnFkN2JkOC9qTWRWeDdMejFjMTJt?=
 =?utf-8?B?TzFBS3M4V3l0V0xNMVBEcFJYdkF2a0dzbTd4ZEVSblQ3clBVZW1jZ0s0K21t?=
 =?utf-8?B?Yi81Y3JtaStPOUdMQ2JuUnJCRHJyN3Z5T3k5K1ppVXNjZS9YbXR2dy9IVi9z?=
 =?utf-8?B?czZKRWpZMGhselErbFltT05WWk5yVEdlNVIwRzJJbmtraTNQRlkwUlc4WVJh?=
 =?utf-8?B?UEVVcEcrNWlVT1JVbUc1S0NGNGcvZmduRm4vNnJkQ3MvZHJaK2d0REVoR1Jj?=
 =?utf-8?B?N3dIMFducDRMMlM0cFE4U0VzYzV0SGNhMWJOYXNPQnNJcEhyaURwUFZJRU5N?=
 =?utf-8?B?NGluTWN4ZWlYY2tRdUhBOHJrNGhWenJ0TmxKdmRiQnZIZXFUZzRkWC9yL0Ez?=
 =?utf-8?B?c0x1SEJRY3dwcDVRZSszWU42WFRtNWRZMURSazBkUlkzWkc4enVhcFkwbnJs?=
 =?utf-8?B?aWNXemEyc3E2RmNXTDJSRFVybUlYY0dybDBOZ0N0Y0JYWmkyUFpDeDRrRnZs?=
 =?utf-8?B?eEtnNzFBblkyWi80UTZ0Zz09?=
X-Microsoft-Antispam-Message-Info: gGcFN/QQBx12u0Nm7rRxAP2XJUTpjl7AOfqeb+Yvl0ODUTwV0sXheAYkh8SjaVISAAlXRc9lpSjEKlOu+c2EQ8A1DXbom9Q6g7a1sXDeyNMzD4AZLgn3G+BdVL87DIRbE4oJHsM0Cm7ZzgbxcWV3+Q0XfQ6jWxw8xx7TmCv5aHij0mR1eERF6j2mrkZp5WMx
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;6:Bf7+wC9rlfMt4QJwy1dbf0bqem3kidLe3DCjvgy+BfMBinCnB+aWsB/LXGTu7OYLjDDCURrBsSZ33EmKWwT8dRsgjUzV/Z+5veMtljKp5SE+XTRODEYCuv6mgM1eQsb44XQQWHUJtCMq0hluetRDSunSlFRhoN95L+aRlFntaCYY1JXsE+pGpIUkSOUZMym2k4ai5GX6aC4uUz8x3l38SUGwFNnH/xIMlhm7SpqRyAz8RGCTdIVIGEPzYG9ylnFXqhOOcmg2d18c/T9hGs2sZd32lyighIPV6XRyNDmlbAJmX++VmLLVtGJxViJHhRvjMbigCgiTseUnZKHCQ/2yvxu+pL+T6zQYdhM7K5hgEO61WYEVrmrrQcLkEJTZ7BRXqJ5kZHoyEt59hz5Pj+t1SH7nwesODuOvae5jGoMyx1l44VczNoeXTsM5LCMsn3JOq53dNbRfwspIUiV6mQLINw==;5:ufojLeFtp+hf6H73CT78H/MZDzR/jNxOOXyJKThvte+IZlpecOK/bqV4yG/6Jx3bmdtyg+Ge/HN6yx7Jv7uQi9nEa3BbveLDhFyYXk1L+8OYwrWQTxO5W3m6HRpHNweqrzW2MSMjQwZwj6aqjTUAaumbWo6xrjpncbJogD/t3mk=;24:2VHFQSTAtYtXTdvIZuBZiqCM7G9B+5yoaBGvmp/uPO1QF5NWsvfALFdWFwk9m712bsifolVl2d58UPVwQW8CDWYOqRPhB9eydWEW8g3Pnvg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0691;7:6xFYju9aCFMDMUBrkHKF9XJFPhDkKkbMwKKkuHlI9QtxSP6NVMuTOwov5yrePR4lLCa1oax2n49ru5LCHe+zE/XRW2wOYDVomuNkNdz4lyfX8aeVj+xToj7vfJVmW3RY4uME8I/Q8kQFCoOya4vX7R1biS2JtY16v+nVB420+9Fdyz5q/Cdh849WI+Y/8ZxkPlT1TOtiG4JGHQ7sc6/35bqtQTMJ7y+qc0wJ2oebWQUW9eMWQ6ZvlY6ZZ/tKTriY;20:CEzLJ8/pao7s6JAgEo67Nlvk090++hJ16nW1JPSSJw0NTO/52Zar3/oyJeL5VXW/rW9XA3YFw6S57m/d9lO4HTomALTcRlcBadP/sFw60+Mqd/krKb5skVUhSQ4cUaW8dD71Mya92eGh/uNvIcx1uCGiEeCZWHs9ZsmYe+Q8L+qs01W46Yu16cetlztOB2LCewhkNtxbgv53PgVockArHClS9QaBJgnJxbdc+ic2MGHDLz1OVzfk3zSBsdhzxyYh
X-MS-Office365-Filtering-Correlation-Id: 95ea3fdf-f7d2-4f3d-0e4d-08d5aed4c738
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 19:58:43.1873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ea3fdf-f7d2-4f3d-0e4d-08d5aed4c738
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0691
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches create a top-level function to create a debugfs directory
for the IOMMU, under which drivers may create and populate-specific
directories for their device internals.

Patch 1: general IOMMU enablement
Patch 2: basic AMD enablement to demonstrate linkage with patch 1

Introduce a new Kconfig parameter IOMMU_DEBUG to globally allow or
disallow debugfs code to be built.

Changes since v3:
 - Remove superfluous calls to debugfs_initialized()
 - Emit a warning exactly one time
 - Change the Kconfig name to IOMMU_DEBUGFS
 - Change the way debugfs modules are made

Changes since v2:
 - Move a declaration to outside an ifdef
 - Remove a spurious blank line

Changes since v1:
 - Remove debug cruft
 - Remove cruft produced by design change
 - Change the lock to a mutex
 - Coding style fixes
 - Add a comment to document the framework



---

Gary R Hook (2):
      iommu - Enable debugfs exposure of the IOMMU
      iommu/amd: Add basic debugfs infrastructure for AMD IOMMU


 drivers/iommu/Kconfig             |   11 +++++++
 drivers/iommu/Makefile            |    6 ++++
 drivers/iommu/amd_iommu_debugfs.c |   42 ++++++++++++++++++++++++++++
 drivers/iommu/amd_iommu_init.c    |    6 +++-
 drivers/iommu/amd_iommu_proto.h   |    6 ++++
 drivers/iommu/amd_iommu_types.h   |    3 ++
 drivers/iommu/iommu-debugfs.c     |   55 +++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h             |    4 +++
 8 files changed, 131 insertions(+), 2 deletions(-)
 create mode 100644 drivers/iommu/amd_iommu_debugfs.c
 create mode 100644 drivers/iommu/iommu-debugfs.c

--
