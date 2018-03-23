Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802440-2-2112624238981795999
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
    t=1521802440; b=gqfw/r3pYS8vqe4G4V1mOhvycJb2K2AMEvdH81g8yvV8lA8
    ZAn3h78QI2/tvnLVEdn6uhGigEyADo/lqy7dPlkrZhEkDm7AiPK2V6Llrz71qVjC
    ZbL2YvnLP2cXcoxlHig8xoP+tYHf8edj8BdScH0pyM7cP+4RKKMOBheVatOOO1sE
    wwPwWrTqP5pzlZgDdbXzjbvjxAJ15d7XFzXU4SvIpN3Jb+MlpiuPPxGIPY2AaLEZ
    8ofS4iN6Vl8Tr2Uav3fZED4XEmxMrQ7CUwijlwXZyQ+zLUy2yawNMgJnD1O+8AaS
    0A55zYrcI+UveGCTuHEEuSKq/mhn3LNotLjCFiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802440; bh=qA6Ihn/V/+XUmttB7uBGo/VpxL
    CwxXFxPho49uvrBIo=; b=J0AMcz080Tn+q6Lcz+NCEFtSD0ue6XKlLpm06/TqE4
    zCH7fHSUOdv6HedbUymIOjEfaL6eJBm7f3ftSZYF32HDmjc63IO3Uxro62Mt/IKl
    DId388JrnkJaGBoW/xdryAadZ5RoiT9n08Z490O73MAUktqazXEeXszntcUbcjDj
    1A7lOn5V6D2uaizae5exKbEah9xc6iCNK4AErKXWDZV2sgrdaudnFuk0j2VC0jqj
    jDGPpVomZjL6jffelkRFRdVsmBZld3PWV0Cr1YROlbplvEOmD+2QFkTCHDJIlA3C
    q0bKXlASZCGVfzT/6uaJ2jbGm+UkzpAgVbb4i7eStXeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755905AbeCWKNk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:13:40 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44890 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbeCWKNh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:13:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, rtc-linux@googlegroups.com,
        alexandre.belloni@free-electrons.com,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 08/97] x86: i8259: export legacy_pic symbol
Date: Fri, 23 Mar 2018 10:53:55 +0100
Message-Id: <20180323094157.982180842@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
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

From: Hans de Goede <hdegoede@redhat.com>


[ Upstream commit 7ee06cb2f840a96be46233181ed4557901a74385 ]

The classic PC rtc-coms driver has a workaround for broken ACPI device
nodes for it which lack an irq resource. This workaround used to
unconditionally hardcode the irq to 8 in these cases.

This was causing irq conflict problems on systems without a legacy-pic
so a recent patch added an if (nr_legacy_irqs()) guard to the
workaround to avoid this irq conflict.

nr_legacy_irqs() uses the legacy_pic symbol under the hood causing
an undefined symbol error if the rtc-cmos code is build as a module.

This commit exports the legacy_pic symbol to fix this.

Cc: rtc-linux@googlegroups.com
Cc: alexandre.belloni@free-electrons.com
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/i8259.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -418,6 +418,7 @@ struct legacy_pic default_legacy_pic = {
 };
 
 struct legacy_pic *legacy_pic = &default_legacy_pic;
+EXPORT_SYMBOL(legacy_pic);
 
 static int __init i8259A_init_ops(void)
 {
