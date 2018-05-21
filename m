Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1344077-1526937976-2-5849557942541311991
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937975; b=LYWrxbsiwr13kHMOWDa4tcZRpf3h6S778YCtdJJtOnmzaQjxDa
    0gkIBh5zWoamBgjUSLhD395td0xRx+UBEBchlDY4FVTv0DSL2CivQ/AMIDnnTRh0
    UvJSYal8P0NRUIOjVMW/qMvIq+HlWUAvoK07DM2gh0QswUV5VfsRfKSXkeJlEk94
    f8XLxWa0Uh12cymhFc+0DI6pi66bFjgOhS5Z24WYURsf0EHEv0JLE+knobh4RWIx
    AexsYbtWkmMy7vxfpjnTAevaEG3OuGdFyB/t8y49pr6IX9hho9PXwVpW9SewoPwl
    dCGibbvBT07AOGlaKxjqU6sPG1ori2nQkfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937975; bh=avkhoi6OZZ/GSGEmtsvt3PVdKocOdt
    PnbysnSjOQ7OA=; b=T1kBhokMQRJRMjFLxY4y1dC3iCzhHHeNuGXyb3wkY3FCz9
    z6Ybd4ypM+1mMkvRe2ZDOlDcPeMJbnqT5DjRlbS3n1Q/jrK1lX1Kx0L0i5ep62kM
    bYRVMIWqNhZQ+y1sygcOf44fHW/SVTFYGNwU13m4jYHJuxWHowVyUcJ2ew8PRHrx
    HCaalHUDTAiiAE7kZYMcMrd9ShdVHbj+VGV82RA1Y9E4iqx1nrbX7zCTm0AUu42z
    CZmuhipYPeIMJGAwncB9x/IgJxNvS6rFDaIiFLly/mPVWMbK9wLXBhl8SIQtPrYI
    kV0LjdntjAFqF3Gqlw/QSqX0AdOf1Fx3cYYi1opw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=O85WTu8Q x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=O85WTu8Q x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB5vPp7EoMK5Kg1CZqwPqbveGsm6pN8Q7vwV4MVVXGeVagqCH+8NBW0mld7G2ANvCwu76xo6nyq0JpCMa1nPPvNmE0XXS7v9MYm9HF3IK8WBYmmS/paX
    J0mSl+Lp61IhBEER8QLKCKR5rJwSyQ4i77MpSJwpLQMhMMbt0/qXcE614JcDXTrgjDBGckE1lqj7twdnlqKw43KcMUFCloGjLjQUWUHGRTISmpEMd9tMS/G2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=DHNPtpFTu180fFLLgmIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932508AbeEUV0G (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932307AbeEUV0E (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:26:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.16 090/110] x86/bugs: Fix __ssb_select_mitigation() return type
Date: Mon, 21 May 2018 23:12:27 +0200
Message-Id: <20180521210513.954849603@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiri Kosina <jkosina@suse.cz>

commit d66d8ff3d21667b41eddbe86b35ab411e40d8c5f upstream

__ssb_select_mitigation() returns one of the members of enum ssb_mitigation,
not ssb_mitigation_cmd; fix the prototype to reflect that.

Fixes: 24f7fc83b9204 ("x86/bugs: Provide boot parameters for the spec_store_bypass_disable mitigation")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -468,7 +468,7 @@ static enum ssb_mitigation_cmd __init ss
 	return cmd;
 }
 
-static enum ssb_mitigation_cmd __init __ssb_select_mitigation(void)
+static enum ssb_mitigation __init __ssb_select_mitigation(void)
 {
 	enum ssb_mitigation mode = SPEC_STORE_BYPASS_NONE;
 	enum ssb_mitigation_cmd cmd;
