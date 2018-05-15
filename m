Return-Path: <sboyd@kernel.org>
X-Google-Smtp-Source: AB8JxZowPRnPVKCoQPACiBzGqPi3+9LJHBXPANaalzsaC3FjFBmsefgm3HnR/foZhj4QdlpVHTVB
ARC-Seal: i=1; a=rsa-sha256; t=1526415965; cv=none;
        d=google.com; s=arc-20160816;
        b=OXXMSb3cgNRFWXpn56uCaNcS3n3Vt/W9d4Il8fBaCR+yGfjEfbte5guefpVT8f55Cf
         jBADgYVO3VWEJnsPYod2pj+NMM+tfwks9zjTwhbZc4/D7bivNVKw28KWW5HxZjmyAwGA
         YldkHYJm0W+gqBZVzRpyN8+Kkti7hWhhqN/OzWc/x6rzI/fMy+sXHqH76cWNIV29kvmF
         WaxXL3dxBEs6PL21XUw9JtCS5K0cwVB2RJWskeu6b2eZQu3jSlPNcBMwBChtr+raRD4J
         xll2+zon74sFZTEDwha4ghxeluKHgay2EcFq2Tmjjaqmf+Y9RL8Ugz8Pif9vDtkyd0oM
         ILiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:subject:user-agent:message-id:references:cc:in-reply-to:from
         :to:content-transfer-encoding:mime-version:dkim-signature
         :arc-authentication-results;
        bh=iPpeZPv/b52rRijtAyfh/241ydLIserbyqbhlNtR0WA=;
        b=d5IdjCWHlpfHd5jPA+bvL+ya5gWYRUZEyiiDXsl3ljJaafh1vfLguEClBJEEma+itM
         7AIbU2eSBTJvTiHmOAgh7hqw4CI/mgM5DqwfZYjiKCWcPE5OebeqCZWbai926WChpuxB
         EayTTt4j3b3f3YChM3Boou8T613raXjrzsTiAYm4lYHchxTZ4EU4v4GYmc/WlTt3Yt8m
         UzDk+QLxEvHeyfxpcB1UULIx6trSNswopiAcl7692IDMZAIJbNGaj+8mDwUvo34ymAb6
         HxRImBnsUbJqiJPKeex6LVB4ONmTPUsuAGQwWypq0Qw5NN1niQFSDRzwjnNsnI4z/BHy
         sawA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SNloT9KP;
       spf=pass (google.com: domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=SNloT9KP;
       spf=pass (google.com: domain of sboyd@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=sboyd@kernel.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Harry Wei <harryxiyou@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>,
 Michal Simek <monstr@monstr.eu>, Jeff Dike <jdike@addtoit.com>,
 Richard Weinberger <richard@nod.at>, Guan Xuetao <gxt@pku.edu.cn>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Turquette <mturquette@baylibre.com>, David Airlie <airlied@linux.ie>,
 Gustavo Padovan <gustavo@padovan.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Sean Paul <seanpaul@chromium.org>,
 =?utf-8?q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
 Matias Bjorling <mb@lightnvm.io>, Michael Lyle <mlyle@lyle.org>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Malcolm Priestley <tvboxspy@gmail.com>, Antoine Jacquet <royale@zerezo.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Josh Triplett <josh@joshtriplett.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Juergen Gross <jgross@suse.com>, Li Zefan <lizefan@huawei.com>,
 Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>,
 Akira Yokosawa <akiyks@gmail.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Namhyung Kim <namhyung@kernel.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@zh-kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 user-mode-linux-user@lists.sourceforge.net, linux-xtensa@linux-xtensa.org,
 linux-block@vger.kernel.org, keyrings@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, patches@opensource.cirrus.com,
 linux-bcache@vger.kernel.org, linux-usb@vger.kernel.org,
 devel@driverdev.osuosl.org, xen-devel@lists.xenproject.org,
 cgroups@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, alsa-devel@alsa-project.org
References: <cover.1525870886.git.mchehab+samsung@kernel.org>
 <e959f23d6f6905ee606fadfda13e2bb37deed017.1525870886.git.mchehab+samsung@kernel.org>
Message-ID: <152641596420.237094.12177504626636253047@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
Date: Tue, 15 May 2018 13:26:04 -0700
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599992730865491295?=
X-GMAIL-MSGID: =?utf-8?q?1600563147855546461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Mauro Carvalho Chehab (2018-05-09 06:18:52)
> As we move stuff around, some doc references are broken. Fix some of
> them via this script:
>         ./scripts/documentation-file-ref-check --fix-rst
> =

> Manually checked if the produced result is valid, removing a few
> false-positives.
> =

> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> ---

>  drivers/clk/clk.c                             |  4 ++--
>  drivers/clk/ingenic/cgu.h                     |  2 +-

Acked-by: Stephen Boyd <sboyd@kernel.org>
