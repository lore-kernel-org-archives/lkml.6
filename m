Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522849104; cv=none;
        d=google.com; s=arc-20160816;
        b=KyYFtitDIY3AKoUt0SQ+jb/fCoRfd5mVWP3rNzSdXYQ+7jx9m4i9nhz9Cdht/bDxNL
         LgMuP7yITwAepSJvJf7GJL5tV22d9dsmc32Q1yFnwbpIEgVp885UPADGy5bWesO9eJe7
         pg9WgMS/EJD/6k7axz2WPoQ7OzbCXkemdzwyiVbYRg4iHvjmmuX9MPcDqbPzKtnAClme
         oftmzuyVxFdLaqIBwHxSiiG+MYqUTWRw3LLjpmlTyIXkShlom/rL0h8MFsjD9LQO9vLY
         u91fbWDuwKc4E3DTy+iAosA0iHHINoxEka13dG90uN4nl2VImilgQdw8iDw1xWCjUi7R
         M6/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xklYloJKrZXd+ujMwXPP96VON1psbOc2p5/hKCTF1ag=;
        b=Y2arWbcV1YNF2ivtnRF6RyAJvCuqOxsYnGF+etU+Q4rwJnQKA4ZqLioDoqDC8vAz64
         3WxOp9tpNLx3gTXs6LIXlop74PGG0ujuoy8MajsmmengrG9T0Cqj7nqnhmVHXq6x/TvT
         zBtro18X4ZxZ0IjGOXs4Ni063nAaUdR391MVmTUg0k8cnJ4cwog0z4ZmGwsjn2nNcE78
         arYTsMNTcYnSPx3vrcjxJNmm3YBP+ADFLcLog510LhLxLhdGBW3j9uqhRb8/f8gPaIHc
         rnl79JoIEvHsObRw/I4WOXX5CbaXVPPznicNKR7euHuSM6/ZYvAToNPZg6dMwrLmL/cB
         qoyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u1cQmpy5;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=u1cQmpy5;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx48KCx9RxoN9HN96QdedJd6NYpCBwlSG/BElmgNfVfarmn0m63CCxnxUKBTea5evanq8V/b3oOuTbM+MvBZmhwY=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <23fe2eeb-127e-7917-0d56-714414cc8c06@topic.nl>
References: <20180404103900.4090118-1-arnd@arndb.de> <23fe2eeb-127e-7917-0d56-714414cc8c06@topic.nl>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 4 Apr 2018 15:38:22 +0200
X-Google-Sender-Auth: wyidoF5f80_ugsMc269lEqICV-k
Message-ID: <CAK8P3a0wWw7Ue4SDcEMvbaNLQJnz0zeH31WZ0oXVNb0fWYP5LQ@mail.gmail.com>
Subject: Re: [PATCH] [net] nvmem: disallow modular CONFIG_NVMEM
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
	Networking <netdev@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596811748893246991?=
X-GMAIL-MSGID: =?utf-8?q?1596823022039293653?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:32 PM, Mike Looijmans <mike.looijmans@topic.nl> wrote:

>
> Which may still be very confusing, since it means that CONFIG_MACB=y with
> CONFIG_NVMEM=m will fail, but setting both to "y" or both to "m" will work.
> So that would introduce more build failures again, right?

Right, it would require having a

      depends on NVMEM || !NVMEM

line in Kconfig for each such driver, or a

      depends on NVMEM != m

for drivers that cannot be modules themselves.

      Arnd
