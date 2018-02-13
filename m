Return-Path: <kernel-hardening-return-11747-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AH8x2244ksCa/YgLCxRJYpEo6q7j1AMj9frAR+P76KWyeDQ2TuXtS4cnVWVLdsLW4WmwfNVVbIE0
ARC-Seal: i=1; a=rsa-sha256; t=1518535592; cv=none;
        d=google.com; s=arc-20160816;
        b=YgiD81R0LQDMprxBKAegNgCw+z8+FlDEOtjyfLq27sUxweu2vvRlQdx2HNZJaFDpwX
         oQ5TTTy+59W7yAQS1X1Rgj9KUZ1dQ1vsC5uN4HY2BnGdta+6PSvWmH/b3mMKJTfrwWJV
         0+p/uaV97CwpWccI4SwKvEJoNWEOeD6CmwU2svbGwe5/OxcTqC0YnorXL7n04BO1Wf75
         T6P5hYKAd36KDjVHsGrOEL5o1vq16f6Bs6U+BaXJA8ZtYl6vYTUn19jM5SYcV6QDmY9o
         L60Uea6Kq6Mn6DCwOYGEFydHc+Jl2EE765eq9pzMuJLPZoaOMO0jEu64Z+lNVQpVzKjl
         nh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=PwIznnRjvwdsoryDXaE25hSzTWnOY5L48Lx7rDC2rsA=;
        b=D9lCNXk3Y/K75KZa57nkxsG1kLKOP5tFbPQHHuYQqLuF/Rbqc71pDpjJbPr50O/FX3
         eMu/WMmS63oK8KdSPUXFk/30mteTRvHXo7jvV+qiVFVcTCKwidt7TteIRp9v0HDARHld
         QcFdvuw8Hzn6shuhK7f1LUALkvozNIr+tGxN0GyAeqnbizyWAiYXToRIQMmaymYDvhmo
         XxN4wS89xn3DjzTPGhLTVFpitV+F2MuKDA4G9fZoPk6Yvo0oOWfZpyiJQJowoBQM1rzd
         FgLHFxvEoUPv9/ifkIh4hssMZqU/2zbxU2fyZE0fx3P4+5SfOuMw3Sh8uvnaNYZiBRcw
         F4lA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Z0QecsmK;
       dkim=pass header.i=@chromium.org header.s=google header.b=nbgZ5NpE;
       spf=pass (google.com: domain of kernel-hardening-return-11747-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11747-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Z0QecsmK;
       dkim=pass header.i=@chromium.org header.s=google header.b=nbgZ5NpE;
       spf=pass (google.com: domain of kernel-hardening-return-11747-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11747-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180213145632.GA7937@infradead.org>
References: <123377.1517765678@turing-police.cc.vt.edu> <20180213145632.GA7937@infradead.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 13 Feb 2018 07:26:09 -0800
X-Google-Sender-Auth: CMdkVosAtI_SvCFwKFo1wom8o7w
Message-ID: <CAGXu5jLtb46yFK1TRE3WBPp6grQQGbCbqGCTYJJ7dok3Kws8pg@mail.gmail.com>
Subject: Re: [PATCH 2/2] GCC release 8 support for gcc-plugins
To: Christoph Hellwig <hch@infradead.org>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591490625322246882?=
X-GMAIL-MSGID: =?utf-8?q?1592299977153653556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 6:56 AM, Christoph Hellwig <hch@infradead.org> wrote:
> On Sun, Feb 04, 2018 at 12:34:38PM -0500, valdis.kletnieks@vt.edu wrote:
>> For reasons totally beyond my understanding, gcc 8 changed the
>> order of two structure member, which leads to an error:
>
> I'm a little late on this, but isn't the whole point of C99 initializers
> that field order should not matter at all?

For C99, this is true. The plugins are built differently and follow
C++ conventions, which, for reasons I cannot understand, are ordered.
:( Regardless, the fix actually results in fewer lines of code, so
this is fine.

-Kees

-- 
Kees Cook
Pixel Security
