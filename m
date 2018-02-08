Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518113415; cv=none;
        d=google.com; s=arc-20160816;
        b=rt/Fb1MQp8v4oIq/KPtYzzgG6k+NOoQZqKfalBHczevJRXBdgSeKMh8Bbrdl4depcL
         ZM7nWVL4t5ACJCI8HXnvluuz++FHWk3kiLJ4trZmCV4ckLzX/mX4wA0PmlH22xOUshvl
         pBU66/CkgmYEJo+ouCZgiy3fcMVd91tc0DcjT8IU6IsjrsWObkETdempyvHOJgwtjEvm
         CYP5OBMNFzs0XEg55y4oMdwq0Sk2PbseZAPPl9xcDERo7v0FljRoDbjDfcSAFHeW4hBe
         B0M9UwawnpDTkqfFuoea+KpkC/GzkYr5faTBtLWVABQWzxjKrjtylyKllqm4Dm5jAYCi
         V+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=C89txlKlvLlhQ8ZurXO7+V+z7CSml6UIRJw4TirbMuw=;
        b=sj9Sql7IAk/6VW/y96fuZK1SauWCoqdvzKlifDRDX/o8gdNkYFRW4/wYcCHjmRKdmr
         Wfmjwmo+0izThaLSCi8taUGQkwXAz5gnERyrkMEjd9eFkQgncnlvqOrn25eQAdyHytgA
         uOn7bHBNyzXM5Jue6s0y04VP14LgiLAyJBuqiqXEiyNzGrqEynN/+T+WFESYcn0xEK1Q
         8enIJOvJjDYUnphrHVEa+miudT0/Ld3Z4ZeXiecs4o7TSENZ0M87Jyplu88zPPsn6uFD
         FTMapL0rWubmnc9+YkWFf4YRu6OfWeaU7MWc1W5IsUsLxXF0plBxALKkFnHnARW1wvPm
         tUUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=0CY5ajD5;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=0CY5ajD5;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x227zPjSnqJGABhI1Ol9PtD5Im1CmnRIZaliI24r/xVKd2uODKZn4vunXF8Lebo1Kjl4VtOXJX7pX/lG2+rzpKLY=
MIME-Version: 1.0
In-Reply-To: <1518110653.14196.25.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com>
 <1517598363.7489.126.camel@perches.com> <CAOFm3uHNvGOh_ErxpG9VeHwMzHGvdoN5Xx_JSN8y+QhB32ivmw@mail.gmail.com>
 <1518110653.14196.25.camel@perches.com>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 19:09:34 +0100
Message-ID: <CAOFm3uGEfdOm=5ebA=uxX3zeH1c_VdKCaeEpBZaSrfrHzrG1_A@mail.gmail.com>
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
X-GMAIL-MSGID: =?utf-8?q?1591857292846365783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Joe,

On Thu, Feb 8, 2018 at 6:24 PM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2018-02-08 at 15:35 +0100, Philippe Ombredanne wrote:
>> However checking that licenses ids are known and listed in the kernel
>> doc is essential IMHO to avoid drift and insulate the kernel from SPDX
>> updates. Case in point  the new SPDX "GPL-2.0-only" is NOT what was
>> documented by tglx and therefore should not be used and banned until
>> we update the doc accordingly. and until we update ALL the GPL-2.0 to
>> GPL-2.0-only eventually which is best done at once.
>
> Agree and I've attached what I believe to be a
> reasonable script for that conversion only after
> LICENSE directories are updated with the
> appropriate and license files and after
> Documentation/process/license-rules.rst is modified.

Excellent and clean!

>> Otherwise, this is
>> going to be a total mess on top of a complicated topic that requires
>> quite a bit of maintainer energy!
>
> There will always be some energy requirement and
> no doubt some legal advice involvement too.
>
> In another vein:
>
> The existing license files in spdx.org seem
> somewhat sloppily edited and perhaps have less
> clarity and precision than desired.
>
> For instance:
>
> If the newer SPDX descriptor "GPL-2.0-only" is to
> be used, why does this license URL:
>
> https://spdx.org/licenses/GPL-2.0-only.html
>
> still contain the phrase ", or (at your option) any later version".
>
> The current diff between GPL-2.0-only and GPL-2.0-or-later:
>
> $ wget -q https://spdx.org/licenses/GPL-2.0-only.html
> $ wget -q https://spdx.org/licenses/GPL-2.0-or-later.html
> $ diff -U0 GPL-2.0-only.html GPL-2.0-or-later.html
> --- GPL-2.0-only.html   2017-12-28 12:17:20.000000000 -0800
> +++ GPL-2.0-or-later.html       2017-12-28 12:17:22.000000000 -0800
> @@ -15 +15 @@
> -    <title>GNU General Public License v2.0 only | Software Package Data Exchange (SPDX)</title>
> +    <title>GNU General Public License v2.0 or later | Software Package Data Exchange (SPDX)</title>
> @@ -141 +141 @@
> -      <h1 property="dc:title">GNU General Public License v2.0 only</h1>
> +      <h1 property="dc:title">GNU General Public License v2.0 or later</h1>
> @@ -144 +144 @@
> -          <p style="margin-left: 20px;"><code property="spdx:name">GNU General Public License v2.0 only</code></p>
> +          <p style="margin-left: 20px;"><code property="spdx:name">GNU General Public License v2.0 or later</code></p>
> @@ -147 +147 @@
> -          <p style="margin-left: 20px;"><code property="spdx:licenseId">GPL-2.0-only</code></p>
> +          <p style="margin-left: 20px;"><code property="spdx:licenseId">GPL-2.0-or-later</code></p>
> @@ -160 +160 @@
> -          <p style="margin-left: 20px;">This license was released: June 1991 This refers to when this GPL 2.0 only is being used (as opposed to GPLv2 or later).</p>
> +          <p style="margin-left: 20px;">This license was released: June 1991</p>
> @@ -679 +679,2 @@
> -        as published by the Free Software Foundation; version 2.
> +       as published by the Free Software Foundation; version 2
> +       or any later version.
>
>
> I am not a lawyer, this is not legal advice, etc... but:
>
> The "1991 This" use in the -only file seems be missing
> a period.
>
> In any case it is awkwardly phrased as "or later" perhaps
> should not be referenced at all.
>
> The GPL 2.0 license as published by the Free Software
> Foundation includes the option for using later versions.
>
> Perhaps the SPDX -only licenses should be more specific
> when it uses the phrase "as published by the Free
> Software Foundation; version <n>." to specifically
> exclude the option of any later version.

Good points and this is why we have and need to use the kernel doc as
the stable reference IMHO.

FWIW, I have raised a ticket with SPDX [2] so that the issue you have
found can be properly fixed there.  Also, I think this  (the new -only
license ids that I think we should not yet use) has been reviewed in
details by the SPDX legal group and by the FSF. At least rms posted an
article about it last December [2] ?

[1] https://github.com/spdx/license-list-XML/issues/610
[2] https://web.archive.org/web/20171221220428/https://www.gnu.org/licenses/identify-licenses-clearly.html

-- 
Cordially
Philippe Ombredanne
