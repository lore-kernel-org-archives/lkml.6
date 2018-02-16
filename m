Return-Path: <akpm@linux-foundation.org>
X-Google-Smtp-Source: AH8x227bkbOSHHfFdYnHTpqAtdTaxl891vVG8lEf2akCxIQL7KgJZMFOEhvI6fwZmQK5IVaGOIVK
ARC-Seal: i=1; a=rsa-sha256; t=1518813102; cv=none;
        d=google.com; s=arc-20160816;
        b=rjl3B6VGqEQb0CjzekNKE9T2fSYp2QzNw4QEaqZlZs5NedQZQtiUmqCxbT73EwO52S
         2dkuH4pCsxz6gYKoS/jnYzxvUKBkyXphKv521xYb40HJugtZTPLmANHvQAmDtlUVf3mT
         x8blqDQgt426lN1hnoI+uYaqLTv6Xq6vduO4EvQgOlJnwNwD2OTT7ZGIfuEn0ahsZmE1
         BIKx1MPmJtDQtQIMtx72rDyJR8fB9ggnbRFi1hKKw9NKzSmeYVyMbXizpBF702BvDJdp
         h7MDvk6xm4UiHJzJPQRrlIu5zMG4iMRLFb1V8oQFrM8NEKO4VuGVpWbSnEOtg1LYc866
         QzUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=dek5TFDn/WLIwJiHOOdMvOmbdbVoqsM73m/WPwS/1VI=;
        b=ts30rnFXykWGHfvG5+rheCOYiOjJckzvnNKRF55k9uEp26DHRNrXDsiPqIr+PjWwVH
         zNg2HNlzwp2yddHaeHUBpobUx5FvSvOlxowKC1AcTWUFEKf1NSZscrvhKfFce1BrRjmI
         WrgtOzjb5k069hdIgA5I6S4jrpKMpHDFVAonwwFGmmI5erlRdLjRUk5JMnWJZUkbxKPt
         Ixm+CYHMv6fQ+33r4+eC9/2EwDYG0hgt8NoUDgjXLkLqEFF/lkjAOgJ7GQhb3u8PdN+K
         CojF2Q7jLBDRlpXct3CtUdGf+scwrEdyTzL9wOGeQPobu94XlipYnN5jspXBNecwuZbS
         3Rhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.92 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning akpm@linux-foundation.org does not designate 104.133.9.92 as permitted sender) smtp.mailfrom=akpm@linux-foundation.org
Date: Fri, 16 Feb 2018 12:31:39 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Joe Perches <joe@perches.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Yash Omer
 <yashomer0007@gmail.com>, gregkh@linuxfoundation.org,
 devel@driverdev.osuosl.org, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: Re: [RFC patch] checkpatch: test identifier lengths
Message-Id: <20180216123139.84c4efe02dc40ed333d886e7@linux-foundation.org>
In-Reply-To: <1518801207.13169.15.camel@perches.com>
References: <20180216113634.12848-1-yashomer0007@gmail.com>
	<20180216125519.odsteynuaielxpet@mwanda>
	<1518801207.13169.15.camel@perches.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592578499665778653?=
X-GMAIL-MSGID: =?utf-8?q?1592590967436054819?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 16 Feb 2018 09:13:27 -0800 Joe Perches <joe@perches.com> wrote:

> On Fri, 2018-02-16 at 15:55 +0300, Dan Carpenter wrote:
> > On Fri, Feb 16, 2018 at 05:06:34PM +0530, Yash Omer wrote:
> > > This patch fix line should not end with open parenthesis found by checkpatch.plscript.
> > > 
> > > Signed-off-by: Yash Omer <yashomer0007@gmail.com>
> > > ---
> > >  drivers/staging/nvec/nvec.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> > > index 52054a528723..39fb737543b5 100644
> > > --- a/drivers/staging/nvec/nvec.c
> > > +++ b/drivers/staging/nvec/nvec.c
> > > @@ -383,8 +383,8 @@ static void nvec_request_master(struct work_struct *work)
> > >  		msg = list_first_entry(&nvec->tx_data, struct nvec_msg, node);
> > >  		spin_unlock_irqrestore(&nvec->tx_lock, flags);
> > >  		nvec_gpio_set_value(nvec, 0);
> > > -		err = wait_for_completion_interruptible_timeout(
> > > -				&nvec->ec_transfer, msecs_to_jiffies(5000));
> > > +		err = wait_for_completion_interruptible_timeout
> > > +			(&nvec->ec_transfer, msecs_to_jiffies(5000));
> > 
> > The original code is basically fine...  It's OK to ignore checkpatch in
> > this situation.
> 
> Right.

Yes, I'd say that checkpatch is simply wrong here.  I'd prefer that a
function call always have the opening paren hard up against the
function name.  Because I often search for "foo(" to find the callsites
of foo() and I expect that some code-parsing tools do the same thing. 
The "(" is the application of an operator to an identifier.

So I'd vote for simply nuking that checkpatch warning altogether. 
Maybe there are other situations in which it is useful, dunno.
