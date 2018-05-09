Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZo18tC5h9aBPKDfkAJlUA+P/2WEUiUg0CXXGjA9/uYrRoKU0SZirKxxvmZIjL0n+AXGQ6rc
ARC-Seal: i=1; a=rsa-sha256; t=1525893311; cv=none;
        d=google.com; s=arc-20160816;
        b=ZFfntvLr85OH7PF2sXUwMgn24M54+1n6iz0Y7Qaw1NugKjjsrOKLLGGnhszjSkJ5ga
         bQpuAQk6RTKOaQJ9fYM52UaeMmK0VY5SmLn90RlAp5XLR81oEsGTkclTB1MIbOxFUHYd
         SEudqflDczTjaJ0A4I7WFuc4ZTPjZKOnyz0G9NwshvEps2iYE0JQBDTiYqov8Wv2JAf1
         /lZxgYbNUfkhA+2YvHy/L+CJF0LbzmF/zhcwj+E6UtGJkc1ELCVRAUDhPEGRrB/OHcNw
         /AJfotlkgBIDtGzo4dYEHNkuq/mBogskUX8Pz3j8jihD2aqGFGwXAhys4GIBdB+BUoTy
         PHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=y6+ISbxYA8Mv4wTfjhCYLCOYUSCrOzXxt/K5ug6gA0I=;
        b=cRJPeVLY2hkQYhO4Cfjj1+5WEhZlaap/ZkmpJRGyWHbmooMR8Krcevel8tMd1t+ltf
         Iq7RjC5SHNgR+IY4h5LDwJ3X2S5FTXwiV7wElmHY2/tre3Bu7iji6QcSU56hZ4DlPYXg
         Ky2j4etxvx9x1CAVGQl2A5YAjNPYhTtihhml/QZ2gbZXeDpmliroCkvq/YzF0Tve6Ubt
         ThiSsPAJJraRvbHNJczUJLZdnvxK0Cdk3X3j59KPmeWdS4zTS9TZyHk3h45dK9IR79pC
         IbE/H/NMp3/ieMrwyc3HJ+2qarldEteEEbhdFy8BY8N8/u/hvQdBmiSxQBCLQUJdX5XH
         AAnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 19:15:08 +0000
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
Message-ID: <20180509191508.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
 <20180504000743.GR27853@wotan.suse.de>
 <1525393466.3539.133.camel@linux.vnet.ibm.com>
 <20180508173404.GG27853@wotan.suse.de>
 <1525865428.3551.175.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525865428.3551.175.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600015105411225645?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 07:30:28AM -0400, Mimi Zohar wrote:
> On Tue, 2018-05-08 at 17:34 +0000, Luis R. Rodriguez wrote:
> > On Thu, May 03, 2018 at 08:24:26PM -0400, Mimi Zohar wrote:
> > > On Fri, 2018-05-04 at 00:07 +0000, Luis R. Rodriguez wrote:
> > > > On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> > > > > Allow LSMs and IMA to differentiate between signed regulatory.db and
> > > > > other firmware.
> > > > > 
> > > > > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > > > > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > > > > Cc: David Howells <dhowells@redhat.com>
> > > > > Cc: Kees Cook <keescook@chromium.org>
> > > > > Cc: Seth Forshee <seth.forshee@canonical.com>
> > > > > Cc: Johannes Berg <johannes.berg@intel.com>
> > > > > ---
> > > > >  drivers/base/firmware_loader/main.c | 5 +++++
> > > > >  include/linux/fs.h                  | 1 +
> > > > >  2 files changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > > > > index eb34089e4299..d7cdf04a8681 100644
> > > > > --- a/drivers/base/firmware_loader/main.c
> > > > > +++ b/drivers/base/firmware_loader/main.c
> > > > > @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> > > > >  			break;
> > > > >  		}
> > > > >  
> > > > > +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > > > > +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> > > > > +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> > > > > +			id = READING_FIRMWARE_REGULATORY_DB;
> > > > > +#endif
> > > > 
> > > > Whoa, no way.
> > > 
> > > There are two methods for the kernel to verify firmware signatures.
> > 
> > Yes, but although CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is its own kernel
> > mechanism to verify firmware it uses the request_firmware*() API for
> > regulatory.db and regulatory.db.p7s, and IMA already can appraise these two
> > files since the firmware API is used.
> 
> IMA-appraisal can verify a signature stored as an xattr, but not a
> detached signature.  That support could be added, but isn't there
> today.  Today, a regulatory.db signature would have to be stored as an
> xattr. 

Right, my point was that if someone has IMA installed:

	a) they would add those xattr to files in /lib/firmware/ already
	b) upon request_firmware*() calls a security hook would trigger
	   which would enable IMA to appraise those files. So not only
	   would the kernel in turn do double checks on regulatory.db,
	   but also a check on regulatory.db.p7s as well.

The difference I suppose is IMA would use a hash function instead of signature
check, correct?

> > As such I see no reason to add a new ID for them at all.
> > K
> > Its not providing an *alternative*, its providing an *extra* kernel measure.
> > If anything CONFIG_CFG80211_REQUIRE_SIGNED_REGDB perhaps should be its own
> > stacked LSM. I'd be open to see patches which set that out. May be a
> > cleaner interface.
> > 
> > > If both are enabled, do we require both signatures or is one enough.
> > 
> > Good question. Considering it as a stacked LSM (although not implemented
> > as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> > IMA though, then surely I agree that enabling
> > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> > system integrator to decide.
> 
> Just because IMA-appraisal is enabled in the kernel doesn't mean that
> firmware signatures will be verified.  That is a run time policy
> decision.

Sure, I accept this if IMA does not do signature verification. However
signature verification seems like a stackable LSM decision, no?

> > If we however want to make it clear that such things as
> > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> > could just make the kconfig depend on !IMA or something?  Or perhaps a new
> > kconfig for IMA which if selected it means that drivers can opt to open code
> > *further* kernel signature verification, even though IMA already is sufficient.
> > Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?
> 
> The existing CONFIG_IMA_APPRAISE is not enough.  If there was a build
> time IMA config that translated into an IMA policy requiring firmware
> signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
> be sorted out at build time.

I see makes sense.

> > > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > > to handle regdb files differently.
> > 
> > That's not the main concern here, its the precedent we are setting here for
> > any new kernel interface which open codes firmware signing on its own. What
> > you are doing means other kernel users who open codes their own firmware
> > signing may need to add yet-another reading ID. That doesn't either look
> > well on code, and seems kind of silly from a coding perspective given
> > the above, in which I clarify IMA still is doing its own appraisal on it.
> 
> Suppose,
> 
> 1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
> "CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.
> 
> 2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
> "CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
> appraises the firmware signature could be defined.  In this case, both
> signature verification methods would be enforced.
> 
> then READING_FIRMWARE_REGULATORY_DB would not be needed.

True, however I'm suggesting that CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
could just be a mini subsystem stackable LSM.

Its not clear to me why we need to add a new READING id to any open coded
firmware signature checks if we don't have this futuristic option
CONFIG_IMA_APPRAISE_FIRMWARE.

Yes it provides *more*, but IMA is still seeing the exact file descriptor
and do its own thing.

  Luis
