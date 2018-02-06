Return-Path: <tedheadster@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517942031; cv=none;
        d=google.com; s=arc-20160816;
        b=OtYfU9MUO3S1T7iyiJvSgwCSVHjIYj8KIbV3u+B7vkH7OFk81cIrTJPkSZiHAe/6N5
         ZO9vaC+B+iLwsVqeU5XzMfeSraH71Ogro0h9Ycb8ufAFDZkIB+j9HDgBtLvyN7iquQeu
         GFgnhTMfRpYkS+A+mWykpVm86n841lTtudFWPAUOgkHPlyQmrrrHbo1rVUEIetG4atEq
         Mfu4lSdRkAzzLJSlzRWCtCYel57Gcr3/2z5PV2eXMFVEcGCW4/nvWlsr5A1qwz7kMAIp
         O0p1SJCXTjdIVnCxByd+KZ1s4QkylqbHxEoWXc8M3D71Jmn53Q9DwY/14tFdilyF0iMS
         IgQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=jOO9CjEoxL9EUmCsn7BdAHYIGXN620nae/pymObodsM=;
        b=y3FUSTe8A/XGTjDxd4tdvsDfvkh17HLyRl6dbZl9e/1mEJjc5h4dwrJHZN6mPAWjhD
         L8X/DnFO6lyU1+wv6N8aA4f84zEtKMusL4+HB1QZsymJHfp8mzDysmBMGCc9TEDLHcIQ
         2ytbaSrl1Gj0MXs+4ZOqJiPievvGV/8bu6RYEnpv7vn5K8MHCESwHpxtWtQXmj+eomC0
         xbnwuldwg4EyUcjcLMQtCyDackdz1XQcQ8DAPTZtCPIkhn0RDgP7hpdmmZ2+0GqO7mh6
         5F/MH2PklpL0pwqg0JGlXP6zka5r3B4Eb3v3Nbefbl0aVsbnTdmGtpCUnAajo3+PpVKg
         z3OA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DkQPx+8H;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=DkQPx+8H;
       spf=pass (google.com: domain of tedheadster@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=tedheadster@gmail.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x2244Xpm5cBop8GIxK5SxAB16Y4R/LQhRkhigsAPvnMDpBccpjLVcQGYgVKpMscbgqpfxc6/HZ5jYaRjjOz9wLNw=
MIME-Version: 1.0
Reply-To: whiteheadm@acm.org
In-Reply-To: <1517643438.31953.108.camel@infradead.org>
References: <CAP8WD_YnJnQW9o+t2jn6HRrY3kKQMRD44joP=thPYO5vS4ev7Q@mail.gmail.com>
 <1517643438.31953.108.camel@infradead.org>
From: tedheadster <tedheadster@gmail.com>
Date: Tue, 6 Feb 2018 13:33:30 -0500
Message-ID: <CAP8WD_Yrp5g6YZwV+XQTx93YpTakWEL8MD+p0bZDaPi3-r88JQ@mail.gmail.com>
Subject: Re: [BUG] x86 : i486 reporting to be vulnerable to Meltdown/Spectre_V1/Spectre_V2
To: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hugh Dickins <hughd@google.com>,
	dave.hansen@linux.intel.com, jikos@kernel.org, Borislav Petkov <bp@alien8.de>,
	Guenter Roeck <linux@roeck-us.net>, Kees Cook <keescook@chromium.org>,
	Jamie Iles <jamie@jamieiles.com>, eduval@amazon.com, labbott@redhat.com,
	Rik van Riel <riel@surriel.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591354140743903681?=
X-GMAIL-MSGID: =?utf-8?q?1591677583851428055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 3, 2018 at 2:37 AM, David Woodhouse <dwmw2@infradead.org> wrote:
> On Fri, 2018-02-02 at 23:52 -0500, tedheadster wrote:
>> I just tested the 4.15 kernel and it is reporting that my old i486
>> (non-cpuid capable) cpu is vulnerable to all three issues: Meltdown,
>> Spectre V1, and Spectre V2.
>>
>> I find this to be _unlikely_.
>
> This should be fixed in Linus' tree already by commit fec9434a1
> ("x86/pti: Do not enable PTI on CPUs which are not vulnerable to
> Meltdown").
>
> We'll make sure it ends up in the stable tree too, if it hasn't
> already.

David
  I believe I got the patch(es) you mention in in the stable 4.15.1 kernel:

Pull x86/pti updates from Thomas Gleixner: "Another set of melted
spectrum related changes"
(commit 6304672b7f0a5c010002e63a075160856dc4f88d).

Unfortunately, the symptoms I reported remain on at least the i486 and i686.

- Matthew
