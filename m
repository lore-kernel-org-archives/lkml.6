Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4170133-1518140376-2-14934498265306062239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518140376; b=dGodDcScgErt/io3oubNtPKEXB9182zUEKWgnIHWjoXnGvx
    9OTP6+b4z1rYlzmyfoPMPqYshZD0UkgpIApHwJPu9eVNLker4kWD7Ffs/5Fj453i
    +w1yoGlTeJilioJMuIUNM76O7lWkDHsTWWyDKGf2v/v8CjhW4XGobFXt7zolYlAU
    nCL1jmOpneMVhLluEjTPeqqq6Px+3bfz0jSfbUYNStAOyTCS/sJ8kqdW4cndT8Ck
    OZDTM/2ZUUbxQvgZIy5gMyswabNJ/OEqI4/NiGHv5v8u8uXeuFh5bSxcr6DCz4BD
    2l77TjCY0QU/GbcTsf7hvNQcU/ZKuL/Qfd3UB7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=arctest; t=1518140376; bh=6k2cVfghWSrFqdZ860R4xtHIafY
    y1NAeihRBWsF+DMY=; b=becF6LEYdUXKFT09u+gxEis9RfmDZWJGgx+Aj4SF+i9
    TUU8J6QtZ++ZiiNPdJE8IO4Kk0iKtqjMx4p6+BP+XNxtgHLqZS0PIHPWWdtPQ8H2
    1//upe+npStsTjmLn8f+j8idOAXvzySctSD6MVFPDdWynG5mFuSgzNg/cSc2rXu/
    T5l/NEP4DBdLrMmx8bWt75D9WNh9WpwEeP7fqe6nYcTRPt4tdytZQmJ1BdFblpJs
    tWTANSLmui1x4N3+ZPvNe0VdBhZ8Qwrl89CXJRQkpi7e5LBibKUAjvJaQ2k/pvYp
    2iUTT7IfxPmqOw2GMJeCd7UOWxgQ3c7Fh9WBdJAPZYw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>
Date: Fri, 09 Feb 2018 12:39:18 +1100
Subject: Re: [PATCH 41/80] staging: lustre: lmv: separate master object with
 master stripe
In-Reply-To: <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
Message-ID: <87r2pvkkl5.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: wang di <di.wang@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============1587293770872222169=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1587293770872222169==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 16 2016, James Simmons wrote:

>=20=20
> +static inline bool
> +lsm_md_eq(const struct lmv_stripe_md *lsm1, const struct lmv_stripe_md *=
lsm2)
> +{
> +	int idx;
> +
> +	if (lsm1->lsm_md_magic !=3D lsm2->lsm_md_magic ||
> +	    lsm1->lsm_md_stripe_count !=3D lsm2->lsm_md_stripe_count ||
> +	    lsm1->lsm_md_master_mdt_index !=3D lsm2->lsm_md_master_mdt_index ||
> +	    lsm1->lsm_md_hash_type !=3D lsm2->lsm_md_hash_type ||
> +	    lsm1->lsm_md_layout_version !=3D lsm2->lsm_md_layout_version ||
> +	    !strcmp(lsm1->lsm_md_pool_name, lsm2->lsm_md_pool_name))
> +		return false;

Hi James and all,
 This patch (8f18c8a48b736c2f in linux) is different from the
 corresponding patch in lustre-release (60e07b972114df).

In that patch, the last clause in the 'if' condition is

+           strcmp(lsm1->lsm_md_pool_name,
+                     lsm2->lsm_md_pool_name) !=3D 0)

Whoever converted it to "!strcmp()" inverted the condition.  This is a
perfect example of why I absolutely *loathe* the "!strcmp()" construct!!

This causes many tests in the 'sanity' test suite to return
=2DENOMEM (that had me puzzled for a while!!).
This seems to suggest that no-one has been testing the mainline linux
lustre.
It also seems to suggest that there is a good chance that there
are other bugs that have crept in while no-one has really been caring.
Given that the sanity test suite doesn't complete for me, but just
hangs (in test_27z I think), that seems particularly likely.


So my real question - to anyone interested in lustre for mainline linux
=2D is: can we actually trust this code at all?
I'm seriously tempted to suggest that we just
  rm -r drivers/staging/lustre

drivers/staging is great for letting the community work on code that has
been "thrown over the wall" and is not openly developed elsewhere, but
that is not the case for lustre.  lustre has (or seems to have) an open
development process.  Having on-going development happen both there and
in drivers/staging seems a waste of resources.

Might it make sense to instead start cleaning up the code in
lustre-release so as to make it meet the upstream kernel standards.
Then when the time is right, the kernel code can be moved *out* of
lustre-release and *in* to linux.  Then development can continue in
Linux (just like it does with other Linux filesystems).

An added bonus of this is that there is an obvious path to getting
server support in mainline Linux.  The current situation of client-only
support seems weird given how interdependent the two are.

What do others think?  Is there any chance that the current lustre in
Linux will ever be more than a poor second-cousin to the external
lustre-release.  If there isn't, should we just discard it now and move
on?

Thanks,
NeilBrown


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlp8+8YACgkQOeye3VZi
gbmBKQ/+N2KBAw2lRurkIXFnMflCyFJ0tYIWK9PpF+rYiPB4t5XDzGdTJ8+hk9iM
9jVr39LMliYEWCq3AZkSYFCeCg2GgE3jLUw9waE1EjEyhwOxCkcnrD3E42W2r9YK
PN9lren4hLelbFRhTO9xCTKT9wQKI1/JzN/Tbaas2hVH0UwQ8gfB572fhCFz1TnV
DG47NnBwjm52gjcq6imOLRooy6hfuw2n638F9Ibz1/c3WQbgEWi0CgO/0bjeCMQV
j9f4NiWapYIlZsg5+mpKZkEgEum5XCYZtsUXVbQLM2LoEMuNI5658VEurE/jqvzd
muEyXYSusWeOc+AJZT67PMMfmy3BHCwS9qMAgGMaMtVKWnEuGztSCNjJs/LckLuC
s9icTPStymLIvmZKT+hIUz3H48FWqDh354ALu2TDDq7kH822VnSWoz1fgP6BZ80T
PCq2LIVoNvG/5M8xInyzvyMgaGsGamKVEIoNJsqpsn3/Xgh+rayLX5b/FRhkt2Aq
u4hRSNXFSNQAr6SDrq1He/WkigyAJ41XA/bnC6gzdnGTUsA9SZs6e6rRq08jKmzw
Myt6RUZ3+EhPir/iv/CDbw6/1rvq7eDngNpmWPNkwW/FTEiI0+b/4p6bqjDHQY1r
T1hfXYtzR3pCxiuEJeRT8GLAz+oFgKFFN+LVu4nMgLQK2Ks9DG4=
=OIfh
-----END PGP SIGNATURE-----
--=-=-=--

--===============1587293770872222169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1587293770872222169==--
