Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518101135; cv=none;
        d=google.com; s=arc-20160816;
        b=IIFm5OXHbQeqzeMQqND8iYuSVQ9XKYY+tM+8AqV16XlyqUSfCbEFcbEeYHGUpBs7zg
         mZ1paaeS7qtrMMw5gN5DUzrag0gCV2TtdPikGlQP6WouU+So1iXMgWJnGMdgBNnul4pY
         jys0yKwQBd98Q6OF/DwTTCFKRjeUz8i4ZArYxNh2pXMwDjuGFsS/EaLcz/jZXW1gQOOy
         oR2ceXE32BAx1q/BAmEKAOyjn8XyslImWYfxiLhZCImYVw4TSymHUrpMraXaOpMQAv1k
         EcN8y+DqqGJFe6xsh9yA3GcZfPhp1UKuuqpS8nEGem6OYCdswYYFQ+46gg/AMz3zfmj3
         llhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=B9Dtw1vz+AZ93miUCPoG8uEIc4Alxj9HVBWQYCpgFEg=;
        b=WRjHg5MItm//OCPZtfu7LKv/m05pJkxMUTKG7e+LAhyR7QhxotZqkUsVsOiTL/x9ei
         2C+dOhYA08VSvwpGdjOJOunu+x4HNFWy9reQZoDjnabIY2EjxsQp59Qf5vJt1X6BHQle
         ELdea/JxOVE5O2J1hAGp6/wmW/SoLukBKRBuGQJDcIhA8te5sww0QFVs23/85NeDHHCv
         8q/6OMKCYDv912m4FMbiVIRI9C09bV8GRW+sgCY1rjKA/6sTTnCOpOSOt+l7ZzSUOoa8
         hFEZXT4IkCdX/CQKDgcjEwY62CFpitsw6C6iQC+ehfiknJWHHWNC8QCOY+3DXoQy4ldR
         TbMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=jswsOkJ2;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=jswsOkJ2;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x225AAGIXjYLMq312ONTTvpv47GouIbcA7BgriGxUd3HkZXVzJ7flgd8RZdcSK9KeoIBUDX6eqMyGEZVGmEvERPk=
MIME-Version: 1.0
In-Reply-To: <82b1f083-7df6-9c9f-e0a3-1cfc4a70a765@huawei.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
 <1517598363.7489.126.camel@perches.com> <82b1f083-7df6-9c9f-e0a3-1cfc4a70a765@huawei.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:44:54 +0100
Message-ID: <CAOFm3uHSpL6XMm4ZtBrNUrUVMFwrsbD8PQReqY5V-Ja8kJ3kaQ@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>,
	Kate Stewart <kstewart@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591844416387110417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 3, 2018 at 2:41 PM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>
>
> On 02/02/18 21:06, Joe Perches wrote:
>> On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
>>> On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com> wrote:
>>>> On 02/02/18 17:40, Rob Herring wrote:
>>>>> Add SPDX license tag check based on the rules defined in
>>>>
>>>> Shouldn't it also check that the license is compatible?
>>>>
>>>
>>> Perhaps we shouldn't try to script legal advice.
>>
>> True.
>>
>> I believe what was meant was that the
>> entry was a valid SPDX License entry
>> that already exists as a specific file
>> in the LICENSES/ path.
>
> I expect that there is a finite number of compatible licenses.
> Maybe I'm too optimistic about what can be taken as legal advice or not,
> but I would expect that a warning about unmatched license type does not
> constitute legal advice.
>
> Is it too optimistic? :-D

That's very reasonable IMHO and this not legal advice alright to me.
This would be just a tool that warns you that your license expression
does not match known licenses in the kernel.

-- 
Cordially
Philippe Ombredanne
