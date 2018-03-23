Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521828380; cv=none;
        d=google.com; s=arc-20160816;
        b=UHj0IYGd4IGpxHp0Vo5B3lFgNDiFivtaGAAdB2JYfNCCt3E6Cz7oL8vgvxA4s3Md3R
         yFpIkWlr7z0054MEersvyaqDnKRyAPUZieqcLiKKKKWdQfrzNeiKNCME6mZUzJlgVV/C
         khstmazwOKl+K4Dm7hvg7jtnPq+Lks4EXA9iqvCIc23NMsoDMGd/YKryUAYI9g3lpibg
         RUvVCG+D3eBNCbtzoEcNhVCTnXt71c+mKF/o6B9CLQ4rCND16dTPxd7D882sjnSHX5HF
         uYYxJMHV8XwpS4kHqIMfhimM0jVlsAHuh/A9/3FQvf2vX5Qsf881dwLW7PKLIQ7XWXw/
         m11g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=mUDeQOFtVJWXm0knc1bDJKVfDM0pxa/3uJzZ1chGIyw=;
        b=ptyosl7GS+Np1OTOllpTtfsnJWSMFJEcV8r+dHbrtsdJDkfBUJidFAdlpgOC7dW+kY
         hLfj3P5gSDzlqlMQLeZMazKRat0gv2mWb7oZxb/2RNl+hi1uce6QBHS1fJwQ34A3H49l
         MGwHN2j96RELaTFzrOv1eskylK7747Wz4Ynzi2VcyGoIfbDVURuxGA4wJ/crtCK31Yzb
         9vG7gN5VzCifbVBAlRU2y3P38Ah59l/Km05sf3fiDj8t2+HbaqJVwKZe8FgVFkvhkxuc
         5n2+roBZl8tcJ5jsgbwXVCg55BymiuI+7xeq/Y++7K0Pq0DFxWUAvZOf8pFVoRKhKQ9i
         b71Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jIFClqM2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=jIFClqM2;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELuwVASQJuluZ/sxgns/L2ZBnFzahf5eN8QRG8B7Cl5vv15nFLehmUwm5Hp9VuoeLi93oMVzqw==
From: Andrey Konovalov <andreyknvl@google.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>,
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
	Stephen Boyd <stephen.boyd@linaro.org>,
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
Subject: [RFC PATCH v2 11/15] khwasan, mm: perform untagged pointers comparison in krealloc
Date: Fri, 23 Mar 2018 19:05:47 +0100
Message-Id: <6eb08c160ae23eb890bd937ddf8346ba211df09f.1521828274.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
In-Reply-To: <cover.1521828273.git.andreyknvl@google.com>
References: <cover.1521828273.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752716297382191?=
X-GMAIL-MSGID: =?utf-8?q?1595752716297382191?=
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
index a33e61315ca6..5911f2194cf7 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1494,7 +1494,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.17.0.rc0.231.g781580f067-goog
