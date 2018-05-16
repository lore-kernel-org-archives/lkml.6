Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-969494-1526507690-2-705613042085372101
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES ensk.us-asciiro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526507690; b=Qm3E51jRLsWe/Yah4V0EUoAtooFs0DvLzVGwkxlv7asTYPiQaR
    nu6KzmLf3pKhJ7mq9qTzSyE2SGiH4qPWFBQNF6O0F22MTmzJE58K2GSnDl84cYfa
    puzhWAEQoQoIonl7oZX6lAchMiC2gYCtzRJKjYqpzjI9S/uscmz9TxVUPvnK1Sij
    DBnIBXbE8AaqMhPMbPbGCcGnyzXsub/+twmeZuh0mo8EAoqwzmaDA3QITCZkT22k
    Fcl8J9r1RX28cFPttIx3rqkbygtlfwnBdL45+mBU2MgzdpbBpcnfkse0szno5nlY
    g8PoFvEXq1qqGR7J+nYU+3/oF73exLlZXSEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:reply-to:mime-version
    :content-type:content-transfer-encoding:sender; s=fm2; t=
    1526507690; bh=eMdd3wtml0gIxav0GjUyJ0p3gSp/VaGoROlf/1CssT4=; b=B
    SyXurmcpXAWJMF3pMmWD8uwA7gcOQBhEV+OqteMGFsZ9D659ewA+bDLv1+vE6BpL
    /ryAM3OeuGiAK+Gp0ZU9HFKUWXoAB4mjrypPOJkhMsfBiMQLqrdM3pcp48Aag+1y
    zCv3t9zv6MWvaB6sfglLVNnioHwwdDZUBWNkm51CCTuXDweLHqDCYQYFnRA9ZlSB
    EDRu0xQtJQHgq8JD+DOOx+pPz2dT6H2WIgQf7unQoR0p2p+wlZ4VFa2iKjO24s3a
    4qgKuqxs0nCF4IgrnO0wdVUpuWTsh1NClaCq2bn6Ybi/wevS7VZ1fz+edsyblIin
    KySwB1Ir97BZ22e8jbe1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxonhyperv.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
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
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxonhyperv.com
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHZfzATzF4R09WTiuZN9B6CUlU4Y7fD+m7ClwIzg+PWv5Uv2XwxDZq8Gppj68sP5aLBZoYr8wOYcMLV9ED+3OjglDKmMEAwNeSSGjzbQnXHp/+PIGCr8
    TjjLMj+dKBsiuC6yxOibU8W0gvCORT1gZbvjNN7FHVkrQt8i3rR46EmDjxduP9mu8VPwDhzzxWEYVABcSgIYGuh8HsXRU3ye82/ICaezFi+Klab/zU2bjYg3
    4085uGfWksmjbxUbqEu0RA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=wmH2h71lHiwA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8
    a=DDOyTI_5AAAA:8 a=F6DzB2bOAebDD460gfsA:9 a=_U-CBZyVp_kiX-60:21
    a=I5Cnayo9lOi12jQG:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
x-originating-ip: 107.180.71.197
From: kys@linuxonhyperv.com
To: x86@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 devel@linuxdriverproject.org, olaf@aepfle.de, apw@canonical.com,
 jasowang@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 sthemmin@microsoft.com, Michael.H.Kelley@microsoft.com, vkuznets@redhat.com
Subject: [PATCH V3 5/5] X86: Hyper-V: Consolidate the allocation of the
 hypercall input page
Date: Wed, 16 May 2018 14:53:34 -0700
Message-Id: <20180516215334.6547-5-kys@linuxonhyperv.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180516215334.6547-1-kys@linuxonhyperv.com>
References: <20180516215144.6481-1-kys@linuxonhyperv.com>
 <20180516215334.6547-1-kys@linuxonhyperv.com>
X-CMAE-Envelope: MS4wfNqvlMmiPYwI6bi7/M2XWcxyHEqUhV91tLaTyJ64GMMmZOA0SLsxx8aIEo8yqvNJnaIdzBcvjjIpF195/nmluUveOX3AuT1uK+Pof/WNaUm34wUQ1LJi
 M9GtY18WXfA1ZMMPXF6b6v1gA27jNREAv1ZlJ1AxyLC/AnNnkNjIkUeV+S4G0/WSqZbfzX/PxZVyaYO7H4JIxeJve9x1YnZf8exgG68Bt5vXWhpPA5dSYiAg
 rPBsoZ18Uv0eavBS1MZ1A+kL5mYPxL29H1bhHVK8rRMhIRDNwzYvtT0smI/VhGt+uFajDUYY3Brt/BwHv7o+4v6xCXSRgghB8CWwBIE3Fdjz2BLWQghccj96
 7R5gfMUJQwMddzh7vVknOgepT7Wf2rd0bC+qCdweHUpW+/M6s9Mv9WcgLqIzQUelSMbwQcq08MV6H2oT68gPYnzQpI5Ze8Fea+WxAeppBzIrBbXd4Jua+a8N
 J6lYkw+v7bZWe0qy736K5quSFE/TXraZUetm8kQrYTx9krIPvZZV602BZD2Wgvp0i4sthOdVavDN4dLOYuy3HbAy25jSaAt073Inz5E7QwsTAcfe07KBCGF/
 dWULx1DQGAYd42TiuXv2tl1M
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

Consolidate the allocation of the hypercall input page.

Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/hyperv/hv_init.c       |  2 --
 arch/x86/hyperv/mmu.c           | 30 ++++++------------------------
 arch/x86/include/asm/mshyperv.h |  1 -
 3 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6bc90d68ac8b..4c431e1c1eff 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -324,8 +324,6 @@ void __init hyperv_init(void)
 	hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
 	wrmsrl(HV_X64_MSR_HYPERCALL, hypercall_msr.as_uint64);
 
-	hyper_alloc_mmu();
-
 	hv_apic_init();
 
 	/*
diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index c9cd28f0bae4..5f053d7d1bd9 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -32,9 +32,6 @@ struct hv_flush_pcpu_ex {
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
-static struct hv_flush_pcpu __percpu **pcpu_flush;
-
-static struct hv_flush_pcpu_ex __percpu **pcpu_flush_ex;
 
 /*
  * Fills in gva_list starting from offset. Returns the number of items added.
@@ -77,7 +74,7 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -85,10 +82,8 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -164,7 +159,7 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	trace_hyperv_mmu_flush_tlb_others(cpus, info);
 
-	if (!pcpu_flush_ex || !hv_hypercall_pg)
+	if (!hv_hypercall_pg)
 		goto do_native;
 
 	if (cpumask_empty(cpus))
@@ -172,10 +167,8 @@ static void hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 
 	local_irq_save(flags);
 
-	flush_pcpu = this_cpu_ptr(pcpu_flush_ex);
-
-	if (unlikely(!*flush_pcpu))
-		*flush_pcpu = page_address(alloc_page(GFP_ATOMIC));
+	flush_pcpu = (struct hv_flush_pcpu_ex **)
+		     this_cpu_ptr(hyperv_pcpu_input_arg);
 
 	flush = *flush_pcpu;
 
@@ -257,14 +250,3 @@ void hyperv_setup_mmu_ops(void)
 		pv_mmu_ops.flush_tlb_others = hyperv_flush_tlb_others_ex;
 	}
 }
-
-void hyper_alloc_mmu(void)
-{
-	if (!(ms_hyperv.hints & HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED))
-		return;
-
-	if (!(ms_hyperv.hints & HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED))
-		pcpu_flush = alloc_percpu(struct hv_flush_pcpu *);
-	else
-		pcpu_flush_ex = alloc_percpu(struct hv_flush_pcpu_ex *);
-}
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 0ee82519957b..9aaa493f5756 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -294,7 +294,6 @@ static inline int cpumask_to_vpset(struct hv_vpset *vpset,
 
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
-void hyper_alloc_mmu(void);
 void hyperv_report_panic(struct pt_regs *regs, long err);
 bool hv_is_hyperv_initialized(void);
 void hyperv_cleanup(void);
-- 
2.17.0

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
