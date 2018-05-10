Return-Path: <jason.vas.dias@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525953783; cv=none;
        d=google.com; s=arc-20160816;
        b=of4z9ePcLQr1kcwSnfoWw4XZLTJgou6WLlWEBaK005DJaF9LKQOeUszGQhaTHJtrSZ
         TshG9VsIWlRO+ZRixj97jDTMtCeJlkh1pTXSGSkU5nmoSo9nhWL75hPKNYNkcfco1NHI
         zDVtwWLRHMZUMROYI8Ga6xuhQl5SbZgl3v5HbO/gOGGGPIib9ZbzxLTJAZH1113K3UcE
         47BqGDdeuhBaXky45xW/sS321gWkbaTVGQoajfouJbbIPSGGYDlm46OnGSVkDMX7REjC
         xRMmhj3aTv/eHH++nMIYhEbWwCtnVFBV9YAQ/RtU4hsqwoocO7X1Lb9Oc0r7NmphdTxM
         XAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=5xS+HFeOn4uOLUdoVcuZgrMIaE5HIiotvF32una61N0=;
        b=pJ75Ix8LzSvJZTt9jRHxIu/OMTQP2uKaYGemKXim0ipZFnoO5a8RncWlDnsxHBhEAK
         vJQaNedh5wjp62ADCowW7VbJ8ChTyU2U7sbUbGH2FmfVJDucuFPKrlMeSOQYap3u3Rlz
         C2Hp4SfYFv+u6gJDXw2OOYFXRUGApTb5aA9NVycM0OWmd8GOOYvb1wZoUrUeeFmgpiMe
         NuqxECURwvUvyDAOwqsaq+ZvyzghBbbAN3yNuAoMS9+jL+oA71lu98zoOiWM7EBUcLF+
         qeDLr0q+OhWUcOjdMZQBh4GrX2TkVIANELzc7iGK4KSnarBuevrZQFDujZzTAvE+i53x
         az5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GPqMGxfM;
       spf=pass (google.com: domain of jason.vas.dias@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jason.vas.dias@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=GPqMGxfM;
       spf=pass (google.com: domain of jason.vas.dias@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=jason.vas.dias@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZp1G50+uJpqVqlhrTB+P61w93Jc5xGuERCiuUB1zRcxD9AWEBAhqMyEx74U5kkMNLFcGnXOt0YkOu752dRzizw=
MIME-Version: 1.0
In-Reply-To: <4502a7e5-930f-15b6-fbef-929df29d5ef0@infradead.org>
References: <CAKi4VA+1krn9rdBWE69DkhNZSrxJoeYzyPgvn-SUk8U0=CxFkw@mail.gmail.com>
 <54EB4C83.2000500@suse.cz> <CAKi4VAJwvtLaF1GTw1dg__CXHGjwOwJqUS=g5B0rbPNp1w8dDg@mail.gmail.com>
 <4502a7e5-930f-15b6-fbef-929df29d5ef0@infradead.org>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Thu, 10 May 2018 12:03:01 +0000
Message-ID: <CALyZvKzDYUFxbkZW=zVP6Z5KV3QQGJaZb6uW35qkZRV2xYUzJg@mail.gmail.com>
Subject: Re: Differences between builtins and modules
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>, Harish Jenny K N <harish_kandiga@mentor.com>,
	linux-modules <linux-modules@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
	greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1493908198172541119?=
X-GMAIL-MSGID: =?utf-8?q?1600078513973592061?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry I didn't see this mail until now - RE:

Randy Dunlap <rdunlap@infradead.org> wrote:
> Would someone please answer/reply to this (related) kernel bugzilla entry:
> https://bugzilla.kernel.org/show_bug.cgi?id=118661

Yes, I raised this bug because I think modinfo should return 0 exit status
if a requested module is built-in, not just when it has been loaded, like
this modified version does:
$ modinfo snd
modinfo: ERROR: Module snd not found.
built-in: snd
$ echo $?
0

What was the query about the Bug 118661 that needs to be answered ?
I don't see any query on the bug report - just a comment from someone
who also agrees modinfo should return OK for a built-in module .

Glad to hear someone is finally considering fixing modinfo to report
status of built-in modules - with only a 2 year response time.

Thanks & Best Regards,
Jason
