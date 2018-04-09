Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523305571; cv=none;
        d=google.com; s=arc-20160816;
        b=GEpzcBidqnB2eKxoF5ivZK/PHksga91EG2Rwep/489kkCiR5gXknt33qvJB6J2fAn4
         45XGeOmiFbLq+KivmIzrWygqWGatO6oJT5j3lRsx7Tfg9CyT63GPYOtZzVvpSrQqylhB
         /oTd6bt0bSLROvmwk0rjXRt9glU6lmv0/tAsF17OxeyIg1uQ3hO4cJ4TwV7Cm3crG9cw
         I4qMWTVrl6ng548aZ0jUI1GOXQWCQ/eQEbwQkc8E2Ey8PuhoAeryOVSCJ5AgSqoJJoY1
         ctVmCP5BW1sR1cfnC/zdYKbJQeS/O4iTt9gWAucUjle7VYM0gSfVpoFaXnUYdwouUcFU
         S65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=0amWzqW/FHLqypWUnlrt3ApmERgAEnTe+kwFOUB3XJU=;
        b=WLAMssOGNX89+tCNe7z1fZDzuqdVNadJki7I5K8t/hN9OLp0Lf6TBBgMrdVPTpQmNM
         1AJtAgxPLoAjWufHqFJ2lDFJUzfCnkmK1n5RNw8QT3VghtkMt9EmuwTM4P+aegy2wCSs
         sDLSFayKwzmCM5M7NyDy9ueAyfC7E4vw6YetYjKgd9o6BCBczMQq2IoyERorth6WBn9m
         MILByY8/BXLze+Mtk9klGagPpgNW9+I9BbCvDrNg636eFEkkXexbj0Dci9qNF7YODmqT
         bXzPxoHM2jg45uEgw7lC/B6sVruOKo/QbbS6RMIM9XwXw0eaLzl/M5J5VD300lFyIP2B
         cOIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AIpwx48bDr0J9frlFbCMmH5AsfW2uvFyCUHQ5x0aFXHELwZEDlbHNZfShQ8lcubdlUSWmOx5NPu8TQ==
Date: Mon, 9 Apr 2018 15:26:10 -0500
From: Rob Herring <robh@kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 10/10] dt-bindings: gpio: Add bindings for Cadence I3C
 gpio expander
Message-ID: <20180409202610.2ckwi4ekswiaumym@rob-hp-laptop>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
 <20180330074751.25987-11-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330074751.25987-11-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347993996271622?=
X-GMAIL-MSGID: =?utf-8?q?1597301662894360206?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 09:47:51AM +0200, Boris Brezillon wrote:
> Document the Cadence I3C gpio expander bindings.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
> Changes in v4:
> - Use GPIO_ and IRQ_TYPE_ macros instead of raw numbers
> - Fix the unit-address in the example
> ---
>  .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     | 39 ++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt

Reviewed-by: Rob Herring <robh@kernel.org>
