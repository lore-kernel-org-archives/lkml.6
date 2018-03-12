Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826782-2-16905833916310931439
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
    t=1520826781; b=fDrsxOYN5NjTWxDJcNH6ySgqNghzujuZcqBp9L73r0Xbbaa
    BsVDeXRIVHnPXNUscUNZHoMWvMWGIHjO7jaFzPtRnDCrP3BA4F4OtW/2hqi4TfGz
    HW2aTLzNO8X7GD3QPlxBZmnI63rruTrGixuC7mzzYKw9pK2UOnZRYdHuOonmEJOI
    QWwruZ2IjK7LshAEX267QsgYQD9a2m+Br5Xa7jR8T71VuuaAze1vIKUHxs3w6/Ag
    tZvSqSzA8L5d/4FxH3mHfsInVFUUqHxEy2gIi504v5+auqKvoLSIyohY4Y4lLiMh
    3aEYUHtrU/ws4bFe2DlKxGsybzuwX2QWkSOBfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826781; bh=nVL2KmYsCzBe84E33k7
    ZaRPmhW0lm/V/nJIGvRK3kmk=; b=DJUCEqdlDXM0fmwP/7GzVpCiSVtYdabvckC
    lZ5QYJyopP1UnmOOvlmUr0+yG0sH2rfzZRVRJggit9UUwuJWM8t5QBTLyvYm17CQ
    nVtq9xRSeAXF+FGV+S4Az/ZGkGzU8h02zV6P5+KS5CxiqpfoCHTxIC5uAPbnYcgT
    u35fHYc0PmWricjnvtsdNNoIim/3q0BxD6MLbEPqP6yQxXisYWc6C7PdG938CP/K
    EBrGKBfeh74534oYBhmLkbz5mUWqDvwlOCwt2nG5OFBA1uf44fEqkE7oLQfPz2dJ
    Q6s66uGT568XQ1KwwnC+lC85LSlIcNgJF/mrkBO7wnaBz+KTtOg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
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
        id S932609AbeCLDwa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:52:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41025 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932533AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John W. Linville" <linville@tuxdriver.com>,
        "Larry Finger" <Larry.Finger@lwfinger.net>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.944128640@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 003/104] rtlwifi: rtl8192se: Fix gcc 4.7.x warning
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

From: Larry Finger <Larry.Finger@lwfinger.net>

commit f761b6947dde42890beea59b020e1be87491809e upstream.

With gcc 4.7.x, the following warning is issued as the routine that sets
the array has the possibility of not initializing the values:

  CC [M]  drivers/net/wireless/rtlwifi/rtl8192se/phy.o
drivers/net/wireless/rtlwifi/rtl8192se/phy.c: In function ‘rtl92s_phy_set_txpower’:
drivers/net/wireless/rtlwifi/rtl8192se/phy.c:1268:23: warning: ‘ofdmpowerLevel[0]’ may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtlwifi/rtl8192se/phy.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/wireless/rtlwifi/rtl8192se/phy.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192se/phy.c
@@ -1254,6 +1254,9 @@ static void _rtl92s_phy_get_txpower_inde
 		/* Read HT 40 OFDM TX power */
 		ofdmpowerLevel[0] = rtlefuse->txpwrlevel_ht40_2s[0][index];
 		ofdmpowerLevel[1] = rtlefuse->txpwrlevel_ht40_2s[1][index];
+	} else {
+		ofdmpowerLevel[0] = 0;
+		ofdmpowerLevel[1] = 0;
 	}
 }
 
