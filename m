Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518324039-2-12600805097428689705
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324038; b=sbf3U4dTc3CIb4Dh4RWtdfN9kVnNOXBSBfwM01TkSxwlJSH
    rhoWX68T14/kVsfFIva4a5mxYgkJWM/kN4acFS1Qmz7fVAdzgvdgEhPTUY1twlkc
    9Jq7GmSizbajgrUdmuHqd2m9dPiVo1nkZnF0AtXNEstKVITuh0YbkXVkpzTYW4Ms
    WswN4/f1i6KK0OCsfCo/cn3KoEwFBbjr1kmfSH9wjJegrDmLrzepK45K57KD3ZrH
    XaZ7PK60h99bBieiUAeCCSaiMCnnl/kK8QWhktjd5xKY6fvhO4zVp5UT22yN0/p7
    iAssZArCWf5+Z4ykr3IJN5QcTFKH+DO9sDozCew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324038; bh=GgrLiRahRNgfUYg0gaU
    79ZZYuj/ZqWtxg3fmFVuhFSA=; b=gnxXsoq64LeEAEmjigno1AxVmhj1xrbjJuj
    SZyTBWJIYrfDUqNZhIe/YNc/FCXjlimf0E2aAIaTySfcnL0CTk7XYxb5/4m1bO4g
    y3r+ajNJuQVDNct3CvQP4S95Z7bS7QtswAAsyWBCzRVxosZd35qt3tqew2Y+AWIK
    EF/KkcezT29t1mZ/GM/iHKv5vHRip3zvzT4sf9EvYzNKYgS7g6hAm8aOmS+m/uur
    Nxzm4DjtB7+nVfM442pv9KFrYaFVrQKy0m77X1UCPQtOZgfPbd0Lzuxv+2CjFDa1
    RJyNG1OalVf6ZaQpZE3TtGfMtrc+B1sAhxdmGEpHCIReRHAzHDg==
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
        id S1753245AbeBKEi5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:38:57 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41698 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752956AbeBKEeJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:34:09 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?=" <mirq-linux@rere.qmqm.pl>,
        "Thierry Reding" <treding@nvidia.com>,
        "Peter De Schrijver" <pdeschrijver@nvidia.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.972888328@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 047/136] clk: tegra: Fix cclk_lp divisor register
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

From: Michał Mirosław <mirq-linux@rere.qmqm.pl>

commit 54eff2264d3e9fd7e3987de1d7eba1d3581c631e upstream.

According to comments in code and common sense, cclk_lp uses its
own divisor, not cclk_g's.

Fixes: b08e8c0ecc42 ("clk: tegra: add clock support for Tegra30")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/clk/tegra/clk-tegra30.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -1060,7 +1060,7 @@ static void __init tegra30_super_clk_ini
 	 * U71 divider of cclk_lp.
 	 */
 	clk = tegra_clk_register_divider("pll_p_out3_cclklp", "pll_p_out3",
-				clk_base + SUPER_CCLKG_DIVIDER, 0,
+				clk_base + SUPER_CCLKLP_DIVIDER, 0,
 				TEGRA_DIVIDER_INT, 16, 8, 1, NULL);
 	clk_register_clkdev(clk, "pll_p_out3_cclklp", NULL);
 
