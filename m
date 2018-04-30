Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AB8JxZr2nO4uhlFfuhEaEjnMTrrKfjcgwH+vxrvXx+SiQydJRh15dJRvEKGt7oMve0fSANVm0+KO
ARC-Seal: i=1; a=rsa-sha256; t=1525081071; cv=none;
        d=google.com; s=arc-20160816;
        b=HbojZ14Wt21qZ0tXyDs3O1Mtn7l6ypUmbhF5kRWrzCaV25LYuaQBH52F94+VuMWI3c
         FKyxNsju/WC/7+vTLeR/q4/k56c+WBBFME914QRaKZUgkFOWxUL5acQQRXl3iLPRD8c+
         L9Cqbl9bJH0Dj99MOdxzOfOt6WAgMVSrhZ5BRYaqEBbZaMcwKQGpYCNVZsJbKYEvDXOK
         HHMR2by03RTaz50QfVkjVF6qYMPf5y69Wg2EWoJvOSoQ0RCRbzgGoTHcY4kRijEc83Wg
         /vOAxFB6od6ZauMzmYpez12EGk9fbUEtl2DFdwFIJhRRV+o7OrUnlxrPFgjaudpzxxs+
         e2ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=n1ckFqMqVJspb1kiOrml4TmkPvpOwKrjQm/TpHuFFUo=;
        b=bwij6Rh3uaMNnitLWl2QzfyzL3CpaJQGpr0T22IcibJAew7YZ7YEBThqvJjYnKHtlD
         dproX2gRH6e3uGPJbyfC+twNUqoLSqyiuzU0AokeQEMCmoWJZT09Nj4USN9aNqtEkt+2
         QEtUCqU2gHqAqsj7nXCwzwtCUhN8COAwkM5OoyMJOU5eps2xuYaA04nrbtU91ceBzE6a
         6jaGttgg9tcxo5W675hDFYNefRgA2SXKTr0/U1641lpybB/FloZ27x1EMkzuqpoOSAJI
         uh+uMAiRykwQ0nqRBmfUr4RYMkBzX6DQRRxJYBf07VrIbAswnseflvTwSFus6H//JepS
         P8DQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 30 Apr 2018 11:37:50 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wolfram Sang
 <wsa@the-dreams.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz
 Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz
 Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring
 <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add the I3C subsystem
Message-ID: <20180430113750.002d384f@bbrezillon>
In-Reply-To: <20180429133642.GC28913@kroah.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
	<20180423193814.5c8ca75a@bbrezillon>
	<20180423175646.GA23210@kroah.com>
	<20180429133642.GC28913@kroah.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347987778039674?=
X-GMAIL-MSGID: =?utf-8?q?1599163409244235380?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On Sun, 29 Apr 2018 15:36:42 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Mon, Apr 23, 2018 at 07:56:46PM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Apr 23, 2018 at 07:38:14PM +0200, Boris Brezillon wrote:  
> > > Hi,
> > > 
> > > On Fri, 30 Mar 2018 09:47:41 +0200
> > > Boris Brezillon <boris.brezillon@bootlin.com> wrote:
> > >   
> > > > This patch series is a proposal for a new I3C subsystem.  
> > > 
> > > This v4 has been sent almost a month ago and I didn't get any feedback
> > > so far apart from Rob's R-b. Greg, is there any chance we can get these
> > > patches merged in 4.18? If not, could you tell me what should be
> > > addressed/improved/reworked?  
> > 
> > I'll look over it later this week, thanks.  
> 
> At first glance, it would be great to have at least one other
> reviewed-by or signed-off-by on the main code here.  I don't want to be
> the only one to have to review it :)

I understand. Arnd, Wolfram, any chance you could spend some time
reviewing this patch series? I know Arnd is in vacation for the next few
weeks, so I don't expect him to be able to do that immediately. Also,
Wolfram stated that he didn't have time to review the series in details
when I submitted the v1, I don't know if things have changed since then.

Anyway, I'll keep searching for people to review the code.

Regards,

Boris
