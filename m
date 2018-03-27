Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522167808; cv=none;
        d=google.com; s=arc-20160816;
        b=0f7Nyus3ad5uCnlqwVNyinWXQvBothmDS8uAqy8e4rWrbwE0qabKdkA75ec9jcoBt9
         ZqPNP/KJMuskA5hD5A8ko4PNBZxQNO+JUkaIUvaeaM/BAmMf5bg/wbVAzCycxTETFAWb
         LpWK+g5RRTPbirRvo0YuZtq+uscmbj/DFfzJ/C/xY0R9w/ans/jZRMl1ho/2QXx3USwK
         sWcM0l24DHv6L52EDBFlZ9FjtOXMWBj0rEh4NL5AAADzwAclYJ8Acgq5Mxb8Ep/kDi/n
         74nqT2WSpBz0KrvTbPcq3OG2G3PiqM556VpRv4K5FAsynnbgducuIcRSXhHWa83Lk044
         FyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=pys75mizRub3iArpXL2iZ1sjh/2DoW0stH5mTaAZ3Ak=;
        b=Jzpax6VpMtexKrlHf9Qh9uIuBHg6LsBR5q1nn93s61BAi0+bKEAPTQaN+voOotNucj
         B1PRo2KK/c/cAhRzMKd2E62xonSKRCm24TUBSeYzB3I6X4toaw0zDNzJzF1rAuydYntn
         Sa0fGOFM63yJTtQGl1UTdi1BZyNtxuvNOR4mX0XA59v3cpwn8xb1hTqfZw/zjlCwu4Uh
         aA0d5pI0t71Yuyvuha/L+GyRfKMLJDgvIlQAKEDhvQA7fe8XqvcHbNJw8Mf/J3I0x8kD
         zGQrQcJ02nVrpICU84B9f5jnJldfuCd+WeXFIkfd7Uj4kaZU6gldRXi/q5wFbXCcpJXz
         J26g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eWou4AxB;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=eWou4AxB;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AG47ELvBmDZYRqJfamNc3AYYPHdwIjusY5K1RF0sz7c2PYMiXPDfOxDARYB+7bffRi8wAglaBGWGA7uI+sBft8Tttb4=
MIME-Version: 1.0
In-Reply-To: <20180324084332.u6qik7lkdbenqbb2@gmail.com>
References: <cover.1521828273.git.andreyknvl@google.com> <1fb0a050a84d49f5c3b2210337339412475d1688.1521828273.git.andreyknvl@google.com>
 <20180324084332.u6qik7lkdbenqbb2@gmail.com>
From: Andrey Konovalov <andreyknvl@google.com>
Date: Tue, 27 Mar 2018 18:23:27 +0200
Message-ID: <CAAeHK+za1Zg2+1_CFrQbdn_Hwa9o_nZkHuMLaekV18W380jAoQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/15] khwasan: add CONFIG_KASAN_CLASSIC and CONFIG_KASAN_TAGS
To: Ingo Molnar <mingo@kernel.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
	Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>,
	Christopher Li <sparse@chrisli.org>, Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>,
	Michal Marek <michal.lkml@markovi.net>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Yury Norov <ynorov@caviumnetworks.com>,
	Nick Desaulniers <ndesaulniers@google.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>, Punit Agrawal <punit.agrawal@arm.com>,
	Dave Martin <Dave.Martin@arm.com>, Michael Weiser <michael.weiser@gmx.de>,
	James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry@arm.com>,
	Steve Capper <steve.capper@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>, Stephen Boyd <stephen.boyd@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>, Paul Lawrence <paullawrence@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, David Woodhouse <dwmw@amazon.co.uk>,
	Sandipan Das <sandipan@linux.vnet.ibm.com>, Kees Cook <keescook@chromium.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
	kasan-dev <kasan-dev@googlegroups.com>, linux-doc@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>, kvmarm@lists.cs.columbia.edu,
	linux-sparse@vger.kernel.org,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>, Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>, Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>, Kees Cook <keescook@google.com>,
	Jann Horn <jannh@google.com>, Mark Brand <markbrand@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595752701351251910?=
X-GMAIL-MSGID: =?utf-8?q?1596108632150011944?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 9:43 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Andrey Konovalov <andreyknvl@google.com> wrote:
>
>> This commit splits the current CONFIG_KASAN config option into two:
>> 1. CONFIG_KASAN_CLASSIC, that enables the classic KASAN version (the one
>>    that exists now);
>> 2. CONFIG_KASAN_TAGS, that enables KHWASAN.
>
> Sorry, but this is pretty obscure naming scheme that doesn't explain the =
primary
> difference between these KASAN models to users: that the first one is a p=
ure
> software implementation and the other is hardware-assisted.
>
> Reminds me of the transparency of galactic buerocracy in "The Hitchhiker'=
s Guide
> to the Galaxy":
>
>   =E2=80=9CBut look, you found the notice, didn=E2=80=99t you?=E2=80=9D
>   =E2=80=9CYes,=E2=80=9D said Arthur, =E2=80=9Cyes I did. It was on displ=
ay in the bottom of a locked filing
>    cabinet stuck in a disused lavatory with a sign on the door saying =E2=
=80=98Beware of the
>    Leopard.=E2=80=9D
>
> I'd suggest something more expressive, such as:
>
>         CONFIG_KASAN
>           CONFIG_KASAN_GENERIC
>           CONFIG_KASAN_HW_ASSIST
>
> or so?
>
> The 'generic' variant will basically run on any CPU. The 'hardware assist=
ed' one
> needs support from the CPU.
>
> The following ones might also work:
>
>    CONFIG_KASAN_HWASSIST
>    CONFIG_KASAN_HW_TAGS
>    CONFIG_KASAN_HWTAGS
>
> ... or simply CONFIG_KASAN_SW/CONFIG_KASAN_HW.
>
> If other types of KASAN hardware acceleration are implemented in the futu=
re then
> the CONFIG_KASAN_HW namespace can be extended:
>
>         CONFIG_KASAN_HW_TAGS
>         CONFIG_KASAN_HW_KEYS
>         etc.

How about these two:

CONFIG_KASAN_GENERIC
CONFIG_KASAN_HW

?

Shorter config name looks better to me and I think it makes sense to
name the new config just HW, as there's only one HW implementation
right now. When (and if) there are more, we can expand the config name
as you suggested (CONFIG_KASAN_HW_TAGS, CONFIG_KASAN_HW_KEYS, etc).

>
>> Both CONFIG_KASAN_CLASSIC and CONFIG_KASAN_CLASSIC support both
>> CONFIG_KASAN_INLINE and CONFIG_KASAN_OUTLINE instrumentation modes.
>
> It would be very surprising if that wasn't so!
>
> Or did you mean 'Both CONFIG_KASAN_CLASSIC and CONFIG_KASAN_TAGS'! ;-)
>
> Thanks,
>
>         Ingo
