Return-Path: <kernel-hardening-return-12220-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtHOOQeVDsXdP5FjntV0tf5VdQ+P7fS2qXu/xvQWe6YSb1xajlI33GmCD4yb9UGuQcI5zkB
ARC-Seal: i=1; a=rsa-sha256; t=1520467029; cv=none;
        d=google.com; s=arc-20160816;
        b=wr0MZAkHmGNsW4v6dFMt+3F3joQvcanjKP3rxJcRpO37Ls9Re1ASTzekd5/lquLZW4
         FtNtQ1lS28YT5JiRRyVsuP1S+2AMyKGzfn6yblqHr5nnRgXLvbjTozhHMvmk/f6mOz9s
         30lfhLvkxPDuLkeGD6UsgvD243GEdjLGz/yDFo9rf2va8YFzzRe9LGC9rfAUGusNdOi9
         qpVTMnRHldNKPye7Z77+N3+HWOnkLToMCUhtCh5Kp8VfNkFWWwCWEGe4ZooaMjnkrUxN
         +lLRTfJCpd/f+Fm6zcIPGeZgjh/V1XmN5TCY1UiehsJj2UNWQ/9IPKLOyit32VVEloko
         3joA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=0O5pD0MUPSf76IR/I3oVC3iYtPncWQayOFSkjL26LA8=;
        b=sPl35INdmVEw1YguZgJmdRJyXgtgCKNtdj1DwMBoeS0pNfeazjSWQoJzMi/QAMqG5e
         8HSs0I/oCZ4MUpk5VvqFZj0V5ZrY5ty7RpNZCZ8fIY9uMMukUa0med5SGTet9jTby0XF
         ruZOzPKcmWE+wEk5+DrX6NJnpjKw8FbMIwObq7A3E9S8wB8tc3b9lkHrQo7tIyULDuD1
         GkL0C/w96S8X5LzgB0e5bt6h0vhckD1VcXcmpi1G139lzyx1dhn08aE7+N152VrfBq0W
         aKQ2hg3vV3N6wujyr8E8MAa3FlbPMlmfCmO+CY00B3t95UWbV8U+PBlL+kDL9j+pxdNe
         SzGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=PoKjuguC;
       dkim=pass header.i=@chromium.org header.s=google header.b=JJ1QzILA;
       spf=pass (google.com: domain of kernel-hardening-return-12220-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12220-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=PoKjuguC;
       dkim=pass header.i=@chromium.org header.s=google header.b=JJ1QzILA;
       spf=pass (google.com: domain of kernel-hardening-return-12220-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12220-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180307154019.e39890b5f8aa98cf25532cf1@linux-foundation.org>
References: <20180307230714.GA20797@beast> <20180307154019.e39890b5f8aa98cf25532cf1@linux-foundation.org>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 7 Mar 2018 15:56:50 -0800
X-Google-Sender-Auth: pzkJtep578FenoJcyTIzKMQQupA
Message-ID: <CAGXu5jJofYYFiKEbNsU+g11x38JFsPg30AHJbH3hArAgr3PBVA@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: Remove accidental VLA usage
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
	Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
	"Steven Rostedt (VMware)" <rostedt@goodmis.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594322119542311159?=
X-GMAIL-MSGID: =?utf-8?q?1594325236310185966?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 7, 2018 at 3:40 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 7 Mar 2018 15:07:14 -0800 Kees Cook <keescook@chromium.org> wrote:
>
>> The "sym" calculation is actually a fixed size, but since the max()
>> macro uses some extensive tricks for safety, it ends up looking like a
>> variable size. This replaces max() with a simple max macro which is
>> sufficient for the calculation of the array size.
>>
>> Seen with -Wvla. Fixed as part of the directive to remove all VLAs from
>> the kernel: https://lkml.org/lkml/2018/3/7/621
>>
>> ...
>>
>> --- a/lib/vsprintf.c
>> +++ b/lib/vsprintf.c
>> @@ -744,8 +744,9 @@ char *resource_string(char *buf, char *end, struct resource *res,
>>  #define FLAG_BUF_SIZE                (2 * sizeof(res->flags))
>>  #define DECODED_BUF_SIZE     sizeof("[mem - 64bit pref window disabled]")
>>  #define RAW_BUF_SIZE         sizeof("[mem - flags 0x]")
>> -     char sym[max(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
>> -                  2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
>> +#define SIMPLE_MAX(x, y)     ((x) > (y) ? (x) : (y))
>> +     char sym[SIMPLE_MAX(2*RSRC_BUF_SIZE + DECODED_BUF_SIZE,
>> +                         2*RSRC_BUF_SIZE + FLAG_BUF_SIZE + RAW_BUF_SIZE)];
>>
>>       char *p = sym, *pend = sym + sizeof(sym);
>>       int decode = (fmt[0] == 'R') ? 1 : 0;
>
> A year from now I'll be receiving an email titled
>
>         [patch] lib/vsprintf.c: use standard max() macro
>
> won't I?

Hopefully a year from now we'll have added -Wvla to the global build
flags and no one will be able to try that. :)

-Kees

-- 
Kees Cook
Pixel Security
