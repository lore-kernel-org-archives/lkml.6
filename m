Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZqvOf7tytt9144nYAcnGCxGBqRNHMqNhnniMXpY9VRrkoCUz8vWwbLdhN9IgtKMYqUMwMGk
ARC-Seal: i=1; a=rsa-sha256; t=1525894986; cv=none;
        d=google.com; s=arc-20160816;
        b=rrHxoonYqKMaYCdM/P6QvVvNVqvCuxxoEFdmQClWwApVzJeUflqll0PW1RqlXNBWNd
         farUKq6j6CQPUoLY79+P9Dv1dtbBwgb6ueJ+U+7BhDM9gB97GGJWWb/pTFuHXM2kzrEu
         S1SPamTzbuPOc4L/kn1X7OQrvqh4yjXqXfqRDvFOIReiGgfkfGyBj/reoLG/5VKF8Uv/
         aJrPQR2sABbcSAHnaHoVZ53vrU19fGxM9ZXPXD+xgKST4TualTajZgWtQpfI1l4uZ6Ej
         OQujmRliD7e1lslbGUPMm3o6ECgkybtYOvUnKpyxT1ialaBUHLZp9FE0fIJgY44GSCnz
         dOzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=jvRoYswcAvH6Qky7saWZp6Q/iF5eFMk5xuQmKgy5NIc=;
        b=zgg1JGKk1n4yDhby4RXdUTHQGm7/s4QrlJZxZ3SCj7V6OA5QR+PKVz5fkZvJdK255y
         Ym5p2gPidlqmivaMNz+xjmVGpmymr9W6DVhUgP89vh+Hx68WAXEBorpU29pFbk0jYjXt
         +0Wpre8eLhIDY3hOIa4YHhWnrwZ6R1yIhWVqud8otVNbb0f4f8XLBIj7rqFJjUu0t9v5
         a5XXwYb9n/x9AGboO/F6fQQ+SB7g1hSFFhGn9g5Vhg/daHtRFci+ZgoHYb/cpA6VrJUO
         0xLtRYO7CWt5UAcjSaiC0KiLZ6wIhpdguqLTGTGH8MfEZFxI+kLw1aJGPSnBi3rdPltB
         04Gg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PNIfnQGu;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=PNIfnQGu;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 16:41:53 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>,
 <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Linus Walleij
 <linus.walleij@linaro.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Harry Wei <harryxiyou@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Michal Simek
 <monstr@monstr.eu>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger
 <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
 <hpa@zytor.com>, <x86@kernel.org>, Chris Zankel <chris@zankel.net>, Max
 Filippov <jcmvbkbc@gmail.com>, Jens Axboe <axboe@kernel.dk>, David Howells
 <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie
 <airlied@linux.ie>, Gustavo Padovan <gustavo@padovan.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Sean Paul
 <seanpaul@chromium.org>, Pali =?UTF-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>,
 Matias Bjorling <mb@lightnvm.io>, Michael Lyle <mlyle@lyle.org>, Kent
 Overstreet <kent.overstreet@gmail.com>, Malcolm Priestley
 <tvboxspy@gmail.com>, Antoine Jacquet <royale@zerezo.com>, Sudip Mukherjee
 <sudipm.mukherjee@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Paul
 E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett
 <josh@joshtriplett.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross
 <jgross@suse.com>, Li Zefan <lizefan@huawei.com>, Paul Moore
 <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris
 <eparis@parisplace.org>, James Morris <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng
 <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Jade Alglave
 <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Akira Yokosawa
 <akiyks@gmail.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa
 <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@zh-kernel.org>,
 <user-mode-linux-devel@lists.sourceforge.net>,
 <user-mode-linux-user@lists.sourceforge.net>,
 <linux-xtensa@linux-xtensa.org>, <linux-block@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-clk@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <patches@opensource.cirrus.com>, <linux-bcache@vger.kernel.org>,
 <linux-usb@vger.kernel.org>, <devel@driverdev.osuosl.org>,
 <xen-devel@lists.xenproject.org>, <cgroups@vger.kernel.org>,
 <selinux@tycho.nsa.gov>, <linux-security-module@vger.kernel.org>,
 <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
Message-ID: <20180509164153.5b9ab9db@vento.lan>
In-Reply-To: <Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
References: <20180509152045.722f0c51@vento.lan>
	<Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992730865491295?=
X-GMAIL-MSGID: =?utf-8?q?1600016862010510368?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Wed, 9 May 2018 15:11:07 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> escreveu:

> On Wed, 9 May 2018, Mauro Carvalho Chehab wrote:
> 
> > Em Wed, 9 May 2018 19:15:01 +0200
> > Andrea Parri <parri.andrea@gmail.com> escreveu:  
> 
> > > >  tools/memory-model/README                     | 10 +++++-----    
> > > 
> > > As mentioned in the previous thread, I am for keeping the current
> > > references: the REAMDE is listing the doc files, as well as other
> > > files in tools/memory-model/, relatively to that directory.  
> > 
> > Yeah, at least this hunk deserves some rework, as now some
> > references are Documentation/.../foo, while others are just
> > bar.
> > 
> > As on (almost) all other places (except for tools/memory-model/README),
> > the references are always from the main directory, I would make all
> > patches there also relative to main dir. If you're afraid of
> > not being too clearer, we could prefix all of them with something
> > like:
> > 
> > 	${LINUX}/tools/memory-model/...
> > 
> > just like some DT binding files do:
> > 
> > 	Documentation/devicetree/bindings/sound/audio-graph-card.txt:see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> > 
> > A bonus of doing that is that the broken reference detect script can
> > keep parsing it without changes (well, it wouldn't be hard to make
> > it also accept a relative file, but doing that just due to 
> > tools/memory-model/README seems overkill).
> > 
> > Another advantage is that it would allow to easily add references
> > there from the main kernel Documentation, if needed in the future,
> > without messing with local x non-local relative namespace.  
> 
> How about changing the relative references so that something like
> Documentation/recipes.txt becomes ./Documentation/recipes.txt?

Sounds a good idea to me. Andrea?

Thanks,
Mauro
