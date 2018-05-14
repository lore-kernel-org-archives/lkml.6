Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZo/FzQeVV4p19U4z+ijPSsykhDHkMfwMcU7YOqnKEtwOJQDKkI0sw0QQtg0PwtzR65WBgPX
ARC-Seal: i=1; a=rsa-sha256; t=1526302718; cv=none;
        d=google.com; s=arc-20160816;
        b=wMZn3AZlshFEsVj45ezjO0KtG6tjoEHSsCgVWQQDA0sUrCPyzlQYwB0CR7dcEu3o4N
         q2M/FgMwcNDLxoTglu293Gg3L1WvUKgB+n8xDRc4H5jwdkpb3NtZYhM/wiaBUTE+pNs+
         VeRRqdloDCKODGLYvgu4DgZ00+dtbPuIyHF9b49t3wsjtrq9QcI15tyeJr36wnuqYKc7
         nFfkLZxb2CnAgG9zblKHhhEwxYu1MufCK1L5GLR7y0cIvMNSRPXbsSPQI+GluSLgvBgD
         bXiIwtGf1SHynwAKRAtaRBSkGgqjwoNBEFJsvAqnTEqxJyFebdlijxHFR4XQVHQpHcWE
         LThA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=+yvjQ0g1XOCrApHMFTDoV9NxfWfFHNMuut19i7/fXKw=;
        b=R2s553SRcIEFp8pRsYFF7Sm1k6EADKljS03ERFr3XE2BgbhZH10eaQiV4mpGTq8/un
         WgxNcb9USQ4bH2FjeboQ+cmQIid4VIal3YH5kay50oWP50t0iYvLgTVcAK/Y0SZPHAXh
         WogodIFco2LVOgqe4Y0GW6ZfBOQMqY6xoW4xbht3W3gcAcogFLY29EVg2fzA3ND+/+vp
         Wxx5G/xDT8CAqhCoTswXeOvUfBSLrCwPeR9oXHj69xYd8mszUeW4z6749XuUDifRwbxI
         t/lZ5YGZyUfr9qEqLBbMsOoBOFB4/v7qofqBlFFcKY3K+QE4CXIOu554L8COBWZDaA70
         uARg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 3/6] firmware: differentiate between signed
 regulatory.db and other firmware
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>,
        "Eric W. Biederman"
 <ebiederm@xmission.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Alexei
 Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>, Jessica
 Yu <jeyu@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        One Thousand
 Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Peter Jones <pjones@redhat.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        David Howells
 <dhowells@redhat.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Seth Forshee
 <seth.forshee@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-integrity@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Ard
 Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees
 Cook <keescook@chromium.org>,
        Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,
        Andres Rodriguez <andresx7@gmail.com>,
        Linus
 Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Date: Mon, 14 May 2018 08:58:12 -0400
In-Reply-To: <20180511215250.GJ27853@wotan.suse.de>
References: <20180508173404.GG27853@wotan.suse.de>
	 <1525865428.3551.175.camel@linux.vnet.ibm.com>
	 <20180509191508.GR27853@wotan.suse.de>
	 <1525895838.3551.247.camel@linux.vnet.ibm.com>
	 <20180509212212.GX27853@wotan.suse.de>
	 <1525903617.3551.281.camel@linux.vnet.ibm.com>
	 <20180509234814.GY27853@wotan.suse.de>
	 <1525917658.3551.322.camel@linux.vnet.ibm.com>
	 <20180510232639.GF27853@wotan.suse.de>
	 <1526014826.3414.46.camel@linux.vnet.ibm.com>
	 <20180511215250.GJ27853@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18051412-0012-0000-0000-000005D66CA3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051412-0013-0000-0000-0000195382B5
Message-Id: <1526302692.3898.145.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805140133
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599489927866627191?=
X-GMAIL-MSGID: =?utf-8?q?1600444399110392676?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-11 at 21:52 +0000, Luis R. Rodriguez wrote:
> On Fri, May 11, 2018 at 01:00:26AM -0400, Mimi Zohar wrote:
> > On Thu, 2018-05-10 at 23:26 +0000, Luis R. Rodriguez wrote:
> > > On Wed, May 09, 2018 at 10:00:58PM -0400, Mimi Zohar wrote:
> > > > On Wed, 2018-05-09 at 23:48 +0000, Luis R. Rodriguez wrote:
> > > > > On Wed, May 09, 2018 at 06:06:57PM -0400, Mimi Zohar wrote:
> > > > 
> > > > > > > > Yes, writing regdb as a micro/mini LSM sounds reasonable.  The LSM
> > > > > > > > would differentiate between other firmware and the regulatory.db based
> > > > > > > > on the firmware's pathname.
> > > > > > > 
> > > > > > > If that is the only way then it would be silly to do the mini LSM as all
> > > > > > > calls would have to have the check. A special LSM hook for just the
> > > > > > > regulatory db also doesn't make much sense.
> > > > > > 
> > > > > > All calls to request_firmware() are already going through this LSM
> > > > > > hook.  I should have said, it would be based on both READING_FIRMWARE
> > > > > > and the firmware's pathname.
> > > > > 
> > > > > Yes, but it would still be a strcmp() computation added for all
> > > > > READING_FIRMWARE. In that sense, the current arrangement is only open coding the
> > > > > signature verification for the regulatory.db file.  One way to avoid this would
> > > > > be to add an LSM specific to the regulatory db
> > > > 
> > > > Casey already commented on this suggestion.
> > > 
> > > Sorry but I must have missed this, can you send me the email or URL where he did that?
> > > I never got a copy of that email I think.
> > 
> > My mistake.  I've posted similar patches for kexec_load and for the
> > firmware sysfs fallback, both call security_kernel_read_file().
> > Casey's comment was in regards to kexec_load[1], not for the sysfs
> > fallback mode.  Here's the link to the most recent version of the
> > kexec_load patches.[2]
> > 
> > [1] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006690.html
> > [2] http://kernsec.org/pipermail/linux-security-module-archive/2018-May/006854.html
> 
> It seems I share Eric's concern on these threads are over general architecture,
> below some notes which I think may help for the long term on that regards.
> 
> In the firmware_loader case we have *one* subsystem which as open coded firmware
> signing -- the wireless subsystem open codes firmware verification by doing two
> request_firmware() calls, one for the regulatory.bin and one for regulatory.bin.p7s,
> and then it does its own check. In this patch set you suggested adding
> a new READING_FIRMWARE_REGULATORY_DB. But your first patch in the series also
> adds READING_FIRMWARE_FALLBACK for the fallback case where we enable use of
> the old syfs loading facility.
> 
> My concerns are two fold for this case:
> 
> a) This would mean adding a new READING_* ID tag per any kernel mechanism which open
> codes its own signature verification scheme.

Yes, that's true.  In order to differentiate between different
methods, there needs to be some way of differentiating between them.
> 
> b) The way it was implemented was to do (just showing
> READING_FIRMWARE_REGULATORY_DB here):

The purpose for READING_FIRMWARE_REGULATORY_DB is different than for
adding enumerations for other firmware verification methods (eg.
fallback sysfs).  In this case, both IMA-appraisal and REGDB are being
called to verify the firmware signature.  Adding
READING_FIRMWARE_REGULATORY_DB was in order to coordinate between
them.

continued below ...

> 
> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
> index eb34089e4299..d7cdf04a8681 100644
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
>                         break;
>                 }
> 
> +#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> +               if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
> +                   (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
> +                       id = READING_FIRMWARE_REGULATORY_DB;
> +#endif
>                 fw_priv->size = 0;
>                 rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
>                                                 msize, id);
> 
> This is eye-soring, and in turn would mean adding yet more #ifdefs for any
> code on the kernel which open codes other firmware signing efforts with
> its own kconfig...

Agreed, adding ifdef's is ugly.  As previously discussed, this code
will be removed.

To coordinate the signature verification, at build time either regdb
or IMA-appraisal firmware will be enabled.  At runtime, in the case
that regdb is enabled and a custom policy requires IMA-appraisal
firmware signature verification, then both signature verification
methods will verify the signatures.  If either fails, then the
signature verification will fail.

> I gather from reading the threads above that Eric's concerns are the re-use of
> an API for security to read files for something which is really not a file, but
> a binary blob of some sort and Casey's rebuttal is adding more hooks for small
> things is a bad idea.
> 
> In light of all this I'll say that the concerns Eric has are unfortunately
> too late, that ship has sailed eons ago. The old non-fd API for module loading
> init_module() calls       security_kernel_read_file(NULL, READING_MODULE). Your
> patch in this series adds security_kernel_read_file(NULL, READING_FIRMWARE_FALLBACK)
> for the old syfs loading facility.

It goes back even farther than that.  Commit 2e72d51 ("security:
introduce kernel_module_from_file hook") introduced calling
security_kernel_module_from_file() in copy_module_from_user().
Commit a1db74209483 ("module: replace copy_module_from_fd with kernel
version") replaced it with the call to security_kernel_read_file().

> So in this regard, I think we have no other option but what you suggested, to
> add a wrapper, say a security_kernel_read_blob() wrapper that calls
> security_kernel_read_file(NULL, id); and make the following legacy calls use
> it:
> 
>   o kernel/module.c for init_module()
>   o kexec_load()
>   o firmware loader sysfs facility
> 
> I think its fair then to add a new READING entry per functionality here
> *but* with the compromise that we *document* that such interfaces are
> discouraged, in preference for interfaces where at least the fd can be
> captured some how. This should hopefully put a stop gap to such interfaces.

Thanks!  Eric, are you on board with this?

> Then as for my concern on extending and adding new READING_* ID tags
> for other future open-coded firmware calls, since:
> 
> a) You seem to be working on  a CONFIG_IMA_APPRAISE_FIRMWARE which would
> enable similar functionality as firmware signing but in userspace.

There are a number of different builtin policies.  The "secure_boot"
builtin policy enables file signature verification for firmware,
kernel modules, kexec'ed image, and the IMA policy, but builtin
policies are enabled on the boot command line.

There are two problems:
- there's no way of configuring a builtin policy to verify firmware
signatures.
- CONFIG_IMA_APPRAISE is not fine enough grained.

The CONFIG_IMA_APPRAISE_FIRMWARE will be a Kconfig option.  Similar
Kconfig options will require kernel modules, kexec'ed image, and the
IMA policy to be signed.

With this, option "d", below, will be possible.

> b) CONFIG_CFG80211_REQUIRE_SIGNED_REGDB was added to replace needing
> CRDA, with an in-kernel interface. CRDA just did a signature check on
> the regulatory.bin prior to tossing regulatory data over the kernel.
> 
> c) We've taken a position to *not* implement generic firmware singing
> upstream in light of the fact that UEFI has pushed hw manufacturers
> to implement FW singing in hardware, and for devices outside of these
> we're happy to suggest IMA use.

There are a number of reasons that the kernel should be verifying
firmware signatures (eg. requiring a specific version of the firmware,
that was locally signed).

> d) It may be possible to have CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
> depend on !CONFIG_IMA_APPRAISE_FIRMWARE this way we'd take a policy
> that CONFIG_IMA_APPRAISE_FIRMWARE replaces in-kernel open coded
> firmware singing facilities
> 
> Then I think it makes sense to adapt a policy of being *very careful* allowing
> future open coded firmware signing efforts such as
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB, and recommend folks to do work for things
> like this through IMA with CONFIG_IMA_APPRAISE_FIRMWARE. This would limit our
> needs to extend READING_* ID tags for new open coded firmwares.
> 
> Then as for the eye-sore you added for CONFIG_CFG80211_REQUIRE_SIGNED_REGDB,
> in light of all this, I accept we have no other way to deal with it but with
> #ifdefs.. however it could be dealt with, as helpers where if
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB is not set we just set the id to
> READING_FIRMWARE, ie, just keep the #ifdefs out of the actual code we read.

Assuming you agree with either REGDB or IMA-appraisal firmware being
configured at build, but allowing a custom policy to require firmware
signature verification based on IMA-appraisal at runtime, so that both
REGDB and IMA-appraisal firmware signature verification methods are
required, then the REGDB ifdef's can be removed.

> Perhaps it makes sense to throw this check into the helper:
> 
>         /* Already populated data member means we're loading into a buffer */
>         if (fw_priv->data) {
>                 id = READING_FIRMWARE_PREALLOC_BUFFER;
>                 msize = fw_priv->allocated_size;
>         }

Thanks, this looks good.  What IMA-appraisal should do with
READING_FIRMWARE_PREALLOC_BUFFER still needs to be determined.

> PS: the work Alexei is doing with fork_usermode_blob() may sound similar
> to the above legacy cases, but as I have noted before -- it already uses
> an LSM hook to vet the data loaded as the data gets loaded as module.

Thank you for the clarification.

Mimi
