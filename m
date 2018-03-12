Return-Path: <kernel-hardening-return-12474-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELs6hP+2GVnbsrFJNk1xhsAICm5IRPmj5S0Wukul2gzHvgI3OtOIovv5dLB4b/MFDvXhqatD
ARC-Seal: i=1; a=rsa-sha256; t=1520880375; cv=none;
        d=google.com; s=arc-20160816;
        b=y+4dUYwt1GX2es5JKLkwdKbjMQS0iCGrcENqd+bOYydKrOhvPkil7Ek95pF/2TUps3
         1XQua3jp0qJO1G3TvSmyrt/tsVewMJ9Giy3i24jFcigVqD+NnO/EGVfOuQORxOI35o9S
         lEw4PUTFuErXV+sUUu7hnaor3WPDto65JK/f9qcAk3vtKXHiJobyar6fMPT63ToPbNOM
         XbV0GZZaXG6/XamndPTa0dBL1DFfITDB/u8XzOS4SnJVYo/w8y2R8TVdge5Yx13c4+HA
         MjzOPUxpcbpohx7Wj01SDs84gtkLUwTdbX4KIla5kp4GxaP6fKL8ulyPNEs0vpRCcQ9n
         wCDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=pJcVN4K8MStWv9CMj+HnfDAMBAVRn2sFc/k0DLzj+zY=;
        b=pLLEfv6KPGEsXfgSYsbLK1ek440xapWjSU7xZPQeXbxdH+N5VuZObg7G9GYHXl+8w2
         /3+baWbeLSeO873CDMfV39RNMPKcXgEKA7Rv8/yzzYG2UqYI+1vO6SbgYsLw9xG3n4yM
         s8XGwrDqpQaqidM8OQapNtWdy+dUWZ5qkmJBesv/1zpGifju4m0fUzHjDZfLEfvPZHR4
         bO0PCXPu3tBgdeD0r+iIG/hKWwPMb2PP1SRbeSKQ61vofShNpstE5Z5wHjTU55GkqY5H
         aTNEFqJF+xHNdjEImg20C7xiseNGFpX9MyooW2L0tQQJDenTQ9UtQE6U+klKTA5K00iy
         xZ1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nuUHJlfp;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=OkGHv4b6;
       spf=pass (google.com: domain of kernel-hardening-return-12474-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12474-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nuUHJlfp;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=OkGHv4b6;
       spf=pass (google.com: domain of kernel-hardening-return-12474-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12474-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180312030834.GC8631@eros>
References: <1520802418-17284-1-git-send-email-s.mesoraca16@gmail.com> <20180312030834.GC8631@eros>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 12 Mar 2018 11:45:53 -0700
X-Google-Sender-Auth: fG-oAOXPW5pcXl3KzCUaIUDFkO8
Message-ID: <CA+55aFww=otC4Wv40enadF+9NAyWG4Hotzjvv2EKb+_wGFui-w@mail.gmail.com>
Subject: Re: [PATCH] scsi: eata: drop VLA in reorder()
To: "Tobin C. Harding" <tobin@apporbit.com>, Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux SCSI List <linux-scsi@vger.kernel.org>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
	Dario Ballabio <ballabio_dario@emc.com>, Kees Cook <keescook@chromium.org>,
	kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594676969721761588?=
X-GMAIL-MSGID: =?utf-8?q?1594758660848910065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 11, 2018 at 8:08 PM, Tobin C. Harding <tobin@apporbit.com> wrote:
>
> I think we are going to see a recurring theme here.  MAX_MAILBOXES==64
> so this patch adds 1536 bytes to the stack on a 64 bit machine or 768
> bytes on a 32 bit machine.

Yeah, that's a bit excessive. It probably works, but one or two of
those allocations will make the kernel stack really tight, so in
general I really would suggest using kmalloc() instead, or figuring
out some way to simply shrink the data structures.

That said, I wonder if the solution to this particular driver is
"delete it". Because the hardware is truly ancient and nobody sane
would use it any more.

The last patch that seemed to come from an actual _user_ finding a
problem was in 2008 (commit 20c09df7eb9c: "[SCSI] eata: fix the data
buffer accessors conversion regression"). And even then it apparently
took a year for people to have noticed the breakage.

But because the person who reported that problem is still around, I'll
just add him to the cc, just in case.

Arthur Marsh, you have the dubious honor and distinction of being the
only person to have apparently used that driver in the last ten years.
Do you still have hardware using that? Because maybe it's really time
to retire that driver.

                   Linus
