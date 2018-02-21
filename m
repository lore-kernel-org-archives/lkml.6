Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937781AbeBUOgW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 09:36:22 -0500
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:31136
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934352AbeBUOgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 09:36:18 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
From: Brijesh Singh <brijesh.singh@amd.com>
To: linux-crypto@vger.kernel.org
Cc: Paulian Bogdan Marinca <paulian@marinca.net>,
        Brijesh Singh <brijesh.singh@amd.com>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ccp: add check to get PSP master only when PSP is detected
Date: Wed, 21 Feb 2018 08:35:58 -0600
Message-Id: <20180221143558.4799-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR18CA0072.namprd18.prod.outlook.com
 (2603:10b6:903:13f::34) To DM2PR12MB0156.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e222ae60-c55e-4718-ecb9-08d579387656
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM2PR12MB0156;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;3:auB/Ze3wI0Uay8uXLV09SAwAYUs2wudBSU76ggY6Wb+BPTgFMN3AB8iIPjzY6VQfs888r1exXXNVYJjW10pc0YaPYlBcH77LAvAs1qhG7dlce6UbsQqH/zTdBS8hEsmqpc6ji8L5QX13kUoWdVp0QBxUlXJBEItBZ4fpmuPKwZIDoASTXTDHM89eF7zEE0WrS0SQo1IhRcS5w5nQDyUEuzHWaOdcla/3cWIvp4MfX5P/wCNgBPVXZ5RxBVPKtp6W;25:BN66Pu4GmAO6XoDY9sSXnCX9TjVuwSUh9QZEx2768B0IYPw+/tM7K60PETbxtym469NQEMb1XEDj9ILAy7t5kemK/ImAWhlo+KnBgqZ2iZCtxw6QrgxfZNVmicPvblvap4JiZLFySd8e2nGAzxjtTCnVJkKZuJ5wgAgMiJ5FrdE5d/tD2lXCELYLhPZS5IyeHWKgqQLiahMd4USt0XV6ivLDBzD33wXZs6ElD77lQShJb8ay/TvaEArSdZxZv8rCkSDTcUJ/JwkRYcLGWkbg1DPSLbYd5uxeDbujUPgs5iBPOQVr83N3shw+ceqDWxwcn7DhQ4PIx2vnU4jtNJhjFw==;31:pzAoICVZDGtnL+U6BeTpbqCP4g5KT5mPQDaH9ugnrqfSIQz3WF9zfPpOmzYerGThKHX0jESZbEa/YHyxbfKibeNEISvN9MPvY8goPtEXxW7mbKOcmR5E+zFutoSEq8d1Eew0AJGHaoKdTppXxlHPzbje/tEItxuR+Zqx+qQ/iaBmV0E4FsZ3r2W63SEElJmfue7aP0WtKRFwOqNwgvz7A0Gg1C+4KAurhOOGuMUUaFc=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0156:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;20:kwMEzTVdqs1/ns9+hvzFILyeVuzomLQ3AP7lDk0BNRvRuF+XHuoG4Aw9Rvd06xuODmK9zUZXa0oHQe9xTFgVHByGXgjrFHL/N/2rMkrmcwXqaWrKwyUP5+zn6T7kwp3oKpGxd3QUizkLYbcYMelxyLXkld604q6dmoWlDiwNw/ZPpakGoxy4Lblx22vB5iDxXuuj0+wY+EpRSWxEvJP5wRw/9VmIGAFSx3RiAtIhCp+YV4rqaV2TRK6APcM0N55rCnw4v3hd6U+cXLl/OwHgB+LdPhexk9mnKGSjx/Lu9oH0QkjbHp99mKOjwRguPfhF0dSZoF+b9mPKFmGIftfYfer6g2D5PBQOlMqf98/EEmmw7CjvQ6iT7kc18xL+CFxTE4dT3nyonmJ0HWg9cNOKaDrUGw87kzpWrH37NZDVky+G9Fhicajw2/SGUKk5QiGs5GpD5qfchLqjoaXYEZJUASOn+KxynlTh6JHZZvdraGhRaDzdbUIVSX1Tw8Efphi6;4:YvGwFp82dA/10TGcp9RwWMeROOK/wZshVnIiX0Jb8ZliJnucwbGJAhG69EoePg/+deGUypOc94Gx9ZsPMYugG3UDNzwML4413SIhkSKlN0n29Bb9TSX/gKgNUiIY8KNOvXBzQmvKh14jKOzxsgLZZX1bs11seWAsdewCpBRttA0J6o75b3vIxDjX4vPlAOV+f0v8L29GuM5eTEntdnqfIz4YPwe2TEyvIZI8D43Rx//cRylwHrMN/AMUe7KXmPle4/gNPPh3WSUBpnISkhlEXtNRxiD09HURnc1Fn4l3NdkGn4yJUSTBhqGcwXYqvwKYJpW+g/VFJKDpkzuU6wCQNw==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0156F1499DD8FABDCE1D16A5E5CE0@DM2PR12MB0156.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001068)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM2PR12MB0156;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0156;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(8676002)(6486002)(2351001)(2361001)(54906003)(16586007)(106356001)(4326008)(478600001)(6116002)(86362001)(1076002)(575784001)(68736007)(1857600001)(5660300001)(48376002)(50466002)(3846002)(25786009)(51416003)(7696005)(53936002)(52116002)(2906002)(6666003)(50226002)(186003)(66066001)(16526019)(47776003)(386003)(105586002)(59450400001)(36756003)(81166006)(26005)(316002)(7736002)(305945005)(97736004)(8936002)(6916009)(53416004)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0156;H:wsp141597wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR12MB0156;23:aXqZkrPL3vEkAVmnBZkShScVAvfiTt4ej97j5SmLB?=
 =?us-ascii?Q?Gz1mxdasxz362lMXZ81Q8UWFPKMclBDYm/VFKP7Lm6Xw+MBgqlH7NltMfatJ?=
 =?us-ascii?Q?qdFmu5uldzJNgxuCbnd3HmdVlALARmf2OqKknkceI9vj/KxkYBg7QCgjq9mO?=
 =?us-ascii?Q?KD9agiqXLGe6/mhDPhqaOyp15L0hEPno4S61RFmugTxP7+bKrWHuJX2t1nrr?=
 =?us-ascii?Q?XEMZLqX5Hnagj8ILifnNiUJJo/52RRtRwP4rd70XfrT5Zgg8xSv9I8B7snjm?=
 =?us-ascii?Q?7bHTgsWWrVkr+nZtGRm8tlwEMWqUImDbsf5DWuuT5cqJ/H6L9BXYsSAcel6n?=
 =?us-ascii?Q?HEEmBN0+mtotrAB1oRicJQDdUXEpK8P0SlVh1giBOH5QlOzNKJxX7+8WbM+h?=
 =?us-ascii?Q?K8eHyMHyoVOtJ6Ag66lNIxTT8upyoLwHvBHAnqCJjpStrhwzS5R+4S942ifp?=
 =?us-ascii?Q?rb/+g8WFKk1L+PhYPikg8ZNHA2jo0I+BLWlGrvng2Hx4kL6D9FuYle8piJbZ?=
 =?us-ascii?Q?+5QZKQrhzB28111lWP+8TY5X0ADvNTOTEayBIzXo629pe1F5fz3Uwsw4Qvkd?=
 =?us-ascii?Q?LHVFDgZXXpKGiKGqc337635z7gYmrspyP5dn4kKIlhMPOMykaEi/1Afd4a+9?=
 =?us-ascii?Q?CBzQu+e6vkxY1UPrywLdIxtOAaFl52Mee3YaadSe27cvYqla5Hcl38ZWPsB0?=
 =?us-ascii?Q?t8HkV+etpPQP4XWMqLP/bcGEgVGGaq9f9/Gd9llciqEiIJafoo7yPvkto5My?=
 =?us-ascii?Q?85plmlEfP1uJmaIGe2TA6XBe3pc1k6Sm/Ui1Tyy3SEzbsJ5IRmms53ra0Cjh?=
 =?us-ascii?Q?wVgLTZYqpTCAY8u4x2noR9riiyePl1lnt0Xkc1+EviTYKAi4ddbUxUtYs9TQ?=
 =?us-ascii?Q?rk+JioC0ldwsbunj6P95omslwe+Jn+QKsihCc24QWwrSsTXg9ikXH/JWBP2b?=
 =?us-ascii?Q?jr+8vJXkqwowVp5fcbaz7OZANn1M5Eo4FLC/LEFM4g4Q281EW6BD10hUOkm8?=
 =?us-ascii?Q?MJi1fRI5Zw4vS+E9YP+GHXffPg189tg2dIQ6DJxVGaSXbsZHhzaeiRVk9fTP?=
 =?us-ascii?Q?pCBRVIJGQ7faB0acg84D3Wp4jfv7XJQRj/L1pSj4dIig/Qleb/+MucVRIITb?=
 =?us-ascii?Q?zyj6ym5mri2BSGu71kEFqjuSdnw55mpJKTjaAzkWgQLOf8/FB8I8KULtlFPP?=
 =?us-ascii?Q?3+KN/qkkgO8Gyjv0GKpqsQB13KLZl4CYxPF?=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;6:W88VFjx5tONUgRF6ZmEGH432YipUvtiJNflrmY092/hSEEDZQtZSbRcRQN5W1Qgxc6dRrM26SsX4p+Sc673J1+7FodxhboD+LMfWIiWHuFiyu9VPw5k0BF1pQKkZnQyuYKTGh0Bq0Cqhqh2+WZXU4ZD3mH2myKSAQou4+h46/GCaZbmN8D8uAOmp0Nis95DBO+dIKrTOzQAaJDcdro30S3sCugBE1Zs3t8L66/Evk9VfxsdDY0mdw7Fq2wnonkE7ACLgtYytP7OGxDpc+cqVDitBQzJUClMuCfM+cofA86i9zA8hTVMV2oiuuqq7c2B3PoFV5pJb310QG6TjH4WV3V7HrxxwMWkXptb0PxsQI3E=;5:St2OB4VVM3PGQistwedGJ9phkN9X1qzWVvcVXDAtjBBVoQWJDEPc+JFaN9ivt2gP3NOxxor8oDvFFSenA9crfslUA6VP4PfNjyag4UUCngx1yMZuCcNlzw0EkchQFlloL6FD3egpRjKvZ+Ol58Optgvy+zyYX2AE09SZgjnKSM8=;24:CQvasjNAELy9RXDxIWBxZCHtI7LMEVvbYhmmoGMepicDyuX8LtQkPDiHzyq+jQBUdAKF8NBG4tOAxnRSUQAJlLvv3NskqYEvQ6hi6nnn3q8=;7:tb8pO7YS85Kz8aKMs3mGqWlRnuA5BLAol+orBhY3VkNIjMVZJAFjGm28MuNVjp0Rl0bTCQwZbSoe3Si+QtNZdA+KuXZOc3sB7wk9KGBpZPGYpICbJdH4b0arlAifalxkIVkDuD+TWVPOAE+d0V2C2hxjIqHXOtfxKvP6ak0OAaeTLjsgal2WICDBClzKxwxpMDpIqlSDFjVdLwrCKy3aY4R8nm4iRdkJvEnt+kz0SKljo83tEh6VXwvdJFGlqpWC
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0156;20:kvIUu4e1uJCMzISzX6d9B49yGGCkKzWQCwvZFfq8cfuadt/wI+bN3BPiH38GQ1vDmZOiaTkh2Cc+OlyY9ZaLIID7z4Q8oqMHbHEfUFKlPsOZ4yGodesqZfd1RabkjFwJmnqkC7CsUoTqqy5r5lvvBIbw0QVXmtU1oOb1hSlPNwdyix+BKuNh/SSmhkcrleXomBpRoxPWXOKc6cbmdUsk/7Q2V6wyx4YDrpRtzw4lZstIPon4Or1n1C7GiKOANvW1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 14:36:14.8018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e222ae60-c55e-4718-ecb9-08d579387656
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0156
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paulian reported the below kernel crash on Ryzen 5 system:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000073
RIP: 0010:.LC0+0x41f/0xa00
RSP: 0018:ffffa9968003bdd0 EFLAGS: 00010002
RAX: ffffffffb113b130 RBX: 0000000000000000 RCX: 00000000000005a7
RDX: 00000000000000ff RSI: ffff8b46dee651a0 RDI: ffffffffb1bd617c
RBP: 0000000000000246 R08: 00000000000251a0 R09: 0000000000000000
R10: ffffd81f11a38200 R11: ffff8b52e8e0a161 R12: ffffffffb19db220
R13: 0000000000000007 R14: ffffffffb17e4888 R15: 5dccd7affc30a31e
FS:  0000000000000000(0000) GS:ffff8b46dee40000(0000) knlGS:0000000000000000
CR2: 0000000000000073 CR3: 000080128120a000 CR4: 00000000003406e0
Call Trace:
 ? sp_get_psp_master_device+0x56/0x80
 ? map_properties+0x540/0x540
 ? psp_pci_init+0x20/0xe0
 ? map_properties+0x540/0x540
 ? sp_mod_init+0x16/0x1a
 ? do_one_initcall+0x4b/0x190
 ? kernel_init_freeable+0x19b/0x23c
 ? rest_init+0xb0/0xb0
 ? kernel_init+0xa/0x100
 ? ret_from_fork+0x22/0x40

Since Ryzen does not support PSP/SEV firmware hence i->psp_data will
NULL in all sp instances. In those cases, 'i' will point to the
list head after list_for_each_entry(). Dereferencing the head will
cause kernel crash.

Add check to call get master device only when PSP/SEV is detected.

Reported-by: Paulian Bogdan Marinca <paulian@marinca.net>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
CC: Gary R Hook <gary.hook@amd.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/crypto/ccp/psp-dev.c | 1 +
 drivers/crypto/ccp/sp-dev.c  | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index b3afb6cc9d72..b342210e582a 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -677,6 +677,7 @@ static int sev_misc_init(struct psp_device *psp)
 
 static int sev_init(struct psp_device *psp)
 {
+	return 1;
 	/* Check if device supports SEV feature */
 	if (!(ioread32(psp->io_regs + PSP_FEATURE_REG) & 1)) {
 		dev_dbg(psp->dev, "device does not support SEV\n");
diff --git a/drivers/crypto/ccp/sp-dev.c b/drivers/crypto/ccp/sp-dev.c
index eb0da6572720..e0459002eb71 100644
--- a/drivers/crypto/ccp/sp-dev.c
+++ b/drivers/crypto/ccp/sp-dev.c
@@ -252,12 +252,12 @@ struct sp_device *sp_get_psp_master_device(void)
 		goto unlock;
 
 	list_for_each_entry(i, &sp_units, entry) {
-		if (i->psp_data)
+		if (i->psp_data && i->get_psp_master_device) {
+			ret = i->get_psp_master_device();
 			break;
+		}
 	}
 
-	if (i->get_psp_master_device)
-		ret = i->get_psp_master_device();
 unlock:
 	write_unlock_irqrestore(&sp_unit_lock, flags);
 	return ret;
-- 
2.14.3
