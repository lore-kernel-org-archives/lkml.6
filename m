Return-Path: <kernel-hardening-return-12643-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvKpTk90ECUq1v3SvI3QwbxpvDB/zqaYcTta+APLgOTZv4Xcbe498nDuf+C/lRVCS5fDvwN
ARC-Seal: i=1; a=rsa-sha256; t=1521150154; cv=none;
        d=google.com; s=arc-20160816;
        b=SdRPck98Bz3HLnFMSBAMOHmQEvO6XIg6gks4XmQGW/ZYb5U/h+ZIYor3hlmfspT9rp
         Jq4iKDb7CzUFnmOjwDuBi7f/TmvSgk/o++jW5RP23sFYlJmHH0Bt4aIrTqfNLkeP3D1I
         02Ygz+j/rh6r/63lZhm4wioDHR6eiKhWAbF2/v0y+9L/EpowWEPm+uPAZvd++68a8M9L
         mswtRL08T5lPV+bDKn/8S31qTA7LIOTGdw8GTogruvtyz6f1bx7cxJBgtiWiTByL5LlA
         dolgAJZEwEL5Xd742t15aBzYQwVW8mGBQfdJCL7IKbfVNcM9d4wo9dQGsFpHLpxUAs9W
         XYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=Is4IjQQ0eoM0oQM3z2XQ1hg8AZZtcMV4ott+2ChQJ/s=;
        b=a+ujTOHqtHiyXA8HJy78YX2zwia4CM/BMGOmuSZ2D6/wx4kn4p+blsX0Fej8Mb+VMk
         sdDLOsadm9pNwMh8lJx8Uc+yhUB0nASDW0zPRCXUFvh39pmMoFmKYWLY2UYAiDtfiYFg
         6yWwS0ARFOzUSGiidGjM720aRueAaVh3FfLnO+ERZH9hTsr5/hu15hWtpmqBsGwS/unO
         sMGIYqnHaW+U5kDt91g2vbzgDj1Hy/LjiW9kAHRAwLTZuCVMPXHa/0cPZbwjm5ne3PdG
         QOykkTh4+GNmtu9mVENL2pkUZrhgELgYE81U0l4dWKhe3R5M2ey9Nc/uog8wg7pLDi81
         UhSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qH1HCepk;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Hvkpjqfm;
       spf=pass (google.com: domain of kernel-hardening-return-12643-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12643-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qH1HCepk;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=Hvkpjqfm;
       spf=pass (google.com: domain of kernel-hardening-return-12643-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12643-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1521143266-31350-2-git-send-email-keescook@chromium.org>
References: <1521143266-31350-1-git-send-email-keescook@chromium.org> <1521143266-31350-2-git-send-email-keescook@chromium.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Mar 2018 14:42:13 -0700
X-Google-Sender-Auth: 4kynBy1OBf91aOeaPMVF1abkwjA
Message-ID: <CA+55aFzu+VU_FVZdbLCZttUspZdJCvBhkuo4V69H=XnqmLrpLA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] kernel.h: Introduce const_max() for VLA removal
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>, Ian Abbott <abbotti@mev.co.uk>, linux-input@vger.kernel.org,
	linux-btrfs <linux-btrfs@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595034361293703830?=
X-GMAIL-MSGID: =?utf-8?q?1595041543823442219?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:47 PM, Kees Cook <keescook@chromium.org> wrote:
>
> To gain the ability to compare differing types, the arguments are
> explicitly cast to size_t.

Ugh, I really hate this.

It silently does insane things if you do

   const_max(-1,6)

and there is nothing in the name that implies that you can't use
negative constants.

                   Linus
