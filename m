Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2107488-1525955970-2-37195437619747983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525955969; b=OzoiUV3sElkvNCLPjX6/P7HGLgjf+rr3il+gaGaiO+iw2WnGhn
    OGNVtfU32pYKjtS+PJX/RAUD+8uRoz79t6x7mp9VEjeLuJPOuQyoKjNZhJPzwqFF
    kDGdkHUpBB3pwfRH9roIXfbA+uCBvxBTm5T0/tzk28jvAxgjTp2HF/Rqrv3r5rL3
    aQa6lMSoSnUu5NLfSgYUhIUNCzQpJFgmdG4BzUH4FLFhWmd45ucUcsOoPJdyNaps
    Augqb0oIR9qTi1pb/tm1xJGYw1qqcJdXG8AIkLo1Ad69o/5He8k7+j2PoVCq1IYD
    SPxtFzqlkMNiyDoaWTkXUsyR0A/lI7midQPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525955969; bh=X8H8Kno2gHFTQ7VqV15kaN95d1MVpl
    IbHuXSjAQrH2s=; b=F9YKfpYGEenlk3/35TctD04j462MqCHClFHT2Gxj+ZxzrW
    LgW4hMn8MTy5G1q/b/JJiwlcKwVfpCKLoxvQ5doFAnhN3nJT05ik5LV78imCivFa
    j8wNHMAwjMx1nISNY2Og8gEksvu/k09WVI/pxFxiZDEOlmqoPkkmGvTEQT7FQFVL
    qstB8JgKTdL1QJDRTedGHZgNrz9WqaXaSOGwaYj9daobWtILQ+KPPHuzNTLmhOzY
    7i1s85R97Q93rArqeGGXttCTv03hnkLWS9LTOI6yDXJsC5sGMSIwK9j+zxLtEhdu
    RAPaxNm5PQ23P8ZvKVcK7TaVl7ZxdLSmKxfFMeTw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCXLJ8EkBcBeOwj7+1x3eRtAyF52iOyqy3xm1J/3N+tI/ALggt2qf5VjDEYmCYvBIC1ehxSYwqkwVk6WCoBGkfXud1A3x6+YYLneXxi6xvPRzxf27STW
    c++VVk5OMmat5XjYxsabLSI+JHDMjscK4f/PR/3CC3Hyv+C5mCHTIg8BMju5owqtAHE3zbVDJq//krow6p0Yrpo9LUd8oCx/vKrwWGJqyke3csxC+Usy5Ktb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=meVymXHHAAAA:8 a=NW8rkkeDe7lZfGPZF9gA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757355AbeEJMj1 (ORCPT <rfc822;linux@kroah.com>);
        Thu, 10 May 2018 08:39:27 -0400
Received: from mga03.intel.com ([134.134.136.65]:5593 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757217AbeEJMj0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 08:39:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="38267428"
Date: Thu, 10 May 2018 20:29:12 +0800
From: "Du, Changbin" <changbin.du@intel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: changbin.du@intel.com, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com,
        akpm@linux-foundation.org, rdunlap@infradead.org, x86@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 4/4] asm-generic: fix build error in fix_to_virt with
 CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Message-ID: <20180510122912.mqmpy4j4dj2trb5r@intel.com>
References: <1525855396-7908-1-git-send-email-changbin.du@intel.com>
 <1525855396-7908-5-git-send-email-changbin.du@intel.com>
 <20180509085224.34116e36@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509085224.34116e36@gandalf.local.home>
User-Agent: NeoMutt/20180323-6-5ca392
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 08:52:24AM -0400, Steven Rostedt wrote:
> On Wed,  9 May 2018 16:43:16 +0800
> changbin.du@intel.com wrote:
> 
> > From: Changbin Du <changbin.du@intel.com>
> > 
> > With '-Og' optimization level, GCC would not optimize a count for a loop
> > as a constant value. But BUILD_BUG_ON() only accept compile-time constant
> > values. Let's use __fix_to_virt() to avoid the error.
> > 
> > arch/arm/mm/mmu.o: In function `fix_to_virt':
> > /home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
> > Makefile:1051: recipe for target 'vmlinux' failed
> > make: *** [vmlinux] Error 1
> 
> Perhaps we should put this patch ahead of patch 3. Why allow it to
> break?
> 
Agree, let me exchange the last two patches.

> Anyway, besides that, I think the series looks good.
> 
> For the series: Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > 
> > ---
> > v2: use __fix_to_virt() to fix the issue.
> > ---
> >  arch/arm/mm/mmu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> > index e46a6a4..c08d74e 100644
> > --- a/arch/arm/mm/mmu.c
> > +++ b/arch/arm/mm/mmu.c
> > @@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
> >  		pte_t *pte;
> >  		struct map_desc map;
> >  
> > -		map.virtual = fix_to_virt(i);
> > +		map.virtual = __fix_to_virt(i);
> >  		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
> >  
> >  		/* Only i/o device mappings are supported ATM */
> 

-- 
Thanks,
Changbin Du
