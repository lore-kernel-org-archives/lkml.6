Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523407910; cv=none;
        d=google.com; s=arc-20160816;
        b=d/uFqJCHX7y4Bz912u0CHXXnsPUtFTlLyCeUkeEC2Q85aRD2dyy38sacHH+V6TywGU
         nwBUDfOGfJvZ/8cZzPEufJ/NFJSYL1xrtIDLoPhZb5+N3SmUb6LoF5uxcafXJuP0451j
         GaxV/v+9ZQgsU2V5QGTzh5/Zs0ToetQKbPbw/dQ0fEnQX3gZAz5mRfZNlPVdIgjc1G3n
         OGPv3giN9Ko81eQjN/R2vS5PCkNFaHEkiiu8b3kNK2votxmPYcLc/P9Tg5U+eP71BZzk
         m4P2PKWYMTgRvfufJLW+wZgM63udw19+qZCE2UcsRF4+qx1hxirFzga8FbPTZFi//eUS
         AnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=vsmjpZvDXCQgBAfMZyuXvRWHzersY5XBB7+V/qHPPE4=;
        b=cjA11j2g+4mkIyoYC3SGcEUBAhcgM+DIPVmzfrWxuIMLPP983Ou8w0U2GlI1TlRGgf
         SWoV5/hnRKDEOe4n2Qbb3zXoHi4RrhNZtZ6tN7s8YUt6whVcSXDame38dCJgJpzl7GUy
         OITtHfBY36PwWtDtGrntJ5aM9uadeVJYnUwq7APPdjsILHHn/9hM+UPfbou2H/6IBDgj
         rYRta3y/howdFkiQc49hB70aenEg+MN2tWfje3ZmbsNgSd3+MJIVoeBTCWskG0y1YMFq
         TQK0y5xAGJU1tqDtCEg1+uuz+82ZmffUD4JJocDt0iEb484kAvifp33EPJko3MeEMZuM
         aOjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sTc5Nga4;
       dkim=pass header.i=@chromium.org header.s=google header.b=LwV/UMdw;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=sTc5Nga4;
       dkim=pass header.i=@chromium.org header.s=google header.b=LwV/UMdw;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx4/g+GyR8YZXzRfH+HBjpyMWuTOurIu8PEaiYsV/mIEo1IMjKpiZOhvPAFBmCgUiYI0D8p/nYyPwou2UWtl7vjc=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180411003331.GM30522@ZenIV.linux.org.uk>
References: <20180410234532.185426-1-ksspiers@google.com> <20180411003331.GM30522@ZenIV.linux.org.uk>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Apr 2018 17:51:48 -0700
X-Google-Sender-Auth: HRPSWRtWsJFdAzKW2RrIIWHBxEk
Message-ID: <CAGXu5jJBqiXZzvRaoXRVuxFckaFJq+LfM227t2uXF3vhwE7WPg@mail.gmail.com>
Subject: Re: [PATCH v3] isofs compress: Remove VLA usage
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Kyle Spiers <ksspiers@google.com>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
	David Howells <dhowells@redhat.com>, Greg KH <gregkh@linuxfoundation.org>,
	Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597404821961766971?=
X-GMAIL-MSGID: =?utf-8?q?1597408972599047488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 10, 2018 at 5:33 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, Apr 10, 2018 at 04:45:32PM -0700, Kyle Spiers wrote:
>> As part of the effort to remove VLAs from the kernel[1], this changes
>> the allocation of the bhs and pages arrays from being on the stack to being
>> kcalloc()ed. This also allows for the removal of the explicit zeroing
>> of bhs.
>>
>> https://lkml.org/lkml/2018/3/7/621
>
> Do you even bother reading the feedback given to such patches?  I'm just
> curious,

He made a tool mistake (sent v2 again) -- please see v4.

-Kees

-- 
Kees Cook
Pixel Security
