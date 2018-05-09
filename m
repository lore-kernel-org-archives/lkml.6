Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZqjVmisb7dVfqwUvT8igQwAjeKMIMzsMwdP7hkKtv3Iu/HQK2SWVU0nek5mfFM1M0YdiUZF
ARC-Seal: i=1; a=rsa-sha256; t=1525900933; cv=none;
        d=google.com; s=arc-20160816;
        b=zyt4Hgd8PQnvFljZqsVsFKJEWvfGP/febFWbFcexLSHp0LsCLXFxgOMXxdzxblOgT6
         rxS+0WLvD6NSCZrRkj8oz5BQFjakHPeI/aZahUX/z9trB1IhIsnGargHDbiIK+oKfFpK
         IRNWGIb/stBRnOsaMdyLUqx/DukR4bpvQnKEk3GVvy54j0NDdCduubxjvGRpVmevQ2sx
         djvW0hvTetZ9Z9qrBkFJby5EWzIr2Rav4DmG1ZBoSa+dW/w5QTddWeakgWpN611LBvIN
         nqrY7MCcC/lEUWO2QoXTYSSQsL6AOKry++cs8YgJiPhxuoQm9fhaR3ZXCuMVRVdKYRRH
         8XOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=9YD7VZ4DoSyeY1q+qzyArWXssCIeBdSqI1sKdoCssr4=;
        b=kaXIMLJUopIlyL/IzFYmPyMWkR+ezWiHgfgsC9x04i0VAsAd6fjwGaHWu8wARSJSTX
         tMwk0MTOMSjElWAIuUCEjNgIVTjCC+Exh+N6zxzUWjHfEL0A6y6eYSK20PJq5TijD9WX
         GyeMc3smlxqXyJy2I2VYjzX1NFcDtSNeb9wu6lv4/PltHrdOIOBjP2mL1CoLVYnVInPh
         ejV0HoHxYR2Aa/DmeCnqpSI1BRhfm7LEdttDahaQZGdY0QYxPoluWZDeLVjBj7RXyv8v
         3iaI3kb+Z9dYPLptqI8L+Z+9kNZpj7hf1hc/Xri2kemMsypLR6PPCmlsW+Mi2m2sj+En
         quLw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 21:22:12 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Seth Forshee <seth.forshee@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-integrity@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Peter Jones <pjones@redhat.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andres Rodriguez <andresx7@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 3/6] firmware: differentiate between signed regulatory.db
 and other firmware
Message-ID: <20180509212212.GX27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
 <20180504000743.GR27853@wotan.suse.de>
 <1525393466.3539.133.camel@linux.vnet.ibm.com>
 <20180508173404.GG27853@wotan.suse.de>
 <1525865428.3551.175.camel@linux.vnet.ibm.com>
 <20180509191508.GR27853@wotan.suse.de>
 <1525895838.3551.247.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525895838.3551.247.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600023097601846623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 03:57:18PM -0400, Mimi Zohar wrote:
> On Wed, 2018-05-09 at 19:15 +0000, Luis R. Rodriguez wrote:
> 
> > > > > If both are enabled, do we require both signatures or is one enough.
> > > > 
> > > > Good question. Considering it as a stacked LSM (although not implemented
> > > > as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> > > > IMA though, then surely I agree that enabling
> > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> > > > system integrator to decide.
> > > 
> > > Just because IMA-appraisal is enabled in the kernel doesn't mean that
> > > firmware signatures will be verified.  That is a run time policy
> > > decision.
> > 
> > Sure, I accept this if IMA does not do signature verification. However
> > signature verification seems like a stackable LSM decision, no?
> 
> IMA-appraisal can be configured to enforce file signatures.  Refer to
> discussion below as to how.
> 
> > > > If we however want to make it clear that such things as
> > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> > > > could just make the kconfig depend on !IMA or something?  Or perhaps a new
> > > > kconfig for IMA which if selected it means that drivers can opt to open code
> > > > *further* kernel signature verification, even though IMA already is sufficient.
> > > > Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?
> > > 
> > > The existing CONFIG_IMA_APPRAISE is not enough.  If there was a build
> > > time IMA config that translated into an IMA policy requiring firmware
> > > signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
> > > be sorted out at build time.
> > 
> > I see makes sense.
> 
> Ok, so instead of introducing READING_FIRMWARE_REGULATORY_DB, I'll
> post patches introducing CONFIG_IMA_APPRAISE_FIRMWARE, as described
> above.

OK, its still not clear to what it will do. If it does not touch the firmware
loader code, and it just sets and configures IMA to do file signature checking
on its own, then yes I think both mechanisms would be doing the similar work.

Wouldn't IMA do file signature checks then for all files? Or it would just
enable this for whatever files userspace wishes to cover?

One of the things with READING_FIRMWARE_REGULATORY_DB is to also use and trust
the wireless-regdgb maintainer's key for this file, could IMA be configured to
do that?

Because that would be one difference here. The whole point of adding
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB was to replace CRDA which is a userspace
component which checks the signature of regulatory.db before reading it and
passing data to the kernel from it.

Now, however silly it may be to have CONFIG_IMA_APPRAISE_FIRMWARE *and*
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB, is your intent in this new patch set
you are mentioning, to still enable both to co-exist?

> > > > > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > > > > to handle regdb files differently.
> > > > 
> > > > That's not the main concern here, its the precedent we are setting here for
> > > > any new kernel interface which open codes firmware signing on its own. What
> > > > you are doing means other kernel users who open codes their own firmware
> > > > signing may need to add yet-another reading ID. That doesn't either look
> > > > well on code, and seems kind of silly from a coding perspective given
> > > > the above, in which I clarify IMA still is doing its own appraisal on it.
> > > 
> > > Suppose,
> > > 
> > > 1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
> > > "CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.
> > > 
> > > 2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
> > > "CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
> > > appraises the firmware signature could be defined.  In this case, both
> > > signature verification methods would be enforced.
> > > 
> > > then READING_FIRMWARE_REGULATORY_DB would not be needed.
> > 
> > True, however I'm suggesting that CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > could just be a mini subsystem stackable LSM.
> 
> Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
> would differentiate between other firmware and the regulatory.db based
> on the firmware's pathname.

If that is the only way then it would be silly to do the mini LSM as all
calls would have to have the check. A special LSM hook for just the
regulatory db also doesn't make much sense.

> Making regdb an LSM would have the same issues as currently - deciding
> if regdb, IMA-appraisal, or both verify the regdb's signature.

Its unclear to me why they can't co-exist yet and not have to touch
the firmware_loader code at all.

  Luis
