Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeBSQMx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:12:53 -0500
Received: from mail-dm3nam03on0052.outbound.protection.outlook.com ([104.47.41.52]:10668
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752943AbeBSQMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:12:49 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
From: Brijesh Singh <brijesh.singh@amd.com>
To: kvm@vger.kernel.org
Cc: Brijesh Singh <brijesh.singh@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1 (different base types)
Date: Mon, 19 Feb 2018 10:12:28 -0600
Message-Id: <20180219161228.46931-1-brijesh.singh@amd.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR12CA0042.namprd12.prod.outlook.com (10.172.49.28) To
 CY1PR12MB0152.namprd12.prod.outlook.com (10.161.173.22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f67b12e-a346-44a6-5d19-08d577b39e0c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY1PR12MB0152;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0152;3:kKb2Cw0svwD99AexykyiodfBafF82Oq6XFjszi/dcqQSdspr3cEZa50sMLqXXwUZqCl8Y6v9xzGey9bcO2F7j5OcvKQqvp9VMOujNF4FVq7QK0v335pliSuueFokTmPhqDvTtLsNVYZvXINIzqnuML8EVCTjteDq4J0mgVamiA9DuP1TLbc+utWof+em5JpZIKIJhYlAogObiJG78UzgvEPcXAkA5EmRaRGFby9ubXqe6/YkZfEafIhWEM37f6CF;25:nAG3uzziMPh6jC2WSIO8Qne7aRU1UKsECkfPiVhoW9rbW9wBwXj/xYLgPG944uKuvWmhQH+bH56yq+MmwIPOKGPa/syguNQnW+o0QL+gollkCREL7GrmOp/X5gx5SBowGZ1beRnNQqAAj6d6Q1EPVmQRyCXGFM6CJS/okrmAY14R4SObFkNpuQc6VJ0q7R+tWM+qPdDz9762Aowz+MgXbKEMVTearUpf2J78lK0ll6EdgZIEpJ7atT4GgOLWu1S/X164k5+k9NBF39K4ljJuAePYTyjcb36+OjXMQU1BDZKN+SMv+n3F4NKXHeYZMPqgBTkBwUwLJSAuBHtZhhDnGw==;31:mwSFKpNJPhzfAvwL0Oeh0WhzhyQOk430AFeN1NsSGqPAxGj3+MvdxFXx5b6Rx7nEtrHV6M/jtcFYkNtRJusJHXA7oBoCI6Mrs++rmgdTGbCOuMCV8+nwYnDOiAr8I1xyYgCWJQIOcNU5xjTC4H6nB3UsNDWxzt12m5JGFJy9rNaF5dSXfxW6gq+k/LOV+OdiOTBQu2RUtarAd5g6ZhBi3e049mCfhx0NL4aTg2Zas60=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0152:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0152;20:pgdV4cTR26sW0djljrPned9m75X5WpbfZCA4n5vFLvug+FJNuL1ZTWB3wFn4cwoOTKNQ7uvguxZgU4fNLx8BpwanE/cyxuKaGp2N1xQWupLZLgEHB6IWigo02tV8g9WARO1cwDyFlvTRNwTiuErKa0WyZlahhTYt/fHN/rUWvpX3kglMH2nBqAopNwUs8W60sLTkE3mDW+fCLlsqpa+imaKugQKdzHNj2t9HJ9TFdMq0ikMUW6bd+SzWsKMBxftteq4aiF5TbJBRaxFnsP8JuoEiNiUQyWtOEvb89Vp5EGH1OGGnikY2rFkqYURw/49yInysaJbMrhSi0lB6bQ5xuXeJk7HHMxnKxuJfJ3Madhudk/pUP5aZUdKAZu3CAk9PAY9Io6fGhOg0OBIXFSrUG39M3d5RPNia6lt3YaEaOg8mp/3NzlOu6skuNV0/8fFiM9foDLU7M5ZIPSumANDqcUfY3e2juEmUWJu6oEGanfWfK256ZtqHEIiMbfZ/UT12;4:v1Wd5Py5Tpk1CQEBGwyONzTFvn6J0PRDopWJj1CPlV0+zap0o7ltgBoUh1YFUrsTdKPeB8T8ySFRjz9NEn80nhPIds760XKXSh8E5LUXMvJoi3ScrogZNbE6fnhWezpgeFr5RSj3jPOKQwT1CgzZgCduRa9aNtN1PvW94sOhEftvIl8RdXtVGXbiOlV2f5W7odzznpFEcOSU8XyWIUL8YYmHFAhhQKPiKMe4e5yOrt3qp0KR8AZYBfGlRA6em6itjJ1Pb/KeFniWj321NNkiKSq+Mhtu4QNVzvfBu5u+Ll9T3pcQ+qRuBciElpRVWFhqJFnMM3Fd7VJ2dv33QjUOhg==
X-Microsoft-Antispam-PRVS: <CY1PR12MB0152CDD700215A33D4E63528E5C80@CY1PR12MB0152.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001056)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CY1PR12MB0152;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0152;
X-Forefront-PRVS: 0588B2BD96
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(366004)(39860400002)(39380400002)(396003)(346002)(189003)(199004)(50226002)(25786009)(2361001)(7736002)(8676002)(106356001)(2351001)(50466002)(53416004)(478600001)(59450400001)(305945005)(2870700001)(81166006)(81156014)(2906002)(105586002)(47776003)(66066001)(5660300001)(6916009)(6666003)(6486002)(8936002)(36756003)(4326008)(1857600001)(97736004)(68736007)(1076002)(3846002)(6116002)(53936002)(186003)(86362001)(54906003)(16526019)(23676004)(316002)(26005)(7696005)(386003)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0152;H:wsp141597wss.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwMTUyOzIzOjdZNjl3a2ZORExyOXZQeWo1MkVkUHNBU0hB?=
 =?utf-8?B?R0FHOVFNeWxTUlZZQ1paWXlsRWNQcTlrakQ2dG1jd0drUHpvbHZoVUNtcVlu?=
 =?utf-8?B?YVV2d3AvTm1VbG9QSm1UQUtLUnYwUmVXeW1VSzhDdDVtTXF4VktTemJFcEM0?=
 =?utf-8?B?SzJobERQcTVjT0srZ2NyV3l3d3p1RzJBbWNtWUJpM2Z6cjNrS3puZHRrTngy?=
 =?utf-8?B?NFZGeHMwb2F0RkltSzJZUEtmR045UjNvUU84UGlLOFhLNmd0YlpMcThGd2lq?=
 =?utf-8?B?aUdGankxbjZkUFJ0dEtBUWcvaGEzRUI4M1FGUlUzOGNnMGx2czdvdmZleU1n?=
 =?utf-8?B?VUduaERoYlBIbktvcmZMVWxXdndFbHg3bmswWVJDa3cxVmI3bEVVNi9RVWNx?=
 =?utf-8?B?K0RhRk1Pb21HV0NwTHBxcmxxKysvdFBBQ1FMOUFvMGd4b3ZZd2dDRnNuWG5k?=
 =?utf-8?B?OHZqanRGMkpYMDJjQmdyWHRQclB5aHFWMUNXU1NtRTRjUlp2RWxxYUR6Kzlp?=
 =?utf-8?B?UjB4aXdDc25XQWI2c1ZvVlBtdmRnQXZEQ0Y1djJDamowenluM2xYaVphOStL?=
 =?utf-8?B?TUNTR1NDQ2J5Qy8ra2c4SU9DeGtSNUVmcUIzWUVwSjEvS1Ewd3pwQWx5WFhy?=
 =?utf-8?B?Nk93TlRWV2dYdkJJTVA4SXFhQWRJemNHbFMyZjNWcWJEa05YMWVxZXZyWVA1?=
 =?utf-8?B?bTlrc3psOWhmTWI4WmFzcHJDSXVRN3hITWRFU21QWVpIYjFIdkErR0k5bSsr?=
 =?utf-8?B?RFIvVmlPcmh4ZTVld3o5bkNCaXdUTk0vUGI5dmhtNXYyVGxxRTJtQ1piR3Uz?=
 =?utf-8?B?RkZGNTFFb3dRSTVnaUFaeEtMZk9RNmN2eExUYkJXWGtTdmJ3bERBRHdXVmVS?=
 =?utf-8?B?Nk9BbGFUZmhQYmRDMWtNcm9ua0JtM2dxM1lsYWc2RjFWcExoaUlsckx5VE5O?=
 =?utf-8?B?OVRaSjBwY1orVFozU1pZQldsZFFGTFpFYm9Gb1F1TlRKcGhBY3F3ditaaVls?=
 =?utf-8?B?dWN2OThnQlR1RW9kOXVGTHVKSERDbVlYT1JDZnBBTndwck1rNUZJaUU5S0JF?=
 =?utf-8?B?dVBPaDdBZDNzWWpnU0VscWZIdXU5RGlrdVZTUkt2emNBLzllVFM5NUZmNXB1?=
 =?utf-8?B?b2VvQk9MRi9NWDI1S3hVNDVEOVN5bjJXZ3J6NWFRdnptY3Ftc09VOWs2WVV5?=
 =?utf-8?B?VW1Fb0gyUTJqMDQ1L1IrbWgzeFpYK04vVTBHMVFGbEdpUzMrZXNnZm5kN2M5?=
 =?utf-8?B?dlpTcDJJRnNBQ01MTjBTODZVSXBWdVZZTEl2K3RmaCsrRWM4ZWkra2xVVFV4?=
 =?utf-8?B?eWMvMU03MHk0YVhpWDRWNUhQUkZFK3pPSlppVWRUU1BUeVhIMHVqTmhmOUwx?=
 =?utf-8?B?eTJOYWtRL3lkZERDdWpJaUttd2Y3REkwUTljUHVMaUJIU1kvOU5JQUdGQS9s?=
 =?utf-8?B?THM4MHBvamFIaWtDbVYwTHJsTVh0SUJnYVNuTGNYY0Q0Ri9mUVQ0cEJWVDRx?=
 =?utf-8?B?WDVKaUF5KzNkMEhHV2ZiQTRHMzI0d3NpRnQwK2NXRkZwZlVSa3p3MCtnR1lP?=
 =?utf-8?B?bDNoeHNaOTdORy9ybDU3Z0REdkNlamc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0152;6:/VwFutAti4ZHyLSmdjMROgHoFICTRDxgDsozjsbOgPLvHBG9t4zGCtqUX8hMA8Xj60IZqZ/xNNVkmhlaWmVfWZK4gv8HhEWgstU8pH+L8NNzM8VNhI6c3Q01dLTNOxa8ChbAxsrxr5TgP/mqutgR6zGfeXQBZuwTIvTkwCbxXyzHGTVp3c04iywdQMBNRIanOr3tNq8C4ha36CoT7sH+em+951W7e6BAVPgHyzqP8ddhKgWLBIJfQ/siX4O4gAy5aBpH+g3lvo7k9lI9HBbAYVnpiFh+sBTwZMBUuDpEfYXR1UtkYQZ5Dp7amifbnaiPfP0+tZzjOElUw4skms2h4WOAD2+8zu8U3+9H1CPwjOk=;5:thV6Ff3+6hL8If8cefU24qCYTKjyhlKuKad4bVm3foVkHtlJG3mG9PANl/wfl2LCTtvlMPHZCOScrEK6ttR6UjWej26gJmGoVOkNw1nwU61eFxbHkEF0OlHEY1WKLM8yXKup0Pq7Rd9xkX3NL8Lb+hxIfFNHEbWto64/1eNlkDE=;24:IZPS4InWWgJLfSJdx6y/cFH2ZJg1JUPWrpvUXCwKUZh38bg49v7GLETxwcY43ki0hX8XBVsvhiY+i4776UpieZqxV5v7xyJKQM9JiVKeDVE=;7:pRm/gJ1XjbU4u6Zxy3Mf6kEvPeduQKbHRRIFzsc7vttjfesDlMw88MyfrfJX2/OahgsR/u9QYeR3XejJBZIJLSsBR1JSngC+DA6SW8HVeAAkyJ/GWn7BluKZDw51dy83rNrk5v5nM2dSNCv5QTgc12tKAUjFc1rjCU37kircnM27vJpjt8gcPCVTfxfafb+3F2D7UAR6dx34EZIfS2Bcr4uN8dQ2Hc2juEuyV0qOa/2r7qb+pDqsK6QgPQT/m6sy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0152;20:h8uIiFjYLdlGqh7F6uafRvaMZMb5Ux3VfHyxcgEi8NnRAPpkRiLkIT2iQWgynfPp/STfRAHQ0cC1KnSyAQLz2J4Mu4ZAMKDKSi3emSkU8iX/0weGRKpHAsUbfQrJH60n5h11HTfClsswjZF9RXuQqX23S02eMGVec7v/7eRTtiek2dfojxu+5OD43EaR+5niovgMJHOQN5PNlLdKpp8aknQmlERIUun4OTzJqS3rstR0clQBWjGuEyDTzqS/aeDB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2018 16:12:46.8192 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f67b12e-a346-44a6-5d19-08d577b39e0c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0152
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse: incorrect type in argument 1 (different base types). Typecast
the userspace address argument.

Fixes: 0d0736f76347 (KVM: SVM: Add support for KVM_SEV_LAUNCH_MEASURE ...)
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 arch/x86/kvm/svm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index b3e488a74828..a2f1bb73640c 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -6262,7 +6262,9 @@ static int sev_launch_measure(struct kvm *kvm, struct kvm_sev_cmd *argp)
 			goto e_free;
 		}
 
-		if (!access_ok(VERIFY_WRITE, params.uaddr, params.len)) {
+		if (!access_ok(VERIFY_WRITE,
+			       (void __user *)(uintptr_t)params.uaddr,
+			       params.len)) {
 			ret = -EFAULT;
 			goto e_free;
 		}
-- 
2.14.3
