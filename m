Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1481099-1524091120-2-12273955214440379560
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524091120; b=cL5kF+NZp+y6QIBHh19XYP8+Oh6QmQVuQCC+qSzF8J/37COtyc
    JKZDIR49Z8LEz30LMdisHUUiTfc2BFDMQiskX0CIySJmytwh/DDyaeiuxhZJyoDt
    fCBFPNPC+SiXt2Vwb2YoxGjRi9t4F7lqRV+U6y7kp5OUbd7CansaSe7LUHZtdS0q
    yMEunDNjz2GXoO+ERTQtZOcbPagl2ZGocmLSmHm1on8apvlaZ57hh2Vl8gyUWpsZ
    xO6w0wpX67AojTm1cXoIlI4grJbMevythWhWpEV++iXFHj5AgKivGJPUJmGk/fok
    XZRNh6r8lK0Wh38jJH2jM4C6IuCaF8TaaDSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1524091120; bh=ef9UH3U3+d5rrwOikJBUOYeV1aLRr4M
    lOUKzwJWsyno=; b=smFqihfWkrkco3uCR5Z0SvoYnhTYnpGdD/pKnMflEQdVZKu
    GOMWaWr8lnpgTy359u5Y4PY/ah0C9trONsP92gn9rVQeskKNbN52Q/L4L/bgDdh6
    Jsd5m+NzlZ5S69IQaFS4Eumq/kVZQc1DdVNqjUITbtVNnsOxrBLcTsezbQcmkZ3z
    z4lmjSv/4ruui9ybNV4TQO35TTeUApDFXULRRvSZEhyp2pxenb2ye9HE36IRY5Ys
    aKdnB+9us7kpKwGNKcT7c/7s0MTD73G2BJnsa9/fk8RaUM2LPdNsPQIwvl519Ulf
    9nJ+VZqqsG76LWSJ6OxIEhx/wVzWDmm0ZgHVfUg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    smime=temperror;
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLWwJNTb2uYfW9Bcvgd9XaM2b6HKnc+MYNUm+9ZShIfyBUkNw2M1vBT6vQ3TMhsUNycS08Rwm9rTbAb7rtE/mXwsGk3ywc/Pw9HQRoqvyHsmke4Z2UWl
    Sy068mdCs0+UnacKEECyNvWfXr9rll4kaaA0+4sGHE7iNoM2EGe2A8go1YjIi2JAlFq7kUAw8augHUdj9MuEzUt/L9sCJJGzKTDMkTBgJSqUWZ3crUWafgQN
    uOr7wYi1LtAa30zcSznNrg==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=1oJP67jkp3AA:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=MEeggG1rS_yOCf_hZoUA:9
    a=I81HZUdHeTUZyFTDVHkA:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>
Date: Thu, 19 Apr 2018 08:38:10 +1000
Subject: Re: [cfs_trace_lock_tcd] BUG: KASAN: null-ptr-deref in
 cfs_trace_lock_tcd+0x25/0xeb
In-Reply-To: <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
References: <20180418133831.uef7d77ejdyjtxgh@wfg-t540p.sh.intel.com>
 <20180418134058.l3orjjxcpv7cxjfw@wfg-t540p.sh.intel.com>
 <CA+55aFz=VCq6w=kH5aYavOM0-h130HgzVhVc94JxeYSdbMWbxg@mail.gmail.com>
Message-ID: <87k1t4qgx9.fsf@notabene.neil.brown.name>
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
Cc: Staging subsystem List <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Denis Petrovic <denis.petrovic@edu.ece.fr>, LKP <lkp@01.org>,
 Andreas Dilger <andreas.dilger@intel.com>, lustre-devel@lists.lustre.org
Content-Type: multipart/mixed; boundary="===============1560075589716988871=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============1560075589716988871==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

On Wed, Apr 18 2018, Linus Torvalds wrote:

> Ugh, that lustre code is disgusting.
>
> I thought we were getting rid of it.

Lots of people seem to get value out of it.  So we're trying to polish
the code to make it less disgusting.  This is just a little fall-out.
The smoking gun is

[    6.528851] LNetError: 1:0:(module.c:546:libcfs_init()) misc_register: error -16

lustre registers a misc char device with the same number as USERIO.
If they both try to register, one fails.
Until recently, lustre could only be built as a module so when lustre
failed to register the char dev, the module-load fails.
Now it can be built monolithic (makes my testing easier) and the failure
mode is different. The module that tried to register the chardev rewinds
some initialization, and a subsequent module assumes that init was done,
and explodes.

There are patches in Greg's inbox to change lustre to use a dynamically
allocated minor.  And it is on my todo list to get lustre to do less
initialization at module-init time (where, in a monolithic build, it is
hard to give up if some previous module failed), and more at mount time.

So this is a known bug (maybe a new manifestation) and a fix has been
posted.  There is certainly room for lots more cleanup and that is
slowly happening.  I'll make a note to look into the large stack frames
you observed.

Previous report of bug was
  Subject: [staging]  184ecc5ceb: BUG:unable_to_handle_kernel
  Message-ID: <20180319091931.gt6ijdw7ahkbtvrq@inn>


Thanks,
NeilBrown

>
> Anyway, I started looking at why the stack trace is such an incredible
> mess, with lots of stale entries.
>
> The reason (well, _one_ reason) seems to be "ksocknal_startup". It has
> a 500-byte stack frame for some incomprehensible reason. I assume due
> to excessive inlining, because the function itself doesn't seem to be
> that bad.
>
> Similarly, LNetNIInit has a 300-byte stack frame. So it gets pretty deep.
>
> I'm getting the feeling that KASAN is making things worse because
> probably it's disabling all the sane stack frame stuff (ie no merging
> of stack slot entries, perhaps?).
>
> Without KASAN (but also without a lot of other things, so I might be
> blaming KASAN incorrectly), the stack usage of ksocknal_startup() is
> just under 100 bytes, so if it is KASAN, it's really a big difference.
>
> Anyway, apart from the excessive elements, the report seems fine, but
> I'm adding Neil Brown to the cc, since he's the one that has been
> making most of the lustre/lnet changes this merge window.
>
> Also adding Andrey to check about the oddly large stack usage.
>
> Not including the whole email with the attachements - Neil, it's on
> lkml and lustre-devel if you hadn't seen it.
>
>                 Linus

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrXyNIACgkQOeye3VZi
gbkKsQ/+J+yynPr0444BWI3/gQEsufVSY5CIo7XDwAvGWDLpOgZWB5NCPcQ5w+LI
zZbZsBEg+dmn2t2shfDRFvWfJAH+6ph1+Ic59LXX78nYWMysAsmtCAQikhTpgjy7
6L6Ymym7ra7xQGybIohuZclTEdwMkrBu4h+fNb8V31ttt4gTuTY5WAA+LFpo+btP
bx1Hv0ytMO9U/mFbbX7v/NHdJzGpviJuC/amMdj48SL83csT9JKAKXWetfwP8uy8
iavuuQHb3yRALvD79TQpmRaoJEIXm4dEdjz2qyUrPuHtHzU/gVTsoRyV4b3tm9xj
FOjr/YoDJMyvu9Cb5+QOYjZDqBoGXQorRtjhx3pvIktf/14B7vAnRvV2ZsViPKOG
d6ucvH8o8hYOHhq+aVqsN3U4380ZL1WBLBexhs3lD/T7T2Br4PR6HdCf3e2r0Tr+
hyvstv6QaGuKdkHlCaKnetTNWqfRschGvjYbTTbrlFWfqGuj/AEVl7Wor5uzwsWn
gUYrzzR099Q/GKIiqy6jzWimM/qFCOz39ItWbjtXxEQjs8nKBsUkVM4/NoWHSxHV
mHO5bi8SiQxExuKcJh8rHLtrY8UKj9MOUR1k6OEEAHnFPuFB1HjeE9v/Opap0CKt
3tq61VwShWq9eyiK04DNdGwDlS1RajL7bAr89sPorNYaA9FTr78=
=cNC0
-----END PGP SIGNATURE-----
--=-=-=--

--===============1560075589716988871==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============1560075589716988871==--
