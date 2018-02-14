Return-Path: <kernel-hardening-return-11759-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x22524Mao1BkDK4ihgonaEw61FbPyH+dAVEemIQXyE/4ZFfJpnGZtaQFcbjjNNINepP0P+zT/
ARC-Seal: i=1; a=rsa-sha256; t=1518636246; cv=none;
        d=google.com; s=arc-20160816;
        b=lzED/qYK0LsbsEyXpqWq/Z/QilMnVpFxEnDggqyoOHNfgjnE4c3AthgoRmQUEDIL7M
         IkiaGXkCu+JdNg9D6GO8Gg7n3G4MxxCWDanctSdP5N/WOaCDshjtrLLrJhzDmVGvtUXT
         9VL41QF+UAZbcQTgKEobAVNqrt7Usd9RkrR91k2VFxqrxLgFWfAvfqAglkg4ZFS8pDvU
         x0cdtQtzAxXmfgSh0JlyU4q0sOEOn/itAVq4UrrypPsX7KjjU7GJMNHyG8g/gNQjc2M3
         M61hxH7qwfjCzos1ANqbX+gwIx8VMNISg2ltxEcVPvCHXN8ZPO7UsWxz8FUcxO2ydXcx
         KaLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=IgulanZDsEA99FfN8NEA0YXsuDnNUPM5WDLk6Gy6yjQ=;
        b=A02Wh8vJWut6VVd7BDJP0Fc+jxmm+BYGR7JmCtcEtFUY/MNX7f+JwvVb84mIW0owow
         I6aaruMahgN4OeAo8JU7Ea/u3pImc0gTUU7seMsuAettYv39w/B94QSlDgKmuNwCuqMC
         NmAKKDnSWGPL7Fuin/SEcFccvulufZoQq7GZ1M2fVhqLyxWm9yk3EKzfRHed+4ICPr0G
         rjtrnjgcoPYO0x28zmOHwwfKVspJ5oNqHJVhDxyPuZWcEgGVydex5CRVa6CqxQAFplmy
         MpGFrCiAlr0vigcQ/aUNDYtItdaQg6UV85ejqHpSieKivhcq0IY9D0GA+uwx8xvZWHaL
         143A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Pj6ycxKa;
       dkim=pass header.i=@chromium.org header.s=google header.b=PaEoTkzy;
       spf=pass (google.com: domain of kernel-hardening-return-11759-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11759-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Pj6ycxKa;
       dkim=pass header.i=@chromium.org header.s=google header.b=PaEoTkzy;
       spf=pass (google.com: domain of kernel-hardening-return-11759-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11759-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <1518634058.3678.15.camel@perches.com>
References: <20180214182618.14627-1-willy@infradead.org> <1518634058.3678.15.camel@perches.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 14 Feb 2018 11:23:47 -0800
X-Google-Sender-Auth: -UfuC153PMumUmvNOZQDodlAo1k
Message-ID: <CAGXu5jJdAJt3HK7FgaCyPRbXeFV-hJOrPodNnOkx=kCvSieK3w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Add kvzalloc_struct to complement kvzalloc_array
To: Joe Perches <joe@perches.com>
Cc: Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <mawilcox@microsoft.com>, Linux-MM <linux-mm@kvack.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592401947833736714?=
X-GMAIL-MSGID: =?utf-8?q?1592405520777170692?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 10:47 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-02-14 at 10:26 -0800, Matthew Wilcox wrote:
>> From: Matthew Wilcox <mawilcox@microsoft.com>
>>
>> We all know the perils of multiplying a value provided from userspace
>> by a constant and then allocating the resulting number of bytes.  That's
>> why we have kvmalloc_array(), so we don't have to think about it.
>> This solves the same problem when we embed one of these arrays in a
>> struct like this:
>>
>> struct {
>>       int n;
>>       unsigned long array[];
>> };
>
> I think expanding the number of allocation functions
> is not necessary.

I think removing common mispatterns in favor of overflow-protected
allocation functions makes sense.

-Kees

-- 
Kees Cook
Pixel Security
