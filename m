Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AH8x2259ETf+yiZPjI8Y8qlfcxdWoQOtO3nIRzAVP9JJ599lEOZpHTNQpN+FgYWRLVIjOPtGbTqN
ARC-Seal: i=1; a=rsa-sha256; t=1517596060; cv=none;
        d=google.com; s=arc-20160816;
        b=ZUwtj7SpAWZCVIcb8LFth8zCWM3f5VSR5auFzLYS7D6x+3GpCLAMyXaMIO2CjHUFGe
         4mGAzB/BYMsEmpOxZUC7b60UHc/goJIcZg75tuHOI55t572Hb8twjM8ObdcRACXuEpMy
         KqgJsJ5alzs2t0LNrd5DZg1hL81DrRxZ/FkhktWBUphOND9trVkXhgr2kBt4r0xlsPev
         5xmEFRLPCx7p8kUNO8geSeLnAc6vbAl6tKiPT8xlq3UccPBBO0I14Mm17BNPDpO6uVl1
         LrUOngEmdA2CFiq8j1tR+/u/XqJkNOluQNPmbdm/HTLkGT6lpzVq8gEsAtj6pbP15Ufk
         ojsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=QaK8AtBDhFl5XS5myjlHN1plf/c7C1+9qBB34eO4txo=;
        b=SLk4jrBpKC+Do2kPNW3z+PbZ25QQn2jv8dKHBdvbseVVV4Uzfj0eBF1c2RCWyMGELl
         lVNrjUao57k3+lJa5NvI8//0n3ydqIO4cvX3j+wjcMuQRjFwADhgvyuYASnQfolquCOe
         6I4fkGVbzH1SgwhpeZmhC9M+xW3ETvyuHhnh6az3eQerv6XbtZFhog/XpJwmrIm3KCs6
         lQRPDc+ITPraAMWx5MkCPGRrQwvJkM/YRzr3b5+XNPM5fZtTY2stdkCpy8qYDnp9uSGx
         pPjXrmxfrueyjueram4F9djGF0g7fZNYKdbk408fFACBE3T1lOTjUncfa7YPe0Bj507n
         fAzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08D6C217A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 2 Feb 2018 12:27:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
Message-ID: <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>,
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591314806641367659?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
> On 02/02/18 17:40, Rob Herring wrote:
>> Add SPDX license tag check based on the rules defined in
>
> Shouldn't it also check that the license is compatible?
>

Perhaps we shouldn't try to script legal advice.

> [...]
>
>> +                             } elsif ($realfile =~ /\.rst$/) {
>> +                                     $comment = '..';
>
> What is the correct/acceptable license for documentation?
> Creative Commons? AFAIK GPL is for source code.

At least for the DT bindings, we probably want those to be Apache v2
because that's what the DT spec is. But that really only matters on
the common bindings. But then are device specific bindings derived
from those? And we have include/dt-bindings/ which are part of binding
definition/doc and those get used in dts (GPL, MIT or BSD) and source
files. In summary, it's complicated...

Rob
