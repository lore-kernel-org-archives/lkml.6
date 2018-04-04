Return-Path: <tytso@thunk.org>
X-Google-Smtp-Source: AIpwx49kiJBd2aJ97+kwRc5FHHizZnaktqG/31rjfVxMNzK57ksVrHWVEGvw2im8ruNN2YouHaY4
ARC-Seal: i=1; a=rsa-sha256; t=1522846668; cv=none;
        d=google.com; s=arc-20160816;
        b=WCQuYSL79xTgRWn1A4jtqoBjf6V+jSpTRpe9/pG9KfRQHY+6zQtI075jYPUaR5wC2V
         /gZmBIphPN50C8D+oEeaUgzv/is5g2nvu3KuKzwkQ04TJY05XEOvjz2JtNyhAGefC0iL
         xIyA2jKDxVmUrhtBk5uMRmtw3AP5xBBLlyK+ElIU/ddtwRGV1yamKE8K4T0xzjjcqMxn
         iopgmmTTBdDafyoYiczH91svs+coqQ+LRoJgTvZDQ8CAU80ZwdMtVSteK81Auy4KLz3F
         accJnWIq3hd0RTJQrBofREiGkyI0F5yanX+KxQTNUeKb7QP4wIPNDqMk1T6SQbt8uuV2
         rwAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=WXtbz0g34TnB+aHPNFOAyD4ibj2WT80QKjUYESMt0X8=;
        b=ZnuqaHCYrzvKSdDq4srJMnwvFRnwrp0ggqidzu2i5Ef/rkXcLmYZclT6d4zShERXL9
         WYZmOsYMAWPwZcmrUhmrnC9ZoQuOEXUJff2QPsHg4PS9hQZWGi+DXsbUk3OZglewIeuB
         Jeo1Xc9lgxbdGewxZNxQ0Vo9e6wXYGc3FVuIl1VYJdhj5TlgbAikdeYNoDZiKXUUTXRK
         pR4bXGoNswqo3eWAjfUdV79leWiRmOjExEOR4D3qrdV4rwLek0hiOelx95hL9thS1oIk
         TQNCbH7vWjUo4tUDdp9C/c1N5/jVDJOds5+5ZzjZ2dLcu3RuXU8HpsnbkpK2d6iS+PpS
         D+og==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Q99A8sxL;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@thunk.org header.s=ef5046eb header.b=Q99A8sxL;
       spf=pass (google.com: domain of tytso@thunk.org designates 74.207.234.97 as permitted sender) smtp.mailfrom=tytso@thunk.org
Date: Wed, 4 Apr 2018 08:57:43 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: Matthew Garrett <mjg59@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
	David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
	LSM List <linux-security-module@vger.kernel.org>,
	linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180404125743.GB16242@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
	Matthew Garrett <mjg59@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
	David Howells <dhowells@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
	Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
	LSM List <linux-security-module@vger.kernel.org>,
	linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	linux-efi <linux-efi@vger.kernel.org>
References: <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596407243846270411?=
X-GMAIL-MSGID: =?utf-8?q?1596820468105748059?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 04:30:18AM +0000, Matthew Garrett wrote:
> What I'm afraid of is this turning into a "security" feature that ends up
> being circumvented in most scenarios where it's currently deployed - eg,
> module signatures are mostly worthless in the non-lockdown case because you
> can just grab the sig_enforce symbol address and then kexec a preamble that
> flips it back to N regardless of the kernel config.

Whoa.  Why doesn't lockdown prevent kexec?  Put another away, why
isn't this a problem for people who are fearful that Linux could be
used as part of a Windows boot virus in a Secure UEFI context?

If lockdown simply included a requirement for a signed kernel for
kexec --- and if kernel signing aren't available, to simply not alow
kexec, wouldn't that take care of this case?

This wouldn't even be all that much of a burden for non-distro users
with lockdown enabled, since in my experience outside of enterprise
and data center use cases, kexec isn't used --- and in fact, very
often kexec doesn't even work outside of a very carefully selected and
bug-fixed set of device drivers.  (It often doesn't work in non-distro
kernels because very few upstream developers really care about kexec.)

					- Ted
