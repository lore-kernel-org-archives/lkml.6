Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZolVnyipL9OQNDAA56Qt8yNzs5dv207i893okpPp/aFZIEmjl+TvmQwwlYeXrp6J13eJOYb
ARC-Seal: i=1; a=rsa-sha256; t=1525865443; cv=none;
        d=google.com; s=arc-20160816;
        b=uZtm0sEft5Cac0JDZvCbZxYKkoG7AaGW7TDvebqs+25u69KPqx3blmm0Pv8MRsnUNd
         3rt8dTurD1IpEOcc5LECjJ6LVKmo+AM2sqznzlW01k8IMP2QfiTqPJdhOwnLgPyFr9zW
         2frmSdlnlQAp8oImeKX4obNIsFBNtFlGQw/ZBP8A2zClyeKxYJj5HkND1MZATJ6fBWOr
         QZ2FRgfSBJ4kNmS8ay1L1Ff/i+XpRkfnaojbNsUlP6LNv7H22n+b/pQo9pZmXFT+tM0v
         GyOkwvAirFsFF2CSIOu0knG0FN/r5cqmpEteiM68FbOeSixEmxWITG6NssD653zdBB1b
         cUgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=wMh2k6Zz+tGpbmJl7NTXECV7Z3BRiso3ztzLNMmuPbY=;
        b=Io5KTocPbpO7RPMgPvC9T9NYck1KpMfamr3EDn29ApUShUGFNEjjoQwRrCLqZGjlI7
         AgAe2tbc3l7tJOlNUtBWmA03sbm6M4sEzJVL9zv5S0dUeZuonMXDl0HiWdLrAesUsmKe
         kgkhOUnzDSAFLoYEW9wTmtu7o+i8+fuMIe8xPuOO+udrotxy8nD+vdpv55YUkmYfx+r5
         DSQyohC/kOfSgAW0iErhA/xh/FzV7Ade1Lh+slVSXx2zBHu5NGKEJjbUsYGdmtganJFx
         cQVFfGu6Q5FPH61L5nxs+0DnmN+2mpgtxMlCysQNvoVQ7+zqhYpGnzUAZ+IC9mEn5GID
         X7IQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-wireless
 <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Seth
 Forshee <seth.forshee@canonical.com>,
        Johannes Berg
 <johannes.berg@intel.com>
Cc: linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones
 <pjones@redhat.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Kees
 Cook <keescook@chromium.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Date: Wed, 09 May 2018 07:30:28 -0400
In-Reply-To: <20180508173404.GG27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <20180504000743.GR27853@wotan.suse.de>
	 <1525393466.3539.133.camel@linux.vnet.ibm.com>
	 <20180508173404.GG27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050911-0040-0000-0000-00000437C75B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050911-0041-0000-0000-0000263C076A
Message-Id: <1525865428.3551.175.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090109
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1599985882887098918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-05-08 at 17:34 +0000, Luis R. Rodriguez wrote:
> On Thu, May 03, 2018 at 08:24:26PM -0400, Mimi Zohar wrote:
> > On Fri, 2018-05-04 at 00:07 +0000, Luis R. Rodriguez wrote:
> > > On Tue, May 01, 2018 at 09:48:20AM -0400, Mimi Zohar wrote:
> > > > Allow LSMs and IMA to differentiate between signed regulatory.db and
> > > > other firmware.
> > > > 
> > > > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> > > > Cc: Luis R. Rodriguez <mcgrof@suse.com>
> > > > Cc: David Howells <dhowells@redhat.com>
> > > > Cc: Kees Cook <keescook@chromium.org>
> > > > Cc: Seth Forshee <seth.forshee@canonical.com>
> > > > Cc: Johannes Berg <johannes.berg@intel.com>
> > > > ---
> > > >  drivers/base/firmware_loader/main.c | 5 +++++
> > > >  include/linux/fs.h                  | 1 +
> > > >  2 files changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> > > > index eb34089e4299..d7cdf04a8681 100644
> > > > --- a/drivers/base/firmware_loader/main.c
> > > > +++ b/drivers/base/firmware_loader/main.c
> > > > @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
> > > >  			break;
> > > >  		}
> > > >  
> > > > +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > > > +		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> > > > +		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> > > > +			id = READING_FIRMWARE_REGULATORY_DB;
> > > > +#endif
> > > 
> > > Whoa, no way.
> > 
> > There are two methods for the kernel to verify firmware signatures.
> 
> Yes, but although CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is its own kernel
> mechanism to verify firmware it uses the request_firmware*() API for
> regulatory.db and regulatory.db.p7s, and IMA already can appraise these two
> files since the firmware API is used.

IMA-appraisal can verify a signature stored as an xattr, but not a
detached signature.  That support could be added, but isn't there
today.  Today, a regulatory.db signature would have to be stored as an
xattr. 

> 
> As such I see no reason to add a new ID for them at all.
> K
> Its not providing an *alternative*, its providing an *extra* kernel measure.
> If anything CONFIG_CFG80211_REQUIRE_SIGNED_REGDB perhaps should be its own
> stacked LSM. I'd be open to see patches which set that out. May be a
> cleaner interface.
> 
> > If both are enabled, do we require both signatures or is one enough.
> 
> Good question. Considering it as a stacked LSM (although not implemented
> as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> IMA though, then surely I agree that enabling
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> system integrator to decide.

Just because IMA-appraisal is enabled in the kernel doesn't mean that
firmware signatures will be verified.  That is a run time policy
decision.

> 
> If we however want to make it clear that such things as
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> could just make the kconfig depend on !IMA or something?  Or perhaps a new
> kconfig for IMA which if selected it means that drivers can opt to open code
> *further* kernel signature verification, even though IMA already is sufficient.
> Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?

The existing CONFIG_IMA_APPRAISE is not enough.  If there was a build
time IMA config that translated into an IMA policy requiring firmware
signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
be sorted out at build time.

> 
> > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > to handle regdb files differently.
> 
> That's not the main concern here, its the precedent we are setting here for
> any new kernel interface which open codes firmware signing on its own. What
> you are doing means other kernel users who open codes their own firmware
> signing may need to add yet-another reading ID. That doesn't either look
> well on code, and seems kind of silly from a coding perspective given
> the above, in which I clarify IMA still is doing its own appraisal on it.

Suppose,

1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
"CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.

2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
"CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
appraises the firmware signature could be defined.  In this case, both
signature verification methods would be enforced.

then READING_FIRMWARE_REGULATORY_DB would not be needed.

Mimi

> 
> > > >  		fw_priv->size = 0;
> > > >  		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
> > > >  						msize, id);
> > > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > > index dc16a73c3d38..d1153c2884b9 100644
> > > > --- a/include/linux/fs.h
> > > > +++ b/include/linux/fs.h
> > > > @@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
> > > >  	id(FIRMWARE, firmware)		\
> > > >  	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
> > > >  	id(FIRMWARE_FALLBACK, firmware)	\
> > > > +	id(FIRMWARE_REGULATORY_DB, firmware)	\
> > > 
> > > Why could IMA not appriase these files? They are part of the standard path.
> > 
> > The subsequent patch attempts to verify the IMA-appraisal signature, but on
> > failure it falls back to allowing regdb signatures. 
> > For systems that only want to load firmware based on IMA-appraisal, then
> >regdb wouldn't be enabled.
> 
> I think we can codify this a bit better, without a new ID.
> 
>   Luis
> 
