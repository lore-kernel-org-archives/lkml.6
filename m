Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3741095-1525414183-2-6173709141787514688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrosv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525414182; b=WPpSXufO8qYKviag7iwhcHcxPLHKFZKI0IcIoMjt1WzuOSL9cc
    sTbAg3PCh16UlXy8Py3UwODASmyDhhWLMcmpW/3Ab6KTzw8iQcPp3iY+rTsP7GUS
    ICvhuAl2uW7Etn4clcKve+Ld7VUBtsOcI1pXANP7xWWd0i3QFEDUINkk2QQx7o7Z
    OWooc3Zeeur69MWFNyulfyqfyQps5+2Dvvlf9RqD4GXjDH3zoJVVWKdA+qmtrAmB
    28jQyaNJTCQUGwYrqm/IvmA+HzDDop5f6zHnQ9PPXBGXTdrsrDkEoZCxKZyot7JI
    sclNi/7D8a2gs5bIbZ+qqAsQscY0XDBSLihA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1525414182; bh=k0cLnN153f5/zuiQqyLiK8wqUc+TOny8MC0uhnRtLlw=; b=d
    566SgKZgU1zrpQJggtpe8nR/Ly1+fJWFEEK5VlBjm+HJ1IzOFsX8d/dI/FkoqR55
    01k/inR8eOQ2eNDTJIpQn5uJKKQTWKd8YdRbw8ehDNDVoI7w4uFpZAMth5CSMah3
    q3Ntm6dxFdcpnkjW3APf3/upWbUmxci4EgZ5wdfk83jC61oK9EBOBmv+JRFBSsEX
    Fsxrmvdzfu3miK6grIg8FYw6VOSWi6U0rxQ1zqj3glzEycEy/Yw8siGIMwx63Qfw
    PmWXB7RLbl2r1YLpptRgOPP01csrFS71f3CMAShN2UhRw9NvIdI76NJEAGTKTRRJ
    j8H5YTlrsklo2oxSZ3A7g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNY5Kz9NmcezNBdLTXZTd2mnpCyt9D+dg4NAKW3NjgltrHrdGFGxBbuNaHQ2MMF/pHclI/3SYNyNPZ0zdodqXaHX8OK6/p22nzqbUIkHAQ5H2neoi7f3
    i9XP9j1qrrA/UfeQ4nvRyDzF5OB7dn8MmRBA3gNKTIgCnryasnt5U9CQQAhAO6eN0iQ1K5LXDF+RWZ8yLyi2e+J9kH4MQNvQeU1AUEvuOWk1ROD82pjFtYuy
    Uu4YsSaJOgxvNnJ12Bz4ZQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=Wm50CMqxRF3z0ZTy-GIA:9 a=x96Puk8oez5E3pkm:21
    a=M0kWt4hH1XmksLWF:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V2 4/5] X86: Hyper-V: Consolidate code for converting cpumask
 to vpset
Date: Thu,  3 May 2018 23:08:22 -0700
Message-Id: <20180504060823.3345-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180504060823.3345-1-kys@linuxonhyperv.com>
References: <20180504060653.3240-1-kys@linuxonhyperv.com>
 <20180504060823.3345-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfO5fvkw+ICjeE8oWzPxGFCBGm3Zc66fVrKwfAY82FCzX5SI+qzbsNESUFMgu8U9vXG5J+SmXeLoe4jHRvWFEvMaDNmzlUNB5UOig/OjoQZZ9Y/qZyeDB
 ZgskzSkTDTXEi8ZAL8b9bv0or+nECpDcOWa5PkYq+9WblT5448g61b9k9rLVa2B0gWwANUFq5GaiNJv3WF5pf/8xS0uCBB6gb+NUHYYfyCZGClmp7PPXIJZU
 9bPAb3A83HvKdXvIwxc/eT7F8NyoZGewzUZVsJJbwIy5v36cV9m8zqtEdPHOyDDdYhJhHCqdxQ+bwsMhOBv1D2oja/zrE2FKIKd7QnpRt04tWBs72R0WaDE2
 Fww29vmU3O996oy/B9a+uhs8vMVQFbVf/QUOzjYm/Gz8JFxE4kWQC+cgttC6thE7if1xYz6YwM/aFV2X18R9+ussT9oCHDHBqu3Jg6Y0EqPuo/pYn8yZYXiQ
 MGbtxmAzHRVXZxXrGxEfgm50rr7YEtYk2NecToZ3IHgugIUQYryRhnVc5tmlRONXcfDLVP/SXkzGqDBUFZvipH9zuXVFdKOMqSF5OesnPCwYUEVXKgOgw+vA
 QY3Tgp9Ttqddo3CbwLApoBp2
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Reply-To: kys@microsoft.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "K. Y. Srinivasan" <kys@microsoft.com>

Consolidate code for converting cpumask to vpset.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
---
 arch/x86/hyperv/mmu.c | 43 ++-----------------------------------------
 1 file changed, 2 insertions(+), 41 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index adee39a7a3f2..c9cd28f0bae4 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -25,11 +25,7 @@ struct hv_flush_pcpu {
 struct hv_flush_pcpu_ex {
 	u64 address_space;
 	u64 flags;
-	struct {
-		u64 format;
-		u64 valid_bank_mask;
-		u64 bank_contents[];
-	} hv_vp_set;
+	struct hv_vpset hv_vp_set;
 	u64 gva_list[];
 };
 
@@ -70,41 +66,6 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-/* Return the number of banks in the resulting vp_set */
-static inline int cpumask_to_vp_set(struct hv_flush_pcpu_ex *flush,
-				    const struct cpumask *cpus)
-{
-	int cpu, vcpu, vcpu_bank, vcpu_offset, nr_bank = 1;
-
-	/* valid_bank_mask can represent up to 64 banks */
-	if (hv_max_vp_index / 64 >= 64)
-		return 0;
-
-	/*
-	 * Clear all banks up to the maximum possible bank as hv_flush_pcpu_ex
-	 * structs are not cleared between calls, we risk flushing unneeded
-	 * vCPUs otherwise.
-	 */
-	for (vcpu_bank = 0; vcpu_bank <= hv_max_vp_index / 64; vcpu_bank++)
-		flush->hv_vp_set.bank_contents[vcpu_bank] = 0;
-
-	/*
-	 * Some banks may end up being empty but this is acceptable.
-	 */
-	for_each_cpu(cpu, cpus) {
-		vcpu = hv_cpu_number_to_vp_number(cpu);
-		vcpu_bank = vcpu / 64;
-		vcpu_offset = vcpu % 64;
-		__set_bit(vcpu_offset, (unsigned long *)
-			  &flush->hv_vp_set.bank_contents[vcpu_bank]);
-		if (vcpu_bank >= nr_bank)
-			nr_bank = vcpu_bank + 1;
-	}
-	flush->hv_vp_set.valid_bank_mask = GENMASK_ULL(nr_bank - 1, 0);
-
-	return nr_bank;
-}
-
 static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 				    const struct flush_tlb_info *info)
 {
@@ -240,7 +201,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	if (!cpumask_equal(cpus, cpu_present_mask)) {
 		flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-		nr_bank = cpumask_to_vp_set(flush, cpus);
+		nr_bank = cpumask_to_vpset(&(flush->hv_vp_set), cpus);
 	}
 
 	if (!nr_bank) {
-- 
2.15.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
