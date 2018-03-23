Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806724-2-15481224586623814553
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
    t=1521806724; b=AWcO5o38QQL637htpzd9i7FJbiGAogSaARze2/FuEpdDdMQ
    smgYN+aQYwunJ12LR2JiPkTm7qcxmWe5Skbbceh7PQCsRORRyCgqGjRIvXGTsCrV
    aYq7dGMQFijxW4WVQoG5BMFF2kvj1SXfJrfAg20TrjG/ynFelmIVLbGjs/3GhEin
    bJ6hXfqPySy94BguJRFQAWNX7hTRuMglgFgDCm3yOy3/sv3PhfaOOQ8GpNXgkVHE
    x4/9def0Fa0GENhr7VJJS1WIYCB2y7n3jzMAfqrmFxTeGro9nQUKeRobebqTdtlo
    nlpUFms3yZQvhAWqSqUJXAoJd6PwCBWa5pYF+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806724; bh=c4ghVu/wxmT3OUIxVM//41lavm
    OflKmWb2GkA/Ncl84=; b=sbpvsCK17gDkR31NBovggBg2fISljUIdiax2lKRgxm
    qiBQIKXF2y/cT6WEUwWb+j/WpYhgVA3lWYfk/y+hQcObTaa9UcbTCaiKTCdAS5N2
    7SY9yPeXMlgrsHtEusZ2VRToyAv4YmC0N9UmaLvn4WaqwIBkOF7REbonZ771NzEs
    slgJuRu3zmcitOJwd2ybD8MvTl406p8Nr0kyU5+Jl8Vq2/P8Ad2IImShranZ9kgv
    Mnx6Gxu/lectKoG23zd4g6c+4zRD8YObDfX6tOjR/sVYXbCt33V5kVsKGAO0Q2o1
    8eer1JUqJmDW/IEluHQVV4UeCdXzTrM60fkvlhDv7hWA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1753287AbeCWJ7N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36016 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752328AbeCWJ7K (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Sergej Sawazki <sergej@taudac.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 73/84] clk: si5351: Rename internal plls to avoid name collisions
Date: Fri, 23 Mar 2018 10:54:27 +0100
Message-Id: <20180323095423.009876978@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
