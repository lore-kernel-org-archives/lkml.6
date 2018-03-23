Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802776-2-532596127233847877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_RHS_DOB 1.514,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802776; b=kXI7x7MLMYDnF3MBAuZkvgadeq6G9Nw8oKzTtt6w29yWsBx
    wT1mxRqYzhP6qORHJUweVP/gdtrcge0cejs1ApY9FM4UAMSiZK/dU13KgSZAexrA
    ZpIV1R7xrOw9D27m+H5raLNuGZMNt1d5qifdZd6rUUZnNtQJB1pymQ9eQE2Enaf9
    HsieWTSDN4PCviDarcGIbt5L3ti3OXsAco19c83EN4aPWXH5Jh5Zks+mrApTY8GB
    7rwZ9vIQyOh9xI1P/lEXc1IIb164yYNfTv+b47Pd7k2jizvfV668/ds8Xzol8JeM
    73+dq7LKmG4ctffTk53Ggu7bngLUjvOOQ/BsFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802776; bh=glLtkZ4MAWA3QYKuCiwUkX2AhD
    badBzGB0JGOmxKi3w=; b=FkQGff7Gs8p0X35f0/Ik+nMfkHEi0oeM8+X+An/xqa
    abP/xyMuLipwiydq28wcFyUkFH3GiKLQ6q7cXy1l1PKJEJ+6xa21Lgp0OGRjQ2py
    XLTlWrufKLn44DYhHgueoyESgxeHjvcoS288f17wAVZVGegeGG2KBF4JFkJTcGt9
    UhdF1EjRimcI1gaUF6zBAI9om+0hxVB402dWdXUhlDtP/57zuYiBZNfCkf0Q8j1i
    tI0Yii5BkWzVchEqW6qZ0WbmllmHLBfQVTnM9TcT7nKAMNHlsV6sSHq+aBowR/XE
    THqb+/YRXmUrqw8wzfkorIy9zfm8Ky03Pwo5u9TlVz/A==
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
        id S1751894AbeCWK7T (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:59:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbeCWKMc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Sergej Sawazki <sergej@taudac.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 170/177] clk: si5351: Rename internal plls to avoid name collisions
Date: Fri, 23 Mar 2018 10:54:58 +0100
Message-Id: <20180323094212.652789125@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
