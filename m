Return-Path: <kernel-hardening-return-12683-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtOLs7vEjZlDjBOYESzPqr4KCkcvJyjXyLbmIerJHghwfiPE5WidD+Kc7Jzm7QQTnAO4SBV
ARC-Seal: i=1; a=rsa-sha256; t=1521271643; cv=none;
        d=google.com; s=arc-20160816;
        b=NQQXQGDNl40iH3rPxK5WX49a1kTPX1c0ih4kt1iyLEkwaVZe9Dldpp30DkhexCaHyT
         JRYeQDPDVvc17lUwVss3fNJCGpwZgXfi6Tqh33dfT7RrRqFszaFQQ4LG9u70I+3r61hI
         SdwTazL6MiM4JY/hj6BnCTWVbfrtNLwPWJzK87gHe7ROg0OhrfapgVdsWmyc/Z3FAkt8
         LKNps8doVPcifztaMzq++MviWh8ytmvEdrUQHFxmTvoCgwUHe3V9HzqS0agltzmmgxkI
         Bwi9t0Cmg37JNS8iSYIR6rVEUr5yhXn7XrqKQ2EoD1nU5Nruxij0K0pGweh2eUCuSN7y
         PyHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:sender:mime-version:dkim-signature
         :dkim-signature:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=YvqdxoMV6Dpyb4G26V8wcUbssk2lDN2bAkRCC3ax69I=;
        b=kopGq0dhtGa3O3s9Q7UGs71M8Hg33WX3N8ye4GWUVy7mcuBni8IEj2COj37XY9XUz5
         ytYL1q5AXfnITV6Twh50uM6fwCeCTVfopqcU8e2B1EK9Z+ZsYT9KoKutHu5nh2WrYw3S
         TKJARtZ+9hCZmm0fCpphiCNC39Rz74Gj2v3JtqSTa6BHWu2k12KaWJ+SwTjMWVrFi/b9
         m0s7HPR8ahcrR/9cZDlzaAd/5LtNhi5ihaPjWDQK8/SrxkYzP17rSCsf+hA2hNc+y6xp
         l9F51B8obsvOdun01GPMCfYR7HMfYiQ/8uX3eZU/RxsYOhK9GZgz6xAQoDLrwbbddw3X
         Y56g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JGZnhJnG;
       dkim=pass header.i=@chromium.org header.s=google header.b=bju8X690;
       spf=pass (google.com: domain of kernel-hardening-return-12683-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12683-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=JGZnhJnG;
       dkim=pass header.i=@chromium.org header.s=google header.b=bju8X690;
       spf=pass (google.com: domain of kernel-hardening-return-12683-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12683-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
References: <1521174359-46392-1-git-send-email-keescook@chromium.org>
 <ab2933a2-ca7b-eb3b-744d-bc037b1be688@redhat.com> <CA+55aFx92dXg-qnrjGS2Rsna6TE5HSPBgGpSA3cv4n_n3RqBzA@mail.gmail.com>
 <20180316175502.GE30522@ZenIV.linux.org.uk> <CA+55aFzsrVF7W+YQye=EeF4Wk3yDOTbb_vSiM8s1zkKbE4JV4Q@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 17 Mar 2018 00:27:02 -0700
X-Google-Sender-Auth: KhgjZQ07me5r4PFLOhmwRgugg00
Message-ID: <CAGXu5jJmAAgaq3VCsUN2yjpHLSc7P-kNrM_4c4cqP=ysFcETXA@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Remove false-positive VLAs when using max()
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Florian Weimer <fweimer@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>,
	linux-input <linux-input@vger.kernel.org>, linux-btrfs <linux-btrfs@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034368078500739?=
X-GMAIL-MSGID: =?utf-8?q?1595168934816597813?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 12:27 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Kees - is there some online "gcc-4.4 checker" somewhere? This does
> seem to work with my gcc. I actually tested some of those files you
> pointed at now.

Unfortunately my 4.4 test fails quickly:

./include/linux/jiffies.h: In function =E2=80=98jiffies_delta_to_clock_t=E2=
=80=99:
./include/linux/jiffies.h:444: error: first argument to
=E2=80=98__builtin_choose_expr=E2=80=99 not a constant

static inline clock_t jiffies_delta_to_clock_t(long delta)
{
        return jiffies_to_clock_t(max(0L, delta));
}

I think this is the same problem of using __builtin_constant_p() in
4.4 that we hit earlier? :(

-Kees

--=20
Kees Cook
Pixel Security
