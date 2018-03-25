Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx48bZ3xyMOf8um6Tvpj6yPL9HVKKvwClolkq+y0XaVkS7eY78Pmgf9SlkLW/zzKAdKLBokVt
ARC-Seal: i=1; a=rsa-sha256; t=1521973176; cv=none;
        d=google.com; s=arc-20160816;
        b=y6BypldfCugYjktLEbIpt/sGAe3KmM2x1RHpIJL7LTYPRqn47dFaJ8amY/MtIJiEaA
         uy4yNQODJW0qG2sx7vDeUHcI4J0aSmrbmvVfaeRQashTujkSYrroBKToG8ig0u/Ntcd4
         IWwILLzc8vGPAJsFOYCOzBquWpU5HdwWbF3xhhLd/ddmFlgYjBU3kG/MtYJ2/W+kwl0h
         5M6lAfONNWh24T942sQltG6YGkBpsG051k1ygTZtISBeHLVWJt9TtTzP/BlrT8bv4k4r
         qtbDoZjCN/GTK/nFCTmxfSrBPZDpX9Vp72IAoHo+1z/lBvJJMsjkfQjU4CE8qTkpNNi6
         1Kyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=64DDenrjK4PMOFi0gHHihGvedNhJlLWtiuaYdRTMp8A=;
        b=n6BBKk9QvcOdN9Foc/TAtJE1IxjpkPfBuN7LpS7mFfi8AfewSUcnPBHe3W47+Suqww
         HolknFALPGYKOlmN4mcKGZXGKaE+5+wuv7XNugO6zMGxgiyDX76QV79V8LOarQn4Xofb
         O5Fh26A/mF3C4uPxPl8QQXu8D1nLVDqXewHFuurRs06mf1Fd+uJ1MoW9V65j/rFlCp6Q
         znqTlIy0C7lSz6oIbzdjd4E42+DbqPUNOnfcY+Wjb5jYaVmHkT/x/sGv+svVvLQxQUmp
         c2+7eqNfGPl2hguBdK0s3CJhXQINZlKGqK2wwwS8EcfDM7NsEuWStqpb8H8qeK2MpI7I
         s8ZQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Sun, 25 Mar 2018 12:19:32 +0200
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
Message-ID: <20180325121932.6b0e5e5f@bbrezillon>
In-Reply-To: <20180324223518.g5jsi5zvoxa75psy@ninjato>
References: <20180323110020.19080-1-boris.brezillon@bootlin.com>
	<20180323110020.19080-2-boris.brezillon@bootlin.com>
	<20180324223518.g5jsi5zvoxa75psy@ninjato>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595725929783088275?=
X-GMAIL-MSGID: =?utf-8?q?1595904545757231023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Wolfram,

On Sat, 24 Mar 2018 23:35:18 +0100
Wolfram Sang <wsa@the-dreams.de> wrote:

> Hi Boris,
> 
> > - rebase on v4.15-rc1  
> 
> This code has changed a little meanwhile. Please check my for-next
> branch. Some changes are identical, some similar.

Actually it was rebased on top of v4.16-rc1, but I'll check if this
patch applies correctly on top of your for-next branch.

> 
> > -	info.archdata = &dev_ad;  
> 
> Why did you drop this?

Well, this line could have been moved in of_i2c_register_device(), but
I realized dev_ad was zero initialized without any further
modification, and leaving info->archdata to NULL has the exact same
effect (see [1]).

Regards,

Boris

[1]https://elixir.bootlin.com/linux/v4.16-rc6/source/drivers/i2c/i2c-core-base.c#L711

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
