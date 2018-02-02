Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AH8x226nC0UIn/o49/IP64ZrKHF+NX8ai/Ua/ucIt5egv4Yf6mFXTFO26NshW4knvWOTEDCyTHkt
ARC-Seal: i=1; a=rsa-sha256; t=1517605101; cv=none;
        d=google.com; s=arc-20160816;
        b=jhZN4gD3nOjD547cAqyaMiCHSG+BBKFUOgWmVGjPrYUzGv0bo9FZmZSvN7j2CR65ms
         hMUPOUvd5wdAVuX+VzGVPJmGfGxgL6QGWqZZtASeWIs7UY2AGIsgbxLtEhCDFffx/6RK
         PiuFD4gc4OZF3r7Lyest1syhn5ug8wq8Zbg1UYvLRmK21RtCvwC0JaYR6NStMEKRRJ9q
         KnFlqMj6taxpwxeGdfwmqDR95no8Cbpszn+6ytCLkwsF+bqWjBRbAyFz7yj2V4XMBl/o
         9Rr1uDCxNu8Atyw2n8Z4WEWMoisvKnEvU4TiZS3EMGdeM9jYfoIHloWfFEuCjmlThfaq
         YupQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=uOU4TcpIjr+eJ/UJid05WZ0YwSwwvbml483Xrc6G6SY=;
        b=zKgTE2Tl7IT4b+Q/X4UPDKmtmxG3m8ZaJCdA5bin/YAv8+6lq2Il5KqZ2bYLVESYuO
         UCpvFA0E9jMF5cmlaZdhayoCrfHgPlOE0dm48q+i59MuW6JAMSzU2fjenuZc/rWIIjWO
         /24rQ7xogK66o9dhcQCVfAlzXy3pzGcRCVNdxxQx1L6aDJcrAWEFPuCzHa4m4cAtv0hm
         X0xZ1tHVBaAqjaQIT0qzWppj6P5tih+MKARZIsk/NgA2YAK56A6+l+hfeI669/yiiv7+
         /kgwWD9y0Cc1SzhgcYBliV4ONGHV9AgCb6LfSxj/PCFtcmzbzwftWlq/5flDVg5eEg43
         nd/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3027A217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <1517598363.7489.126.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com> <1517598363.7489.126.camel@perches.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 2 Feb 2018 14:57:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDgNrpfhg_5bL0VywJ9zFLbO+aCJsCKow9YPSJnB8huw@mail.gmail.com>
Message-ID: <CAL_JsqJDgNrpfhg_5bL0VywJ9zFLbO+aCJsCKow9YPSJnB8huw@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>
Cc: Igor Stoppa <igor.stoppa@huawei.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591324287377967816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
>> On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>> > On 02/02/18 17:40, Rob Herring wrote:
>> > > Add SPDX license tag check based on the rules defined in
>> >
>> > Shouldn't it also check that the license is compatible?
>> >
>>
>> Perhaps we shouldn't try to script legal advice.
>
> True.
>
> I believe what was meant was that the
> entry was a valid SPDX License entry
> that already exists as a specific file
> in the LICENSES/ path.
>
> So that entry must be some combination of:
>
> $ git ls-files LICENSES/ | cut -f3- -d'/' | sort
> BSD-2-Clause
> BSD-3-Clause
> BSD-3-Clause-Clear
> GPL-1.0
> GPL-2.0
> LGPL-2.0
> LGPL-2.1
> Linux-syscall-note
> MIT
> MPL-1.1
>
> From my perspective, it'd be better if the
> various + uses had their own individual
> license files in the LICENSES/ path.
>
> Right now, there are many missing licenses
> that are already used by various existing
> SPDX-License-Identifier: entries.
>
>
> APACHE-2.0

Given that Apache 2.0 is not compatible with GPL 2, that would pretty
much mean anything with Apache license is dual licensed and it would
be the other license that applies. Do we really want/need license
texts for all the other possible licenses that don't apply to kernel
files? If so, this should all just be scripted to sync LICENSES/ with
found SPDX tags in the kernel.

> BSD
> CDDL
> CDDL-1.0
> ISC
> GPL-1.0+
> GPL-2.0+
> LGPL-2.1+
> OpenSSL

ISC and OpenSSL are only in license-rules.rst as examples. We should
just fix those examples to something else.

Rob
