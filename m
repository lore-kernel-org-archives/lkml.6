Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqpjCSqyvukgMT5bOLrqOBIN7rKR+K+NMMTG532XZRNGwGjsyoBstANiq3m9xXPkldJ4h3H
ARC-Seal: i=1; a=rsa-sha256; t=1525994802; cv=none;
        d=google.com; s=arc-20160816;
        b=N7RRXSja9k8IKtWMGySc3PS1OKXH4TyXCdJKSeeIS0sJ2+8rqAlflDuXI5mZmAscs5
         YcPMx9z1tbPN9AcRPCgAEwRIT6vJousSGR2U4NcBGKq8+9lpB0udExX57aEhKHSQYx4B
         7nKsMIrDcVSBRhNp68K+3KPslCKTVqk1khug44eJQAX8c08sIQtffOcB8RUsPILS9twk
         9YqlMIqZ/8ET5SMwC29Y9Lmyj0Pj45ylT/RtqxTdi2wqCv9KQRBBOzOY3vpSF4wqqSwO
         CCFpM/9lEAqw2/wFS/75uA2uWEJUMXp61wvoB3ATdagecGXnffyWFXnMHge0EO+yr0p7
         qTcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=HMSszjfe7ACwfGYjwjw/dzTs3AbX0oE2qywohG6dX/s=;
        b=e/1/RFK/STCjahGSaDkZ+1Qhgid1ajq8KG6TYLeQGjhBahc2zUhl0MZ1yWkoQOaPvo
         VWkDcObU2P6oTslSG+StWtl7c8UPKI7wnfQubpowfv1tBRwBCaL31/r4Jkur+GwmQzc1
         ev9maZSscBGbfjG5cjXzK5+0H0o5CLSsabc5LAZYJ7LmNLiDLSfyOR+uRBUhwZRCO8sG
         jPh1UqIjpbQwRQd4Ud8jPViF9oUAlaXL2GYUklfnK3+3/iS+nPEqQx6y7mMoV4L8tRIh
         SQgy8oqv1bKGtlzCiSKxy2Tu+JBBtkx2x+hxY8wu1yvXKCQdvWvLoNsbgLAX/0GSYmgd
         FmFA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Thu, 10 May 2018 23:26:39 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Peter Jones <pjones@redhat.com>,
	"AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
	David Howells <dhowells@redhat.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Seth Forshee <seth.forshee@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-integrity@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andres Rodriguez <andresx7@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: [PATCH 3/6] firmware: differentiate between signed regulatory.db
 and other firmware
Message-ID: <20180510232639.GF27853@wotan.suse.de>
References: <20180504000743.GR27853@wotan.suse.de>
 <1525393466.3539.133.camel@linux.vnet.ibm.com>
 <20180508173404.GG27853@wotan.suse.de>
 <1525865428.3551.175.camel@linux.vnet.ibm.com>
 <20180509191508.GR27853@wotan.suse.de>
 <1525895838.3551.247.camel@linux.vnet.ibm.com>
 <20180509212212.GX27853@wotan.suse.de>
 <1525903617.3551.281.camel@linux.vnet.ibm.com>
 <20180509234814.GY27853@wotan.suse.de>
 <1525917658.3551.322.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525917658.3551.322.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600121526264523624?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 10:00:58PM -0400, Mimi Zohar wrote:
> On Wed, 2018-05-09 at 23:48 +0000, Luis R. Rodriguez wrote:
> > On Wed, May 09, 2018 at 06:06:57PM -0400, Mimi Zohar wrote:
> 
> > > > > Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
> > > > > would differentiate between other firmware and the regulatory.db based
> > > > > on the firmware's pathname.
> > > > 
> > > > If that is the only way then it would be silly to do the mini LSM as all
> > > > calls would have to have the check. A special LSM hook for just the
> > > > regulatory db also doesn't make much sense.
> > > 
> > > All calls to request_firmware() are already going through this LSM
> > > hook.  I should have said, it would be based on both READING_FIRMWARE
> > > and the firmware's pathname.
> > 
> > Yes, but it would still be a strcmp() computation added for all
> > READING_FIRMWARE. In that sense, the current arrangement is only open coding the
> > signature verification for the regulatory.db file.  One way to avoid this would
> > be to add an LSM specific to the regulatory db
> 
> Casey already commented on this suggestion.

Sorry but I must have missed this, can you send me the email or URL where he did that?
I never got a copy of that email I think.

  Luis
