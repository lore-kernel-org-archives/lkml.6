Return-Path: <khc@pm.waw.pl>
X-Google-Smtp-Source: AB8JxZr34ftcFVRpTVetfKNGrMPaz1l3zA6RLnhIQpUI+QkFKjx0DIB3Cd4pyBRNrj0jRWAHwjxL
ARC-Seal: i=1; a=rsa-sha256; t=1525461431; cv=none;
        d=google.com; s=arc-20160816;
        b=pebS+BsD7h9qMY1bMVtwAnjhOmAfKcoEYh368U46Lmx7gquSXgMDHEcSN1pDyMmJKZ
         yiQZ7d2ty6cKCrG2jTLSsJb0ictFWhPeVCs6INgz01yv1RlEbQQ4aOvM1ce3ZTWBAgNe
         W115f36ceFnjnFeKgBtvxoYr9kTTDWxHCEJiVLz8XUhlU7O7t7ylgHDeb6ZdUsrhBot4
         FWzuqFN9yCT3Sexh6xt33ZghlZAIO0h8F3ABb33z4OQpWCfNTloO0T1YtVcqr7bofVUb
         7cuXaWxqfnq+z+JA+MXadGVvan9G5OZuopj9eO9oeNijLIM0pYqG5rKX++yAwMIaeq6I
         Cjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:in-reply-to:date:references:subject:cc:to
         :from:arc-authentication-results;
        bh=2aJzQhnBJNKw7Mdt5U8ROlWsiFlbQSmKJ7eiOdBXmt8=;
        b=ah2nzHzgR0Xh5+zwnzd29p+/OzLvd3kYdIyvGr3QaNeIfmxE4Ua9YMMgF8Iuwy9CLh
         8u2wyGJzZG4vQoVjHbI0oll9ot3FMDs/Nj0GBo1gHzii7Y8GfjyN1v1AzMNAaw97yOxO
         KezmjqBFnke3moMUAapeQV0RCNDLAebX3hBuYJuRf2EMq3gMVEgS4U2Oqxqt42F/IzCi
         WB593QJSFlbeOpYP1j/c61qnLhgSL/W8I5r91DPs927KDg25XK328TgWuB6KJ+FgiUiI
         5X6wpV1gyspzn6JtK//cb8bK0LdChErF7qnLkg6/iuVUSnjz8goRxxaGacUii178HsMJ
         Svqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of khc@pm.waw.pl designates 91.202.125.194 as permitted sender) smtp.mailfrom=khc@pm.waw.pl
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of khc@pm.waw.pl designates 91.202.125.194 as permitted sender) smtp.mailfrom=khc@pm.waw.pl
From: Krzysztof Halasa <khc@pm.waw.pl>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org,  akpm@linux-foundation.org,  keescook@chromium.org,  josh@joshtriplett.org,  teg@jklm.no,  wagi@monom.org,  hdegoede@redhat.com,  andresx7@gmail.com,  zohar@linux.vnet.ibm.com,  kubakici@wp.pl,  shuah@kernel.org,  mfuzzey@parkeon.com,  dhowells@redhat.com,  pali.rohar@gmail.com,  tiwai@suse.de,  kvalo@codeaurora.org,  arend.vanspriel@broadcom.com,  zajec5@gmail.com,  nbroeking@me.com,  markivx@codeaurora.org,  broonie@kernel.org,  dmitry.torokhov@gmail.com,  dwmw2@infradead.org,  torvalds@linux-foundation.org,  Abhay_Salunke@dell.com,  bjorn.andersson@linaro.org,  jewalt@lgsinnovations.com,  oneukum@suse.com,  cantabile.desu@gmail.com,  ast@fb.com,  hare@suse.com,  jejb@linux.vnet.ibm.com,  martin.petersen@oracle.com,  davem@davemloft.net,  maco@android.com,  arve@android.com,  tkjos@android.com,  linux-kernel@vger.kernel.org,  linux-fsdevel@vger.kernel.org,  linux-scsi@vger.kernel.org,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] firmware_loader: cleanups for v4.18
References: <20180504174356.13227-1-mcgrof@kernel.org>
Date: Fri, 04 May 2018 21:17:08 +0200
In-Reply-To: <20180504174356.13227-1-mcgrof@kernel.org> (Luis R. Rodriguez's
	message of "Fri, 4 May 2018 10:43:49 -0700")
Message-ID: <m3lgczcjt7.fsf@pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556382367072293?=
X-GMAIL-MSGID: =?utf-8?q?1599562246025092685?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

"Luis R. Rodriguez" <mcgrof@kernel.org> writes:

>   * CONFIG_WANXL --> CONFIG_WANXL_BUILD_FIRMWARE
>   * CONFIG_SCSI_AIC79XX --> CONFIG_AIC79XX_BUILD_FIRMWARE
>
> To this day both of these drivers are building driver *firmwares* when
> the option CONFIG_PREVENT_FIRMWARE_BUILD is disabled, and they don't
> even make use of the firmware API at all.

Don't know for sure about Adaptec, but wanXL firmware fits every
definition of "stable". BTW it's a 1997 or so early PCI card, built
around the PLX PCI9060 bus mastering PCI bridge and Motorola 68360
(the original QUICC) processor. Maximum bit rate of 2 Mb/s on each sync
serial port.

It's more about delivering the .S source for the firmware, I guess.
Nobody is expected to build it. The fw is about 2.5 KB and is directly
linked with the driver.
-- 
Krzysztof Halasa
