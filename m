Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518323825-3-9049337640960064120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518323825; b=e99cqUFx9uiqmlB4pyXQTxn2g4VpUxMHTb1YUJucPXr2P/r
    hqbIHjJ78jB78DT8jfO1fTAHd2aC1xEzmCsqhWXxbQK2k2nmnzHorZh3cU0iE30t
    b1TVNXApvgMv9YhTKNjycpgl3UyFF4w3igTJEMjSBU+9x70ajjCyOg18Fb5OuzNB
    fIb9NWbFTCW/3lxA2kQ0DvMr8nhTWRIp4si5E6Lk0dV5TSWKswixMfKNUXCWGrTB
    pGzL3n+9QNwROFUxXT95MIrj+mpPWpaA7XHhzBGlNBLgJGQ9iHDEiJHVof1tQZ2t
    jUEGuCIjEHUy7D/tuYcSV3gy6owgpQrkuxBAbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518323825; bh=ZWlq/ImG526ckulM9CM
    oisEsV99nGifoeZu9y13o1Gw=; b=VaqHCuBFDF+mjNdIJovGCbFIeUtvQ7Q1D/E
    BpHqlLnVn+DPP7chJgjdiklV5KdzqpAL49mSkpFT/Hrmcgxb3n91yigvsIf/dwtb
    /Q7jgrmo0GKBEMm6BEbgo4c0mQ1MhuxWuomO4Bc7450Ivg2zqXE3FT6OzW0+kqd7
    BvxOv37PiCl3OZHblJk0Ld7XioxZa206L4fGIAz7eaPuKTzBsjZ4xqSYavcQyzEx
    XbNncC9F8snaLafUHKWlW2F7QolgIV3IK1+V+OhA/7VKNKTqsel8ganHCON62jdd
    PbQwQp+nwkWffTjdYUcfQZ/Jeo1V8SdEoVdsc7rN5xqWHcEg5cw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeBKEfE (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:35:04 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41756 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752989AbeBKEeL (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:11 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Peter Ujfalusi" <peter.ujfalusi@ti.com>,
        "Stephen Boyd" <sboyd@codeaurora.org>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.432802846@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 080/136] clk: ti: dra7-atl-clock: fix child-node lookups
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 33ec6dbc5a02677509d97fe36cd2105753f0f0ea upstream.

Fix child node-lookup during probe, which ended up searching the whole
device tree depth-first starting at parent rather than just matching on
its children.

Note that the original premature free of the parent node has already
been fixed separately, but that fix was apparently never backported to
stable.

Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)")
Fixes: 660e15519399 ("clk: ti: dra7-atl-clock: Fix of_node reference counting")
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clk/ti/clk-dra7-atl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/clk/ti/clk-dra7-atl.c
+++ b/drivers/clk/ti/clk-dra7-atl.c
@@ -262,8 +262,7 @@ static int of_dra7_atl_clk_probe(struct
 
 		/* Get configuration for the ATL instances */
 		snprintf(prop, sizeof(prop), "atl%u", i);
-		of_node_get(node);
-		cfg_node = of_find_node_by_name(node, prop);
+		cfg_node = of_get_child_by_name(node, prop);
 		if (cfg_node) {
 			ret = of_property_read_u32(cfg_node, "bws",
 						   &cdesc->bws);
