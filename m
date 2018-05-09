Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525868013; cv=none;
        d=google.com; s=arc-20160816;
        b=J2DVY5069jwvpa7+SViWRFqlfmBpPe8oFVQ+bMKA3gq0dh5YnbpseoAeMMAtPA3aCm
         R1otWvZJ5/EFBGuuTobnrKB/LP1PLmqN4uVJclogHcblzSICgObJlRphM25W1gCpUuiJ
         x2XCmVvw4CyRFR3OcdHR8SAHxLHtVJjVqVyJntZKGO14P9MSZk3zKRMUbr9q6ADUctxr
         dVUVMGOyRPuAHRaVOMiQksMOR88M8QSBJ4XDv2tv10uPPqslMdl2OBAxcL1Pxu3rNvoz
         Ho3fHoOyaEmVJTSN/9XSEDepn8AQibMFHc+uZ21JspIt/ruvUxd7n4WEv9bVfDYtRFIH
         VV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Qp0+cIcHfBTh0Vgx3/mf3mGp+HuQ8vINUK86NC2VMLU=;
        b=ePt+248K+N3OWiTSPa0D1y4s6U+BguJ7h1YOeoTH8+VDSUpzQwcjch3YBcNg3nIcQV
         yhblQJjPMJjXsx+fB1Km6gKuDsIA99Qq3oTmEQwcjCnHnTKinBD+UWzqxjCxCJgC8IuU
         zXtzqKNWBBFfiUcMr46gFs34/LMeXpjloI0cpi6oKi09Ew1lsQzrqIDRErU2G9/uAl8U
         3n6BkwjnmWi74V/2QM3d1GjnduP9OS/Xx9jtpZlC6Jip3axdZ6ngh/miJwN4uA2Yh4+L
         s62sINkkxnhnAoVDk2cjO+pugsdx5ZtBUnFSmDkMdFN0MsJ+xl+qArnqaM7ZSdBO8+x7
         J1NA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=u1DY2xG5;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=u1DY2xG5;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZqrk+xH2GmRW9SwiLTETdKbOMkQW+QrqApyVZOntPNxiUCXBJgLCtPR6QK6Ps+sBkMeUBX6cHOqNqK+ORf6jQ0=
MIME-Version: 1.0
In-Reply-To: <20180509052632.GB15939@rapoport-lnx>
References: <cover.1525798753.git.andreyknvl@google.com> <bc150eb0a71437400c64a4388805327fbaf9bb30.1525798754.git.andreyknvl@google.com>
 <20180509052632.GB15939@rapoport-lnx>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Wed, 9 May 2018 14:13:30 +0200
Message-ID: <CAAeHK+z=6cY59C9F5sz4OUEkGyiS1GFySx--5+Di0k1o9OjKsg@mail.gmail.com>
Subject: Re: [PATCH v1 16/16] khwasan: update kasan documentation
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Yury Norov <ynorov@caviumnetworks.com>,
	Marc Zyngier <marc.zyngier@arm.com>, Kristina Martsenko <kristina.martsenko@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <dave.martin@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	James Morse <james.morse@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
	Julien Thierry <julien.thierry@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <keescook@chromium.org>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>, David Woodhouse <dwmw@amazon.co.uk>,
	Paul Lawrence <paullawrence@google.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Tom Lendacky <thomas.lendacky@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	Dan Williams <dan.j.williams@intel.com>, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
	Ross Zwisler <ross.zwisler@linux.intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Souptick Joarder <jrdr.linux@gmail.com>,
	Hugh Dickins <hughd@google.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>,
	Boris Brezillon <boris.brezillon@bootlin.com>, Vlastimil Babka <vbabka@suse.cz>,
	Pintu Agarwal <pintu.ping@gmail.com>, Doug Berger <opendmb@gmail.com>,
	Anshuman Khandual <khandual@linux.vnet.ibm.com>, Mel Gorman <mgorman@suse.de>,
	Pavel Tatashin <pasha.tatashin@oracle.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, kasan-dev <kasan-dev@googlegroups.com>,
	linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-sparse@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599917372360161351?=
X-GMAIL-MSGID: =?utf-8?q?1599988578171203231?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 9, 2018 at 7:26 AM, Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> Typos: in turn is only supported
>
> of the
>

Hi Mike!

Will fix both in v2.

Thanks!
