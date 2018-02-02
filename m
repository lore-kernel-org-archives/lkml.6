Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2700043-1517585534-2-15718168017993412280
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517585534; b=GmQ/k1kWufBlXbMaURRX8JYIJX35mQzTvE+KiuuS921/FWF
    BLc9RtKOttD9sDYk2h1wY6f/gJZaU2ImSc6wJ2ZKcFg84IVUmtKkCdCY29J6hP4h
    FctvBDspElGMwUx0Lil3ib3k4Om1gcDAaP5Ybs3QbQHOqbnUWerxuIsYFCZB0MIq
    eoAgPeaW6gBLQXAcIqwpzQKy1vDiPVwBvlc4tlg+NeS+Q+ppfPD3NhZ4vgo0j8AF
    UtvLlVxynSm5AVIb4MGcoXWVDb59YCVxEFJNL6UbTZzTBBJkPhf/SJvKh6zogr40
    YZ+Vnpcar7gBtq+NOKrAtPd1ez1kInPOoESpSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1517585534; bh=MEBNXGBAmabjZnxAv8rEeSBFzP
    eGKTFSLFuQUHd4AFg=; b=ES2sm6bkfBff2yKzesYiaN5JoNQs9md8EFrndKc5NF
    Nfy9m3YK0sD6kJc7DM+3EwcnlZJPt52fgaj3vkto04V3schhdJUtIGMwS0CQbi8H
    ozEaXeoYNtPrcZLkNHVWErIeXGZVM4XVPJsy2SubM6ljQ02gG2CnD31oPmeWvP52
    JT7l1j/XHDc6/Etxhy8Z4DnWSKPYWwvD0mwijKPW9C7EBW39i7ZavrAE4kkLHpSi
    WkCKR2IS1oih2Zn3MF/cq6O8GFG24KcjidFbEjc+XDHFBc5Utk92YJw1MtM60mwH
    iRrRltKh9z+WguicNh5DhpKq8ttgmzi8eVtBw1ME5oTQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBBPcM (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 10:32:12 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:55261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751470AbeBBPcL (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 10:32:11 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: Martin Sebor <msebor@gcc.gnu.org>, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        =?UTF-8?q?Peter=20Gro=C3=9Fe?= <pegro@friiks.de>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Benjamin Berg <benjamin@sipsolutions.net>,
        Mohammed Shafi Shajakhan <mohammed@qti.qualcomm.com>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cfg80211: fix cfg80211_beacon_dup
Date: Fri,  2 Feb 2018 16:31:23 +0100
Message-Id: <20180202153142.1142229-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:tnic2nJf0NeoKdNqdegbp7zo8c4ktPewtt6EsbfX1YlNj1gA8/4
 PCg2eI9ItUE/gEuy6CELuTPuH/b58kuXJ2Qo7R6goliPkwACqaQk+JgE9633DS5/wRjY9dz
 BKyedxaetNuUE9OP1OpvlW7n7+0b0AP7A+WjwZji+2EmE4fT2sT/6+XamWYj8QBhw4GtXa0
 55YaERMqigVaf9bHMYIUg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:uQyaJNquCPM=:ndWLOFh3M+6xCn6X7G+RGd
 tWqRFRQNRZoZLJPPu156up6pj9s32qM7vlg6WxiFE0HM/h71cZqyUIJduXoXkLljB7uuoAKNT
 i9gTqu9kQw/R3PyaYToeNjOYiMLkAhwIAkYUanqItqpJHB//lB0k7R6hp4LrvOt+TzTQBPWYz
 KIGMVAv4kbacliH8JXFMRbBB/Pvtb1RAM3bSf9RHOtykhWR9CNHusDJ/xMn89kNNPGPwFcaEk
 /44fDe7ZUUTw5bNOOaKEMkXg40oKjSPE1CBAeO3yIs0C1d3w1ib5JICeya4A3Zaw4j0Ry4O/l
 Bep8mJ6XkJEEuCvX+4crDanPDv7GhIQSJusjuIfH1NfQPoIS4Z9RXOpE9s9oXeMRzsGOx+Jam
 Jk7yUemMLQ4fs+zGR9U288kxaXcp25jKh8KM368aiYQgKDARCTDdMGhYmzQ31ne3VgcYkIjoB
 3spTnJP+uccwiSChxhzaADP90836Dvh0fBBT+FxUDxj3rzy0WTc/ynypiE3CqMw3u7X7NTTv0
 0FQ+9kNetr2MaUWNXzGsmhxBJKArS3gv11Ag93Ibbt5lYfqJnHKx3SmaLJ/zO8zAJ2yQuYpF7
 gl5EWUrssBfKoE8vBBjTcoqbhugIhJY/EtRisdTBx2d8ZA2ypf8mgjdlmnkV9YXVH/BXtzAEF
 j98aujK6ll9JcLLqGZkOyn5pkxWMDO4c5o1fy2h4Bo0Qu9uDAbQopKuNnXiv7Z49oKo8Xp8on
 EAcuEBn9GW2i3Me5APGjekLSyGaCB4YR7nCgEw==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc-8 warns about some obviously incorrect code:

net/mac80211/cfg.c: In function 'cfg80211_beacon_dup':
net/mac80211/cfg.c:2896:3: error: 'memcpy' source argument is the same as destination [-Werror=restrict]

>From the context, I conclude that we want to copy from beacon into
new_beacon, as we do in the rest of the function.

Cc: stable@vger.kernel.org
Fixes: 73da7d5bab79 ("mac80211: add channel switch command and beacon callbacks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/mac80211/cfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 46028e12e216..f4195a0f0279 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2892,7 +2892,7 @@ cfg80211_beacon_dup(struct cfg80211_beacon_data *beacon)
 	}
 	if (beacon->probe_resp_len) {
 		new_beacon->probe_resp_len = beacon->probe_resp_len;
-		beacon->probe_resp = pos;
+		new_beacon->probe_resp = pos;
 		memcpy(pos, beacon->probe_resp, beacon->probe_resp_len);
 		pos += beacon->probe_resp_len;
 	}
-- 
2.9.0
