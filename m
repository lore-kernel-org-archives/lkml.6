Return-Path: <maninder1.s@samsung.com>
X-Google-Smtp-Source: AG47ELuFX2vvYw7qscKJWUTsbLvNYLat2E/cfuOqpYjN9x2Yw1x69GxDOIoHPY2zlDc8AvwhOSo+
ARC-Seal: i=1; a=rsa-sha256; t=1522153885; cv=none;
        d=google.com; s=arc-20160816;
        b=FP7hKnnLUOMBTTc2GZUz3lpqFqiF8csF68WfIJsIhxgHsGUsUqsH9IGUUqPAVzj1+Z
         XUm/ZXo3n/t8mYd4g6wnorbKuiH3Rtd04FTyny/qC5UzxBq1M/NHn95PFUm/7xHrSWql
         xvFUnldvKhuYdJgXKjhQlBQnxDdmKFwQe6MfgRk+GV9FiPE2K6mMffdwS31WNKMAFcE4
         MpPx+X4qx1GNrg1auns2VHd/XecI1Cr1V5XBCPe0gqOT1CVMp1Sd43hnhFJaGQ7e3q/q
         Omo9v6q/XAhH4EGzRwYqgA4PNmXMoHGbIPPi8wCm5jpqBlvxGkVfpeHk8kYSB5ILsu44
         8SWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding:date
         :message-id:in-reply-to:cc:to:from:sender:reply-to:subject
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=xo/Ma1pemF9WR5F60ZHQBTkwPhbvhfqMuyApM71cEeI=;
        b=a6NcNFsUcYNTI4YqiTvcz/ZEjc9ic7gXrAn84dS2e+of8sj2M/WPWyDnaTuFI61sK0
         IdhtIoeAg+KNU7yvFEgXUm/KqwRbhhB9fh2eV0KM0Cys9FDMb9f3QXZcF3WNjQz2B0QL
         VRXYcAgj3CO8WpLtA6aqBPtbvp+RduFeGJp2JjcXWFLRLuPrjmeHebZrAc2dnMP+kEQI
         2OL92WxgNn0LqLYyGqD/13XeWfvPGVf74owSZENVauXq3vzvfLGKLFFPHptJsyNdHZVK
         4BQN/Rwz1UzGDfDh5PDuRS0Qm3PzQegMqA9g+RmJmDlrUoUShRpWEXxpFLdgxF5heyBb
         38hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=dJQHvson;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=dJQHvson;
       spf=pass (google.com: domain of maninder1.s@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=maninder1.s@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180327123124epoutp03d5ce7795d6276c90b4e01201d5fc6744~fxuSdlloH2012320123epoutp03C
X-AuditID: b6c32a49-71dff70000000fee-45-5aba399a8f22
Mime-Version: 1.0
Subject: Re: [PATCH v2] mm/page_owner: ignore everything below the IRQ entry
 point
Reply-To: maninder1.s@samsung.com
Sender: Maninder Singh <maninder1.s@samsung.com>
From: Maninder Singh <maninder1.s@samsung.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vaneet Narang
	<v.narang@samsung.com>
CC: Dmitry Vyukov <dvyukov@google.com>, Andrey Ryabinin
	<aryabinin@virtuozzo.com>, Alexander Potapenko <glider@google.com>, Kate
	Stewart <kstewart@linuxfoundation.org>, Thomas Gleixner
	<tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, Vlastimil Babka
	<vbabka@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>, Michal Hocko
	<mhocko@suse.com>, "vinmenon@codeaurora.org" <vinmenon@codeaurora.org>,
	"gomonovych@gmail.com" <gomonovych@gmail.com>, Ayush Mittal
	<ayush.m@samsung.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev
	<kasan-dev@googlegroups.com>, Linux-MM <linux-mm@kvack.org>, AMIT SAHRAWAT
	<a.sahrawat@samsung.com>, PANKAJ MISHRA <pankaj.m@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180326125228.1f40abb9a52f3674b1491aea@linux-foundation.org>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180327114019epcms5p41dec80bebd551f85f576d90ff144fba8@epcms5p4>
Date: Tue, 27 Mar 2018 17:10:19 +0530
X-CMS-MailID: 20180327114019epcms5p41dec80bebd551f85f576d90ff144fba8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180327114019epcms5p41dec80bebd551f85f576d90ff144fba8
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJsWRmVeSWpSXmKPExsWy7bCmpu4sy11RBktumVhc3J1qMWf9GjaL
	L5PesVtc+b2f3WLCwzZ2i/aPe5ktDj98y2rRvHg9m8WKZ/eZLHrmNDFaXN41h83i3pr/rBb3
	+xws7r3ZymTx//c5Voute6+yW2zeNJXZ4tDJuYwWsxv7GC3Wbz3A7iDi0XjjBpvH5b5eJo+d
	s+6yeyzYVOqxZ+JJNo9Nnyaxe7w7d47d48SM3ywe++euYfdYvtPEo2/LKkaP9VuusnicWXCE
	3ePzJjmP1/sPMQbwR6XaZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
	ufgE6Lpl5gB9raRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyMtIzMY21
	MjIFKklIzWjYfJip4DhHRfvK3AbGZRxdjBwcEgImEo2XRbsYuTiEBHYzSlyYdp0FJM4rICjx
	d4dwFyMnh7BAiETjrWdsILaQgKLEhRlrGEFKhAUMJH5t1QAJswnoSazatYcFxBYRCJXofH6U
	EWQks8BrVolHx3+zgiQkBHglZrQ/ZYGwpSW2L9/KCGJzCnhL7O7sZ4SIi0r8aYCpEZV4f2w+
	VFxEovXeWWYIW1Diwc/dUHEZidWbe1lAlkkINDNKvFjcwgThTGGUWHS8lQ2iylzi/Mn5YN28
	Ar4S5491gdksAqoSL6f3QE11kbj79RHYVGYBbYllC18zg3zJLKApsX6XPkSJrMTUU+uYIGxb
	icM3z7BBlPNJ9P5+wgTz5I55MLaqRMvNDawwD3/++BHqMQ+Jt483MU1gVJqFCOpZSBbPQli8
	gJF5FaNkakFxbnpqsWmBYV5quV5xYm5xaV66XnJ+7iZGcOLX8tzBOOuczyFGAQ5GJR7eGRw7
	o4RYE8uKK3MPMUpwMCuJ8GYK7ooS4k1JrKxKLcqPLyrNSS0+xGgKDIKJzFKiyfnArJRXEm9o
	YmlgYmZmbmhgYGmiJM7rGOgSJSSQnliSmp2aWpBaBNPHxMEp1cDYa3ntzhPBFS+m381kvb32
	VOgUH4nlk+490r20ITzq0LVlt1mU9SaXHbnG/lP7StCHmH0FjQnSX1ekfY47rO3h9Wry1Ucz
	ufKUt6p/mBq1oVHL4sjdbU2eW9+fzU+7tzX3o6P7o4UqL7I/9Z/nfzbviPrOky1936dvsuAR
	9OpTDO8SS5kebm+9XYmlOCPRUIu5qDgRAKhWf+cSBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
X-RootMTR: 20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41
References: <20180326125228.1f40abb9a52f3674b1491aea@linux-foundation.org>
	<CACT4Y+Yfx+fTHyQ=d3T68bwfgQQsmqd+e72V67kaAHajo536JA@mail.gmail.com>
	<1522058304-35934-1-git-send-email-maninder1.s@samsung.com>
	<20180326141717epcms5p4064a0fd4f594b2ff434f9b05cd1ea5ad@epcms5p4>
	<CGME20180326100020epcas5p2b50b7541e66dccf4e49db634e5fe6b41@epcms5p4>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595993933133123096?=
X-GMAIL-MSGID: =?utf-8?q?1596094033021245065?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andrew,

>filter_irq_stacks()=C2=A0is=C2=A0too=C2=A0large=C2=A0to=C2=A0be=C2=A0inlin=
ed.=0D=0A=C2=A0=0D=0AOk=20we=20are=20thinking=20to=20move=20definations=20i=
n=20kernel/stacktrace.c=0D=0Aas=20a=20normal=20global=20function.=0D=0A=C2=
=A0=0D=0A=0D=0A>in_irqentry_text()=C2=A0is=C2=A0probably=C2=A0too=C2=A0larg=
e=C2=A0to=C2=A0be=C2=A0inlined=C2=A0as=C2=A0well,=C2=A0and=0D=0A>should=C2=
=A0return=C2=A0bool.=0D=0A=0D=0AWe=20can=20declare=20it=20as=20static=20fun=
citon=20in=20kernel/stacktrace.c=20as=20its=20user=0D=0Ais=20only=20filter_=
irq_stacks.=0D=0A=C2=A0=0D=0A>Declarations=C2=A0for=C2=A0__irqentry_text_st=
art=C2=A0and=C2=A0friends=C2=A0already=C2=A0exist=C2=A0in=0D=0A>include/asm=
-generic/sections.h=C2=A0(and,=C2=A0for=C2=A0some=C2=A0reason,=C2=A0also=C2=
=A0in=0D=0A>arch/arm/include/asm/traps.h)=C2=A0and=C2=A0should=C2=A0not=C2=
=A0be=C2=A0duplicated=C2=A0in=0D=0A>include/linux/stacktrace.h.=0D=0A=0D=0A=
Ok,=20done.=0D=0A=0D=0ASending=20new=20patch=20with=20fixes.=0D=0A=0D=0ATha=
nks.=0D=0AManinder=20Singh=0D=0A=0D=0A=0D=0A=0D=0A=C2=A0=0D=0A=C2=A0
