Return-Path: <linus971@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524413317; cv=none;
        d=google.com; s=arc-20160816;
        b=h+NT0xTLdpJZK3O9Lzps2KeH0Lju7yZV3AzwugIGvdD7yAxYbc9rbY3vGQJHlIPu28
         uhZWRa0ag7ZY1IzkQsviNJG0n6N//kGakWt0olOMub4J37Ws0H0mPnFY42ZHFqrBzDVx
         MtIh6qmlC9wvqkRpx9NCqN91eINPwlF5LVs7W+7k1vkzeEacgfV0Y8NmCkrNp9blM2jo
         6tuty4hDni051R4ELSDyKwMxXPzTjjEA4gFR300TpgZpacxk6VPv/rHFLavWDA6wDmAp
         wkL10Tjf/BIcbVb7IIe5XQlCKbaZzRi8r29+qR8LClOSgGzALpjlBh+GC2ovEkIqa2AA
         Knbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=+TfLXmFiXOZCKOD61J3Xd7sBC3Ov3ope4bpQNWUHMwk=;
        b=PL2N0XdUZglR4yjJZSJ6Fi2tlAK9COa4ObNyqymJSfarIDZ3Z5VZ5HbXc/Imo/GDz1
         e0QZlSMhP3z19c1iulkWnWe9ul3rj2cw1st45ZM9Ks0FJx+VELzNxW/fuMj9B8TfJcGa
         84Fu9XY5ZZuRJkUWC4CSRaDV6o+X+Ct+JUFHJFrKAuCspbky2SidCCALCPTVlQWxCH/m
         ft9NLW6/keTIl6ttPRn6ClhSKkskZhdNkSGuSrMxF3CGcgGW4A1UsKhPtA97Jb7UM4VG
         /NyWj8cDxAuBvlDNIPEwF6pe7669NhwB0z70oYgj8k+DKJFJaai1aUJE7DaJ95ktOG0H
         fNLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u50cD841;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=hiIB1GOs;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u50cD841;
       dkim=pass header.i=@linux-foundation.org header.s=google header.b=hiIB1GOs;
       spf=pass (google.com: domain of linus971@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=linus971@gmail.com
X-Google-Smtp-Source: AIpwx4/64c8le1afmjr0l4Ptl/JW1NuNVJWlStEKSXWdv6yivB7tuFzuG6lA+t9Kyxf9n9kS4RPWaqnBqtXoeaUguGs=
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180422100032.GA18114@amd>
References: <20180307214624.D4361772@viggo.jf.intel.com> <20180309204526.56301f43@alans-desktop>
 <CA+55aFw5+KjVqKUpAMF+-BfE6NuXSNb8qdRtmAWDq6apK2v+sA@mail.gmail.com> <20180422100032.GA18114@amd>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 22 Apr 2018 09:08:36 -0700
X-Google-Sender-Auth: aTPrn_y5elTt7_NA4St1gOXyLng
Message-ID: <CA+55aFwXrH-NiwUhxj_F-uTv2PfA28mD4gsLwZY12HTxSn-rkw@mail.gmail.com>
Subject: Re: [PATCH] [v2] docs: clarify security-bugs disclosure policy
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Dave Hansen <dave.hansen@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>, Andrew Lutomirski <luto@kernel.org>, Kees Cook <keescook@google.com>,
	Tim Chen <tim.c.chen@linux.intel.com>, Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594317071955827625?=
X-GMAIL-MSGID: =?utf-8?q?1598463218867145362?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 3:00 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Fri 2018-03-09 13:15:31, Linus Torvalds wrote:
>>
>> Oh, I don't want to be taken seriously by people who use gpg
>> encrypted email.
>
> Heh. I see that gpg has some usability problems, but we do encrypt our
> http connections, and email is at least as sensitive.

It's not about sensitivity.

It's about the technology actually *working*.

PGP does not work for email. Never has, never will. It's unusable
crap. Nobody sane uses it, because the cost is just too damn high.

Make it as easy to use as https, and things will change. As it is,
don't even bother.

Thomas helped me get S/MIME working, and even for that I had to fix an
alpine bug that caused alpine to SIGSEGV. And that's _convenient_
compared to pgp email. Whee.

             Linus
