Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932235AbeBLTtJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:49:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54822 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752039AbeBLTtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:49:02 -0500
Date: Mon, 12 Feb 2018 11:48:33 -0800
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
Subject: [PATCH 03/14] x86/crypto: aesni: Add GCM_INIT macro
Message-ID: <20180212194833.GA60642@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1518211765.git.davejwatson@fb.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::6:842f]
X-ClientProxiedBy: MWHPR22CA0029.namprd22.prod.outlook.com (10.168.250.143) To
 MWHPR15MB1757.namprd15.prod.outlook.com (10.174.255.10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9c3cc80-273f-4b8a-2665-08d572519b07
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR15MB1757;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;3:CsboLofSIYfEGxaZr59P4aaZEKqo+30n+7DG+SSoqQHn8pbEsAk3o1o3hHSnpZSVo1RkojB32Voe4cNLRGGlH9CVdmLuW7x4vN2Is7Gt8/Cq2DNKHgNxADXqj37eiUB5cYGVco9doLrYHtqbEfrTpeNfq9jWiGIIFtySRF020rQPlKn85QHrMojnjAk9U6CDx2nqMSwWA6RTU6RirqbfWKgjoFJ3a+UqxhVS+S7kJoLaCOXoAt9a/w3AecuWA87p;25:deACTSUoUHFFN4xliX57SvzWBu2xaxy+/v3VFMwp+ABtlM/x508j4zfycletCLyUr0J/AGrRzqgs+1gpwJdWvqAij0Ymq5iLqd6v3aONdpiLcvhurw1vwiKkXazxOl+k3PcjJ6mm9qdhoAPGz5+KQlngfWEZHS/Q99HxSgUtvbti5JwixaWcAW1oXWloeAYvOiHKmMPf2WetQPq+tYpDKw+baj4IUcoQalme1lC09qk2i2QeWMIaPqonETzVqu5Z2KXS88OgUZ7fmAS5vSCiqO+VKR9Bbrql4vdQZYGR5xfGtIliRvp/Zp5FoAEYnirwC+Rre9SrUYa9qUJw2zlEZg==;31:95Akgc7++OGTZ/H/NkTuNXGr6SECreDXIXfVsaq1zWx+a0o+girwaF2kyciuq0IBrsu7R2yTl3TslGBR3VuYRLV0efcJ3Sd0N8untR39Jm0QJWPjnbBmEWMqmTh3Fi5BugNY6wS4NUsfNsorRKq4mco+No3yTTSIr7AdGKLmYf4JqXugjTF332C/XIIlFCLPVv/A6nejIpR6bBhfX3rC1bmpKRKlVAyR8ylrwWC25vk=
X-MS-TrafficTypeDiagnostic: MWHPR15MB1757:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;20:+GCSEHoZlFgA6NajucdyGxV+Gq8rdnhRQBcMDfOgUknM0yLfBzPE7sRQ6EY2lPdpuwYSxgqsKcC2T1gYoCB00bJpwK4DCt03zdJ539+ziBjpgRPnSROHJ98VGMzs5pYWU9NaL88PmIL1bBmF0WIrdE2wyL6RhB7aREY6mkus7VbhSIusjZDivvtZBxm/I8nBERFQM+dhyA08CccwDDkkk+r3pbU0pQJSskE+sluDYYnZQ7EM5wPNepa8yDK02cGmu9AL195KR0iNmQyiZzZyCs8uVCEwZlWQe+XvJOM2YqR9CsD8DhVfIrsNsSGfYpxpAl0d/N7HLpW1o92Z9m0m6e9It7wE5CAJI3EgiKsZrbUAoHhJ8FDHRT4zM/DRdAa8tlf1QoqhKIUj9dETpbZXp2fJBKhDODJGMPAkD0mdCwhN7ik3yaaNyY09p+5He+LwDYQ+YS8i5g2JULIXhg55jNjvzT5Z5eHu8hpN/9N4p8GaoCc5za8AbUKXRR/GrxBz;4:3Z0pLnTjZTQ7zs665Q8QC6dVVC26uZDlRHWsbT+4XOL09+oaPlwoIY7v8PewWIHmDUJJrpF82n3Fd+QWgyP+l9B88XOhojEBvRV7OOMnYgEuxF+S2BMOBgoLPj4NkifFA3S+cfNv8QOmdzsT1mqCpou6248ffkee9MOrBlF1fR80ms6LLsK2PQPPG0POlz7ixW79WslJoqLGuPAglweapZklp9hFKo/bZvPNVpc8OFTTkw/gkYT68baR8z7Hk3KXfDQ9/8njjX3m/nXkbDApTmU2txFgIbl9UVpRD5ZupBe0VREod1VMsRZD6qCKHSllcLz6qamApvFAxp6hytG46vV9caYlTlbqengvhFri6nw=
X-Microsoft-Antispam-PRVS: <MWHPR15MB17572B3B18D1152B1B3E119CDDF70@MWHPR15MB1757.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231101)(11241501184)(2400082)(944501161)(6041288)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR15MB1757;BCL:0;PCL:0;RULEID:;SRVR:MWHPR15MB1757;
X-Forefront-PRVS: 0581B5AB35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(396003)(376002)(39380400002)(346002)(366004)(39860400002)(199004)(189003)(76506005)(6496006)(86362001)(6666003)(4326008)(52116002)(6486002)(52396003)(25786009)(7416002)(2950100002)(105586002)(97736004)(68736007)(478600001)(47776003)(54906003)(23726003)(58126008)(1076002)(5660300001)(98436002)(33656002)(110136005)(386003)(81156014)(81166006)(106356001)(186003)(7736002)(16526019)(305945005)(2906002)(8676002)(8936002)(316002)(83506002)(9686003)(50466002)(53936002)(76176011)(16586007)(33896004)(6116002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1757;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR15MB1757;23:AYioLwBeky7C6esnr8wqnCtudRWvGiPoXKabbilm7?=
 =?us-ascii?Q?qa8GEkvy3WbC+1DNOPhCFKuhhnujjmje2d/Hr38Nh4gH27qDxIU4KHiCEJJt?=
 =?us-ascii?Q?5mDeBDBfGwLIyHnzb72MoZYbxoOkFzpNYv0hklY7Xs/as1KxGSy3nNeK7pII?=
 =?us-ascii?Q?yAI474SuknAn/YGcnx6BqZnOwv4iLRWBSPqvzN+ovPbzq236OpMsb7DBQLdU?=
 =?us-ascii?Q?WHTd4QNXa07CCuRlmXlkKiyLaXN3u3hmIgsdlVA9cOXEo0Pc5Z0UkzOovalk?=
 =?us-ascii?Q?VoJckmodgqRMZ4Ef1rBJX0zJ5yuLt+jju7dpPdyoTMPj9k0fwU/3llhmwS4U?=
 =?us-ascii?Q?+gPjEC9EkNi+I4/akb38ZHmPExScbyp+DiJPD9m/Y5ebBkpwpFdq3igRk6WJ?=
 =?us-ascii?Q?XdcParUhwpMNncqtomMNpbJcgxG/iZKbHyPwS/AGyjrlpKYLWrp+tpJJh6f1?=
 =?us-ascii?Q?/Hzs+MbnEKGkLXOjBwx1Xu5u6L6D2H7VfNquIsKxdAiDDLEn+Zbo1TLZnIcS?=
 =?us-ascii?Q?tL5gUed0MEGnYfqQv94IJrwajpISFRWK5WtdP7T8FeQu3GPyDamDC+sdLAKR?=
 =?us-ascii?Q?hOWRwZgxC9OMu6YDe7w8xzSOrCqVxyyBo0wdzL+LRDcs1MN4tZAExDSrgQZb?=
 =?us-ascii?Q?brzTxjPbtpIfodbatb2EtB6PqjzPP2sIs0TEbRpX+WeEx2x559/VIbnLjwtz?=
 =?us-ascii?Q?wIADcHv56ZHAWQNc/b4oXBBlqnd9zLYlq/xNTnYNwF70g3jNe9R4NkXFCTPc?=
 =?us-ascii?Q?XVBhnylB6vIb3Z5w2Ds0bSs0W9a53u2o0aQqm7oIX9ud7zzHSVCwnd9MSA5S?=
 =?us-ascii?Q?M4E50SKu6D2VSU2/YKvr+6QGXDi0om9/CGqYM5tpDIVs14ifv1k2YjjbXxkr?=
 =?us-ascii?Q?plZCVvZnk4u8LQj+K7it2vDYpfiyrkIdrFAW6Cm8cFGtkvlK8C61tY29WSJM?=
 =?us-ascii?Q?bDVhzKloPcSvu0BrjneH3T6ofH8t8BX6G3NEltWanWOePP9V7KI6wRVAlBjO?=
 =?us-ascii?Q?B+eezExeZ+61ISfOJGaCfWBtk/Tr+2F4Doc+MA8JZ8JkqSBT0Unpm8sOtbLy?=
 =?us-ascii?Q?HOCOII9O9QrtgiK+qBdULgUqdEMamoBbdxVVKIKgUeo+Y0ZyrEv9X1iUEudB?=
 =?us-ascii?Q?9AnXSLAPOiTrB4LZvIxivomWJ8WlI9lJN181LQ+UKCSeDUZ1jHE5h5L5eCUN?=
 =?us-ascii?Q?D+haSJE1Vcfc1XxNMB/Uv+6knkOk4CpNX1WIFklZiIJOVmfNsIY8fRlcE6Bx?=
 =?us-ascii?Q?qAjSMXFzjo8UBhSUrk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;6:54+hVtYBVutsljHMmeU7c2h0nBcp1UHFsiloex4HMjcq7Y9cHtWYAfOce9aA6JpIY2ZjDWczz9/UoWkcg3NrY/3cMgyfq1kFu4sGGOvPdhp/WATWmalV4SAYCVNVx+efMV+4L018V6Ct4tmxIdDJm3O0L0J+CV7ZoOSIn+i02u9xXmNpPoo62+e7PYmo0bkIlstRNJcx6FVCewiA9B+kIXE1Dfjb4hrG2o9nueYE3LroKASxj4zgMar8dNRvPk4+kRK2WshDL9RJZWN5BUM0uKh9ASbl+zxl23pM8NGNfgQ2TiQ3KUFGkzm5SgPNORmKUmQisLtnkDMJt1f+XDG79bJFWs3cPgphH3Pr7srlA64=;5:p40wRoqa59yA7pD9ugW8a68Uf6gOWJCzqyVAY0IAHPcwN5RuOK4NdkvCYpSnZLyWh/c0EN1YO0qN8SVSdKXHWP2PmDlujri9hF0Avtucj31cCb54HHajh1MUfr55kFQQR+j0RrsvYY0hSiLZ8PJeZbZTSNLs1EAY/GNZuxGYlvI=;24:R+9qLRW1RI4E7u4vgGVlhwBhpTWLYSylhiPjp5nZ427UiGOKpOAES5s3ZeVKJqrE16R3DHtatS4xMhHfaqcZVEXs0/8q+IwQXtlDQ/5AYVY=;7:qa/GzYt6pMerIDuUYjbBiPG2OmR/dDP5oB/qBhbCrVllJtjD42AiL2CyLQOC9tyqdi0LLI7fAkJyDVQuUauY8NHlTzl+OB8FNhUxFLwrqqbD0lWj3letFtQ2RO2+QaO1VycowM5rWVQ5gS1a3R6QMM269A8+1700ZscmgGHH5MsJjINzcikVTElC6GEJN6SERW5M/N7OdQB8OuogXnIpsthb/pZNDDqzrO1keHTm7K9cyKwd1XyYaANGS27nak13
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR15MB1757;20:GP+U/G9bRl57C+kB4Pr2dHwRrK7fJEtLhYGdDuDmjjdqlsKKRnmVqbRnUle6ZUR3qaL5L1mkGtcVk+LMQcunrQ/k56VOBLOC4tmKZ3GkkEgEdl8uDeyFmDYitmdXwn8cttg0Ken7c5KIJ5UH+Y426f+E4V9xk48Nx0wN3M52GYI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2018 19:48:36.0866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c3cc80-273f-4b8a-2665-08d572519b07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1757
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce code duplication by introducting GCM_INIT macro.  This macro
will also be exposed as a function for implementing scatter/gather
support, since INIT only needs to be called once for the full
operation.

Signed-off-by: Dave Watson <davejwatson@fb.com>
---
 arch/x86/crypto/aesni-intel_asm.S | 84 +++++++++++++++------------------------
 1 file changed, 33 insertions(+), 51 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 39b42b1..b9fe2ab 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -191,6 +191,37 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	pop	%r12
 .endm
 
+
+# GCM_INIT initializes a gcm_context struct to prepare for encoding/decoding.
+# Clobbers rax, r10-r13 and xmm0-xmm6, %xmm13
+.macro GCM_INIT
+	mov	%arg6, %r12
+	movdqu	(%r12), %xmm13
+	movdqa  SHUF_MASK(%rip), %xmm2
+	PSHUFB_XMM %xmm2, %xmm13
+
+	# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
+
+	movdqa	%xmm13, %xmm2
+	psllq	$1, %xmm13
+	psrlq	$63, %xmm2
+	movdqa	%xmm2, %xmm1
+	pslldq	$8, %xmm2
+	psrldq	$8, %xmm1
+	por	%xmm2, %xmm13
+
+	# reduce HashKey<<1
+
+	pshufd	$0x24, %xmm1, %xmm2
+	pcmpeqd TWOONE(%rip), %xmm2
+	pand	POLY(%rip), %xmm2
+	pxor	%xmm2, %xmm13
+	movdqa	%xmm13, HashKey(%rsp)
+	mov	%arg4, %r13			# %xmm13 holds HashKey<<1 (mod poly)
+	and	$-16, %r13
+	mov	%r13, %r12
+.endm
+
 #ifdef __x86_64__
 /* GHASH_MUL MACRO to implement: Data*HashKey mod (128,127,126,121,0)
 *
@@ -1151,36 +1182,11 @@ _esb_loop_\@:
 *****************************************************************************/
 ENTRY(aesni_gcm_dec)
 	FUNC_SAVE
-	mov	%arg6, %r12
-	movdqu	(%r12), %xmm13			  # %xmm13 = HashKey
-        movdqa  SHUF_MASK(%rip), %xmm2
-	PSHUFB_XMM %xmm2, %xmm13
-
-
-# Precompute HashKey<<1 (mod poly) from the hash key (required for GHASH)
-
-	movdqa	%xmm13, %xmm2
-	psllq	$1, %xmm13
-	psrlq	$63, %xmm2
-	movdqa	%xmm2, %xmm1
-	pslldq	$8, %xmm2
-	psrldq	$8, %xmm1
-	por	%xmm2, %xmm13
-
-        # Reduction
-
-	pshufd	$0x24, %xmm1, %xmm2
-	pcmpeqd TWOONE(%rip), %xmm2
-	pand	POLY(%rip), %xmm2
-	pxor	%xmm2, %xmm13     # %xmm13 holds the HashKey<<1 (mod poly)
 
+	GCM_INIT
 
         # Decrypt first few blocks
 
-	movdqa %xmm13, HashKey(%rsp)           # store HashKey<<1 (mod poly)
-	mov %arg4, %r13    # save the number of bytes of plaintext/ciphertext
-	and $-16, %r13                      # %r13 = %r13 - (%r13 mod 16)
-	mov %r13, %r12
 	and $(3<<4), %r12
 	jz _initial_num_blocks_is_0_decrypt
 	cmp $(2<<4), %r12
@@ -1402,32 +1408,8 @@ ENDPROC(aesni_gcm_dec)
 ***************************************************************************/
 ENTRY(aesni_gcm_enc)
 	FUNC_SAVE
-	mov	%arg6, %r12
-	movdqu	(%r12), %xmm13
-        movdqa  SHUF_MASK(%rip), %xmm2
-	PSHUFB_XMM %xmm2, %xmm13
-
-# precompute HashKey<<1 mod poly from the HashKey (required for GHASH)
-
-	movdqa	%xmm13, %xmm2
-	psllq	$1, %xmm13
-	psrlq	$63, %xmm2
-	movdqa	%xmm2, %xmm1
-	pslldq	$8, %xmm2
-	psrldq	$8, %xmm1
-	por	%xmm2, %xmm13
-
-        # reduce HashKey<<1
-
-	pshufd	$0x24, %xmm1, %xmm2
-	pcmpeqd TWOONE(%rip), %xmm2
-	pand	POLY(%rip), %xmm2
-	pxor	%xmm2, %xmm13
-	movdqa	%xmm13, HashKey(%rsp)
-	mov	%arg4, %r13            # %xmm13 holds HashKey<<1 (mod poly)
-	and	$-16, %r13
-	mov	%r13, %r12
 
+	GCM_INIT
         # Encrypt first few blocks
 
 	and	$(3<<4), %r12
-- 
2.9.5
