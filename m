Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834627-2-18045122984493699414
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834627; b=JcpLC7o/tjg17FjdB9AwUYlnSunkLCZRJ+vLwcy5M/yx0Za
    HL/lA/AG3LTYV2i8OZ0IjIXcAyykVWBAHqNbZZErSQouVQeN5bWPcMTlNkpPXOSj
    OwYjeg6ENrxvOrk0FTfx0jg2e7C08N7xWwrJqZt/j+WhTnZo5bXlhYNal63mBxER
    6DEF38ao5BOZ8qJNXL8zW0U0GFSBlDHacnX2sWcXYPEBldms/OlD1yFWhmS82HVZ
    PPy8v/U4IauFmrZuQhKTzKrxHb53SRxH2gAd8lAVT46bTjCFidWZXGT4WkzQwCA7
    S+7nU7hd3Hy4lwn+9xnMdH5nqRgY61kqfVk+86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834627; bh=QjfBTYgRfze/9r46X2n
    epwCfmJm0mKvmtoMahKlzfrc=; b=RG9G/P9wLQb8FN0SfDirAPZ4p9I6sC2gKAW
    BxglhRch5XITUpYAPN1FIUytURSqwgEu7AWpNA7afOtetp9L/wEyyvqDtDZynCTg
    2yN66UNcFX3zV+7o/N98S+xUlkjCYPT1t+0p9szKBQTxI+TSRPiT1fnq0fZFpLYy
    YwVmRGkb7Cjy7esmS4sg2jkddv1Hk8xu8UpTtGa/5dwGVke5MHAkgAL/KTmr6lcH
    177qWwkyiG3TBzmdOrGbrGfjjuErEsTI7XBb377NWS8HKmZon0ibuOGk4bB9ROpU
    1BxAQJhtDYakQ930ikmDYzAsUb5UxJLUOH4yB0pbJWnZyZZN/AA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934857AbeB1QQy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:16:54 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35248 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932654AbeB1QQj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:16:39 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "John W. Linville" <linville@tuxdriver.com>,
        "Andrew Bresticker" <abrestic@chromium.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.203403009@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 233/254] mac80211_hwsim: fix compiler warning on MIPS
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Bresticker <abrestic@chromium.org>

commit 5d26b50813ea6206a7bbab2e645e68044f101ac5 upstream.

The dividend in do_div() is expected to be an unsigned 64-bit integer,
which leads to the following warning when building for 32-bit MIPS:

  drivers/net/wireless/mac80211_hwsim.c: In function 'mac80211_hwsim_set_tsf':
  drivers/net/wireless/mac80211_hwsim.c:664:98: warning: comparison of distinct pointer types lacks a cast [enabled by default]
    data->bcn_delta = do_div(delta, bcn_int);

Since we care about the signedness of delta when adjusting tsf_offset
and bcm_delta, use the absolute value for the division and compare
the two timestamps to determine the sign.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/mac80211_hwsim.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -685,11 +685,16 @@ static void mac80211_hwsim_set_tsf(struc
 	struct mac80211_hwsim_data *data = hw->priv;
 	u64 now = mac80211_hwsim_get_tsf(hw, vif);
 	u32 bcn_int = data->beacon_int;
-	s64 delta = tsf - now;
+	u64 delta = abs64(tsf - now);
 
-	data->tsf_offset += delta;
 	/* adjust after beaconing with new timestamp at old TBTT */
-	data->bcn_delta = do_div(delta, bcn_int);
+	if (tsf > now) {
+		data->tsf_offset += delta;
+		data->bcn_delta = do_div(delta, bcn_int);
+	} else {
+		data->tsf_offset -= delta;
+		data->bcn_delta = -do_div(delta, bcn_int);
+	}
 }
 
 static void mac80211_hwsim_monitor_rx(struct ieee80211_hw *hw,
