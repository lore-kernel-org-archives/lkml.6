Return-Path: <jrdr.linux@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523902827; cv=none;
        d=google.com; s=arc-20160816;
        b=BHpfUzCpMhA/m51WMzIsrPN3h9EtPHxJrZGIoYQuzr0T3oI+tGgXoTbNSY53HURgu5
         t6JQTXZlLwRezixEyZ/oJdfEUclFw4MD+tFs7MN8vuG+lw0sN4D1Vu1ECHGKOvg5poVR
         0rlP6FS49Jc9ZfaYPiPtjq+qcU7MnWmT6OIdzf9CFGC7rPBG3lCUiOqR/mamWumV4z9p
         RlUbfFOBhRx41lCg9h44y1X5dEjPKaFmra2akexNXbZFYofQRA88M2+eipQibI5ZQRcK
         7jwDYfi+vPyaD3dmE+LY9sLo46GnXuKdIWRxQXDfY/OR/5HoaPlX1qMvI43G/C9jrGyA
         4SzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=2llTcT+YbZKzL3KQxugtRiFkWIEbBupjsrXULU4D5bE=;
        b=m9A7bspnsewuiQnN25gSs/27ndN/Q0sAMkb3/RSaej/OrAA3o1TgpDUXNU0htP5G7l
         iKB1W6djeUVgZeKSbAErnXfNQM/2U8PwFm2mkAIk0VEqJPxWx4s4AUx50sNuenqL9pKa
         RlPuaOZxllxxN7rzEtqJr10wBbPCB76vQ6CCRhd7cdsQ4X6GimJJgBUEb8xHcw0Y2gt4
         R2icl4HpIwau8YtAF/zCxx7jMeaKzxhBEWPV4oy9XRqPRwEfHFyAByCIpVaipTHI7TK4
         cp+9+Fcy5I7MPWeUvurDHYgvxTtNiLfuzqgKQe5HX6WgDpBaaBkPsgPWbyXP5Af3Yfgv
         /vQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MV2qivzS;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=MV2qivzS;
       spf=pass (google.com: domain of jrdr.linux@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jrdr.linux@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48QF36SVnTwW/xWk3WhCLtOTuhD7fhQXLYC2FlgzXzP+mOmnLFW2luXQRNlBGEBCguXnOgPWZvKN2myuRkTyKc=
MIME-Version: 1.0
In-Reply-To: <20180416152658.GA6398@kroah.com>
References: <20180416145440.GA26704@jordon-HP-15-Notebook-PC> <20180416152658.GA6398@kroah.com>
From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Mon, 16 Apr 2018 23:50:25 +0530
Message-ID: <CAFqt6zbaLt6g-Np0S-7YThs4ibvnPKaa92zBbRSYX-MqnCdfEA@mail.gmail.com>
Subject: Re: [PATCH v2] uio: Change return type to vm_fault_t
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597914866157448313?=
X-GMAIL-MSGID: =?utf-8?q?1597927931730214252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 8:56 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Mon, Apr 16, 2018 at 08:24:40PM +0530, Souptick Joarder wrote:
>> Use new return type vm_fault_t for fault handler
>> in struct vm_operations_struct. For now, this is
>> just documenting that the function returns a
>> VM_FAULT value rather than an errno.  Once all
>> instances are converted, vm_fault_t will become
>> a distinct type.
>
> Odd line length to wrap at, your editor should have told you to use 72
> columns, right?

Not clear about this.
