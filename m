Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521805472-2-5426550697124400182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521805471; b=k2dkmguCBea9xrI432m/iMqT6z+TjlOVZNiR9Th7WKQcTe2
    JWB6kbYAENwgfDFWFEGI6CK0+sfO1sagBGLFV3C1+P0WFi5p0RMDJlizN8kNyQRO
    gLGCXnRbVv7p7r0pn0ZW9OCx0eKeuH6By/Ef45VE4L01nsO6odHSaX6vUgXnBT/z
    63ChMjsFqO2rWUz6sNkdnx7CdoSg3jqi/tdfjTYdDFuMMxpUx9cXCEf7u+gEfM/s
    6eWguiPF26i3H9eI1P3tr49jTl7PR8XkMkIGndVBRuBM/lhbfuKggltezm9kMp7l
    STm8HjPr+4RSwB30geqNbbrZkW+ILn1UutO70iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805471; bh=Q+C6r0HKxfU7UN04KBMmCCQmPJ
    t/Nc+DyKHwBmyhEoo=; b=FjzUPkUnrRXgAnii2DqW2aznNeXceSdS3KavIDAOsk
    OUcdx4zlbnLOBk2e1G8rIoLyhsu3VTNA8/6ltiVbIoq5dUNfpSc9cXogmjJ+5bEF
    5VlcsbSmyF1upllfneakEWcYrTdOVYUK1BNW6NEPnzNjzsSK+CHQmbQKpEnzgtPv
    g0rSxd0+OuJADhqI9rCDhkVvH0RGFVpYE7nZSKm9RsrBLKVl3Lu2SBTWYyA5ZO20
    gnw2rwqKhkn4P+CXFo8K+FxxS121xUUz2Xa5S+nKNJUzIANXUZkTXW8hzLZgFJRp
    fOyXBu3KIHAwua3xeV9WKu3OpW6bZHv5Z19LjDXbrrCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeCWLoP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:44:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38774 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754446AbeCWKDZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:03:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Sergej Sawazki <sergej@taudac.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 64/77] clk: si5351: Rename internal plls to avoid name collisions
Date: Fri, 23 Mar 2018 10:54:38 +0100
Message-Id: <20180323094146.573471544@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergej Sawazki <sergej@taudac.com>


[ Upstream commit cdba9a4fb0b53703959ac861e415816cb61aded4 ]

This drivers probe fails due to a clock name collision if a clock named
'plla' or 'pllb' is already registered when registering this drivers
internal plls.

Fix it by renaming internal plls to avoid name collisions.

Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Rabeeh Khoury <rabeeh@solid-run.com>
Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-si5351.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -72,7 +72,7 @@ static const char * const si5351_input_n
 	"xtal", "clkin"
 };
 static const char * const si5351_pll_names[] = {
-	"plla", "pllb", "vxco"
+	"si5351_plla", "si5351_pllb", "si5351_vxco"
 };
 static const char * const si5351_msynth_names[] = {
 	"ms0", "ms1", "ms2", "ms3", "ms4", "ms5", "ms6", "ms7"
