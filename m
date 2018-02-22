Return-Path: <mpe@ellerman.id.au>
X-Google-Smtp-Source: AH8x227dS2NR8RKj8iW9fTDIiQo9uzpLHlytAXt58y5JTb7Bn8m1t3tRbGSW+klWTMAcJBJI1/qx
ARC-Seal: i=1; a=rsa-sha256; t=1519269553; cv=none;
        d=google.com; s=arc-20160816;
        b=jBfWWxdV1hKQa82KFSeRmof5JysNkac1XoCWhWe922LfstmTcQglRvUIn4qqcFMn3P
         nWt0WTbp9+uEk6GoMbPU8eUW3xTNpAvxnuVCqoxYGCQHdnxP1RY261wRCSY4TE0wzqwH
         tptlzLBXw/e98++Ckt0NfTWxo+6MGAxShX7uMT6tT/uuQyfwRWTOP8EQ8wfYKxmiWSQT
         wnsaM50CeNh8RD/lz5fXDBMK80zSEN6y3iWztey2taUDI8Wxd1fA69w592uIJbXqiH0r
         Yl0bZLyLkgz+S7k/gXy654IDkRFKyfFyE2y37pwUPG/6+8mGLr3LG9w67Ntz2tQYCWct
         T5Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:arc-authentication-results;
        bh=hNvxlz27PWctrai00jFvtlbb8T8kYibB17JTX8nLuaA=;
        b=MI4ftt3pTIKcsB61gA42e7GZ0ujRBSNl55Of7IyBYiny+XBKRrUlLsaZdhWJAYt+Tm
         jlryVwJFxk8KpTGMWkHVAmm6R1k4T614Vt8ASmUA3n86AjHZ3iTbMYfgBE4lqMn8gOgf
         KpRJqAAGu8N74l9oJ/DjrNRg+eYmiV6WCGuk0YZogFHqyGQp75wd+cXq1yjQnwFwogGj
         SgYHXlEuyuRdtWGtDApm0jn29nMwE8hqCWL5Dto8r9LG88bHPI84f2aGs0tu4q7RGRDj
         qg9oaT/5De0dx2IFNvRXu/NC00omos9Yy7aZShLekXBKjhwOGOm8aXOPR5H9CQ7orpc8
         2/Vg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2401:3900:2:1::2 is neither permitted nor denied by best guess record for domain of mpe@ellerman.id.au) smtp.mailfrom=mpe@ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alastair D'Silva <alastair@au1.ibm.com>, Balbir Singh <bsingharora@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, frederic.barrat@fr.ibm.com, Greg KH <gregkh@linuxfoundation.org>, "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@ozlabs.org>, Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: Re: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to userspace
In-Reply-To: <1519255934.2867.3.camel@au1.ibm.com>
References: <20180221045736.7614-1-alastair@au1.ibm.com> <CAKTCnz=cy5CkeRjJYpZ1NQpyQN-BVTvKXUxTxOMtTNosZFqJ7A@mail.gmail.com> <1519255934.2867.3.camel@au1.ibm.com>
Date: Thu, 22 Feb 2018 14:19:10 +1100
Message-ID: <87h8q9r9sh.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592985250939595866?=
X-GMAIL-MSGID: =?utf-8?q?1593069590756613971?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Alastair D'Silva" <alastair@au1.ibm.com> writes:

> On Wed, 2018-02-21 at 17:43 +1100, Balbir Singh wrote:
>> On Wed, Feb 21, 2018 at 3:57 PM, Alastair D'Silva <alastair@au1.ibm.c
>> om> wrote:
>> > From: Alastair D'Silva <alastair@d-silva.org>
>> > 
...
>> > diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
>> > index 4b0b0b756f3e..16e1f48ce280 100644
>> > --- a/include/uapi/misc/ocxl.h
>> > +++ b/include/uapi/misc/ocxl.h
>> > @@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
>> >         __u64 reserved3;
>> >  };
>> > 
>> > +/*
>> > + * Version contains the version of the struct.
>> > + * Versions will always be backwards compatible, that is, new
>> > versions will not
>> > + * alter existing fields
>> > + */
>> > +struct ocxl_ioctl_get_metadata {
>> 
>> This sounds more like a function name, do we need it to be
>> _get_metdata?
>> 
>
> It pretty much is a function, it returns to userspace metadata about
> the descriptor being operated on.

It's not a function, it's a struct?

Outside of "management English" "get" is a verb, so using it in the name
of the struct is confusing, it should be a noun phrase.

cheers
