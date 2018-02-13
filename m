Return-Path: <nick.lowe@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518528849; cv=none;
        d=google.com; s=arc-20160816;
        b=M0JBC9kzRxWb1OT1ql3uhZvFkuHuZBsJkaXDHgqU7uAJetUm0cJtIQSy6ItsuZfTDT
         NqKUqp0m8DLqMsaJNlKeDem1uNgahliAA5h3rhQq9gM4sAAx9RURavulqhCf/+2NiXmx
         41emfZyVxpEr4EGQbNorCuHX/HwX/Buaxv9YsASKxBzSj9tS01gQCWFsKiVkLxygl5BA
         OZjUNavqNumdS05YAc7/9WbNvcVUpO1ueKszs80rbCU1V5ZJy6CubshVjrh+zbsxvumu
         B6I7tfh4QnYw502G3IiL4kXgaKlM4IdHzkbQhYF/70RtzqV2oNcSsZP8Z9Qs1WKXe5Ye
         R+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=/4NDhV+Pl2QCAvz0f9BOgUlvG4SWq1wTVS+rO7yvkmA=;
        b=wnNcxahn5i5LC50D51INqjPuC9ZCt82V9ytON7mRonwEM94/vFm+NbS/pr4eAA+smF
         MTjcIaDW39ac6vOWWmgMbvQabmwXyk8agVUk2SrsszJmfK++hh9sixl9oHlSUxypj464
         bsa25o/7M84V0w/PLimU8YFHGxX+cfoA6behASYkboz+knJknYZynl8PuOOJYDlo7vNC
         AdsQR9hYaMVEtAsu26alFgDqBGAUELWSNvns5R711a1Pmk66Ub7RKMdP0MDqyYM+tMQ3
         T4FrAabu5v8cJFZF5VD6rKRYLqlo9b+JfsBpWZ04dti6ZQGzKFbvLvko3Jvi372Iel+q
         ZwWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BQZDcZnQ;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=BQZDcZnQ;
       spf=pass (google.com: domain of nick.lowe@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=nick.lowe@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225qT5yNUjjZHsLfnu7QGUnZhXL4CpoLcZnye+83d1Kk75cPIw/GYDL3ooFTezLgCtibyFDuqUKtU4wMPg7NFNw=
MIME-Version: 1.0
In-Reply-To: <20180209133934.259299920@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.259299920@linuxfoundation.org>
From: Nick Lowe <nick.lowe@gmail.com>
Date: Tue, 13 Feb 2018 13:34:07 +0000
Message-ID: <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	David Woodhouse <dwmw@amazon.co.uk>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@intel.com>, gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
	ashok.raj@intel.com, karahmed@amazon.de, arjan@linux.intel.com,
	torvalds@linux-foundation.org, peterz@infradead.org,
	Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com, tim.c.chen@linux.intel.com,
	gregkh@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591931030693871871?=
X-GMAIL-MSGID: =?utf-8?q?1592292906339822596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

This does not seem to have subsumed the AMD specific code in

x86/pti: Do not enable PTI on CPUs which are not vulnerable to Meltdown
Commit a8799fd14d9f7f385a5a5c86cde247caf4bb0320

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?h=v4.9.81&id=a8799fd14d9f7f385a5a5c86cde247caf4bb0320

x86/kaiser: Check boottime cmdline params
Commit 8018307a45a90ab2eecfd03d48b7efb31707df37

https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/arch/x86/mm/kaiser.c?h=v4.9.75&id=8018307a45a90ab2eecfd03d48b7efb31707df37

Here, we can see:

+skip:
+ if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
+ goto disable;

Refer to 4.9.81's kaiser.c
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/arch/x86/mm/kaiser.c?h=v4.9.81

Also 4.4.115's kaiser.c
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tree/arch/x86/mm/kaiser.c?h=v4.4.115

Cheers,

Nick
