Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZpsdcLHhgxYe4j6TSjucZh479jfdI0R50Hh4pIPfitMmNfwV46FK8VvvZTqIDjM1/+LsLGO
ARC-Seal: i=1; a=rsa-sha256; t=1525895850; cv=none;
        d=google.com; s=arc-20160816;
        b=BGqalfR0yrcAMD/3aLpswtZS10r9N+Wjn22URs9rRxwNUfagJ5XA5ilgs3yGl7rNHO
         Gu9vnfvCEEK+kkh9oOTOD0N827bmZ4OfGsNxm0B8bhzPrdsoNdcka8FZNFy+83k/WkPS
         A7O8w3YtaPD0GCqH4x1lLphEma0StrT1g6+lLslRWdu69Oy19Ttw3bdgPYRmFe2Wlk49
         Cm1Sv6zwVtZolP7nIn5xGzi14QnvrozI+EZ0dC3V7knVm3C9AshuYkjZ+VZiH2UpuBpd
         WyrnYqBB0HUeeMC8M3JGWigmn9xDwFg9Zk/g7owzg0bjDqQP3YkJgL+yTVvFI9pAW9m8
         MQZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=6myoxMR5I5b0VG+lprNAxg0lJ7OyLRd9766/j0EFvnw=;
        b=YdLym5LDrj2i4Vb9DCjlQeCMJhwHKkZitqznwqQKlC9yEZfL36JmTXfNI5Oq4siy76
         e6bPKO+lQkeZwsQC5cMNCVSz/zAC1JKnsqICHw0nKtyJOSx3yMfJLkN0t3QBJT5W0VFQ
         U1wcd6hvrZvX5rr9nnh+bfcug1CubQV6if1purMoS5jtmHfPfunm0Lzc/UTRgA1UFQxb
         fmNRfvzqpxBBEmB5lzlWNnJIDJngsdz4KbhMogY7oZDTOBfI5QDcTqrt97Hmr1jx60h4
         CZZfM1adzVgwiIhrSwU3vFdH2AGeFa7+ySDIHztg48qNVUYLpgBL39+hC3AM98dyQzi6
         1b4A==
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
Date: Wed, 09 May 2018 15:57:18 -0400
In-Reply-To: <20180509191508.GR27853@wotan.suse.de>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
	 <20180504000743.GR27853@wotan.suse.de>
	 <1525393466.3539.133.camel@linux.vnet.ibm.com>
	 <20180508173404.GG27853@wotan.suse.de>
	 <1525865428.3551.175.camel@linux.vnet.ibm.com>
	 <20180509191508.GR27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050919-0044-0000-0000-00000550E648
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050919-0045-0000-0000-000028922FD6
Message-Id: <1525895838.3551.247.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805090186
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600017767033494314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-09 at 19:15 +0000, Luis R. Rodriguez wrote:

> > > > If both are enabled, do we require both signatures or is one enough.
> > > 
> > > Good question. Considering it as a stacked LSM (although not implemented
> > > as one), I'd say its up to who enabled the Kconfig entries. If IMA and
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are enabled then both. If someone enabled
> > > IMA though, then surely I agree that enabling
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is stupid and redundant, but its up to the
> > > system integrator to decide.
> > 
> > Just because IMA-appraisal is enabled in the kernel doesn't mean that
> > firmware signatures will be verified.  That is a run time policy
> > decision.
> 
> Sure, I accept this if IMA does not do signature verification. However
> signature verification seems like a stackable LSM decision, no?

IMA-appraisal can be configured to enforce file signatures.  Refer to
discussion below as to how.

> > > If we however want to make it clear that such things as
> > > CONFIG_CFG80211_REQUIRE_SIGNED_REGDB are not required when IMA is enabled we
> > > could just make the kconfig depend on !IMA or something?  Or perhaps a new
> > > kconfig for IMA which if selected it means that drivers can opt to open code
> > > *further* kernel signature verification, even though IMA already is sufficient.
> > > Perhaps CONFIG_ENABLE_IMA_OVERLAPPING, and the driver depends on it?
> > 
> > The existing CONFIG_IMA_APPRAISE is not enough.  If there was a build
> > time IMA config that translated into an IMA policy requiring firmware
> > signature verification (eg. CONFIG_IMA_APPRAISE_FIRMWARE), this could
> > be sorted out at build time.
> 
> I see makes sense.

Ok, so instead of introducing READING_FIRMWARE_REGULATORY_DB, I'll
post patches introducing CONFIG_IMA_APPRAISE_FIRMWARE, as described
above.

> 
> > > > Assigning a different id for regdb signed firmware allows LSMs and IMA
> > > > to handle regdb files differently.
> > > 
> > > That's not the main concern here, its the precedent we are setting here for
> > > any new kernel interface which open codes firmware signing on its own. What
> > > you are doing means other kernel users who open codes their own firmware
> > > signing may need to add yet-another reading ID. That doesn't either look
> > > well on code, and seems kind of silly from a coding perspective given
> > > the above, in which I clarify IMA still is doing its own appraisal on it.
> > 
> > Suppose,
> > 
> > 1. Either CONFIG_CFG80211_REQUIRE_SIGNED_REGDB or
> > "CONFIG_IMA_APPRAISE_FIRMWARE" would be configured at build.
> > 
> > 2. If CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is configured, not
> > "CONFIG_IMA_APPRAISE_FIRMWARE", a custom IMA-policy rule that
> > appraises the firmware signature could be defined.  In this case, both
> > signature verification methods would be enforced.
> > 
> > then READING_FIRMWARE_REGULATORY_DB would not be needed.
> 
> True, however I'm suggesting that CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> could just be a mini subsystem stackable LSM.

Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
would differentiate between other firmware and the regulatory.db based
on the firmware's pathname.

Making regdb an LSM would have the same issues as currently - deciding
if regdb, IMA-appraisal, or both verify the regdb's signature.

Mimi
