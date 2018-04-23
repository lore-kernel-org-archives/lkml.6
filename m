Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-775307-1524468117-2-8757863246980972118
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: random-silence-compiler-warnings-and-fix-race.patch
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524468116; b=RTKFJrtowfZ1hfPVvVxJvYGfWu6KFjk8YtL+p211MgY63Njujh
    8JCrCa0jrVor+TvgN2mxUNiF3w/wlhmW4DttRYRQNdS8N/JhVdUf8/p15MZ0O5cF
    WkelUNg/DLxhQ6yZ2GMmLGevXqJGrg6DgJkFCnEDcWyGNk8VASEzsGkjFiBBkZam
    yIPE7At3X/vPDidA5DZHJpefHZEAFsHS49O+FSX5xiZDUu5gige2EqfA4rgy8x1t
    NnCypMSW8dwG1mE7/VC25SBDEbzsZR1f46E/38FH7VHk74wF2ftNpgyrP72eXwtg
    pCtXz4dj/JDccWi9KEoOwYo03WF9yrBVQAYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524468116; bh=bxICzaivY7Awii8QG4TVRdm4R3A40H
    Q65RsO2TkkhlI=; b=CfM4PHI9oi+vJf80lGb4DVjU9crDA39yM68wUdPKXLhAnS
    eYLboZhw8abpCAyweM0XZeYv/Non5DrFSTYKKUr9/Qd8R3R+eQEx4gveRdXvRhSD
    AaNvlj/LPxeM1JfVd1ViAdOaeBKKWopjffBTSioH+JJeJlVZt1lRPeYmyS8XZkEM
    3y6SKrpD+Di9UhBYov3tjzqL2JlUDiw4lazXzI0yVQf72dqhlmLk2bsJT6uQWhDN
    sKx3mjkrRxAnkQYoU40EPjYS8whW0UG5pA4OYQDJHgPbmGG1eg7cAWhcHKR6zKJu
    R6aEb9p0xHooW9COMuTvrzRP+FOue88oNDV7ccNg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PVrwKLB/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GdbBbCq5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PVrwKLB/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=debian.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GdbBbCq5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=debian.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLUCKTlkCugLOOhEEXR37San+S5dUXYoIMKVvKn1B7byswIaHWndY49U2W0LtcRr+OaHTVkV097NgvDX+3/6YxhpoH2LF+P3UU/8uOUFcd/MpBcx3LrN
    EP/BcekiD1SR36P1+qcHI6G7htjri5dC3RdRSAkva1xuKaCHnX/qtwdOAsvzw262IB9I5sX5JwGdz2oqcgXKys49aZo7VB34ZpBQ3Dup7vWGyRsRn4XbaVP1
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=TpujumX0jH7REod0KhDaHZOp9kI=:19
    a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=LalYXy39OSIyVBcyPsgA:9 a=CjuIK1q_8ugA:10 a=UGG5zPGqAAAA:8
    a=CIwjkN_fN9UVIhkJDyEA:9 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=17ibUXfGiVyGqR_YBevW:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeDWHVz (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 03:21:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36302 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeDWHVx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 03:21:53 -0400
X-Google-Smtp-Source: AIpwx49j2GAKOQfVWAFa3P6U2F7pcryRg/V1SPLThM8OwxolOBaGfehTC2Ji0dczzrJQwzowlJMClA==
Date: Mon, 23 Apr 2018 09:21:48 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ben Hutchings <ben@decadent.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        stable@kernel.org
Subject: Re: [PATCH 4.9 75/95] random: set up the NUMA crng instances after
 the CRNG is fully initialized
Message-ID: <20180423072148.jbnd2dodf47ffwej@lorien.valinor.li>
References: <20180422135210.432103639@linuxfoundation.org>
 <20180422135213.491879480@linuxfoundation.org>
 <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="cgtqqot7eikssngs"
Content-Disposition: inline
In-Reply-To: <49fa7d5f484a06f02946afec0688c33849e018de.camel@decadent.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--cgtqqot7eikssngs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi

On Sun, Apr 22, 2018 at 11:28:52PM +0100, Ben Hutchings wrote:
> On Sun, 2018-04-22 at 15:53 +0200, Greg Kroah-Hartman wrote:
> > 4.9-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Theodore Ts'o <tytso@mit.edu>
> > 
> > commit 8ef35c866f8862df074a49a93b0309725812dea8 upstream.
> > 
> > Until the primary_crng is fully initialized, don't initialize the NUMA
> > crng nodes.  Otherwise users of /dev/urandom on NUMA systems before
> > the CRNG is fully initialized can get very bad quality randomness.  Of
> > course everyone should move to getrandom(2) where this won't be an
> > issue, but there's a lot of legacy code out there.  This related to
> > CVE-2018-1108.
> > 
> > Reported-by: Jann Horn <jannh@google.com>
> > Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly...")
> > Cc: stable@kernel.org # 4.8+
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> In 4.9 (and probably older branches too) this leads to a deadlock:
> 
> crng_reseed(primary_crng, ...) takes primary_crng.lock
> -> numa_rcng_init()
>    -> crng_initialize()
>       -> get_random_bytes()
>          -> extract_crng()
>             -> _extract_crng(primary_crng, ...) tries to take primary_crng.lock
> 
> I think this can be fixed by backporting commit 4a072c71f49b
> "random: silence compiler warnings and fix race" but I'm not sure
> whether that depends on other changes.

That is, the following test patch on top of the 4.9-stable review
queue seem to resolve the issue. The commit message of the original
commit 4a072c71f49b0a0e495ea13423bdb850da73c58c would though not match
anymore.

Regards,
Salvatore

--cgtqqot7eikssngs
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="random-silence-compiler-warnings-and-fix-race.patch"

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 15 Jun 2017 00:45:26 +0200
Subject: random: silence compiler warnings and fix race
Origin: https://git.kernel.org/linus/4a072c71f49b0a0e495ea13423bdb850da73c58c

Odd versions of gcc for the sh4 architecture will actually warn about
flags being used while uninitialized, so we set them to zero. Non crazy
gccs will optimize that out again, so it doesn't make a difference.

Next, over aggressive gccs could inline the expression that defines
use_lock, which could then introduce a race resulting in a lock
imbalance. By using READ_ONCE, we prevent that fate. Finally, we make
that assignment const, so that gcc can still optimize a nice amount.

Finally, we fix a potential deadlock between primary_crng.lock and
batched_entropy_reset_lock, where they could be called in opposite
order. Moving the call to invalidate_batched_entropy to outside the lock
rectifies this issue.

Fixes: b169c13de473a85b3c859bb36216a4cb5f00a54a
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Cc: stable@vger.kernel.org
[Salvatore Bonaccorso: backport to 4.9: context changes, only apply change to
address potential deadlock]
---
 drivers/char/random.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: linux-stable/drivers/char/random.c
===================================================================
--- linux-stable.orig/drivers/char/random.c
+++ linux-stable/drivers/char/random.c
@@ -810,12 +810,12 @@ static int crng_fast_load(const char *cp
 		p[crng_init_cnt % CHACHA20_KEY_SIZE] ^= *cp;
 		cp++; crng_init_cnt++; len--;
 	}
+	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	if (crng_init_cnt >= CRNG_INIT_CNT_THRESH) {
 		crng_init = 1;
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: fast init done\n");
 	}
-	spin_unlock_irqrestore(&primary_crng.lock, flags);
 	return 1;
 }
 
@@ -873,6 +873,7 @@ static void crng_reseed(struct crng_stat
 	}
 	memzero_explicit(&buf, sizeof(buf));
 	crng->init_time = jiffies;
+	spin_unlock_irqrestore(&crng->lock, flags);
 	if (crng == &primary_crng && crng_init < 2) {
 		numa_crng_init();
 		crng_init = 2;
@@ -880,7 +881,6 @@ static void crng_reseed(struct crng_stat
 		wake_up_interruptible(&crng_init_wait);
 		pr_notice("random: crng init done\n");
 	}
-	spin_unlock_irqrestore(&crng->lock, flags);
 }
 
 static inline void maybe_reseed_primary_crng(void)

--cgtqqot7eikssngs--
