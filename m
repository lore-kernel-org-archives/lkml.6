Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2956071-1519784444-2-4697694511430155178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519784444; b=ejhFlZJ9fK/NAB1g0bHiW8s/PAP6qussHHM5EFTdx9jU+v0
    mkCmshyXUztDAcCImJNHUzgAkVZKFtQnb5HiimXETAIdjKLDSDjybswCN4d1ShSz
    GAppPeoVjKw9JfWrwaHYJ6eR5ex3oyPxP21VEU7ej4ZH85ghS//TUSUNlfyihs9G
    4WPHXsj1FkrbdyYLpQADg1mRauvbM1LjoH0EQToc1qHgvvPneT1AngUbXY51xK7c
    it90Vxy3aSuFM2R6CxhogrnqfJVy7El+76Db+Gj4Rs7rA//NXvICIARIUV3FqiyK
    qtHCCGk/2wJfQjTrLsFUnikVs2Ijp+2xYiIMQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519784444; bh=mi1Ij6L1hIId/FGNIfp5Dm108k
    RjL+xWV/vM/62G3GE=; b=BfYHfk5hRXzM2WdP5tJRwkYODrxg65bFN8LyeaRa0h
    wrrddew+8MMPrwJ0K1WH8fN6+447R8x69KcL5tnBImG2D5F58i6BTPadXdgcBpvp
    bQAEt8zU7HaW6XCSjPFG85Fu72W7DDojpPuNmgWPx0ppSvajvop3yaqyR1sHaA6d
    W6OKTWYEKWmdniGvrE3Ngqx2QyuE/jsn52Y/9ce16h0mpo3h+C/TtvWLExRGHlJN
    fLl/uc5HJlB3aqC797efLpjyK1g73mJCg1j2fbyhxTmtr+W48BHYt2oIlLZNNjxM
    EdmGkHkbWHlfXqw/OVONuQaG61Qe4cx77GcAeZq0riEQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbeB1CUm (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 21:20:42 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34076 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751605AbeB1CUl (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 21:20:41 -0500
Date: Tue, 27 Feb 2018 20:20:40 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
Message-ID: <20180228022040.z5jbv7l2fdbkb3ti@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble>
 <20180214224525.esxiqt7yjjjpzyz4@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214224525.esxiqt7yjjjpzyz4@treble>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 04:45:25PM -0600, Josh Poimboeuf wrote:
> On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
> > On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:
> > > crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool:
> > > x509_note_pkey_algo()+0xa4: sibling call from callable instruction
> > > with modified stack frame
> 
> From a quick glance, this looks like yet another switch statement
> detection issue.  I'll need to dig into it more (unless PeterZ, my shiny
> new co-maintainer, wants to take a look!)

Arnd, can you test this fix?

----

From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH] objtool: Another switch table detection fix

Continue the switch table detection whack-a-mole.  Add a check to
distinguish KASAN-related .rodata reads from switch-related .rodata
reads in GCC 7.

This fixes the following warning:

  crypto/asymmetric_keys/x509_cert_parser.o: warning: objtool: x509_note_pkey_algo()+0xa4: sibling call from callable instruction with modified stack frame

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 472e64e95891..46c1d239cc1b 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -925,7 +925,11 @@ static struct rela *find_switch_table(struct objtool_file *file,
 		if (find_symbol_containing(file->rodata, text_rela->addend))
 			continue;
 
-		return find_rela_by_dest(file->rodata, text_rela->addend);
+		rodata_rela = find_rela_by_dest(file->rodata, text_rela->addend);
+		if (!rodata_rela)
+			continue;
+
+		return rodata_rela;
 	}
 
 	return NULL;
-- 
2.14.3
