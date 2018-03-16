Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932360AbeCPUiD (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 16:38:03 -0400
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:55584
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753536AbeCPUh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 16:37:56 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com;
From: Babu Moger <babu.moger@amd.com>
To: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, babu.moger@amd.com
Subject: [PATCH v2 2/5] KVM: VMX: Remove ple_window_actual_max
Date: Fri, 16 Mar 2018 16:37:23 -0400
Message-Id: <1521232646-79580-3-git-send-email-babu.moger@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR17CA0018.namprd17.prod.outlook.com
 (2603:10b6:404:65::28) To MWHPR12MB1776.namprd12.prod.outlook.com
 (2603:10b6:300:113::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 12150ad9-4e78-422e-5062-08d58b7dcb6f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1776;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;3:/MXoBzoUKK22vFvsP6mH+canABAXI81fsCiBoc2342U8FIYtJWTBYps6Kz35ljEeKZm0gPNOGaecdPbNvXtEYz0Rgw0iVU3rN9U0etRpnffdYXsqvccGY7toEpdJ+IIGhnFlD+4jm23LaPKBWYnvQy+9t/WRHPVJ0DWXp7aVOJlkFJVmsQ7x5hlNeT1D6B85Q5PulELheg3xvsLZb5r/2sjuKWNuMzTaWrdko3UBkBBG/2blK7HqfcDUG09PSSxG;25:9VFA2yo5wl2JwN/Gz7bwvKJHEJf9aGk3Ib7QPj9TBukXLCZbyV68eFFpuSfYEKUzXTxoaOzAQvMTEbhCNmP2MElaIblw0WC6BF07C9rhgJlbXo+nWNnAnLoElob/fkayawoYOx0tQc39KBRwoiQPNlU4/Ej79g6i7R23QQVvH8CY7MYGdnlMBuo+mGHUZJ+uCzlDSD08LLJhL1c2rkqODAekDAa1EivrEoQMHq9JWl5gXnTxXF4Qa9nz+E+hV8407OHwO+RKEWry6EPkzDKWSDfstelHOrjKhqtZZpv4arGHtWeVjL+woUqy71U6GE9OGU7HVJuQSwv1N84ffS5Apg==;31:GvARgqrBoY58drV+2OulmlLN7KINh76MUZUIVWThJflUYpVVvRT/gSPq+gV7kLuhUVx4YYaMs80Pz59eaMZdgovl6RLSptdhfCp8pvySncE9f0kYJr8ALZSQfW1QbzkyXW6txJY9o35NHgNtyvCamMHQha74qKfs5n0WomPMObBgDLOw86rBnwyqm1emnzuMwlVxS3Z16V+usXe86g3Mcwi1UhhqTD8qxMZePlDi+xs=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1776:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:fKCqaBJYyTTHISiQ6xWw8tg/Wlh68tAdUhKr+dysJqsY4KpuU0dQOzZ7YEge4O1F8TB2p4/Q9GmbqqstOl99cYUVPSzYt+uscey1HakTaP1BFRoheCxIaJTCysa10ceBMMYKSaSdvtzsJh06+dJnK8z2RJ5psSrAp55+0bYPtnXXsplv7qj3V6ijAY+HuG6IHauMdBoksgdqx9QqCzjJssslBqIrgY6GMpeYhjcIqIjFCX8Ea49w5GBH+eoR7m2NwRgMYs4h9/yY40LnrbB/fECGG8SbdA5TeswrXZgNVZLW0/h486T5hKMLIL4grhXBn+K9rfIeOkJeeJ3jGwThqfC+LjjCK03X+aGYcjt6IoxKUOSwT9Sgrp7NwWZccr+3avUe91RaabZNCugrxFis9928lqSegKjAQCAc030HGV46gagnZHM4BcbjNnxIWxO8cBqhbf5XcfHkEPszczoUM/pvPK6s64h0i01jPZqF+QgzNjgIBAzzPglbKwJ0tKb/;4:tPKDSGjc/6i9UFAVODaoSio4cz3qAUKz/DxVw6+ACddUhn98qXWP7lDZ3NoYz4U7X8mT2pz/emn/DaVAgHL91FTx9eH8BRcr/D9DK0c3hxkQ25Vh3dxD/MhtIntPTA8TQBbKRXJ6GCNalV/2ftlQHYW648xNdIvkbGfW6uDBe77oDBC3Jjra1IRjjwBeqb6MQ89whqdOw+19Dhy2aM6gdN01uMNsXlk3bQGT6W4UT9ig23dCq8dBTE0W9CL13H176QAKWce7Sn28wSU0gdJMuMMd/M9sL53QP5cQ5CdgTOyR8dhzvdSC3sxzBP6OceUC
X-Microsoft-Antispam-PRVS: <MWHPR12MB1776BEA1B5508209A15B095395D70@MWHPR12MB1776.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501244)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR12MB1776;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1776;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(81166006)(8676002)(81156014)(50226002)(6116002)(7736002)(186003)(16526019)(3846002)(26005)(305945005)(106356001)(2950100002)(478600001)(4720700003)(386003)(6666003)(25786009)(316002)(59450400001)(66066001)(97736004)(8936002)(4326008)(50466002)(23676004)(52116002)(7696005)(68736007)(53936002)(76176011)(72206003)(36756003)(2870700001)(105586002)(53416004)(2906002)(6486002)(47776003)(5660300001)(86362001)(358055004);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1776;H:linux-pyp0.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzc2OzIzOlI1TU5aMVNCMldva01QUmcxdnB5cE5wTDlr?=
 =?utf-8?B?dVVyNkFvLzAvTm9yM0h5bmFxOWZ4MExSeU9NWFRWb2VDSmRFbDVyYkN5UTE4?=
 =?utf-8?B?TkNBdmNodVczTFhwakJjLzFGWTI5aC9JTndqbjQzRWRINTFLQWh4VWVtRVNv?=
 =?utf-8?B?a0RiMUlvbk1MdUZOcVluRzhVTjhabzJ4QmE2Z201TEFTY092SjFidlVOQVpV?=
 =?utf-8?B?WTNWRlBreEVKdzhYVGQ2d3hwaXlMeUp3QnE4eG9qQW5mTzU2UmZIN2dhekVr?=
 =?utf-8?B?WTMwTS9KSnE0bkNWd0ZDMm1IMkszUlFyRFlXYzF3QnA3aDVmZ0gycmVnNGtR?=
 =?utf-8?B?ZWtHWHB5ckFleXJ0d2JPUTZsWXhWRkZlRE95TUw5cFdZYTdJek1aWHNEVTgr?=
 =?utf-8?B?SDV2aWU5MUpvMHFTQWdYVkN3SzVIaGI1U1pRa1pXMzhzSW1oWFZVWlVkbnZl?=
 =?utf-8?B?YlRadjB0YUxHdGlmSFpHV3UyVmQ5MWZ1UTUxd2tIY3E3SnZHcU0yK1lyRzkz?=
 =?utf-8?B?SndKTGx1OHVSUEFUUXdVb1IwdjIrSjRNeWxRZ1RnZnBRa3UrTk80bmlhWHg3?=
 =?utf-8?B?M2F2Z0wrSGhpQjVtTHo3Z3hJQ0ltUzdjV3NiOG9OS0JqWERWc2hSWEFRV3N1?=
 =?utf-8?B?blQwdG5FZ0gzSmZHdjM2cEZ4Q0JKQ28rRWlrNmJ4bWtzL2x4WUhhK0NqWkdo?=
 =?utf-8?B?aXJ6R0hTOERGY2M5QnU3ZFdqNUxyS0ZoVlYrMWNONUhpR2NzOW43cmVEUTNh?=
 =?utf-8?B?d1BYcjIzMDNId1d4Sm1yNS9WTmhpVmJxdkEwdlJKbDJQMVhLRTEzNWRPcFkr?=
 =?utf-8?B?OExaQldmWVl4dkZraTdseUQ5bE5GZWZ3Lzc0Nnhha3A1WWJZK2RsaW83bjMx?=
 =?utf-8?B?QzRpekFyNHlUdHYrWWV0aTJqU0tobUFhSUphOTB3U1VGZlNPUWE5QVNDcklT?=
 =?utf-8?B?Szc2QTg3ZG03YWdzenJhZFYvMUhuMDlyZnNUdVZJbHl2cXdZcE15bG16QVJX?=
 =?utf-8?B?aGtxdkN1dDVtbHRuR3BDeW1xbmJPSkMyRkJ3RGdGMGZ2d1RjdEFDd0d3WHZL?=
 =?utf-8?B?aE1FMXp1OEFWQ2dvSFFvK2pKR0JiUE5NbllYVmk2TnBYMExjc1JWalZlSDlM?=
 =?utf-8?B?NklzZFBKMWFKSVZGMUU5WEZ3M1Fmbm94bVkrUzZZckdZOWlvdmhOUmdkUGhl?=
 =?utf-8?B?ZldQUkVmTk9xbkNadlN1U2pscUJCbGRuUFdQWlVqUTZQd1VLaXNHTXFLOGFP?=
 =?utf-8?B?UmlhaUtzaGpDdnd3K2dJQ1ZOSUJ1WlB6RVhEc3JxTlIvME5DaWg0eTVpZGxV?=
 =?utf-8?B?ZllJRE8xOS8zenl0MjFmbWtmS0pwZDV1Nm5zSU94eXBxUDRpN0tCS1hudVhx?=
 =?utf-8?B?aGp6U0JNQW1MT0hrQ2V6dExzVjkyU3E1NFhUMXN5VGxCQzFPeGxubTdjUmV3?=
 =?utf-8?B?elYwR2dKLzJrNEp6RHhpQTJKeW5QTHAxSDgzWWRtazhwSzU5bjZ4MFUrS2tT?=
 =?utf-8?B?Vk5hSGZ0dnI3czh4WEdqVHFqSkhOS0ZVdzZPSkQwQlFBbmtFWTMwMTVEbEZp?=
 =?utf-8?B?RmQ1MXpacmljSU5Ec25rcEhHeXArS3c9PQ==?=
X-Microsoft-Antispam-Message-Info: UrsQnh7EqPVtwPRzQUz/Ls0fCA7550Q4N5OB3715HhmSrhg5xnAHivxIs4JVNGzxHU7Igm1zoBiByD3t44ZEJhCosLoOVzhb9Lh8I1DjQedhIoMvFdy9TYd3etI7jid+hZlNB67NnraXOyEhy14Mu/IIe92Hae8QRwIf9Fl4QDZBl8sYF1mYmnHZkRYIO4wF
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;6:yg6N+wq2q/L9TS98cc82nj0kph3Nj6DxIiKgoihmDlYrz9tqGCcNubdgXaCSDaK7+N8H2B1JI97FYgrPv16C9vXT+rADG4clZBlfQX6yz8hDMECSVJz4xCHATzFyznXhzFssKsm7UpWO9LRKoclltjmDydeCLVUjLzW9MGvN7LV9/29XoOg3AAyYKQHbZ6RqNqnzYRPQpll/XKJvWIEh1Jwc64HrtNI0JzCDGmvK4GDTcTI5NuVG05XCZfhHyzDPN3X776CThfwpOEU5L1CvNdLTWSwhUDYUjGDuEDMOqf3b6aYzdaOTe1w0bj8SVELBy3lUU/5szQeJYyGkiPBw2UyQ64AsJ1YaMtGC96pNSRg=;5:rTsw4xmWQ/o77Cx6syi2y7LZHwolGuw0L8OmSfzIRXKdr6jWtXzKjdQT1ICiQndMJ70h9pSoqYQA5QsRtNivWZ8X1g/0xg+NFuRNxNyqrdQ+0Y+QhajHoupu9DywdQMV+4S+fd/ilsFrdY3YpicZqupgSkNyW8H+8TtOGGG6Wdo=;24:jVjTym3KPbGi1L2qnCH37obqGDReBVEJVW1uVOPuroobowgOq+39ZzMvn/pGDu6w9IxnX7OTnpEe9tMiqK9iirG/bHtCq8rVhHog4ERAu9Q=;7:IBOVYgQiqywAnEtNJueKKgtLxuL7vaLqwa8I8cZwyFGOTbBxgHHYZqII7m8GBN9FnVA0vSIqlh41dg+VFsW0opwOFsUpO7BoDnb3VNdbwlKQiRctr9P8/cp9lx48wykJXEzUe7atRe0BkIaSfAO28X8cbFZ9uIqUTNk3ObDsnvbr387SMiF/VbSb7peZrlaSRK0CG9LerdpMpaZx+bmnLn0Tz71M256D8qB1GdONj9xO8R8ElfKQVgpqRF6K6dip
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1776;20:rKoheN1ILhNeIVxUBHR65aCbj+dbvG5uyPa/gjgv+WkO5AsTVvkRS940qJwCYurcefLkQWTlTj2X8a1ROo3djzOH51QXQ/8CKqsOo++s/VS9WkyBGENkSE2LdbVHQ0ixMOyGR3dEA7M+5trpOzRcbxUpyiZpT6jV9b5/irKFzmk6mk4ctT9OlcBk9pzwmpKeWYeGN/hEm8kNrWmr60KvoZLYpBO7bCOO/T7sHpRTmolEHN0rjE4fUKeJlE2x36s4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 20:37:52.8348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12150ad9-4e78-422e-5062-08d58b7dcb6f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1776
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of ple_window_actual_max, because its benefits are really
minuscule and the logic is complicated.

The overflows(and underflow) are controlled in __ple_window_grow
and _ple_window_shrink respectively.

Suggested-by: Radim Krčmář <rkrcmar@redhat.com>
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
 arch/x86/kvm/vmx.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index c9a9080..b992d81 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -178,7 +178,6 @@
 module_param(ple_window_shrink, uint, 0444);
 
 /* Default is to compute the maximum so we can never overflow. */
-static uint ple_window_actual_max = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 static uint ple_window_max        = KVM_VMX_DEFAULT_PLE_WINDOW_MAX;
 module_param(ple_window_max, uint, 0444);
 
@@ -6645,14 +6644,12 @@ static uint __grow_ple_window(uint val)
 	if (ple_window_grow < 1)
 		return ple_window;
 
-	val = min(val, ple_window_actual_max);
-
 	if (ple_window_grow < ple_window)
 		val *= ple_window_grow;
 	else
 		val += ple_window_grow;
 
-	return val;
+	return min(val, ple_window_max);
 }
 
 static uint __shrink_ple_window(uint val, uint modifier, uint minimum)
@@ -6696,21 +6693,6 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
 }
 
 /*
- * ple_window_actual_max is computed to be one grow_ple_window() below
- * ple_window_max. (See __grow_ple_window for the reason.)
- * This prevents overflows, because ple_window_max is int.
- * ple_window_max effectively rounded down to a multiple of ple_window_grow in
- * this process.
- * ple_window_max is also prevented from setting vmx->ple_window < ple_window.
- */
-static void update_ple_window_actual_max(void)
-{
-	ple_window_actual_max =
-			__shrink_ple_window(max(ple_window_max, ple_window),
-			                    ple_window_grow, INT_MIN);
-}
-
-/*
  * Handler for POSTED_INTERRUPT_WAKEUP_VECTOR.
  */
 static void wakeup_handler(void)
@@ -6876,8 +6858,6 @@ static __init int hardware_setup(void)
 	else
 		kvm_disable_tdp();
 
-	update_ple_window_actual_max();
-
 	/*
 	 * Only enable PML when hardware supports PML feature, and both EPT
 	 * and EPT A/D bit features are enabled -- PML depends on them to work.
-- 
1.8.3.1
