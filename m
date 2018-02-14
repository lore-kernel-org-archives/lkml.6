Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161318AbeBNRjU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 12:39:20 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36334 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1161274AbeBNRjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 12:39:16 -0500
Date: Wed, 14 Feb 2018 09:38:35 -0800
From: Dave Watson <davejwatson@fb.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Junaid Shahid <junaids@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: [PATCH v2 02/14] x86/crypto: aesni: Macro-ify func save/restore
Message-ID: <20180214173835.GA61851@davejwatson-mba>
References: <cover.1518628278.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518628278.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:180::622a]
X-ClientProxiedBy: MWHPR20CA0013.namprd20.prod.outlook.com (10.171.151.151) To
 DM5PR15MB1755.namprd15.prod.outlook.com (10.174.246.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58c6e310-4e6e-41c7-5c62-08d573d1c850
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DM5PR15MB1755;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;3:sVpH0VR5P1mZWP4bkxyyxha/xQW+MJBoQvHp4WSAemGuYydwqSZCZlt3hx7j1k6atl6pb7huMiT9/+xRoW7o8MWw8JDF2sJH+YR/apyw0o3ja67oW3PRyBcxQKE3foINVb9un5TkyYqkMLEkPu0BNjE75pGX0LQoF6ipHewvOPaKg2XFZczTH+MvbnC6GST/YJNfBxk62AJzWWI3UBvss4s1elGo0x+ndv8K2w/J8UnF9JbSuTOQtfAbsswMwMv7;25:MnLaWfsJ/EUrRKLOkreV8VDUL6InasKmA1GlNvHUHGg75TGiN2CXe/pppB9KYntjknVmImMQI69As9sDrhgwwTbt2x1PaKNW6GgIFnskZJFFPjJBuxfCBHjuZeoAm0g17XG9A+Q9jv4gaxUMjuabz1cqn81q4Cg7PIc5s/+OJDNGLk3wemJvVDyUXJkjUF2DPuVc4QDIFILm6x8LiLJU1cjrU8QSXcAo2XmxNTblqiNs95Ei9kUqZORl/xXwQG2zNJhYg0KCqoFIEgrxn2SXJT4nDcowm4GgLgleZfTJJmg0EVtlkqaAwNUmwZyFSvedSYCD86A+DRjnmQb8V5rFmA==;31:92P8pyZBHQ7QW+f6s91Tw4Zl53dlzs5Wl/QZTgq2XrPXqwC+R4u0jnHfffMXam3h1q+84F5ffHkytcYNdaVLdsY65/vcsoS+FeG8YrVNHp1bCA3QPzYedJYDvKvaBNjmljM9Qf8p7reWO+Q8wYKyJpIDJXmBQIyFFGO1NTqbQqUgkGokfeNcN13uwqIKYn3xahQKf4WHVaunyslouV9v2rfDv1K+rXrRYMS9DkKRbVA=
X-MS-TrafficTypeDiagnostic: DM5PR15MB1755:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:cLnvSyiW21iFf9/N2rBLYVldNZSmQuAQ2G7nw13JbBpZz4fD9OvWBsEh+kHeKiz3fmz/9eT9Ofl6feD2YBvMxYFGUA5w/ilh0loggNwxqour0z6ExFNx9nj1o16M6eE2qiNcKB1c+sFi5D53KG9swsX7+0ugZV9O8snIK58g/Hd2MNupIuLLIzXxGO/JgCjjcmm0/swxt0Koa0WCApeBuh0SLh+DyR9Z8i45a8xeLneYNxHWDUmVNUtiYb/9vYmXcltMHlNrXPDkXuF/uj0ikEt2v6p/+Zjzzn8Ciuz32nSL+9gcjtDcFeb23RN6/WY9cr6/+U9goy5qz2EasmWyPg3BK2U8ponD9wk+5m+43srOJyTHRHxp0wMTFCHDLvmW1LBFz5josPpvlefbXjVVLyZA8v83uVs3eOicJPRkuiMKQg7SE2F03tn5c/ssLRzaCzIGHu0e8oOifewXe/TTSRjTMXTAS+pZzgBNH3IGkZGod2JVeo3+bPnWzpLB2Arl;4:LYHinnh1Ff97opFNVwTGpuG+ctUUZuK6Q43A5PxCcRwc2FsplrdiRGmF4+aYVvLJ9P5kWojXQgul8G0EgJvX0RxyLMkZXVUZDW9yyY7yy9WXQ4xh8Q6jsiXX67LhcTT36s0SfSMLIwCx9AfdlcmG+zmgbSEgX22jA7UM1zlXA21bqiKd4oqACzlwZ6k1VfEuVuVeXl0AUAnjaXF0nVquj28ekmWMbvhUHkwZH6uE4lynQbfax05uuP22agOPf4Syez5DLKzw0W5If6eIz6TV8bPpgT9gUVQLstwzn+mOqzrB9Ys3jO4TbhS2w2ZoNi6y8lySfhY8Lyvi3kj7G5JGxnBeZo3UFRx6K5yjEAxSQs0=
X-Microsoft-Antispam-PRVS: <DM5PR15MB1755B7B04B24A4107958E954DDF50@DM5PR15MB1755.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231101)(11241501184)(944501161)(10201501046)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR15MB1755;BCL:0;PCL:0;RULEID:;SRVR:DM5PR15MB1755;
X-Forefront-PRVS: 0583A86C08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(376002)(39380400002)(39860400002)(346002)(366004)(396003)(199004)(189003)(9686003)(53936002)(6486002)(6666003)(2950100002)(4326008)(59450400001)(52396003)(52116002)(6496006)(16526019)(76176011)(33896004)(186003)(105586002)(478600001)(5660300001)(316002)(58126008)(386003)(16586007)(25786009)(50466002)(106356001)(33716001)(76506005)(8936002)(83506002)(110136005)(54906003)(97736004)(86362001)(8676002)(47776003)(1076002)(6116002)(7736002)(33656002)(305945005)(23726003)(81166006)(81156014)(7416002)(68736007)(2906002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1755;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR15MB1755;23:ak3Ujoq/esmKUDOzLge5w4AlS0kGKHWE3n/3Ak1nw?=
 =?us-ascii?Q?6+GH5uii2q8HlnAABH0axobOlqVSt+zM4ERSNONt1IW+re7BMbhq7/AT2dQB?=
 =?us-ascii?Q?ECxHWZTChXo0p8VFtR6oAMoS82j89Dv6MIllYGDF4529hiumyTKIN9bwYb4/?=
 =?us-ascii?Q?JDfqosERC9F7Rm7AZSMnxowViYcAlzD4QTKjRvt4RgEgK4zNMgEA61nCvYJR?=
 =?us-ascii?Q?fDg7Nr1/YQ/mKCa1vzO0aeXLk3y1ta8NRVSljMfQvZLNhqxk5qzoRVbN71+h?=
 =?us-ascii?Q?aVo2h69PltB2e5MfoXGwWWDKyW+/yb2miQ2WZjC0sc8ZCnxxJZHr26L+AyRx?=
 =?us-ascii?Q?mc7MnAnDgeTamaYahjq46KVto7oF/SQYD4V4T7s8tycK/Fr9Kp4fD4Up+IeK?=
 =?us-ascii?Q?jo26YREaVWjsrC8z13fNne+nURGZheQ+gUAudAWkMlKmlpWoq1LwMod/3m5a?=
 =?us-ascii?Q?DvO0ZB1qM84rNCwDWgDO1EoAe2N2fW0trsw7vSfCZ6rI6zz3t/ni0dwnpQX5?=
 =?us-ascii?Q?bihqnIr5FNnGoisFGzg2jPF8SmdbNISOnHjB3pKjuQNO6zzAwwL29+dwe1pO?=
 =?us-ascii?Q?EDakJRiDx+cIG+aiXOIQ6kCNbRcjrvMFjWuKRHQ/mpUpAL7O3KLqPZ1dTL4h?=
 =?us-ascii?Q?QlA6GSZswbQJcY2oCq0J3YQn5teh29Rl7lHnYfjgAa3ZXsg+DRHx8xnxbH1s?=
 =?us-ascii?Q?m4xM4KocqziqcTUx/7KqITBhjV0jrYYtUNSnjgUhUbe/jH+uLjXnt11auoHo?=
 =?us-ascii?Q?DXt9CT+S2mevut0MS0v2XzuqfnIo+tA2h0q88FecWtJh9hRZIooBmHvDqlOf?=
 =?us-ascii?Q?Hf8LacH0xI57EvoxrhI0vcMqtVzu2ISTdHOhW+lnmUPBkUAyMf8qR0DolhoO?=
 =?us-ascii?Q?m2wAdSUXKLStvaH4rvK437far19+ug+/05gv5u0W6ERu+xF2oQhg+ZWUPGDd?=
 =?us-ascii?Q?6g4oAQ9iWxmBJm//oCcPRy8Op8kY7JVWHlhCw8sI1Rc2TSvZ22ApMJYk9hSU?=
 =?us-ascii?Q?VtKh520febcZR/mlan+tDjQiY/r3aw+4sCZmTaP2ugTw2rB+tccazU125kKq?=
 =?us-ascii?Q?QJZpjNdwYQ3jewDMdC+bpvcCsmK9mew0xTv3sBS4if5CBQ9R+C5VgUbbDoYo?=
 =?us-ascii?Q?zCZ98vvdjiUbBDqNDqu/yv3p4aSzJ7tCjzE7Ip4CwW7djNHJZtxDLOVLy71G?=
 =?us-ascii?Q?Gb5xxXAUgNfZGbI/wcjr5mm72x7YxlJdCO8XLZcIJrhbA+VDBHwij3jpYRde?=
 =?us-ascii?Q?bS4vJqE1LVQrSzovOPv0ymhIfigChWYPXEDesWpoxn+Nw2mwDrI62610z7zc?=
 =?us-ascii?B?dz09?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;6:uFsrCq7DHqXv8mVcwN57TZ8IDNjM3B7y+rGCrajNa8YVZUUEQKCDy6Jm4yM4R8iqNZ+NLWcVX+hpyVU4bVZzqC+S1OZsMauwDIK0I5sY1HzupmxdvS6lVq9YkRl7lYUarbYZMLnMO7l1yfIEa/iCKA8rGmeceMdGqOYL7gp2QYN5qTLMR0BtbfrMSXJ3yBJ0w/PV3eYtcxM2OAotZaLAHsAw/nqXLdY87Dz9TTJBQEv7haIc5aP5Cscojl7b8Q5R+cxgJKQjvl8AX4mYrllKd3Mm0O09eN3FYxwWqjMR6+WQw5YIRPqw2yEd7DxxYlvqWTmOaOlL9UqUeGCyEvp2n9ZkeJzgBgmtGjRUCaCaUUI=;5:gypdDr/PdqCjwrVkc0EY0uJfMr+wnbOjRPStEFE4lvRXdrcmPzLIFDm+fz0/+VJJETIAfLvhPSaf/KBCNCUtMIfeQy6BeYKZfpyHjzFDRLlUngnc0c0G1kvymw57Z48x05igP/Tnaq0NKUniAcnXosfS/udb5lwBLy3zI8T+ftU=;24:FzpWY2jaThpU+McowoQi0SXSsAl/p5huoPSX3dnzjyJ2AtfCHuBvizyA6oHyKaWGmWyvKRtjCdxrVH2UvWzMnKPY63CAwKX9qZcywEJweY0=;7:DpaYFWhHp01bDKku6jiM/b0V4UC4XQkQMNHVCB0Jj8zPe9JMUJiKpde+xcHOfqbNP8hlin8KNNrPrtz9bNsPb/mLxPNoAH1a1T+WjKBAnx4JaQ47GAPdU4hgKodUpjQTi3JmfBnVvT7U2o1EbsOsgmKRs2ANWgQaRFc2d11XKa3D24wDcS5BQSIpPLYpf5aJDraPjJwZSFs6jSGCuQLLR7ihTuDE0gGBAeDYcGV8TZ7GMY+izzhdQKSwj3tR7PaA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR15MB1755;20:81QRGnDofi3JxEn30a2ZgtMSTGwfWP1IJXCjqK/6QxqMzQo8NJps3IbL9nQcMQZe+qmBBEkQar5psCyUo6U6o6WEH2Lk9jIdqWXe9Sk1XBNY0eMUFj9IPlWmXbPQKuP9hMHuRj7p7qxv2WNwJHCbgb1qokyv/7W8Njga1/LpiwI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2018 17:38:38.7143 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c6e310-4e6e-41c7-5c62-08d573d1c850
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1755
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro-ify function save and restore.  These will be used in new functions
added for scatter/gather update operations.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 53 ++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 48911fe..39b42b1 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -170,6 +170,26 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 #define TKEYP	T1
 #endif
 
+.macro FUNC_SAVE
+	push	%r12
+	push	%r13
+	push	%r14
+	mov	%rsp, %r14
+#
+# states of %xmm registers %xmm6:%xmm15 not saved
+# all %xmm registers are clobbered
+#
+	sub	$VARIABLE_OFFSET, %rsp
+	and	$~63, %rsp
+.endm
+
+
+.macro FUNC_RESTORE
+	mov	%r14, %rsp
+	pop	%r14
+	pop	%r13
+	pop	%r12
+.endm
 
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
@@ -1130,16 +1150,7 @@ _esb_loop_\@:
 *
 *****************************************************************************/
 ENTRY(aesni_gcm_dec)
-	push	%r12
-	push	%r13
-	push	%r14
-	mov	%rsp, %r14
-/*
-* states of %xmm registers %xmm6:%xmm15 not saved
-* all %xmm registers are clobbered
-*/
-	sub	$VARIABLE_OFFSET, %rsp
-	and	$~63, %rsp                        # align rsp to 64 bytes
+	FUNC_SAVE
 	mov	%arg6, %r12
 	movdqu	(%r12), %xmm13			  # %xmm13 = HashKey
         movdqa  SHUF_MASK(%rip), %xmm2
@@ -1309,10 +1320,7 @@ _T_1_decrypt:
 _T_16_decrypt:
 	movdqu	%xmm0, (%r10)
 _return_T_done_decrypt:
-	mov	%r14, %rsp
-	pop	%r14
-	pop	%r13
-	pop	%r12
+	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_dec)
 
@@ -1393,22 +1401,12 @@ ENDPROC(aesni_gcm_dec)
 * poly = x^128 + x^127 + x^126 + x^121 + 1
 ***************************************************************************/
 ENTRY(aesni_gcm_enc)
-	push	%r12
-	push	%r13
-	push	%r14
-	mov	%rsp, %r14
-#
-# states of %xmm registers %xmm6:%xmm15 not saved
-# all %xmm registers are clobbered
-#
-	sub	$VARIABLE_OFFSET, %rsp
-	and	$~63, %rsp
+	FUNC_SAVE
 	mov	%arg6, %r12
 	movdqu	(%r12), %xmm13
         movdqa  SHUF_MASK(%rip), %xmm2
 	PSHUFB_XMM %xmm2, %xmm13
 
-
 # precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
 
 	movdqa	%xmm13, %xmm2
@@ -1576,10 +1574,7 @@ _T_1_encrypt:
 _T_16_encrypt:
 	movdqu	%xmm0, (%r10)
 _return_T_done_encrypt:
-	mov	%r14, %rsp
-	pop	%r14
-	pop	%r13
-	pop	%r12
+	FUNC_RESTORE
 	ret
 ENDPROC(aesni_gcm_enc)
 
-- 
2.9.5
