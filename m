Return-Path: <jinpuwang@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520241454; cv=none;
        d=google.com; s=arc-20160816;
        b=QP14VBZ+Ocn54lrlqjTJgVy+Pa2hBDw2mnohbO/fAukjcq2EZRRMHeza9KrB/nefaf
         AvbdMinJQrcFYO2Y1KwxfHWnS1Sv5+QKUm26HsDfbBfaVqouALsoa98rFGmqr3PfQc75
         jrUQHwXv7nuBq95oBHrrn74jj/YiVRnkPw4B+kJZaHJiWGP/O09p4bbsGgMxkvIn52ay
         wgd0G8F4P0uLp2UvupEEGz7Rf04vD2jJ8WvSi+fv3uih1xiakXU8zDagG0kp+Ns2OE0V
         v4LD7zeWm1JNvF2BIZVOYhqAy5EQLeojbj4y9ujdiqji3P0mY/yUmteMC0nz0zeYltRq
         qWzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=mAy76mtMVqWG0QnFNbgblN4eBwUxXZap1rkUL6d4sW4=;
        b=IXdmu9/Yt5WwkvVWZN/qp9fjdrhqs24Q9Q6CUqH1Vf8IeG+u6xMW7CIcLqyeQbzEwZ
         ldaxVP/9o75j5Zy8ZrD6Dr30K1i11HOn8o1yAEUUy/CCyGynRaHNvw0V+MyQ3MqgfLPp
         8yJU2l3xWCSm1dPNfd6o5Vf4W+5i57euFVxJYAjJ3T3BitSezZz7FxFikXuZPY5KPVrS
         7FEBxfvYrUPXZEYobwUGusvF7ztTAb4y/7vs76BL5y2H17LQ3QDUtcix/wnp/Uw74t4p
         f19G3jVydwE9XU3/pnpNfjqIAFm/DCVDFzV9HN1STrWBvyIG48BpG+FKLq7CN5DnqG68
         U2VA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WnrI4aK5;
       spf=pass (google.com: domain of jinpuwang@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jinpuwang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=WnrI4aK5;
       spf=pass (google.com: domain of jinpuwang@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jinpuwang@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsMsAHLLWZyI0cVzt6xVXYDRocTdnt01ZRgTXtfhYQuV5mv64hWcsAB+6/m4FN9t4yzpIIYAHx7z6AuX1bswDs=
MIME-Version: 1.0
In-Reply-To: <20180303210204.GA6148@localhost.localdomain>
References: <20180303210204.GA6148@localhost.localdomain>
From: =?UTF-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Date: Mon, 5 Mar 2018 10:17:32 +0100
Message-ID: <CAD9gYJ+PAN-tW-=GtY6p--T9nP17y=Gnb_=H0JUD-+X9Z+06iQ@mail.gmail.com>
Subject: Re: spectre v2 microcodes blacklist (march update)
To: Alexander Sergeyev <sergeev917@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>, Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	Kyle Huey <me@kylehuey.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593951579457590092?=
X-GMAIL-MSGID: =?utf-8?q?1594088703465053256?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

2018-03-03 22:02 GMT+01:00 Alexander Sergeyev <sergeev917@gmail.com>:
> Hi,
>
> the microcode revision guidance from Intel is revised once again [1] (1
> Mar).
>
> It looks like the following:
>
>> Intel document only clears the 0xc2 microcode on *some* parts with CPUID
>> 506E3 (INTEL_FAM6_SKYLAKE_DESKTOP stepping 3). For the Skylake H/S platform
>> it's OK but for Skylake E3 which has the same CPUID it isn't (yet) cleared.
>
>
> is no longer a problem. CPUID 506E3 with both Skylake H/S and Skylake Xeon
> E3 is labelled as "production" now.
>
> Could we drop { INTEL_FAM6_SKYLAKE_DESKTOP, 0x03, 0xc2 } from
> spectre_bad_microcodes?
+1, I have a test machine with cpuid 506e3, dell/intel releases
production BIOS version 0xC2, but due to list as bad_microcode,
IBPB function is disabled.
I would like also vote to get it remove from bad_microcode list.
>
> [1]
> https://newsroom.intel.com/wp-content/uploads/sites/11/2018/03/microcode-update-guidance.pdf

Regards,
Jack
