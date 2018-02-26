Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751877AbeBZTj1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:39:27 -0500
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:28397
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751454AbeBZTjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 0/8] Decode IA32/X64 CPER
Date: Mon, 26 Feb 2018 13:38:56 -0600
Message-Id: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9ee91b52-044c-418d-d607-08d57d50a2f9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:wyU+06vjTxvkYxTqmt7QcUvcCHzm4jEvBr7vDrgbDjhpEEuDSDR/7Qn1zxQoLBDWE2Ur7NendncsWig5V82MD8ZZg1gPrbnTSvjXB2p8mCAaajAuDVDhiEvDHV3NdEq/Kw8UDMrJBXSGFwCBFDzikPxwabNzXLRvvqGe1m4uJddxDrkIVN1+GtlZ4IxYPP8MpeN/U1AsJMItrO2ivfa99D5P2+atT6X/i2MWFvDtXZm12OMYCk5R/KnZOQPo7ya1;25:8dAgLjjhi8194CK432J74sovxXSJT+JLcqhLk/w//KC80GVeMrUkqNaZiSaVCzH5E+zMSKeGXBMA6BtuILtF7Eru9SHqx/bgGC6UrhFxIz+joNShuVp90PxHd2Yg1PbHKxd6wl692WnkrfaMc9+qmZLZ+7WaKam/yaQqztEVAa4clmXPs1ynTsv+TprJk/oixmFm4355Ed5d3nTnys1LC41DHmSMDses+JWCDDiMNK6z60MlL6Fwf5skle5RNhWdl8Vqjmsf03jJF9tpGeMvBEQSX2pgo+TxMi6WSr3m8qcQRp09TtkTEX9dLmfJFaPgP4vwDdBSyK7wUctQ2dSkrA==;31:EB8mtA94fePthY4M3NK5C6U4e9Ee0bWAANcSZ0iv8bq0DmmLDcI5kKP/a+PRv49ZRjviiRD9ediYyDZTCT2Pghn+5X6n5c1ulhU5ZJkAE+bLve0aw8K8zcZHKcG0SwmUxWlyeeYOlEUO+mySgQ8vmC+DhdW8uR1GGMB0e4WktolTGJEKqIpS7ZFi0jcHstimTPKmYMiFP7+7vr9MomlzOoIb7EL/B1K9CGE3fuOe3BA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:aCs6DEpl26VKQ4aFqnyFUVw+tzRjXpEG27a/cUddbJdyMTeQucc0o+kOSiS/WKM4i5cJjMwb0gyrHvJXydb/OYXTJS5P0/b8u26Ea83aTEUJOrxXf2wngPSb5AqU1qL/r3TRE5k4lWQ+OFkty6swcwWgNdSUhq9M4I22MctkbJ3ox3m0Oxi4jLvuUE0usnpjhYBjl9xsWWiBXSbR4/1aj7+U3B/Bu5QfkMC3079r+/ZVCkWOAzkImuGxyWp23BGXYNVQXErdNrZEhgVcPj+x5wIbzlTg8k0UOV7910uTFN6z3WIFCmY0DS1D6zVOUub4F7wCxr+J2hKcXymC0KvZDaZ9lv6V7XEwpxgP17HVA3kizCszf7EVAjzkZULcwyecfuMNLTw8+TIiFJYgARuim66hKpQzjgE3nseAUGS8IGl6JNr1yAx4bONV39mLFVZOgKjYlBgSWokrnRv6rex4NL5hBEGPqEuMMYxEoNmBzssYN87crWGb2FsWu9gOw7Su;4:KKRka4I4qGNE0u2KnKuTgyoSUvADBkXFiQhxQ0WOUcKdo79amg8/hKxACF99wB8Mn7bYWXhmeuq97H27YXJa3KvxKmkJBmW73CefhA1xZ9cXeP0LX2ScSDIQ3DabE3I1Ozmjt96m1h2e8S2RlChd/7L7nPiPwZj3XPSRosfpwZOmXjpOFTpAyqoXZs6qS8stDFFku1YHI9iOhZiC8KhXoweromRs0YGEX2hR1IVOhIsHN4GBDaKscw7wSYCwLabd5+KLSaN92qCZbVi+VdgfqRLePx4fJK5QTyv2OQkApw/IbaDho0VPfu3wbQsf2ppocMmz+dxvsy8bFgYMOKoABQ==
X-Microsoft-Antispam-PRVS: <MWHPR12MB19177ABCF413F5BE5243B8B4F8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(86362001)(59450400001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(6916009)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:NbfwA8/8av9rsbLE9pRV7H3tfBK0J24NxcIQCJGzU?=
 =?us-ascii?Q?mNHJJLg6/owsxZvUzHj5jrEm5qtG1LMYu14mLHhNjfKL5yydhDxGWnD2NmCD?=
 =?us-ascii?Q?1rC/hNs2RuAAc5cjyB7DMNq1a8AnD0jCV0k6Q1OyWcEkz6sUafROqki0Sj/F?=
 =?us-ascii?Q?3UZcq2pCYLk2h1nElhSXpkA4yEJAX3ketnzU13S+OsFoXcU/NXiXKvJr/0XY?=
 =?us-ascii?Q?u7qGac4raw4BdqyyGm4oKfOUAYf/TcPa4OthSBAEFb60OVh8aw3d0VYQNilQ?=
 =?us-ascii?Q?ueZtufY9tfKPXlI/TPVIqcCh7mTPhdfCSvNMavMmbpCcqjRLlscwt+FnwIrx?=
 =?us-ascii?Q?h+ZpOXjmL8D/NUdY20ynCohguBXqh/xMymahDgD0owjVEWmVRoy3PXQ8s4zk?=
 =?us-ascii?Q?rFvtdUoTy7yPKR+we5hpZN0G/PKiVHO9+eQx1I6V8cEoE3syoI23Tl8o3+4K?=
 =?us-ascii?Q?3iEzj6Z4nr31Hvbi2k6KYz1puFLK4BKTEkM2inHBlLBlPdv64aTy+Eif1D1R?=
 =?us-ascii?Q?wswU8O5DACwMlw9dRSHGcZPVcfRYrq1AQQb3VoC+6bpVvYIeDqzbJRrv+Sf6?=
 =?us-ascii?Q?g2OXy2CpSK+hrQNDeqVPm6W0N/Qwrln8EyM9TcIBK645Y4BIbusMRExyb3ZP?=
 =?us-ascii?Q?X+riEtIgEcRcoQk7gsK8uO9CmDiNqpAxWcmiG2VvXlTw04LuvqxMUptln108?=
 =?us-ascii?Q?G+6ipUPzzi7ptgMgTXhiuDjLQWqj8Jg6EEiTBhT2kEe+P031xjBHzeFlkXYZ?=
 =?us-ascii?Q?MgDPE5Zaq6ycTPOjOnXBRMylCmptsdn7HdeHAYdK83hKiSR8vXxbpOXhs5DD?=
 =?us-ascii?Q?Lezx7AD0JsXk8smwv+yhf3JDhfXweh1C1/5pyt7yHM2Vl+CrdwiYhWHbCENi?=
 =?us-ascii?Q?7OBMAeAmpc9MUa4blRChlXa9qnkjkXLEQeYeKoKk2Y2Yq42+IXcW8PLYGfui?=
 =?us-ascii?Q?pm5S8jn48lAufOpyPc291KnMgJio8dDBwJqpokIRw+VsNNn49zX+hVnxcfXn?=
 =?us-ascii?Q?ROF+hreiYysb9c74vWGSzdk8wwNYRHloVzD2Fnu3PkylVxU0kq/j7lbuPOgi?=
 =?us-ascii?Q?TMRnEowgSmqwjXD5azrXy5P7PBldJBfYRE4qLYb/pK1c3QQe6Q2TXR/wHpVZ?=
 =?us-ascii?Q?6gYWeb3otF2FQg3bE9CatT1xKjhJ8VlhEP1vBWjBSXIZAxe9ZAqFBnKKc1Dq?=
 =?us-ascii?Q?FRUGWKXFwhbRkoliTBvxaVaK3AvCTE4d0o6?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:4PgqwVsKAWaHS2D+PAjzCBx/dXLAifJOO58Xk6G2G+03BCBPTnFU76wpcw4Tge/zQASLIGcUhwplmlRdQiI0ZtOMrN+rJhS9G6twaNnWfUoShzXko3hc/BKMW+wBnC6b2VV2Ae28xT9H/TOdFXozr6pCID58F7yRvtES/8OZZnXLfviZHFQ1msrt/3089LXsV9wnzVDI1dtvJ5h0EIPT30nHQHpVAr74DCN2C9VKFg56waBXRwvckqJXL+jNzl3V5YwkKo5+/PTaZRBrw1ZYmc3VBkmMPEXHwB+ND5rr+C2sbi3/YYKHQdPY3jwaH/a43EJ5FWYqQtbPgv8ZBIAZCHJkJ4W60iaP0JxIp4dji24=;5:I5A5qwLuhoGQIob3UsbOQ8fnrxlt2liPnrQ9qWkmL60l/Y2S6LVro/3PbAE8rZu4MgtWCSaQRycpvL5DdO7BmMR1Zo1sPO/fwwCoKFRpQA/Ey+b3Z8975a7FX0PuJmYgpFtWiy4K+1Jbf9MRuWokxlWjzA/ul8xOiv0dlN5tcjY=;24:wtSvzFT5d2OjDIAp31Abgrl1T0f/7s4UKWPLZRk7EcoQ9g0068O6cRE5RuIZMAden89sZ7Jgdq+hp5vwMYl+MdACksmL0cSuWU7zhXCioBg=;7:3/YDohxPxMdGWjgSGeuDfYSVhZkOjxQlhSF3r+AQDO3/8kYf3apVgDpIOlQJi3TkVxPKbNA/YpQBvGEzV5Me9bKqxTHWNe9K2ygoNuq94Q3/vpzB/HcQsCN23EzpYeCNO6AtBGxevOt8jHBCHJJgjoe4Mv20IbdDipN8ug0hcZgE6HD41N83Vs5WCLPFkIFfkKboPjC8qglC+oTTzIWV9gGQt0oAax2Xo/p55OWrI1uPVxyePomlQt0dsm1Q0Mlo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:ZfmYzhruis66F8x6nzudXzipvZ97Evh+UYOnfuuAypkZJjIPAoUc96p1vfBE5vcieJNLmUsbqwm90l+jXlp8OtE1zHVpEWHTbMVVoFPHltehMPHy+Pl4sp33UFMfpYvGByD36ciJkU27qNy4hbq0G2Dr6jzYLEVH9CvVbEMPsnnDOvhXZIzUY6E6cfhhiOxx/Or0kbXzdjgoceEdA8s/K3WsQbWpubbyNRH6q8cqmJBgONJex9H5QY4RV/UjA657
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:20.7931 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ee91b52-044c-418d-d607-08d57d50a2f9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

This series adds decoding for the IA32/X64 Common Platform Error Record.

Patch 1 fixes the IA32/X64 Processor Error Section definition to match
the UEFI spec.

Patches 2-8 add the new decoding. The patches incrementally add the
decoding starting from the top-level "Error Section". Hopefully, this
will make reviewing a bit easier compared to one large patch.

The formatting of the field names and options is taken from the UEFI
spec. I tried to keep everything the same to make searching easier.

The patches were written to the UEFI 2.7 spec though the definition of
the IA32/X64 CPER seems to be the same as when it was introduced in
the UEFI 2.1 spec.

Link:
https://lkml.kernel.org/r/20180223200333.6410-1-Yazen.Ghannam@amd.com

Changes V1 to V2:
* Remove stable request for all patches.
* Address Ard's comments on formatting and other issues.
* In Patch 8, always print context info even if the type is not
  recognized.

Yazen Ghannam (8):
  efi: Fix IA32/X64 Processor Error Record definition
  efi: Decode IA32/X64 Processor Error Section
  efi: Decode IA32/X64 Processor Error Info Structure
  efi: Decode UEFI-defined IA32/X64 Error Structure GUIDs
  efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
  efi: Decode additional IA32/X64 Bus Check fields
  efi: Decode IA32/X64 MS Check structure
  efi: Decode IA32/X64 Context Info structure

 drivers/firmware/efi/Kconfig    |   5 +
 drivers/firmware/efi/Makefile   |   1 +
 drivers/firmware/efi/cper-x86.c | 363 ++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c     |  10 ++
 include/linux/cper.h            |   4 +-
 5 files changed, 382 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/efi/cper-x86.c

-- 
2.14.1
