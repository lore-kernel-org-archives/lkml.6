Return-Path: <thgarnie@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520974819; cv=none;
        d=google.com; s=arc-20160816;
        b=iQYUXln7oeiIm30RnuXN0c5GzyeeT3CAk9s09Yx3DMZ2Xp/n4WZvq+R/8k8BWOwoSZ
         t3x6BKaz/UjC/TFN4OSLfxDON2D11Kng3QHEgsspunMyF3CJ9mI8ejWwa3ResZDtEyvY
         DSDUo6iM1EQi2n9WCs9n/KaCpcK9eqbaITduAc0SUXUinOnm2NGyHLacDVUlq5BI2aY1
         6Hhe52CykIfLygIeOEXsLki79Z71TJjECD/uPWu55RuHmUSMLIT2S/ZpEgOZe5FK0/kn
         ABHko0qZbIvi+5arnxe2BBNSZ5pqNCEYv6SRIyj+Hx2KTMAsmvCQ9Bbyp5o3h0g4Bx99
         LmLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YFAqguIZ1GKuBePauhrgbb6AlEObB6A1PFNFlK8E2A8=;
        b=JUnDVLWDXYy29abpVDvkOesgzRBWpRqkiFcY/bSkoMH+ducVD9bqDlSo/yN6I4aCCk
         d3CMzrbsJp1cR3OwliruNkWNCIWj9HNXMXpV1MHa0NBWtIEKfP76PtxpdXMtOioHMOoz
         sFrHfyEeE4oC36X6PBcoUiCYtg8okJztY8OFr5zzHMK5Evs8SbYBO3HaYdIU5BZRkebK
         mukppTRZKw15I9iMjpCQn3d1N43mEaCPk1jLulJSuAAcB1VHd+K27RHcghH+P3MEtqao
         1XnZPgC+2mL7LyVWItmJv+HaIdLrtCOuCXpuVrtByOmGwnQYZf0FvIJ35JBJZRaZxCdL
         VQ1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aPPgba8m;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=aPPgba8m;
       spf=pass (google.com: domain of thgarnie@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=thgarnie@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELtDyiTtt4REoMK1E76o/7/VC8sxV/wKKqP/iU+fInpsRTXwqNsS3dRoqgvX7uMd7c9igxeFEg==
From: Thomas Garnier <thgarnie@google.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Thomas Garnier <thgarnie@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Borislav Petkov <bp@alien8.de>,
	Borislav Petkov <bp@suse.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>,
	Pavel Machek <pavel@ucw.cz>,
	Juergen Gross <jgross@suse.com>,
	Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>,
	Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>,
	Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Lukas Wunner <lukas@wunner.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ingo Molnar <mingo@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>,
	Jiri Slaby <jslaby@suse.cz>,
	Kyle Huey <me@kylehuey.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michal Hocko <mhocko@suse.com>,
	Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>,
	Daniel Micay <danielmicay@gmail.com>,
	=?UTF-8?q?Jan=20H=20=2E=20Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc: x86@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org,
	linux-sparse@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: [PATCH v2 04/27] x86: Add macro to get symbol address for PIE support
Date: Tue, 13 Mar 2018 13:59:22 -0700
Message-Id: <20180313205945.245105-5-thgarnie@google.com>
X-Mailer: git-send-email 2.16.2.660.g709887971b-goog
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
References: <20180313205945.245105-1-thgarnie@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857693116409689?=
X-GMAIL-MSGID: =?utf-8?q?1594857693116409689?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a new _ASM_MOVABS macro to fetch a symbol address. It will be used
to replace "_ASM_MOV $<symbol>, %dst" code construct that are not compatible
with PIE.

Signed-off-by: Thomas Garnier <thgarnie@google.com>
---
 arch/x86/include/asm/asm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index 386a6900e206..653d8b82f015 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -30,6 +30,7 @@
 #define _ASM_ALIGN	__ASM_SEL(.balign 4, .balign 8)
 
 #define _ASM_MOV	__ASM_SIZE(mov)
+#define _ASM_MOVABS	__ASM_SEL(movl, movabsq)
 #define _ASM_INC	__ASM_SIZE(inc)
 #define _ASM_DEC	__ASM_SIZE(dec)
 #define _ASM_ADD	__ASM_SIZE(add)
-- 
2.16.2.660.g709887971b-goog
