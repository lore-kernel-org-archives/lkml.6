Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3441149-1520826773-2-4174684038975795687
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826772; b=VknHd754ohUp5kSW8aoKL8X8MU/MSuc/cEEK9kajir2R1FB
    RB5uxNxWeFgtkPkQSoNa1DafPxnMOeG8vNtDyu2hP8FK0IKtt9Q9vwtSy7bBI7Ul
    fU1vL3xIakvAUBzuP2B9tFDKyAIm9CbDD6fNEZzoM+Y5LHoXkgBhec5/1Otn87A9
    N074JyV9dEd2yiEgKkYcAw3xIOu4xnS8R+XPRZTHr9CGpvUBz374PQ7mm5o0H7Jq
    Fb6ovNbgV5Ao6p8HiL+r+VHQQdF4LlC9PKTU7OLeRsG9Ke4cbkjl3ypgBTPPo9JY
    5mEcxCNmXD3CjlyLNY6SQb2pTypG5KevZXsu/Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826772; bh=Zjpd7kZxmUTgFcNZC77
    X0epzkBcqvGcuQtvMThEJp3U=; b=O0+c0qozHzTaSRA7ZSU/91Et2Mq7dN3QKd2
    R5+qgZvrZivKs2QxmSS7kdEJl7/79LQ9abxHNB+9ROzrUglLf3AR32+znLctQu2F
    oK8bdUkSHd+UiZUYo8UEOwvOuo1QjS/Gh4xacQ5olF5sXCXwiaEOkphUvRVhDD69
    fzuej20mNElZ7zEuy7MHHSInkyUGw4kEYyyFnWl7pFYrqV20/6OJ/05paBkxiRqD
    bRLykc2mMXyZgOiWIrJdVvmx1o7h+0cGIeGT/IGaFsQNu/fH6zlEPVPcYcVYlLeU
    ygiiCwfWs9y3h+jXq5s5NLBHNICEUvjgyjOhIHXfeLFF3JW5mWA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S932825AbeCLDwa (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:52:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41019 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932532AbeCLDHj (ORCPT
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
Message-ID: <lsq.1520823814.821378511@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 008/104] rtlwifi: rtl8192de: Fix W=1 build warnings
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

commit 8925d518663628f769173d3586c66987fdd3ab61 upstream.

when this driver is built with "make W=1", the following warning is printed:

drivers/net/wireless/rtlwifi/rtl8192de/dm.c:1058:5: warning: comparison is always false due to limited range of data type [-Wtype-limits]

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: John W. Linville <linville@tuxdriver.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/wireless/rtlwifi/rtl8192de/dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
+++ b/drivers/net/wireless/rtlwifi/rtl8192de/dm.c
@@ -843,9 +843,9 @@ static void rtl92d_dm_txpower_tracking_c
 	long ele_a = 0, ele_d, temp_cck, val_x, value32;
 	long val_y, ele_c = 0;
 	u8 ofdm_index[2];
-	u8 cck_index = 0;
+	s8 cck_index = 0;
 	u8 ofdm_index_old[2];
-	u8 cck_index_old = 0;
+	s8 cck_index_old = 0;
 	u8 index;
 	int i;
 	bool is2t = IS_92D_SINGLEPHY(rtlhal->version);
