Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AIpwx498olwNCU/7+cSqKFdU6fFi+i8Fg76NAQH6rZJuj0k3wZiTkAsmS2qkDkngmFv0Ir9ImSKi
ARC-Seal: i=1; a=rsa-sha256; t=1524321293; cv=none;
        d=google.com; s=arc-20160816;
        b=W5iRbPCR/HeRSLvyCp/gmUNR1zlpOk5U8qaM560BxF5HLrllMrEO3T4GTA5t7Zm6NB
         1Iv+Lh0+jRRSm3IIbNi9ihJHBUfXjkP6rS2mfKzphH009Twrm9CKc1dMAGs8ML2Ag+Im
         L8B9e/n2ZIiN8oP25s/FAq3bTUNjCze0R0CRLcHPFU6sYJN9YPjNEaDGfaI2l55yoOKC
         5qAH6+v+DS7TC4YvjjdbHl+nViJ3J0rTzGnf66NbiTCccgBKhaXxf8UoqYjhQ/BY2p/6
         PQBSyfnBN+eWAtR/CKVExE59j6MvYnjuTm7kckcWk9MupPZCtPHqWx5q5vuzoX49byzi
         zqyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=BewBV/a6xbj41A7paUJPwKNubJ5snrFhPJjYRcdi/vE=;
        b=e4Y7jkTOAHGzZcohe9KzvlBYYFpEJT9BWOaatArNUf7429lVcHp/71txp951Zxsmo+
         hoHpTm1P/i7Z9SknOZBuVVY/oUEVygqCxght5m1fHSkJlYnrYsOUtVIzj/5Hm8rWTG8J
         A001zO3h/wpqtuI5X+E9AWvxKnPkqRCv8oZS7SvaEPF2PSw/kiDvRXBIDm6kGB1iWAEm
         Fzy2+RCT/0zgXsqVmV0GMgu4Qunwpk4gRhh9i+JvO4IW3/k+lmUSBQMRZe0vAp7XaUlp
         RfOAVmtnVMHxWYOiQOj5cUo3B55jyk4epeV33JYSoPd8QtRZFTF/NfgBgMyn5vOgX0AV
         0+GA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93CFD2168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 21 Apr 2018 15:34:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, "Andrew F . Davis" <afd@ti.com>, Fabio Estevam
 <festevam@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt
 and voltage-divider
Message-ID: <20180421153452.6499e151@archlinux>
In-Reply-To: <f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
	<20180410152802.30958-2-peda@axentia.se>
	<f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373529205381513?=
X-GMAIL-MSGID: =?utf-8?q?1598366724687081055?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 16 Apr 2018 16:00:44 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-10 17:28, Peter Rosin wrote:
> > +Example:
> > +The system voltage is circa 12V, but divided down with a 22/200
> > +voltage divider to adjust it to the ADC range.
> > +
> > +SYSV        ADC       GND
> > +  +          +         +
> > +  |  .-----. | .----.  |
> > +  '--| 200 |-+-| 22 |--'
> > +     '-----'   '----'
> > +
> > +sysv {
> > +	compatible = "voltage-divider";
> > +	io-channels = <&maxadc 1>;
> > +
> > +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
> > +	numerator = <222>; /* 200 + 22 */
> > +	denominator = <22>;
> > +};  
> 
> While I already got a reviewed-by from Rob, and maybe I shouldn't be
> stirring the pot, but I had an umpteenth look and I now think this
> one looks a bit odd. It shows a bit that it originates from when the
> compatible was the very generic "io-channel-unit-converter" in v1
> of the series. What I mean is that a voltage divider presumable always
> gets you a lower voltage. Therefore, one would assume that the
> denominator should be larger than the numerator. The fact that this
> translates into the inverted fraction when calculating backwards
> through the voltage divider should probably not affect the binding.
> 
> So, in the above example, I think it would make more sense to have
> 
> 	numerator = <22>;
> 	denominator = <222>; /* 200 + 22 */
> 
> (and then, naturally, adjust the driver to invert the fraction)
> 
> Comments?
Agreed - it is odd as we currently have it.  I wouldn't have
a particular problem with renaming this compatible as voltage
scaler (voltage multiplier has a specific meaning we should avoid
stepping on!)  Anyhow, either way is fine with me, but I agree
the current version is odd.

Jonathan

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
