Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx49ThiEOnN0lTjg/3ZBcY5/jtYokKq3S/qBp3dEDYPU3ZlP5ezpXgX/koQr4J5pXqbPrBTzg
ARC-Seal: i=1; a=rsa-sha256; t=1521973272; cv=none;
        d=google.com; s=arc-20160816;
        b=XkP9wWKN4sKEwiKrCKCjUQQfLNnmqmRWF/DSj7x/wN6niAWelRRpb2ZNuxMZ/VAMYO
         VcWiJCdllyH9itxejbv/517STQBZ534Nk2NSRnml9h5H6vl3v9O5ZKQPhLh5L0G/ERiK
         IjSZp2L6VoFniwIISrpKuEvC4YNril473B/da7k90Ghz5iIyYv8yCWUJi/bfyWKXrzvR
         fkIkD/VblqNXU8qIoeh/DN8RTI81Z7kVDBSQKf0A26DOtfcByapiGwUzuksFdvMNBLkk
         BOx4UXuPFZL8DBMyc5chQcuJBhteJepWHNGQEsDJYOq4ctp8BkIAOtWYGWG60ihspySv
         MVLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=La9FY2SJ7mzBeTT5DM+5vm5tTZ0oLD9Mm7fTDEz24Bk=;
        b=xdw+D+tNZs8kkwn2fVi7qD06Gkz+knULzGCgUjb80DiP2pdlJWAeNinoWDzXKtoiS3
         2jQL9/uHQZYQHfX19oRodjGaKR123+Hf9+nNhP//upD7rfqCf5kZ/VyjQ3W9uXf6CADq
         QsspPUgSSFotLvsR2DsuW14d8rSZBtsq66ghOfalCtumnR1PbY3H35tTfDD2VOn5lfjt
         ejnYRwtkYlDitzRbW7Sn/fzNCjNZswwgCWfM4HJvHQtXewZTeVvp8Crcz0nWyUSa5v9o
         6hl9Vo3GuxQYpcF2zSKIUru9XHUf/853WBfrBeGle4St15TGGLg3M91Dgkee4rn7qzgm
         CvXA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Sun, 25 Mar 2018 12:21:09 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Przemyslaw Sroka <psroka@cadence.com>,
 Arkadiusz Golec <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>,
 Bartosz Folta <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Nishanth Menon <nm@ti.com>, Rob
 Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
 linux-gpio@vger.kernel.org, Boris Brezillon
 <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH v3 01/11] i2c: Export of_i2c_get_board_info()
Message-ID: <20180325122109.31c8e904@bbrezillon>
In-Reply-To: <20180324223832.7wvhghw77ech4orn@ninjato>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-2-boris.brezillon@bootlin.com>
	<20180324223518.g5jsi5zvoxa75psy@ninjato>
	<20180324223832.7wvhghw77ech4orn@ninjato>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725929783088275?=
X-GMAIL-MSGID: =?utf-8?q?1595904646634690679?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 24 Mar 2018 23:38:32 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> > > -	info.archdata = &dev_ad;  
> > 
> > Why did you drop this?  
> 
> If the removal is safe, it should be a seperate patch, I mean.
> 

Sure, I'll move that in a separate patch. Actually, I had a closer look
and it seems the only user of info->archdata is i2c-core-of.c, so we
can even remove the info->archdata field.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
