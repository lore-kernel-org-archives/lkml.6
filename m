Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3199923-1518625230-2-13167421394106839461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518625230; b=Hb3d9ESpmKRo931LYAoolGmRN+uC9YJ6CKMUd6iBq4iKmN7
    eq0Ych6xzfXxz9F3YIFEAG2aWuYCyQu6CD2fTqAj1/dI+CEtvUFow9qDfTxdSR39
    mSGYt7vtUXvvxe9IHHDEp+ljx45d2nk2ABVUKHgCx4uwrQWyOmcmlVdRAqJUU/pC
    vA6gvAnje8KcXhNdOcYLicpcqpP9a4GdD2vKrL78gt/aI0wjLDVM5qBCYswLWwiN
    B1rFF4cwvo3FiEqgDRK8+r5A9EyaaTbfzVQ9/tuuuDcTpt9tRLMJEqR7GP7LRSzL
    1UJttKmSqoCVIGOBvKP3Spsrlcbpn90ZaWHs2cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518625230; bh=vdrvJRGadUbGDZ4Z74E5eYspCYNSVQwkXNmZ4/+fuf8=; b=I
    TK872bnArWFZXDGq0rq3H+HfjBLjxQGebJq5p6PMwCLYlIRIL4D5vHmAP7wfzmAa
    4CQd2okrgZcYxzZI1SjR/ecrGKQ8dOzpNOER+pxp4XqzkZQYUjnhSkjGFkCyzvmV
    Gff2+kJZdRX239YDO1ZGlZXTsWG3Aon4mfXJwAksdlxpT1b/A/gQgacU8qLnq0x5
    G//zNhD/g8r1PKjSby3HILn8Y/pqsIBDempsasNwvoDeUWua8fPxrmjaiGaNJz4h
    jdAPUvXU993+k2l9VlksubN+PHst4vFEKl2U6bRYLAztGQUhdzrDzW611W+LrJAu
    3rmkJT+AjEoDlLQeC21ag==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032206AbeBNQU1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 11:20:27 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:55252 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032203AbeBNQU0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Feb 2018 11:20:26 -0500
Message-ID: <1518625223.3422.19.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 20/87] ALSA: pcm: Allow aborting mutex lock at OSS
 read/write loops
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Takashi Iwai <tiwai@suse.de>
Cc: stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Wed, 14 Feb 2018 16:20:23 +0000
In-Reply-To: <s5hfu66a9nz.wl-tiwai@suse.de>
References: <20180115123349.252309699@linuxfoundation.org>
         <20180115123351.309626066@linuxfoundation.org>
         <1516750548.3417.34.camel@codethink.co.uk> <s5hfu66a9nz.wl-tiwai@suse.de>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-02-12 at 09:34 +0100, Takashi Iwai wrote:
> On Wed, 24 Jan 2018 00:35:48 +0100,
> Ben Hutchings wrote:
> > 
> > On Mon, 2018-01-15 at 13:34 +0100, Greg Kroah-Hartman wrote:
> > > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > > 
> > > ------------------
> > > 
> > > From: Takashi Iwai <tiwai@suse.de>
> > > 
> > > commit 900498a34a3ac9c611e9b425094c8106bdd7dc1c upstream.
> > > 
> > > PCM OSS read/write loops keep taking the mutex lock for the whole
> > > read/write, and this might take very long when the exceptionally high
> > > amount of data is given.  Also, since it invokes with mutex_lock(),
> > > the concurrent read/write becomes unbreakable.
> > > 
> > > This patch tries to address these issues by replacing mutex_lock()
> > > with mutex_lock_interruptible(), and also splits / re-takes the lock
> > > at each read/write period chunk, so that it can switch the context
> > > more finely if requested.
> > 
> > [...]
> > > @@ -1414,18 +1417,18 @@ static ssize_t snd_pcm_oss_write1(struct
> > >  			xfer += tmp;
> > >  			if ((substream->f_flags & O_NONBLOCK) != 0 &&
> > >  			    tmp != runtime->oss.period_bytes)
> > > -				break;
> > > +				tmp = -EAGAIN;
> > >  		}
> > > + err:
> > > +		mutex_unlock(&runtime->oss.params_lock);
> > > +		if (tmp < 0)
> > > +			break;
> > >  		if (signal_pending(current)) {
> > >  			tmp = -ERESTARTSYS;
> > > -			goto err;
> > > +			break;
> > >  		}
> > > +		tmp = 0;
> > >  	}
> > > -	mutex_unlock(&runtime->oss.params_lock);
> > > -	return xfer;
> > > -
> > > - err:
> > > -	mutex_unlock(&runtime->oss.params_lock);
> > >  	return xfer > 0 ? (snd_pcm_sframes_t)xfer : tmp;
> > >  }
> > 
> > [...]
> > 
> > Some of the "goto err" statements in the loop are conditional on tmp <=
> > 0, but if tmp == 0 this will no longer terminate the loop.  Is that
> > intentional or a bug?
> 
> The patch rather fixes the endless loop: the signal_pending() check is
> added after goto err, so that it aborts the loop properly.

Let me rephrase then: if snd_pcm_oss_write2() returns 0, does that
imply that signal_pending() is true?  If there is any other reason that
it could return 0, then this appears to introduce a bug.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
