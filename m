Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2651967-1524407020-2-4629624620334623717
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524407019; b=GGqQcwcuh8nFmn/22ff/9KVb5r+WOJoTdPIEgdymh63kA4bvsT
    amzdVBx5ULbZYt86HWo/O0isX3aXzLNTX9qbOtEdssSwhLsQ+XjntwSd7gLvyDqr
    f8llDdO7RXW28JKutVXtHITD+4kVM2tSlV5fYo0gdenVl37RAWX5t+WQoH9FD2z0
    8LP6RavoZnRy/dVrAG4NiW+vJV9ROYRcMRjjAYzHFELI1C2jT4ztLYTgnK89EEV0
    TBGmA0Y/fEa6pfU2K/LStcgvY1Dcel13ksSwAuk9IPtBiaI3BMzNGhn7dUVEvRKh
    fSqynhQHUfFK964gxrP7wMxAeIzw9k+Q67LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524407019; bh=Yn2SpyPNVhioPeMmhl1Qqu5jrTXEfC
    WxKP75EJet1SU=; b=tHA5Yjh+6VxVhsskc3/GDHeEQChi/45bnh/RVURhRXQ2In
    kB3kNOjjYjRorVnXW+C8yXflZPqY0kjROp9k7hlqysBbsqsIxgleez0yYZU952A9
    2+/8zuwML8yt9Js7ijY0Rk6JFi5glMKaKdFMhY/amEG7U7hdpHAi+5nt81bSAG2R
    UKAfZpVBnNV6vrs7HVJzpnxyi5UuE7MYv+hfoU7pBIWa/mssafha5j3hnaPBztVH
    OrjAaL9HTw5NH8rx0SaJwS+fqHYAj147ZvxOK8RiPNO+k6ufWVZEH3enYX2dOOzh
    JJtdfkb+nPISJimzWtxDc55+nzMVQo5sxFnsj5Xw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHo23+sJzfid19z2dDMUitmT3MIedOOAz0fKz4F/O1kaV8GCDigzJTS61dnRA8jBhdvtMch2fFLwh2Jc0E2n6SkB6b57IgHBeMA0qk8j2WZxYRVFkYnQ
    xrecMIqW7lalvf/Fc/Qcm9bNDOaDw9+SW32ifD9BaGLA9hhrkM7cGvyo8gOVqcv+Cr03juqQkLeI/TWaZHDeVA9/mcigPScYbU2hde/ag1DgwXKoZGfzA1ZJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=uP1ucDPQAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8
    a=voKCIwh6ASnYZjJSyTIA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757714AbeDVOWS (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:22:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33330 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756590AbeDVOWP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:22:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 3.18 27/52] clk: mvebu: armada-38x: add support for 1866MHz variants
Date: Sun, 22 Apr 2018 15:54:00 +0200
Message-Id: <20180422135316.716602738@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135315.254787616@linuxfoundation.org>
References: <20180422135315.254787616@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ralph Sennhauser <ralph.sennhauser@gmail.com>

commit 9593f4f56cf5d1c443f66660a0c7f01de38f979d upstream.

The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to the
list of supported CPU frequencies. Also update multiplier and divisor
for the l2clk and ddrclk.

Noticed by the following warning:
[    0.000000] Selected CPU frequency (16) unsupported

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-38x.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -49,7 +49,8 @@ static const u32 armada_38x_cpu_frequenc
 	0, 0, 0, 0,
 	1066 * 1000 * 1000, 0, 0, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
-	1600 * 1000 * 1000,
+	1600 * 1000 * 1000, 0, 0, 0,
+	1866 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -79,7 +80,7 @@ static const int armada_38x_cpu_l2_ratio
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -90,7 +91,7 @@ static const int armada_38x_cpu_ddr_rati
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
