Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163082-2-11261217296513746172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527163082; b=WqHzbjsi+RFwt+ckQR4GNh90+jNqZHZvC/268I63s0hA2FaU8I
    I6GLqKSL2PTGS62iCrVGxSzrhrvjuiguHhGNktPYu584dsGO8iO3QNoho+HLir8t
    MQ2H8bLVxKbBDKXxi+g5uQ0hdl7KSAqztDIN6zUv5YhS5vh8YOm2wOjkaAiYHJ0q
    NCvY28wd+z55ZKumn5rPaFKa9CCiP4gLR6BgSeulWeE905pk959TFaSioS9oXQgd
    y+G8w3SbBpx/PmjFYfzScUx++69zc6vQK1NG9fVpKvnJcz6DHrCZw7Yx1YZxijQP
    9orRCDiCmV2myg+Q8LaElDGnxrpmDdVOzgLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163082; bh=G18aIivzeO+GvHfvi+jzlpZOx31eIG
    rWSMehWOo40fU=; b=GcnDRk1KFBgNz16krjiSKDcwiQUIAY1x02Ep+vOLi1tJZE
    MHQsFBk7hez+cjcpz4uTOV0aFFwaG0m7F3gKgEkAncJBKJ1iPmOVOBJD/2KPFIb8
    85e+r1RCsu5VGMPyCGjo0ub6JAL4pVI7KmDfwe4kbHrCM9q7UP58MvNyErlc47v+
    5V5VcHR2KouBHey7Ol0Qvm/lHDj9/xt4QJg4c6I4gK6iqnefkit0RfeGEuc/vGNS
    QZZdkmIFs2+4xs3f305WK2IiJEdZxlsnQz/JkjvcBJBk7i1F4vBX+iYUV/bkE3Qc
    X+ADTvJXxX+NdWqCjMlRCvSW4wPfaXmXAL+M7V6w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=cc1g39kA x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=cc1g39kA x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJs52c7uLl5X2dzG0D6s5lEk/Y5VCLggflNCDWVheV+vyVT6VPw3upV2snEgOleh5dDUdxwQxJNwErLzdMccCJWtnsQlPRnm5XcHu0mMtR01JEtj183f
    xw81Wbte0E3+mO1tcZiPYcdmIK+xf2KtEVsnjEeuA9/rFJhRNoSzmK9/2NU9rAxMhpBvUyIuiR6NADb8y9vHp2W818uWbzlr7K3EnNl1tvkVJwCLIrg/mukt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=eHHp_rMNl1P3d2qNW8UA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=ZKzU8r6zoKMcqsNulkmm:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966806AbeEXL5t (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966787AbeEXJpc (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:45:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: [PATCH 4.4 66/92] ARM: 8770/1: kprobes: Prohibit probing on optimized_callback
Date: Thu, 24 May 2018 11:38:43 +0200
Message-Id: <20180524093205.621904100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 70948c05fdde0aac32f9667856a88725c192fa40 upstream.

Prohibit probing on optimized_callback() because
it is called from kprobes itself. If we put a kprobes
on it, that will cause a recursive call loop.
Mark it NOKPROBE_SYMBOL.

Fixes: 0dc016dbd820 ("ARM: kprobes: enable OPTPROBES for ARM 32")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/opt-arm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/probes/kprobes/opt-arm.c
+++ b/arch/arm/probes/kprobes/opt-arm.c
@@ -192,6 +192,7 @@ optimized_callback(struct optimized_kpro
 
 	local_irq_restore(flags);
 }
+NOKPROBE_SYMBOL(optimized_callback)
 
 int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
 {
