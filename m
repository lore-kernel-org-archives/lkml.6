Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-968028-1526507684-2-1782967974913782876
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507684; b=ScSRV4Rk12f5tMlnC1tfhz9mMhdcM0TSO5vmMJG6+FVUwendJs
    nR1lqbIpfshbwSYlYsNfOKweMz/t8IYEC0x1dmhramSuu0VlahNOoe4XMj1C+yyc
    wDnFDA5SdJRLqs5t5VSUicMVFk38/nmmrm/j2K8ObIpYoySiyufxpp+hKf5XkEm0
    fMb544mBFz3i7Ev1+LgtaDLqGwL6L3Uek0lFXLOUHqUgLdz6nr4ny75uyFl77gqv
    IFuNy08JRVRpBUu+Ul9bJA/YzXx743APEZbp+zO29B48dtj8qn2rkajopdY2+1QB
    R3JYCLHtK2Gv+V19fJokO1Rdk6UrMd+blj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1526507684; bh=GjtAVyEwn7+I14+Q43GMLzqtZ23EHtIVGpb9Osr0+fw=; b=b
    xQD2o94iQP8qM6U+BESDPlAJlOIy+bBdBz4vx6g0I4xA4g+YfnQALOMekI6P2jCn
    VRs3OXboQsr0n87qibF/OzLKWKXpMwVNk3D0taNdEGBGvudCN6hR+c+8ruYHALMm
    q626rHHvP3L5WWiUkHKbShnptmEvxdReL4Ar0v6elLd3AtSss0Yp0T7LdmnK93b0
    ohBdoYd28SlFuQQgyiSrAJcFZL7luHU5w0wDdUUqY4J/oLtkbbYSIj96pw81ivIs
    He+/345XctpnVbCEFfqNIz5m6RXkpg7O5Q2mNt2MBl0TK7kUqvKOeauGM3FuMRqb
    e7He/sOFORHK6AXLLQwtw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxonhyperv.com
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOC2oPJ67esq/qF9q8cR/RsWbGW5mwBTX5mJ9l/EUaR4NUuew5xI/LtwG0DW5vBjOoL4rXl3AK/VgTTvIQAaJeKqUzys6imZb2B3jJZ7GROOTz79kZCW
    ZTUhcjkOU70oxNjonxmnGfBoelEWALI3j/hT6Hc2f7tivKhF/suT2RU0kcqLxlzOpNadB+iyspXIBjXN3D4OiQq3gc8suNmq4Bdbb92zEkPLZn6hrnsr5hTs
    Qah61meV6rfeIgazDebRMA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=Wm50CMqxRF3z0ZTy-GIA:9 a=m8--mx8mtZlZ8vnH:21
    a=BsUXsgHBvD4ltEBY:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 4/5] X86: Hyper-V: Consolidate code for converting cpumask
 to vpset
Date: Wed, 16 May 2018 14:53:33 -0700
Message-Id: <20180516215334.6547-4-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516215334.6547-1-kys@linuxonhyperv.com>
References: <20180516215144.6481-1-kys@linuxonhyperv.com>
 <20180516215334.6547-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfNgoIGTnjNFcBW4UgVg38Oyhie2dMpvxR7zUBQGsnP8ZcViaRswzEqgk+4Ud+LGkKXP7Blnsp10InH3OTJgTsqnwsC4mow4WJFYAsY7jn/PNQPiTgkCk
 WqZEIFBZJIH2H17p7IPaueBINbUTRW+lx9+W5M7zRKaI0/PhpQNVzH13RrglFtYvO+bXG2mFvtaPaLTiYtWWMxFKANtXlYV+5grAjZtsSdxr+bHn3Y1xYoXw
 MgzhOuhjOvZULYM++p9hpigAUGuO2km9Emd1/NLgCS+Nr6lcYdnHN7AGGyQvESRCoO92XJsDtIZeOnuFQVzKlgYo649lATBgPOp+bVjRwYDwsrPYtq1gvRPQ
 Q1tWTRH6n5zsC3We18US/wymbAc1qsBaYosdQKF2U+LfkgneTZZiFQie7YuFb7uO46NJGSrGaCiCgBHHzZMtn19ZQ58DvVc2oa7/RmxoJVX2rlUOdz5I3fFV
 hsAH70BavXMF8PrsBuSTrnXM0x6ye+gINFEuSP07+p0nqzQ5epEi8AkYRbvP0VTl+bzQVNw0o6Y2uERrSGqQ+7fYtbizH6dH6jKpFSEpMplZ26xYvdMZZPaz
 1eFuFLaS8+kaZkVfYfDdmyzj
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
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
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
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
