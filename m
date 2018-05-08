Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZpSB9uSUfKo5umSZhshK8Ukg5FkvzLOO5+2375BJh5S3n3UlgBu5xwiQ7y+Qxe4aGugHNOT
ARC-Seal: i=1; a=rsa-sha256; t=1525800849; cv=none;
        d=google.com; s=arc-20160816;
        b=NMIdxQceJ3q4q25oLmHT2oiU69dYd46VhwBbmx1bcEpOc02/mbwZpFQmWDiJAuo9Ud
         mfB+Pa8E1khmkPKBGm3djc9TFLY06RRSZ+Xm435JSn9vYUFgN0sEnVOAoG2v2OFyBAfQ
         lTlb2a0Bl/aVyIHLtyZTFGex5xWngloMcLs9dLEAuvGxcefFQmLRdJ6ZW8UOyH5MmiMD
         d06RT1ncgxkfradvocZnV1R1lhHCWo2I6LUSrz1vwyYyEIuJ/0IYYmgYVwiC7GOp0jQ1
         KSY21K6eFw7CGZS7VMFt0hBXqEDdYLwpUnjbs4bS/gFc9bin4yC6X16staxZkGHvQGWh
         0iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:arc-authentication-results;
        bh=KT6owGCuhwRjJZYtdzMgWq5jyNZsfCPJS7os+stYG8s=;
        b=gNRzDjo1ngQvJfbV9qrIJn00MTPnfsawuJj46P6cVg2yUUUyyaoJxNmQXzV8cYCq87
         nTag8hCmHUOtQMzax0XczDBUjVpFuK534rnOygE20rZJFiOrsAwPHLhschjF77KC1Hhp
         DtRcFCKMpQzhPQLblkSvajSXxlu3wM5ymwV7tdC/gJd8hiRecfAkWo10/O7tKHpImVG4
         P8OAnTyQJd5Okf2I+9O49dHwUl215LMAWEI4CSoMVb8ZHz/nHuDgq1w7f2f3IQpSQKRD
         J/fIqxmqiQQtMyeho6mrvBfPIU6y62t/z9Xxj1xv4L3e/SGtQJRsYsvG46IrFzj0J/bL
         vf/w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Tue, 8 May 2018 17:34:04 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Kalle Valo <kvalo@codeaurora.org>,
	Seth Forshee <seth.forshee@canonical.com>,
	Johannes Berg <johannes.berg@intel.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>,
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
Message-ID: <20180508173404.GG27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
 <20180504000743.GR27853@wotan.suse.de>
 <1525393466.3539.133.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1525393466.3539.133.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1599918151822581294?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 08:24:26PM -0400, Mimi Zohar wrote:
> On Fri, 2018-05-04 at 00:07 +0000, Luis R. Rodriguez wrote:
> > On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> > > Allow LSMs and IMA to differentiate between signed regulatory.db and
> > > other firmware.
> > > 
> > > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > > Cc: David Howells <dhowells@redhat.com>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Seth Forshee <seth.forshee@canonical.com>
> > > Cc: Johannes Berg <johannes.berg@intel.com>
> > > ---
> > >  drivers/base/firmware_loader/main.c | 5 +++++
> > >  include/linux/fs.h                  | 1 +
> > >  2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > > index eb34089e4299..d7cdf04a8681 100644
> > > --- a/drivers/base/firmware_loader/main.c
> > > +++ b/drivers/base/firmware_loader/main.c
> > > @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> > >  			break;
> > >  		}
> > >  
> > > +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > > +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> > > +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> > > +			id = READING_FIRMWARE_REGULATORY_DB;
> > > +#endif
> > 
> > Whoa, no way.
> 
> There are two methods for the kernel to verify firmware signatures.

Yes, but although CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is its own kernel
mechanism to verify firmware it uses the request_firmware*() API for
regulatory.db and regulatory.db.p7s, and IMA already can appraise these two
files since the firmware API is used.

As such I see no reason to add a new ID for them at all.

Its not providing an *alternative*, its providing an *extra* kernel measure.
If anything CONFIG_CFG80211_REQUIRE_SIGNED_REGDB perhaps should be its own
stacked LSM. I'd be open to see patches which set that out. May be a
cleaner interface.

> If both are enabled, do we require both signatures or is one enough.

Good question. Considering it as a stacked LSM (although not implemented
as one), I'd say its up to who enabled the Kconfig entries. If IMA and
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
IMA though, then surely I agree that enabling
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
system integrator to decide.

If we however want to make it clear that such things as
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
could just make the kconfig depend on !IMA or something? Or perhaps a new
kconfig for IMA which if selected it means that drivers can opt to open code
*further* kernel signature verification, even though IMA already is sufficient.
Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?

> Assigning a different id for regdb signed firmware allows LSMs and IMA
> to handle regdb files differently.

That's not the main concern here, its the precedent we are setting here for
any new kernel interface which open codes firmware signing on its own. What
you are doing means other kernel users who open codes their own firmware
signing may need to add yet-another reading ID. That doesn't either look
well on code, and seems kind of silly from a coding perspective given
the above, in which I clarify IMA still is doing its own appraisal on it.

> > >  		fw_priv->size = 0;
> > >  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
> > >  						msize, id);
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index dc16a73c3d38..d1153c2884b9 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
> > >  	id(FIRMWARE, firmware)		\
> > >  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> > >  	id(FIRMWARE_FALLBACK, firmware)	\
> > > +	id(FIRMWARE_REGULATORY_DB, firmware)	\
> > 
> > Why could IMA not appriase these files? They are part of the standard path.
> 
> The subsequent patch attempts to verify the IMA-appraisal signature, but on
> failure it falls back to allowing regdb signatures. 
> For systems that only want to load firmware based on IMA-appraisal, then
>regdb wouldn't be enabled.

I think we can codify this a bit better, without a new ID.

  Luis
