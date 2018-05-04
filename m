Return-Path: <npiggin@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525412257; cv=none;
        d=google.com; s=arc-20160816;
        b=zdz3UiZog9InwvddNNbfYv4bBnWipPmYscykt0mmuk/L/m6XjO3wglCDZAdvIhPKv3
         k4qX/7/T30MBfVzzOpGYaS8CQG3jrUpOWzirR0L8NK2TFVpMK2v415G59O7GzQFVcwll
         V3fXZEar6sm3ekiasmDiOPgmKr9vRGAXbzAe6d/ZPmk7d97ZaL5vTwHBM8p1fC1sIi+v
         fdvWfHiz54Z0Lk+yu19wioXls6Hgr27F2ZzZEoQB5JR7HGkb0VAkBUtW7FQ2p7uc+T3s
         1jOP3FJ8OcehBxSygTiz1dMp6v6A7kYfpFgn7m+m1sunSSMLL4aNSngycpnPXYvZBAJJ
         zn/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=KCPkqm2Mdsd77N3GjnKSznS5oHUrZjxEW97OPi0Jmx0=;
        b=XAdMo+KL5ZTQH1Ewe3fVWz5HZai7MCFLSPHV70Bxw/6DN2XJWfRluQs3HNoJQvIbM8
         GbJj0IUcqvIYgi6SQjPSw4hcKAXsBcb3fUUuF0lhBpxNrK7SfhKc1NOqSIrjVqxL8g7e
         C3rDYolopuwtHWdRVWvU/zedHaWKP/lfynmZYdUoH8L1DeYeZtr6lIt7ylZ51ZNYGyiM
         Jhi4iWrfjlO2cqRpaLSUmRD36+thQGZ/IB1D6dodXN66yNWI0/YrumPJxB2cGpeuozKs
         lqLOsNGNoqaSCilt2WSViDh6S7mqsBeo9gIC4A6+IKFdCtGSj/BVRV70MQhwPdB7Yi2y
         TwFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c5MX41Ke;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=c5MX41Ke;
       spf=pass (google.com: domain of npiggin@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=npiggin@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZrd7jcW7OFkZPhewPQajnaJ0BgyDnBJrZY2nuvYV4r5ha0tcBGsMcAQOV5TVHvlZNdQDjQARA==
Date: Fri, 4 May 2018 15:37:17 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Jiri Slaby <jslaby@suse.com>,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/15] powerpc/powernv: opal-kmsg use flush fallback
 from console code
Message-ID: <20180504153717.4806d9c4@roar.ozlabs.ibm.com>
In-Reply-To: <87muxg80ga.fsf@concordia.ellerman.id.au>
References: <20180430145558.4308-1-npiggin@gmail.com>
	<20180430145558.4308-5-npiggin@gmail.com>
	<87muxg80ga.fsf@concordia.ellerman.id.au>
Organization: IBM
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599183451122520462?=
X-GMAIL-MSGID: =?utf-8?q?1599510682711498930?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 04 May 2018 15:16:37 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > Use the more refined and tested event polling loop from opal_put_chars
> > as the fallback console flush in the opal-kmsg path. This loop is used
> > by the console driver today, whereas the opal-kmsg fallback is not
> > likely to have been used for years.
> >
> > Use WARN_ONCE rather than a printk when the fallback is invoked to
> > prepare for moving the console flush into a common function.  
> 
> Do we want to add a WARN in that path? If we're panicking things might
> get worse if we WARN (which takes a trap).

True, probably a good idea not to... oh there's a printk_once so
that'll work nicely.

Thanks,
Nick
