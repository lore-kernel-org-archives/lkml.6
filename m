Return-Path: <mingo.kernel.org@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526283451; cv=none;
        d=google.com; s=arc-20160816;
        b=q7NoRBHAoM6dclMQ2lhTVq/ZaLGgsrRBgewOSdPDpVZwuwQnv/TTUjPnSE8Z4JswYD
         8yp067EspVNi/bkVTqWuEOuMtEXXD41djcJNgCNiF+OlFAJuSnN/ag+pNcaNTLdXbF4W
         uQw9ehs11YHxXoOgzH10xDeRtOwkGUYr/J2ZLP09U0ehmzNqzinENayqkwdS3TKoG+MI
         RxE6qZLTyeeVcFY6tfrbwlZpe+jKmqeO3siGg173x5UMENywtKTvL/unNCN7hvWLgfss
         kJMVeb0sv45T4MaEXw5ErNFYvsCEL6PGM+kJ01+0UMKgW0EDtf1+W4UlrmGFH/rhI6wU
         FzLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=75Cxvqkt3c+fOzFQyDtXbhODlqsT07pCIM3Ucl/PDh4=;
        b=e5rMIy6AcB2Tefefer+CVcbO2T1b62EzPWF8QmOj4gP4vUKZ7PTxXPwQkW6U54M4Ri
         AtVULmo7RWeNc0B6OMbtAvNBBw+YlAWjMG98hd0RN4nlhecBUk12q6VXhWNzGQOfrWgT
         kW21Rs93YHiiRhmBoMVmFln3Ca+oefI7PXY2cjBd+6WOBX3je/URfSrMDSzAcMeIAyDR
         iJDkTUEa5b7/7CTXhWRGCO/fI1ln6Rg51GQzdZzOcwhXhGiAYv3/2ssuXZ0pJhTMt/Tc
         66F/4kuZjjJC6tt8+Cqsk0LD6KCFbR+L6bIBGfyxTFQXrlZo8fWaL5mvbNnlqsU41/iw
         oQEA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cc2+S2jC;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cc2+S2jC;
       spf=pass (google.com: domain of mingo.kernel.org@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=mingo.kernel.org@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZpfm1cErOwZcK46rX+PNLGpCfXYfgjeGFrD/0Q++LlVjG19LJhCXIA2JUceAHbLOKCMpAkxPA==
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 14 May 2018 09:37:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
	user-mode-linux-devel@lists.sourceforge.net,
	Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	user-mode-linux-user@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] um: remove unused vdso-syms.lds
Message-ID: <20180514073728.GA19463@gmail.com>
References: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600137983171121849?=
X-GMAIL-MSGID: =?utf-8?q?1600424196437182226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> This file contains symbol values, and was originally linked into
> vmlinux, but I have no idea what it was actually used for.
> 
> Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
> not even linked.  Now it is completely orphan, and no problem has
> been reported.  It is a proof that this file was not needed in the
> first place.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  arch/x86/um/vdso/.gitignore |  1 -
>  arch/x86/um/vdso/Makefile   | 16 ----------------
>  2 files changed, 17 deletions(-)

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
