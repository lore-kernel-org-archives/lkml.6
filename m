Return-Path: <pavel@ucw.cz>
X-Google-Smtp-Source: AG47ELsjtGk2eSqKctA4yAp8+OMqFKjwX21R3iyzP8QdefwUeSXgVxeyUGvTJzV3k9KvOCZX6F5D
ARC-Seal: i=1; a=rsa-sha256; t=1521103718; cv=none;
        d=google.com; s=arc-20160816;
        b=tVfKV7Qpyibm0CZloP6Xruv6rJSlaJz7/gCZWDt+n6LEapwMKTnj2zQBbdYeMNU2Vi
         gSyrD+Xq3iLerz5natLeM+YnWkj2vInI4a/RaDdi5aTV3xxZhhxhFKTDpNCs+cMQfH4Y
         fLwMgnB0tozzS7L3BeDCG9wcNB4K2ILY1aOJQxe/njzSwmzO4iLqscy++Ri5yl0/kx4P
         szbXWkxe2Vc6wXk1JJgNGnHelGCaFgRF8rtKBe7GPa6K2NCZNVvtjNIsOq0/beHIHDRd
         ql3QjzXoxeYg9Zvpg0i0D/jEzTDdXaqY4UE8ZXkA3lq1HorgOzSKj5PBozFXRogprL4/
         HEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=+Eqsi3TC2H7UNpfp5/c6c9k2mKj1wJmR3M6kxPc1VUA=;
        b=CFtzb/JU2c0/4mdmIA33FU/JuVvMVfgitjisNuyHizOuZKHm3971pWFD1o0/cb3JZo
         UUh7McbZy9HnwK7JnbA6x2BMcsx/bsIoENah7AlP7i0eyJ5/42xj/RUMcB9/I9kUIHML
         lLHg0m1nVyck4UPBGmMUF6bejwF+1uCvmaaAx4UyAzBGWr1kPbOjacljwF5tKPpH1av+
         nQhdqusIlnG4aL3uVzKDDA7avmw7lDAxMyDeE7JgQgnqhaAgBX+sR3d13sDhoITsmpZg
         abn7p7JSJkNF22aU06DBxtzN8+4d3UaQK1mce4L5M0AUrfiGd7qHSao+xrkrmA8YofPu
         pMdA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.113.26.193 is neither permitted nor denied by best guess record for domain of pavel@ucw.cz) smtp.mailfrom=pavel@ucw.cz
Date: Thu, 15 Mar 2018 09:48:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Thomas Garnier <thgarnie@google.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Kees Cook <keescook@chromium.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
	"Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <len.brown@intel.com>, Juergen Gross <jgross@suse.com>,
	Alok Kataria <akataria@vmware.com>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Dennis Zhou <dennisszhou@gmail.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Alexey Dobriyan <adobriyan@gmail.com>,
	"Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Luis R . Rodriguez" <mcgrof@kernel.org>,
	Christopher Li <sparse@chrisli.org>,
	Jason Baron <jbaron@akamai.com>,
	Ashish Kalra <ashish@bluestacks.com>,
	Kyle McMartin <kyle@redhat.com>,
	Dou Liyang <douly.fnst@cn.fujitsu.com>,
	Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Ingo Molnar <mingo@kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"H . J . Lu" <hjl.tools@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Rik van Riel <riel@redhat.com>,
	Jia Zhang <qianyue.zj@alibaba-inc.com>, Jiri Slaby <jslaby@suse.cz>,
	Kyle Huey <me@kylehuey.com>, Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Michal Hocko <mhocko@suse.com>, Rob Landley <rob@landley.net>,
	Baoquan He <bhe@redhat.com>, Daniel Micay <danielmicay@gmail.com>,
	Jan H =?iso-8859-1?Q?=2E_Sch=F6nherr?= <jschoenh@amazon.de>,
	x86@kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, linux-arch@vger.kernel.org,
	linux-sparse@vger.kernel.org, kvm@vger.kernel.org,
	linux-doc@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v2 00/27] x86: PIE support and option to extend KASLR
 randomization
Message-ID: <20180315084836.GA15953@amd>
References: <20180313205945.245105-1-thgarnie@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <20180313205945.245105-1-thgarnie@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594857684125982930?=
X-GMAIL-MSGID: =?utf-8?q?1594992852680212012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These patches make the changes necessary to build the kernel as Position
> Independent Executable (PIE) on x86_64. A PIE kernel can be relocated bel=
ow
> the top 2G of the virtual address space. It allows to optionally extend t=
he
> KASLR randomization range from 1G to 3G.

Would you explain why PIE code is good idea?

You are adding less than 2 bits of randomness. Cost is new config
option, some size and performance impact, and more than 1000 lines of
code...

Is there some grand plan of adding 30 more bits of randomness with
future patch or something?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqqM2QACgkQMOfwapXb+vIPUQCgiwtu3igz+Mea6JgZEWaFBEa4
DdUAn1zcqcTDjpsItrwfFnQZ9XU/fRNQ
=OpfY
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
