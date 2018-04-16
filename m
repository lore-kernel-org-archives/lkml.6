Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AIpwx4/Nt/ox7rZeiH+1mFGn5xbPY5T2GEWC9jEU/mKRSPyNshvrDxJS9N9yQTZEhVPv23wVQJcZ
ARC-Seal: i=1; a=rsa-sha256; t=1523866064; cv=none;
        d=google.com; s=arc-20160816;
        b=xMRVFg/7ktGHeImJuaJaFyFGHjfBtddDAFoZZVuZE8i2CEzU3kUNbAsMsjTlsA9Pc1
         x2bi5uVIO9zcGYa0En/k9bc6qjU9u/EaYgmDVSdj3BuPi6mOmxg/nvLyQKSBLGrLe66y
         ShYBG5vZMYnJwBByLIsZic6V937kUhaY/dv3o/XBCkR8wbA6tMazReQOu0oe9aO6YHEv
         SO4IxkPqbXy+lAbOgUKQ3o1zXqEkhye0KhuuPgD/dq4VBTA3V8FLlYwdB8/MQfCWKHi9
         9qF1ZK4jFR5pOGLMmterRKJHEJQ7oRXgGw8BZ8RhRHGwbGGY9fjtbCTbT1KW+DPa6/HQ
         uaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding:date
         :message-id:in-reply-to:cc:to:from:sender:reply-to:subject
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=LFUZYwZtUo6DxgEs8gezTVPSfnNB372NaotclQDdeWc=;
        b=aI+LWp5Go2im8zmWChFfqver+SleHO64k8sud2x2ltKkM27jahJ3NnYcPhran7SPnK
         xfa6HQUj5ykm6BRodWKjxFwselfuBa26mar92+PsAT3XFeQQsiTrzBATrMF3DEqqZMRE
         tC9F/Uu8H3StcZB+gMkY3fm7vbVbA1syiL1M9r9Rk4jKxOxknznceKY9b5F942mdkFhR
         XCW4sSkI2L7oFehafVC6yaaWV+1WmL8NPKeWAbEYujjcqPVB5Edk3ppy9KOOBVjUUIR1
         hm/KPCGeT+/NLRbugKmgaY+w80bkTDj6BSkNQHGtab04/ZQ5kfkO4aSxjAP8twj2LnSA
         Qn2w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=PUtMGZKR;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=PUtMGZKR;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180416080742epoutp04508e3defb5f7abebcff5390438a4f207~l3Bw42hCB1183711837epoutp04Q
X-AuditID: b6c32a4b-fb3ff70000000fe6-f4-5ad459cd6a64
Mime-Version: 1.0
Subject: Re: [PATCH v3] mm/page_owner: ignore everything below the IRQ entry
 point
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: "dvyukov@google.com" <dvyukov@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "vbabka@suse.cz" <vbabka@suse.cz>,
	"arnd@arndb.de" <arnd@arndb.de>
CC: kbuild test robot <lkp@intel.com>, "kbuild-all@01.org"
	<kbuild-all@01.org>, "aryabinin@virtuozzo.com" <aryabinin@virtuozzo.com>,
	"glider@google.com" <glider@google.com>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"pombredanne@nexb.com" <pombredanne@nexb.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
	"mhocko@suse.com" <mhocko@suse.com>, "vinmenon@codeaurora.org"
	<vinmenon@codeaurora.org>, "gomonovych@gmail.com" <gomonovych@gmail.com>,
	Ayush Mittal <ayush.m@samsung.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	AMIT SAHRAWAT <a.sahrawat@samsung.com>, PANKAJ MISHRA
	<pankaj.m@samsung.com>, Vaneet Narang <v.narang@samsung.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"jdike@addtoit.com" <jdike@addtoit.com>, "richard@nod.at" <richard@nod.at>,
	"user-mode-linux-devel@lists.sourceforge.net"
	<user-mode-linux-devel@lists.sourceforge.net>,
	"user-mode-linux-user@lists.sourceforge.net"
	<user-mode-linux-user@lists.sourceforge.net>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <201803272356.6XjvciDF%fengguang.wu@intel.com>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180416054459epcms5p85f343635408abccfd12080d7fc322911@epcms5p8>
Date: Mon, 16 Apr 2018 11:14:59 +0530
X-CMS-MailID: 20180416054459epcms5p85f343635408abccfd12080d7fc322911
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180416054459epcms5p85f343635408abccfd12080d7fc322911
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH8+tte4tZ8VLo9huyideYiY7S1hZ+WOpMdOwuuoRkw0S2hd3B
	DZD1RW+r020OpMyFDAYdZqWrWsdAosSaYuVRiBtuxW6DOeoUlshr7sVDRdyyUcD1QeP++55v
	PuecfE9yBJjoHJ4sKNOZGKOO1pD8NdxLV9I2pw/uv14gdXQ/jn70MsjhauejZasPRw+sd3B0
	PXgZR/WTH+Do2Hwfhq5MzvFQVbOLj1y9kzhq+22cg3w3GzD0keMoQB/2/MVFgR4HH421P+Sh
	6aopPhqv24nGZj0c9DA4xEOfdM8C5On7CUcd7uMYstc2ctGS7QsM9ftPAPRZZR1ALs+X+M4U
	arwPpxZXAjgVXLQCqnJkhE8F6mo5VLf9Fk453Waqt8HPp5p7/+RQ7vtWnLozNIRTV21BLnX5
	RDtOeZ0LHOpMt4IaPVmeJy5gckoZupgxpjK6In1xma5ETe55uXBXoTJTKkuXZaMsMlVHaxk1
	uXtvXnpumSZ0ITL1AK0xh6w8mmXJjB05Rr3ZxKSW6lmTmnxVJpNLZNIsiVwulyiUr2+XK0PI
	G0zp9N9TuGEOvn2xYpZXAZpgDYgTQEIBR+cc/BqwRiAivACO/nITrwECgZBIgMtdiWEmkXgF
	rly1csNaRGyA12ztIIwkElK46NkctvmEBJ7t6eWGxyQR5wEcn2iLFBgxEgc7l/wgukwIbcd+
	5Ub1Oth5xhMZFEeo4FSnOGqL4VJFDBHDu75Tq61JsHpsEIvqBDjxr3fVT4HnOmojuyBRBeAf
	zRZOtGgE8POBan6UyoI/+E9h0WAvwZkFddjmEptgS9PvvCiyG1YOVEY0RmyFradnIjhGpEFX
	T0YUeQoe//Y8J2xDQg1XpgVROh7WBm9zYgm7Tsb0JmgZvcCLpV2Yn1+NRUG/5yusHpD2R4e2
	/2+v/dFeJ8DOgicZA6stYVilYZuOOShhaS1r1pVIivRaN4g8ypY9XcA9tLcfEAJAPibsGgwU
	iHj0AfaQth9AAUYmCVvpkCUspg8dZoz6QqNZw7D9QBm6QAOWLC7Sh95OZyqUKbKliszMLJlU
	mq0gnxBK931fICJKaBPzFsMYGGOsjyOIS64A67ZiKm/HEdt6xfDP9xnfPcslaavqbtpE7uGP
	K15872six/z8yP6m6oVbR7e9m2DxBtbynrYYNjrXDne8syPfoRvmLZvq47/JffBdxrO77ClH
	Ph1ou3HP12LNv/HP+oy88s6+8ostr2nQcy9MNSuu5e57/3b+9mCDqtGpmrlw8M0N8Z5nSC5b
	Ssu2YEaW/g/mUpj8PgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180327160057epcas5p30597e515a359dc6a5d54767a8bcb78a7
X-RootMTR: 20180327160057epcas5p30597e515a359dc6a5d54767a8bcb78a7
References: <201803272356.6XjvciDF%fengguang.wu@intel.com>
	<1522150907-33547-1-git-send-email-maninder1.s@samsung.com>
	<CGME20180327160057epcas5p30597e515a359dc6a5d54767a8bcb78a7@epcms5p8>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596090997002612569?=
X-GMAIL-MSGID: =?utf-8?q?1597889382429379819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

=C2=A0=0D=0AHi=20Arnd,=0D=0A=0D=0A=0D=0AWe=20sent=20one=20patch=20for=20ign=
oring=20entries=20below=20IRQ=20point=20in=20page_onwer=20using=20stackdepo=
t.=0D=0A=0D=0AV2:-=20https://lkml.org/lkml/2018/3/26/178=0D=0A=0D=0AV3:-=20=
https://lkml.org/lkml/2018/3/27/357=0D=0A=0D=0ABut=20it's=20breaking=20buil=
d=20for=20um=20target=20with=20below=20reason.=0D=0A=0D=0A=0D=0A=C2=A0=C2=
=A0=C2=A0kernel/stacktrace.o:=C2=A0In=C2=A0function=C2=A0=60filter_irq_stac=
ks':=0D=0A>>=C2=A0stacktrace.c:(.text+0x20e):=C2=A0undefined=C2=A0reference=
=C2=A0to=C2=A0=60__irqentry_text_start'=0D=0A>>=C2=A0stacktrace.c:(.text+0x=
218):=C2=A0undefined=C2=A0reference=C2=A0to=C2=A0=60__irqentry_text_end'=0D=
=0A>>=C2=A0stacktrace.c:(.text+0x222):=C2=A0undefined=C2=A0reference=C2=A0t=
o=C2=A0=60__softirqentry_text_start'=0D=0A>>=C2=A0stacktrace.c:(.text+0x22c=
):=C2=A0undefined=C2=A0reference=C2=A0to=C2=A0=60__softirqentry_text_end'=
=0D=0A=C2=A0=C2=A0=C2=A0collect2:=C2=A0error:=C2=A0ld=C2=A0returned=C2=A01=
=C2=A0exit=C2=A0status=0D=0A=0D=0ASo=20can=20we=20add=20below=20fix=20for=
=20this=20build=20break,=20can=20you=20suggest=20if=20it=20is=20ok=20or=20w=
e=20need=20to=20find=0D=0Asome=20other=20way:-=0D=0A=0D=0Adiff=20--git=20a/=
include/asm-generic/vmlinux.lds.h=20b/include/asm-generic/vmlinux.lds.h=0D=
=0Aindex=2076b63f5..0f3b7f8=20100644=0D=0A---=20a/include/asm-generic/vmlin=
ux.lds.h=0D=0A+++=20b/include/asm-generic/vmlinux.lds.h=0D=0A=40=40=20-460,=
6=20+460,10=20=40=40=0D=0A=20=20*=20to=20use=20=22..=22=20first.=0D=0A=20=
=20*/=0D=0A=20=23define=20TEXT_TEXT=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__irqentry_text_start)=20=3D=
=20.;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__irqentry_text_end)=20=3D=20.;=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20VMLINUX_SYMBOL(__softirqentry_text_start)=20=
=3D=20.;=20=20=20=20=20=20=20=20=20=20=5C=0D=0A+=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20VMLINUX_SYMBOL(__softirqentry_text_end)=20=3D=20.;=20=20=
=20=20=20=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20ALIGN_FUNCTION();=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=5C=
=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20*(.text.hot=20TEXT_MA=
IN=20.text.fixup=20.text.unlikely)=20=20=20=20=20=20=20=5C=0D=0A=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20*(.text..refcount)=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=5C=0D=0Adiff=20--git=20a/include/linux/kallsyms.h=20b=
/include/linux/kallsyms.h=0D=0A=0D=0A=0D=0ATo=20make=20solution=20generic=
=20for=20all=20architecture=20we=20declared=204=20dummy=20variables=20which=
=20we=20used=20in=20our=20patch.=0D=0A=0D=0A=0D=0AThanks=20,=0D=0AManinder=
=20Singh
