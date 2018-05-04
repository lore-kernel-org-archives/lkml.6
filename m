Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZoDwyWAnFKzHYvR5X18AMX1+7hLgorRQBsSKg9dMeydiBRoefXIe2TLjlxYzwIUtgvrI3d1
ARC-Seal: i=1; a=rsa-sha256; t=1525463921; cv=none;
        d=google.com; s=arc-20160816;
        b=vh7JV71eIWYMMT++MriCiTEd7YIqLY4lBlbFlTVA8h3BjKXTIEIukzie0Rjkqy9naN
         GUIVWwH6u0rgEhiokBYIN59kjj4Q/NdRW0Km1lvHrrsiLkqvzRHO614yffszTa4jALBl
         CWI069rFFWPXuIBPnz8+ds/u5QjLM734Y5dSkR+M0xrWqtQtzIzwwvIG7lsWOZX/OYCZ
         L8vvaV7chfGWFdoegeQWeayDbG9Y3Mx8NuOh9rH8eLEW0frd2x69pTttaGI3ty/Zedsq
         pteZTzuoqX2DYn3sEsOWymKQPxkRyNj3pmAd3FP+BVpmsVShsTC+KzmobT2Mq6HUhUJn
         A0ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=IeemFzsSiohKomkxMbxDaIUsJY5NfnLt66zMP/+4MsQ=;
        b=qmsUUoHN8kdhH8vdJTSCTQPtzi8yFXr1INiM0UqJg9ebaKztnWzt1IHMDyaSTwLTwK
         sHp7woWMiqrW1GslmX7Cv7hXPEEqKO9oAuRQTfUmGIBWeN2YeJ4IKtHDLEq1X8uf1+Fl
         j0xZ8liLDTAjtPJeqZhRk3CYwqhOaknQJBVR1/V/eB2TGBn7OHObm2afFNTwmBKXjWaT
         nm8ddT+dzM8eWmD6dYT8zNoGpdkl3vnSoRsiTUWj5oat3xP6H0PWkiLaa3uytTEngqwL
         9Hvdk7UeX7DYnEo9gZF0P0JaX+X61SDsTis8zsEugZukgysQlJfo5HISFv9K0soUwYN+
         tm7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 19:58:35 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, keescook@chromium.org,
	josh@joshtriplett.org, teg@jklm.no, wagi@monom.org,
	hdegoede@redhat.com, andresx7@gmail.com, zohar@linux.vnet.ibm.com,
	kubakici@wp.pl, shuah@kernel.org, mfuzzey@parkeon.com,
	dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
	broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, cantabile.desu@gmail.com, ast@fb.com,
	hare@suse.com, jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
	davem@davemloft.net, maco@android.com, arve@android.com,
	tkjos@android.com, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v5 0/6] firmware_loader: cleanups for v4.18
Message-ID: <20180504195835.GU27853@wotan.suse.de>
References: <20180504174356.13227-1-mcgrof@kernel.org>
 <m3lgczcjt7.fsf@pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3lgczcjt7.fsf@pm.waw.pl>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599556382367072293?=
X-GMAIL-MSGID: =?utf-8?q?1599564857598233603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 09:17:08PM +0200, Krzysztof Halasa wrote:
> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
> 
> >   * CONFIG_WANXL --> CONFIG_WANXL_BUILD_FIRMWARE
> >   * CONFIG_SCSI_AIC79XX --> CONFIG_AIC79XX_BUILD_FIRMWARE
> >
> > To this day both of these drivers are building driver *firmwares* when
> > the option CONFIG_PREVENT_FIRMWARE_BUILD is disabled, and they don't
> > even make use of the firmware API at all.
> 
> Don't know for sure about Adaptec, but wanXL firmware fits every
> definition of "stable". BTW it's a 1997 or so early PCI card, built
> around the PLX PCI9060 bus mastering PCI bridge and Motorola 68360
> (the original QUICC) processor. Maximum bit rate of 2 Mb/s on each sync
> serial port.

So we can nuke CONFIG_WANXL_BUILD_FIRMWARE now?

> It's more about delivering the .S source for the firmware, I guess.
> Nobody is expected to build it. The fw is about 2.5 KB and is directly
> linked with the driver.

:P Future work I guess would be to just use the firmware API and stuff
it into linux-firmware?

  Luis
