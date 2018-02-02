Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517602684; cv=none;
        d=google.com; s=arc-20160816;
        b=lMmfke+6YHJzojNxKLJ4e8D9ICOfC5oq+4kSv28D7tp82D9vl/Is1Pw89xDvZSmdDs
         G9DUlD7+q432PxgdsefpNf1wZE7kMdn6xokiIjmbWs/xubvDrc5L4BYDNzvXlt0DNmaS
         AhvoP0Icr/Gz80oQIdIG/QmOQlvPM6/HiRB8OCXofoqUwhZmmpqj5eTSQ9y4EFLsmWkB
         oUxzNQBE/Pr0vS/LY2FxNEr4MChM1+KfPEC07Lj4Yp2lITR7rSBWMe98QKHmcBqx7at6
         5IjQosqsYkKRflx2DZkHXn0SICHWsHMy2eOwf6z4q37CWosDBnrg4DTXg7r9Uzw/j3AB
         xkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=stGfY5aQhoeR0ykzTSOiRdB10AaJmQBzpRwth2NE+Jc=;
        b=pFH3pvJrA+wkhMXy7HbcyXBnb0qi3pJ6RpvVIXW2js8wCyJPibEWFdSX7H95Ip13el
         3zF05l5dKW7nXIchMVLtrhhzlNy2h6rZrQ4BvzQcR9F6u4bZOIsR3ygtn5jBPegR3kTS
         diYhWN0NKZOcGaYj0SR2LyESaCiHO4QEHoouedbZ/NeBIKl7pY7rY+KZpz48MD6e/Lrb
         walN09BiD+Rr9L31/mN8lJSHJzzRd2OJ2Lq06b2N/ylnhOAugv8l1pbrjNK3XRjOxzxe
         hCI+5SlJel5NM6uyldrlKfP3KcimDY9PphsoiaY8KQDBNp4psDNAIiLnjdGOale4tOFo
         8PJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SdI1jUtb;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SdI1jUtb;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AH8x226URpDWH/thbXaD/pHoHqlexbQmOqyr4KcprTvY6GlfWplTMV4o781pk82jmyxTxsSwdq5wYevHLkr4yz9DSk0=
MIME-Version: 1.0
In-Reply-To: <1517598363.7489.126.camel@perches.com>
References: <20180202154026.15298-1-robh@kernel.org> <bb680231-b9ca-ee46-f088-086da0bed2c1@huawei.com>
 <CAL_JsqK+1Z_vuFE_po1VCxkSc112OFmgCiwM7F1S0mH6gw3KHQ@mail.gmail.com> <1517598363.7489.126.camel@perches.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Fri, 2 Feb 2018 14:18:02 -0600
Message-ID: <CAG_66ZT6R2Ki3AnH6RWRXpd8d64NDR2y-0BwyqJRpQD4hD01oQ@mail.gmail.com>
Subject: Re: [PATCH v6] checkpatch.pl: Add SPDX license tag check
To: Joe Perches <joe@perches.com>
Cc: Rob Herring <robh@kernel.org>, Igor Stoppa <igor.stoppa@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>
Content-Type: multipart/alternative; boundary="001a114110c8ec9601056440683b"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591304287671259020?=
X-GMAIL-MSGID: =?utf-8?q?1591321753373195233?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--001a114110c8ec9601056440683b
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <joe@perches.com> wrote:

> On Fri, 2018-02-02 at 12:27 -0600, Rob Herring wrote:
> > On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa <igor.stoppa@huawei.com>
> wrote:
> > > On 02/02/18 17:40, Rob Herring wrote:
> > > > Add SPDX license tag check based on the rules defined in
> > >
> > > Shouldn't it also check that the license is compatible?
> > >
> >
> > Perhaps we shouldn't try to script legal advice.
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

At the end of december, the SPDX license list[1] was rev'd to
Version: 3.0 28 December 2017.   At the request of
FSF, the GNU license family would not use the "+" notation,
and would bias towards using "-only" and "-or-later", explicitly.
So adding both variants to the LICENSES/ path aligns with
this forward direction.


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

This is the new way to represent GPLv2 only, as described above.
While the GPL-2.0 and GPL-2.0+ notation is still valid,  it is deprecated
in the latest version, so transitioning existing over time will probably
be needed.   So I think the list of licenses to be added to
LICENSES/ path is:

APACHE-2.0
BSD
CDDL
CDDL-1.0
ISC
GPL-1.0-only
GPL-1.0-or-later (note: actually same contents as one GPL-1.0-only)
GPL-2.0-only
GPL-2.0-or-later (same contents as GPL-2.0-only)
LGPL-2.0-only
LGPL-2.0-or-later (same contents as LGPL-2.0-only)
LGPL-2.1-only
LGPL-2.1-or-later (same contents as LGPL-2.1-only)
OpenSSL

Having files with the same contents, but different names is
irritating, but I can't see a another way of complying with REUSE
guidelines.   Any better suggestions?


> Parentheses around AND/OR aren't consistent.
>

The SPDX specification has an appendix that calls for "(",")"
around every license expresssion.   After discussion with some
developers it was decided to be ok to relax that, and only add them
when they were essential to clarify the logic.   The next rev of the
SPDX specification will have this clarified as well.   I think we caught
most of the changes in the kernel documentation patches for describing
this,  but if you have specific cases to be reviewed,  happy to have
a look.

Thanks, Kate


[1] https://spdx.org/licenses/

--001a114110c8ec9601056440683b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Fri, Feb 2, 2018 at 1:06 PM, Joe Perches <span dir=3D"ltr">&lt;<a href=
=3D"mailto:joe@perches.com" target=3D"_blank">joe@perches.com</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri, 2018-=
02-02 at 12:27 -0600, Rob Herring wrote:<br>
&gt; On Fri, Feb 2, 2018 at 9:49 AM, Igor Stoppa &lt;<a href=3D"mailto:igor=
.stoppa@huawei.com">igor.stoppa@huawei.com</a>&gt; wrote:<br>
&gt; &gt; On 02/02/18 17:40, Rob Herring wrote:<br>
&gt; &gt; &gt; Add SPDX license tag check based on the rules defined in<br>
&gt; &gt;<br>
&gt; &gt; Shouldn&#39;t it also check that the license is compatible?<br>
&gt; &gt;<br>
&gt;<br>
&gt; Perhaps we shouldn&#39;t try to script legal advice.<br>
<br>
True.<br>
<br>
I believe what was meant was that the<br>
entry was a valid SPDX License entry<br>
that already exists as a specific file<br>
in the LICENSES/ path.<br>
<br>
So that entry must be some combination of:<br>
<br>
$ git ls-files LICENSES/ | cut -f3- -d&#39;/&#39; | sort<br>
BSD-2-Clause<br>
BSD-3-Clause<br>
BSD-3-Clause-Clear<br>
GPL-1.0<br>
GPL-2.0<br>
LGPL-2.0<br>
LGPL-2.1<br>
Linux-syscall-note<br>
MIT<br>
MPL-1.1<br>
<br>
>From my perspective, it&#39;d be better if the<br>
various + uses had their own individual<br>
license files in the LICENSES/ path.<br></blockquote><div><br></div><div>At=
 the end of december, the SPDX license list[1] was rev&#39;d to</div>Versio=
n: 3.0 28 December 2017.=C2=A0 =C2=A0At the request of=C2=A0</div><div clas=
s=3D"gmail_quote">FSF, the GNU license family would not use the &quot;+&quo=
t; notation,</div><div class=3D"gmail_quote">and would bias towards using &=
quot;-only&quot; and &quot;-or-later&quot;, explicitly.</div><div class=3D"=
gmail_quote">So adding both variants to the LICENSES/ path aligns with=C2=
=A0</div><div class=3D"gmail_quote">this forward direction.</div><div class=
=3D"gmail_quote"><div><code style=3D"box-sizing:inherit;font-family:monospa=
ce,monospace;font-size:14px;color:rgb(88,89,91);background-color:rgb(247,24=
7,247)"><br></code></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Right now, there are many missing licenses<br>
that are already used by various existing<br>
SPDX-License-Identifier: entries.<br>
<br>
<br>
APACHE-2.0<br>
BSD<br>
CDDL<br>
CDDL-1.0<br>
ISC<br>
GPL-1.0+<br>
GPL-2.0+<br>
LGPL-2.1+<br>
OpenSSL<br>
<br>
There are odd entries like:<br>
<br>
GPL-2.0-only<br></blockquote><div><br></div><div>This is the new way to rep=
resent GPLv2 only, as described above.=C2=A0</div><div>While the GPL-2.0 an=
d GPL-2.0+ notation is still valid,=C2=A0 it is deprecated</div><div>in the=
 latest version, so transitioning existing over time will probably=C2=A0</d=
iv><div>be needed.=C2=A0 =C2=A0So I think the list of licenses to be added =
to=C2=A0</div><div>LICENSES/ path is:</div><div>=C2=A0</div><div>APACHE-2.0=
<br>BSD<br>CDDL<br>CDDL-1.0<br>ISC<br>GPL-1.0-only</div><div>GPL-1.0-or-lat=
er (note: actually same contents as one GPL-1.0-only)<br>GPL-2.0-only</div>=
<div>GPL-2.0-or-later (same contents as GPL-2.0-only)</div><div><div>LGPL-2=
.0-only</div><div>LGPL-2.0-or-later (same contents as LGPL-2.0-only)</div>L=
GPL-2.1-only</div><div>LGPL-2.1-or-later (same contents as LGPL-2.1-only)<b=
r>OpenSSL<br></div><div><br></div><div>Having files with the same contents,=
 but different names is=C2=A0</div><div>irritating, but I can&#39;t see a a=
nother way of complying with REUSE</div><div>guidelines.=C2=A0 =C2=A0Any be=
tter suggestions?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
Parentheses around AND/OR aren&#39;t consistent.<br></blockquote><div><br><=
/div><div>The SPDX specification has an appendix that calls for &quot;(&quo=
t;,&quot;)&quot;</div><div>around every license expresssion.=C2=A0 =C2=A0Af=
ter discussion with some=C2=A0</div><div>developers it was decided to be ok=
 to relax that, and only add them=C2=A0</div><div>when they were essential =
to clarify the logic.=C2=A0 =C2=A0The next rev of the=C2=A0</div><div>SPDX =
specification will have this clarified as well.=C2=A0 =C2=A0I think we caug=
ht</div><div>most of the changes in the kernel documentation patches for de=
scribing</div><div>this,=C2=A0 but if you have specific cases to be reviewe=
d,=C2=A0 happy to have</div><div>a look.=C2=A0</div><div><br></div><div>Tha=
nks, Kate</div><div><br></div><div><br></div><div>[1]=C2=A0<a href=3D"https=
://spdx.org/licenses/">https://spdx.org/licenses/</a>=C2=A0</div></div><br>=
</div></div>

--001a114110c8ec9601056440683b--
