Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524235636; cv=none;
        d=google.com; s=arc-20160816;
        b=wmp9kBsBzf65lBgNQYGXfKhNhIjTT71cxDnpHd9UiaXiomAy07mRyka8LqaGPNkk95
         8U+v1tO2YpE1x2VSaJTk2VfSDY4/vXOxJ6//k9iW/sLjNgPH/Tg1qS1FGHPLjTXFmI55
         GfeHfLxLUUDj8KwEdqHGjWyebon7AtPCWW7KkkPNYLC9tcylKldFHe7su4p0wfKSK1Bg
         fgyN6c6zwPKia5nJiGLYfzvapW881Gdfo8JrpoXDY3Vg/xWbHHQ0TtNQ1ZN5JlOf/hZ3
         WbQOtDK2ALvInTLl9CqFGTsxQW1uBfTVmzUD7fDzr3BrSrhEBjbbV7/09xZUSOnnrVdt
         hQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=eqZnb9CbYXA4PcR3Sk/Cz8NCTr1XxEd0fASwB3Vu7C4=;
        b=cc480nNQGSZ/6gOjJ1B+VXq7q2N/tQE4WKM6PvEOZJm42nPcOcX8VGaFBVPczlU6nT
         kKdw0mFHQHS+zLOoFR6WEIyu9UGdCRPA2QrFaxmv1j6fzZW6hrznMvXlcq+UJ4OhIQFN
         1r6srrDhDruOCTcssrb34cfjvjOnGPSWMTZsnXxTEPFs8/QmTd90qO3Xd/DqOX8NNDGO
         yJHkOIVnm74WhNPt/G8gzApKkZj16bCWDbLhcRNWhxpyApJOdMecxp8+Lv3QH5jRupa6
         CRHn6VIIxTeqa7vl2vt0hRaegMMz+uG/qAn2JXwMCUNLcB+rMpWuHTU1ePrQb8W3O3c1
         42Ow==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ECde/gvv;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ECde/gvv;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4/7ml1XmcOnzW49un8fvAUP4eOBkKmKTOmIMCdUZRf4C1YtMABYTOPtCM5ON1NxKB6KpCgEpA==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>,
	"GitAuthor : Andrey Konovalov" <andreyknvl@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>,
	Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>,
	Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>,
	Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kbuild@vger.kernel.org
Cc: Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>,
	Mark Brand <markbrand@google.com>
Subject: [RFC PATCH v3 09/15] khwasan, mm: perform untagged pointers comparison in krealloc
Date: Fri, 20 Apr 2018 16:46:47 +0200
Message-Id: <c39de2d3dac5ff6f2aeb6519c144fb170c673b1a.1524235387.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
In-Reply-To: <cover.1524235387.git.andreyknvl@google.com>
References: <cover.1524235387.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598276907293102849?=
X-GMAIL-MSGID: =?utf-8?q?1598276907293102849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. KHWASAN changes memory tag on the
krealloc'ed chunk of memory and therefore also changes the pointer tag of
the returned pointer. Therefore we need to perform comparison on untagged
(with tags reset) pointers to check whether it's the same memory region or
not.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 0582004351c4..451b094b8c5b 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1478,7 +1478,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.17.0.484.g0c8726318c-goog
