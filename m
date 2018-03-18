Return-Path: <jic23@kernel.org>
X-Google-Smtp-Source: AG47ELtcmHxBvGUnafsOzIKzlkR9y3LDAYy+d+mphYd6cIOzQLl/mZlbTjAmVcsN+A9rF8vPVT0Q
ARC-Seal: i=1; a=rsa-sha256; t=1521368112; cv=none;
        d=google.com; s=arc-20160816;
        b=c0S5Vjx8Pios61Cntv9cS5ro0sl1ML8V6w2pzxO4+dY8Xnudsubpm9SUr9NY4NrAMs
         gE/y+yOAJuzqCdl7dVDwzXU/0ybnf+5h8SzBzhKV5kkOZ32tVgIBClAzhxtlCXbxps0Q
         w3+4NQONbbf3tvnt9YpunpQkf/DAWg8KYPGbS7Ddth0eNUywVrmZPp+pxD3A7Hgnk2jA
         4yboZxQgRQuL3rSe9VCeyRGCT6fz3usL7kmtNy2hoQzsUtXTJ1nLW9FPPdMjrX2qGlhW
         fa9zzYdigXHja74GxsUgTVYj4DKJKjeIuUZ/xI3pwbCKtSVTkdbc4s2KjCSLceMXkjeJ
         OsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=/F3nMGTR/iCuIg/nzCELhYlSrQiWC9s2W18VZ+kAOts=;
        b=TlHnBsvki/jbJJhhkZyMfeBYuI2wiK1PUQGOowLuZZYhxzVVTl9E7ztpT4hR0VJufC
         WNrTXPZowauY4URThTRX767yKDj2Wx+qK3xwatNJsrjAPbiWgfm2NGSnajic3aKhWS/M
         x5DVaClkpPIuWdvHHVQrh95ynFwb7y1R/FkZZshP5OpCg9QJL2N17ktd2Ov0jQ7v/ybO
         w3QS/kj5VNx5Qo+hq86yIA4R3r30DZZs8XNmo3xKnHMXAzYX/N45zmPVnyCaBoiYElgA
         ps90FIx40B14vHwKUZFLQ1aeIuDpBB3/MPPeQqS3qJddwIF6npZ9r7EfTdDI18ueJwQP
         IzZA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jic23@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=jic23@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868D20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 18 Mar 2018 10:15:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Pravin Shedge <pravin.shedge4linux@gmail.com>, Quentin Schulz
 <quentin.schulz@free-electrons.com>, LKML <linux-kernel@vger.kernel.org>,
 kernel-janitors@vger.kernel.org
Subject: Re: iio/gyro/bmg160_core: Improve unlocking of a mutex in five
 functions
Message-ID: <20180318101506.460f3967@archlinux>
In-Reply-To: <73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
References: <16623de4-351d-135b-f3ff-701a465c5d92@users.sourceforge.net>
	<20180317195422.037a8b57@archlinux>
	<73f0a187-57d1-c877-ba9f-3b15f6a61640@users.sourceforge.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594926606648991207?=
X-GMAIL-MSGID: =?utf-8?q?1595270089065063758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, 18 Mar 2018 09:19:47 +0100
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> Am 17.03.2018 um 20:54 schrieb Jonathan Cameron:
> > On Wed, 14 Mar 2018 16:15:32 +0100
> > SF Markus Elfring <elfring@users.sourceforge.net> wrote:
> >   
> >> From: Markus Elfring <elfring@users.sourceforge.net>
> >> Date: Wed, 14 Mar 2018 16:06:49 +0100
> >>
> >> * Add jump targets so that a call of the function "mutex_unlock" is stored
> >>   only once in these function implementations.
> >>
> >> * Replace 19 calls by goto statements.
> >>
> >> This issue was detected by using the Coccinelle software.
> >>
> >> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>  
> > 
> > Hi Markus,
> > 
> > Some of these are good and sensible changes  
> 
> Such feedback is nice.
> 
> 
> > - others break the code.  
> 
> Which concrete places do you find questionable here?
> 
> 
> >> -		return ret;
> >> +
> >> +		goto set_power_state;
> >>  	default:
> >>  		return -EINVAL;  
> > We exit with the mutex locked now and it should not be.  
> 
> I wonder about your source code interpretation here.
> The mutex was (and is still only) locked within case branches, isn't it?
> 
You are correct, this does however reflect the issue with the resulting
lack of balance here.  I saw the mutex was getting unlocked outside
the local scope and so assumed that it was also take outside the local
scope.  That isn't true, so we have hurt readability.

It might make sense to move the lock and unlock outside the switch statement
but we certainly don't want to the the confusion that the lack of balance is
causing here.

I read it quickly and got the wrong idea which generally implies it is not
as clear as we would like.

Hence this change isn't going anywhere I'm afraid.

Jonathan

> 
> >   
> >>  	}
> >>  
> >>  	return -EINVAL;  
> > Mutex is still locked here and the return is wrong.  
> 
> Should this statement get any more software development attention?
> 
> Regards,
> Markus
