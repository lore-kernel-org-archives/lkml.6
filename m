Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518100558; cv=none;
        d=google.com; s=arc-20160816;
        b=Yrs23gY64fwmvhwidxUH1iD/QTNAkHNgolpV51zU2KCAwfqOA2P0kfx82/CdzOpRh3
         2RZYj/s/aw7vNErsWeaLU6laXKo6ZIqplk1IvUwHOdVd88O4xrSGa8+enwh/RrrnE4ae
         5AfIupFCgnOXVn5wW+Oea1+L3/VC89XaKFG0KgrUARpSZdKNztbCcp7sU//GbHA3rCqL
         EFQgM6nANOEpFa9NOl9NHCdYmeL576YcpIj/yVgGdxbidCi2FM4G9hqOo+B1XyNOsRle
         O1dwOjEowO6zWmGYoTILHYnRrtSIljMCIrxSP9+lUJDwBRTWFV/Lo12raNhQuS71lYMN
         yFWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=TzkEVKKhhUBxOAGJIOzoVQW3nmkKx/GVwqhcYsIvdQ0=;
        b=ZQ+bw19liBuy72b/xSov+b8mapdKszsV6POM/59C5GUzgeaGI4zDo76lthJcg1D9JY
         riZ950sBUsZEGA1orA3b6Y8TEbbKQPylJPynO04A7f3BtpYNdzq4itubhoQhZB+lJuKd
         70vTClYu8uDY9wptl5UUlMXuXtuou7evoTVBxyWuxOE5AdAqVgSbprc/5uSjw+zdsQYq
         49cD5paNmAN16obBAI/WahXMpvPAusbzgdunx0o0ioq9M59qozxTmfa5HGYw0BkojJva
         xbz1qoBomucTNbb+vNW9ee+xwhRzjo4tX+znQfI2okx7ITQ0lVVIZhM5k75Jdd4LvEDo
         phPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=J4Y1on0r;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=J4Y1on0r;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x225u3MnPnEZ3tFcP6iV3p9faF2T8KCDAqgHoD41kV4fF9eTftXw7oZi/rXmF/aBSUOMZGio1J7tnPqUpwhQ8yb0=
MIME-Version: 1.0
In-Reply-To: <1517598363.7489.126.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com> <1517598363.7489.126.camel@perches.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:35:17 +0100
Message-ID: <CAOFm3uHNvGOh_ErxpG9VeHwMzHGvdoN5Xx_JSN8y+QhB32ivmw@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591843810770994666?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 even
On Fri, Feb 2, 2018 at 8:06 PM, Joe Perches <joe@perches.com> wrote:
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
> BSD
> CDDL
> CDDL-1.0
> ISC
> GPL-1.0+
> GPL-2.0+
> LGPL-2.1+
> OpenSSL
>
> There are odd entries like:
>
> GPL-2.0-only
>
> Parentheses around AND/OR aren't consistent.

Joe,
I have a comprehensive license expressions checker/parser [1] in
Python ;) if it is ever needed, but that's likely overkill for the
kernel. (this is not in Perl for one thing and second it is based on a
boolean expression parser and minimizer, hence overkill for the
limited kernel use case IMHO)

However checking that licenses ids are known and listed in the kernel
doc is essential IMHO to avoid drift and insulate the kernel from SPDX
updates. Case in point  the new SPDX "GPL-2.0-only" is NOT what was
documented by tglx and therefore should not be used and banned until
we update the doc accordingly. and until we update ALL the GPL-2.0 to
GPL-2.0-only eventually which is best done at once. Otherwise, this is
going to be a total mess on top of a complicated topic that requires
quite a bit of maintainer energy!


[1] https://github.com/nexB/license-expression/
-- 
Cordially
Philippe Ombredanne
