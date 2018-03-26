Return-Path: <robherring2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522103101; cv=none;
        d=google.com; s=arc-20160816;
        b=mk9Ec8jmUauDOW2WpSobyr5oCc5aYQuzPJ1lsJtg4OFLMc2z/doR9h2+hx7zjGRLhg
         2ieOgweAiKyPBzXi9sWmw3wgSZyq9oDs5Jt1T1UJcUBj92awMTMa1f5wW5iKDdb6IJXc
         roegfAHX+BW4v67w8mK0/dv7N80HFFz6hiNPTBCvfodX2h97c+YyEi9s0d7WZTaeOHRb
         uzOlwsSh268gyBBHjuNnhmutXpr+TaSjWl+ZpS6P6aurNJLALyq5JqII1PeNngahVjUM
         vl9Yrd3LktIZ9creINv0oy/uIJgyDi/75Ws/QC5OreqTfLeKy3MpnrceuupQx2EWeZv1
         tZlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ki5JWEUO1PeHaflqJIQJzHx5yi7Gg/xw8iI1dNIDeq8=;
        b=atvwUR3YzXP6lElWtc1QMsVx5qhLSgd2JVHilofxiCp+/5SY21Nr2uU1kD8ZyLU0Oc
         UAqnLZdDBMp7qFr+yv7VvYRWmkezvQkekxcou0tCqb1WywRjukUjdO5SutdtZh3M/jNc
         4owOr6cwr/61i0OoZqPXUUz+szkIPPgvBbBccsDmz/plv/L139Xq8n83Dc4PoSck15+c
         wzp9q0yJFQy5pcjNhp2LyG5G/i0yDBcKm0HArexAB6kX+w+sLokYp4wVapRoFmCX6ALJ
         Cy7zbJNr+6nDEOizGdxII+/iN3Emp4ws4C719aob92dCRbFDbP8+/TQ4HhW6MVbP7T2F
         rN6g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robherring2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robherring2@gmail.com
X-Google-Smtp-Source: AG47ELsS0CewchKtidaLzagMEsCPvPdQVX4evTzYp6DelJQoCSUb1wWGRirYvXgEO6bwsERgHTbW+w==
Date: Mon, 26 Mar 2018 17:25:00 -0500
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
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nishanth Menon <nm@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 06/11] dt-bindings: i3c: Add macros to help fill
 I3C/I2C device's reg property
Message-ID: <20180326222500.muhqsfy5oetk5ahk@rob-hp-laptop>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
 <20180323110020.19080-7-boris.brezillon@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323110020.19080-7-boris.brezillon@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725933191562034?=
X-GMAIL-MSGID: =?utf-8?q?1596040782046850124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 12:00:15PM +0100, Boris Brezillon wrote:
> The reg property of devices connected to an I3C bus have 3 cells, and
> filling them manually is not trivial. Provides macros to help doing
> that.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
> ---
>  include/dt-bindings/i3c/i3c.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 include/dt-bindings/i3c/i3c.h

Reviewed-by: Rob Herring <robh@kernel.org>
