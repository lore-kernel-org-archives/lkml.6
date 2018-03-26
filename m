Return-Path: <gnomes@lxorguk.ukuu.org.uk>
X-Google-Smtp-Source: AG47ELvgZ6EQ/XXf5y3paTxzu3AjQYuwcTTJPuV+kJFDqbg/hvxbbugpil9lmIUWXDSfV5Gp/YE4
ARC-Seal: i=1; a=rsa-sha256; t=1522088672; cv=none;
        d=google.com; s=arc-20160816;
        b=0s6co8NYSLgvR+aryvLnBG5MNFpMFRFQr7aehEDOjarGPFJm+MnL0r+zCpFXll6q5A
         tx0kSH35MV07ZJVl6KdNktJsYkRCWDWhrgKl0ER+DlPmBLTy9qw1blx1G1WvmY90EVno
         qKaoCMjCQ3frmmUTnwtaQY6AfE8iSGEUeQUfZFdO/+WMlYaefpW9/a+4740JMFhd0Y+U
         KiwNiNk79gdlqHBzdZS1kjXyXsQ2qflul3GEPBanUKzFoq/ymYbbAmjXGP3Kna9XWUH5
         QJhmi9+IkpAjO1CklxNtEzgpll/RJd2MCeSgH6fcfW9wwUjUZGObRbzCYIK8G/nYoiKL
         Cxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=F9CFqfl0tc42ByTCDN9PQqixjjYhpdWHT9ym+qBKVDM=;
        b=ZKbmIP7rLXU+efFJsWeHXg9r3v90akD3c7ypp8bEEQJEueUPlNHFBCdrKobdXdjGie
         /tE3obHjnsCRJgdCriBjYrHFVa4bHbtJavm/sn3nCEea+6r8qHywzDInBsplM3GRxTJG
         5AKElZaF+mRrgD4utGGpsoNN65dARD4WbcgzImjW+y1ulM7QGnuIJskhmKdUWAFr+4vY
         rex9zM9outNyg4sEfltsvd+meGIUejWJURdFAYLF2d7LENdpHUr4zw3RpP3Ue3DsW0qS
         3rJZdm/6zygbUXr1bu1lEzYUMwJnmkFM68yP6zrj18Fq+Np6MT8rLsKqBeNNiKeJ6Spm
         0krA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of gnomes@lxorguk.ukuu.org.uk designates 82.70.14.225 as permitted sender) smtp.mailfrom=gnomes@lxorguk.ukuu.org.uk
Date: Mon, 26 Mar 2018 19:24:28 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Aaron Durbin <adurbin@chromium.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Kurtz
 <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado
 <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez
 <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
Message-ID: <20180326192428.71c23abf@alans-desktop>
In-Reply-To: <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
References: <20180314003655.12141-1-djkurtz@chromium.org>
	<20180314003655.12141-2-djkurtz@chromium.org>
	<CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
	<CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
	<CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
	<CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594871326006513106?=
X-GMAIL-MSGID: =?utf-8?q?1596025651331079085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Sadly, this situation
> is not unique to this hardware. There is hardware all over that does
> not meet the current assumptions being made in the early uart drivers
> within the kernel.

Is there any fundamental reason you can't just embed dt entries in the
ACPI table to describe the other features you need. I appreciate it
doesn't solve the generic PC case but it ought to help for anything where
the firmware cares about Linux ?

Alan
