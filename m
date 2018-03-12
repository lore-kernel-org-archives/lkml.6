Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826857-2-10514063207660848239
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826856; b=PvR53Y8wg0LhF41DmOC/1SmwvMgLg8JX3h4qNArZ8thv9bx
    juszcpYxU+LVaXcUamA31T9j0oq7WZlu/Zn5ethqXi11ctyd1LCmEBFnbZeJameP
    v3X9cP2U0I9RTKDdN14IwykkRMhVzqyBTQSjNho3rvDZ8ZfQAkAtpFxtuoYRWfhY
    +PpzDbgALzbmjggR/tIO2O+LMCiPcoXQijjOn0rAJMu6dwDTh6LkgQGAtEl07N/q
    byqLKpw79yWjGjtPTjwrOVOY/2qv+NVZGUUjBeGnXhVgeATlhDnihRs7TOWkHPTQ
    HMf5HVd19T8xH97WuQ763brKvKNtZuNbqZ5HtEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826856; bh=2UMedhhU4ZwlcPEh9KC
    0ytVr5Le+r3b2+BFME/bhzwI=; b=qb7z+InnEhEk46EDZeaSEdmukHJusRWTZlj
    isbdxJphjvmrXRKzGq+AG9xqwKnaHtMcieZRi8IM+aPLcRb2KsB4vMVNMHFATJHN
    Z4TGa+3IwA1DmB86ujsbUAHwQn/WWCTMhTJZWBY4BG0pA+QHeRPT2bsI2wxtCR75
    quqae9svgIBlEJKPnr5jRdpFA/P+C9C1H1nQqdkRatKnjmlPbUzf72bKLlHiXUx+
    7evsQEU6juH7vIoNKz3VVzg7sO/Y/9kH2CCmysgUc8GeBOe/NktPwVkUgU+OxN/x
    YVuSuJ+htvtZdMnoZ/XsHCxF+6WpLO3A8ZcyzDexUToOWCszM1w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932503AbeCLDxE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:53:04 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41027 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932548AbeCLDHi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:38 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John W. Linville" <linville@tuxdriver.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Andi Kleen" <andi@firstfloor.org>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.669831219@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 004/104] brcm80211: Remove bogus memcpy in ai_detach
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andi Kleen <andi@firstfloor.org>

commit af2c8ffe56133928355d1d51978b35115ffbbc2a upstream.

gcc 4.8 warns for this memcpy. While the copy size is correct, the whole
copy seems to be a nop because the destination is never used, and
there's no need to use memcpy to copy pointers anyways. And the
type of the pointer was wrong, but at least those are always the same.

Just remove it.

/backup/lsrc/git/linux-lto-2.6/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c: In function 'ai_detach':
/backup/lsrc/git/linux-lto-2.6/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c:539:32: warning: argument to 'sizeof' in 'memcpy' call is the same pointer type 'struct si_pub **' as the destination; expected 'struct si_pub *' or an explicit length [-Wsizeof-pointer-memaccess]
  memcpy(&si_local, &sih, sizeof(struct si_pub **));
                                ^

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/brcm80211/brcmsmac/aiutils.c | 3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
+++ b/drivers/net/wireless/brcm80211/brcmsmac/aiutils.c
@@ -1193,9 +1193,6 @@ void ai_detach(struct si_pub *sih)
 {
 	struct si_info *sii;
 
-	struct si_pub *si_local = NULL;
-	memcpy(&si_local, &sih, sizeof(struct si_pub **));
-
 	sii = (struct si_info *)sih;
 
 	if (sii == NULL)
