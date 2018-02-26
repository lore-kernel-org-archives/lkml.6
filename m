Return-Path: <jdelvare@suse.de>
X-Google-Smtp-Source: AG47ELuot2dGUaUEREqcLqvK+TfIapcNigNcmec9awsErhrOLD5Ahdy3Tbh+/TSocX9LeK5Swa0p
ARC-Seal: i=1; a=rsa-sha256; t=1519655182; cv=none;
        d=google.com; s=arc-20160816;
        b=CCXdNmwIb+7TxzpjgTxEieu0rk7b/pn1SzFPmIk5s13RNVfGFQZLQHyvsVDI6euVq4
         9alMYKjlqBbTEuDQ22gXHKZ90iI9p9rt0qUkt9Ch8HOIXNLKQ4e+2Yfp+f7GNDnvlaKY
         om3OoBYq91CEEfTzZUQtHqUCcc8FkKNjcSluelNbjFVZcibYM6AhhF+aYZoeGC/uRj9E
         e3N5v5FBLgtLZaqO6UOCkM1GoKKjCcOxmldJDCRulQBgSMRRymQXhUz8vcNT6CFD0i08
         zCrRZzkSrgC58KSkaKBwTT+wGHwnBQ++Ijbfd/Wsc0zl41yGZ72td8YLXmU4IfxMgAQm
         BYCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=lDdUpXb79FIz7mVgBZZj5v4fRjQOruXol31ZZbGcZAM=;
        b=NEYW1DsM1jgWIzFosoD+jM+/Yb9JhZ1kzboXB3eVI5vY5J4mhPKA34KV8lelZKUSBP
         I256WpzAY5F2LudO0fEXECpuKRXUIN0t7Nk3zOs7skQ11dKAkZdbknN4s0mbbuAk/lf6
         koFMgFoAduYsa+c2JxYWgU2meK6rRh8ABLBnJ6/pqAQ9pEV0RWO50dL/dDZ1UJgtAXXG
         HL12BhS7qfTQKRoYLDKijPM2mo0Ce9sGVlOv4N2vQ/cmDfwz73VwXk+XNYUorIxvNRoU
         uyMAv7O3GNhllf4a0RKTThCiFBXQqjDCNbyiYs1xP7iVyFwp2nUspNYTVM7ltU9h3433
         P2Mw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jdelvare@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=jdelvare@suse.de
Date: Mon, 26 Feb 2018 15:26:20 +0100
From: Jean Delvare <jdelvare@suse.de>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linux I2C <linux-i2c@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] eeprom: New ee1004 driver for DDR4 memory
Message-ID: <20180226152620.6740b458@endymion>
In-Reply-To: <CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
References: <20180226102000.1b76640e@endymion>
	<CAMRc=MernxfN-P29HnLUFzAiX-UiFx32ZYZW_v6_BH9dXnfCfw@mail.gmail.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593454680453951468?=
X-GMAIL-MSGID: =?utf-8?q?1593473952570026169?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bartosz,

On Mon, 26 Feb 2018 14:40:42 +0100, Bartosz Golaszewski wrote:
> 2018-02-26 10:20 GMT+01:00 Jean Delvare <jdelvare@suse.de>:
> > The EEPROMs which hold the SPD data on DDR4 memory modules are no
> > longer standard AT24C02-compatible EEPROMs. They are 512-byte EEPROMs
> > which use only 1 I2C address for data access. You need to switch
> > between the lower page and the upper page of data by sending commands
> > on the SMBus.
> >
> > Signed-off-by: Jean Delvare <jdelvare@suse.de>
> > ---
> >  drivers/misc/eeprom/Kconfig  |   11 +
> >  drivers/misc/eeprom/Makefile |    1
> >  drivers/misc/eeprom/ee1004.c |  281 +++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 293 insertions(+)
> 
> is there any reason not to use regmap as is done currently in at24? It
> would spare you a lot of code.

No specific reason, just the fact that I never used regmap before so
the idea did not occur to me. I can give it a try, but my driver is
already pretty simple so I'm curious if there's really anything to win.
Let's see.

Is there any documentation available on how to convert an existing
driver to use regmap?

-- 
Jean Delvare
SUSE L3 Support
