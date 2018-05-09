Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZqbyDyXjZ5p+hW+UktbMnnabwWu6D27I4DKXgTspKDH1dUcclVWN6Erwrlc6ZOzSLDmmWvd
ARC-Seal: i=1; a=rsa-sha256; t=1525903628; cv=none;
        d=google.com; s=arc-20160816;
        b=0E1Amt+sSprJN40pwaRTbBrzxIIsvFXn1KO0dJN4wSado0+9b+oWxaQa1k9katyzxl
         +MSvCWBetn8dRJD4BvreUsln6xly+ALzJP8uGR74izW7FIiTkswt3BNTJ4pWlAFT3Q7X
         c689qFAv/B7OfmqmuBtFCNc3eER3G8Nh6qX7UXj/tvTXfFxpWE6oY7mcLNo+PA/Mnbda
         or75QlX7VIyM/AI+XxmAeio96yNwYJT9sPNfTxx1KkhAPj2u2BKoKW3V9SibouJT0xYh
         dmBnYT+G+RJXrJQmYJndUMURgSknEEN3vNAOzNLB2YVHIOH5UPj3US/LNKtkfyv68/71
         X7ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=m875lT6kb+RNgRmuQ50St1XU6jHsninpwvdsoaG/xBE=;
        b=N28RDU64grS81lSjKWFxqQDE690h6Ka0rFCoksBdw6xwTJtfKmu0nkkABacWhns+Qg
         N3NJ8yXuXOSz7iTOeA77hmyk0edeTsJaOjox4yhncsIsD1ameGSw+sNBoBHdzNHNAqrl
         TNxRKpIdJjF0vmfsv6Czm2r34SeowpthwWsoW3UapGXOWpdSWEUKxr8RQLMNyoSANuN+
         PQN7+0fxB8BJXIXxts0ATZkEb+pwu9+TRcVKXXWc7u2YZzXIysEPR1ot3wrorW9BFaP2
         jtXsqdvP8wqnsmGzNwPr7tWixh40tNGrPLRN1RBBgPXitdVAWC6CPFRrWEPLEtXLxBV9
         T7fQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo
 <kvalo@codeaurora.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Johannes
 Berg <johannes.berg@intel.com>,
        linux-integrity@vger.kernel.org, Hans de
 Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Kees
 Cook <keescook@chromium.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Date: Wed, 09 May 2018 18:06:57 -0400
In-Reply-To: <20180509212212.GX27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <20180504000743.GR27853@wotan.suse.de>
	 <1525393466.3539.133.camel@linux.vnet.ibm.com>
	 <20180508173404.GG27853@wotan.suse.de>
	 <1525865428.3551.175.camel@linux.vnet.ibm.com>
	 <20180509191508.GR27853@wotan.suse.de>
	 <1525895838.3551.247.camel@linux.vnet.ibm.com>
	 <20180509212212.GX27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050922-0020-0000-0000-0000041AF3A8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050922-0021-0000-0000-000042B03503
Message-Id: <1525903617.3551.281.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090205
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600025923122554690?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-09 at 21:22 +0000, Luis R. Rodriguez wrote:
> On Wed, May 09, 2018 at 03:57:18PM -0400, Mimi Zohar wrote:
> > On Wed, 2018-05-09 at 19:15 +0000, Luis R. Rodriguez wrote:
> > 
> > > > > > If both are enabled, do we require both signatures or is one enough.
> > > > > 
> > > > > Good question. Considering it as a stacked LSM (although not implemented
> > > > > as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> > > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> > > > > IMA though, then surely I agree that enabling
> > > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> > > > > system integrator to decide.
> > > > 
> > > > Just because IMA-appraisal is enabled in the kernel doesn't mean that
> > > > firmware signatures will be verified.  That is a run time policy
> > > > decision.
> > > 
> > > Sure, I accept this if IMA does not do signature verification. However
> > > signature verification seems like a stackable LSM decision, no?
> > 
> > IMA-appraisal can be configured to enforce file signatures.  Refer to
> > discussion below as to how.
> > 
> > > > > If we however want to make it clear that such things as
> > > > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> > > > > could just make the kconfig depend on !IMA or something?  Or perhaps a new
> > > > > kconfig for IMA which if selected it means that drivers can opt to open code
> > > > > *further* kernel signature verification, even though IMA already is sufficient.
> > > > > Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?
> > > > 
> > > > The existing CONFIG_IMA_APPRAISE is not enough.  If there was a build
> > > > time IMA config that translated into an IMA policy requiring firmware
> > > > signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
> > > > be sorted out at build time.
> > > 
> > > I see makes sense.
> > 
> > Ok, so instead of introducing READING_FIRMWARE_REGULATORY_DB, I'll
> > post patches introducing CONFIG_IMA_APPRAISE_FIRMWARE, as described
> > above.
> 
> OK, its still not clear to what it will do. If it does not touch the firmware
> loader code, and it just sets and configures IMA to do file signature checking
> on its own, then yes I think both mechanisms would be doing the similar work.
> 
> Wouldn't IMA do file signature checks then for all files? Or it would just
> enable this for whatever files userspace wishes to cover?

Enabling CONFIG_IMA_APPRAISE_FIRMWARE would enforce firmware
signatures on all directly loaded firmware and fail any method of
loading firmware that the signature couldn't be verified.

> One of the things with READING_FIRMWARE_REGULATORY_DB is to also use and trust
> the wireless-regdgb maintainer's key for this file, could IMA be configured to
> do that?

IMA has its own trusted keyring.  So either the maintainer's key would
need to be added to the IMA keyring, or IMA-appraisal would need to
use the regdb keyring.
  
> Because that would be one difference here. The whole point of adding
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB was to replace CRDA which is a userspace
> component which checks the signature of regulatory.db before reading it and
> passing data to the kernel from it.
> 
> Now, however silly it may be to have CONFIG_IMA_APPRAISE_FIRMWARE *and*
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB, is your intent in this new patch set
> you are mentioning, to still enable both to co-exist?

At build, either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
CONFIG_IMA_APPRAISE_FIRMWARE, where IMA is appraising all firwmare,
would be enabled, not both.

The builtin IMA-policies could be replaced with a custom policy,
requiring firmware signature verification.  In that case, the regdb
signature would be verified twice.

> 
> > > > > > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > > > > > to handle regdb files differently.
> > > > > 
> > > > > That's not the main concern here, its the precedent we are setting here for
> > > > > any new kernel interface which open codes firmware signing on its own. What
> > > > > you are doing means other kernel users who open codes their own firmware
> > > > > signing may need to add yet-another reading ID. That doesn't either look
> > > > > well on code, and seems kind of silly from a coding perspective given
> > > > > the above, in which I clarify IMA still is doing its own appraisal on it.
> > > > 
> > > > Suppose,
> > > > 
> > > > 1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
> > > > "CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.
> > > > 
> > > > 2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
> > > > "CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
> > > > appraises the firmware signature could be defined.  In this case, both
> > > > signature verification methods would be enforced.
> > > > 
> > > > then READING_FIRMWARE_REGULATORY_DB would not be needed.
> > > 
> > > True, however I'm suggesting that CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> > > could just be a mini subsystem stackable LSM.
> > 
> > Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
> > would differentiate between other firmware and the regulatory.db based
> > on the firmware's pathname.
> 
> If that is the only way then it would be silly to do the mini LSM as all
> calls would have to have the check. A special LSM hook for just the
> regulatory db also doesn't make much sense.

All calls to request_firmware() are already going through this LSM
hook.  I should have said, it would be based on both READING_FIRMWARE
and the firmware's pathname.

> 
> > Making regdb an LSM would have the same issues as currently - deciding
> > if regdb, IMA-appraisal, or both verify the regdb's signature.
> 
> Its unclear to me why they can't co-exist yet and not have to touch
> the firmware_loader code at all.

With the changes discussed above, they will co-exist.  Other than the
Kconfig changes, I don't think it will touch the firmware_loader code.

Mimi
