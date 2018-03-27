Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4170472-1522168121-2-10436953415963265990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522168120; b=gSk3bFW4oh4Fa2ufqZ7fDubDOiLgkWtMhjkTlqLoPZq3pYF
    xm82ntm907aKqzX4sn3QfA6Cf16MDt6n4P0OsS29Lj7DDbl+JxkUH9A7KuxZjZ/J
    0gSHs5pPQn19jZPKFq+D7rBuwatMaUpwNtKMMsCtZqmBqwfYCosjjNlOypCWrGn6
    7rpQcBX6R4WutjNgnyIqo0/sDVL0qOdCIbnIgyEZw30W1fSzaGDV/LQyu9thRUvQ
    1t/WvV2k9egfgbGaaLB1mfkhJ8Jj8QCFV3hbSHxdMTESvPPRZtCVWmZpLsx49XA9
    CdlgMWxeU4p7onreJsmXlj6nwAypDvXmenfvm5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1522168120; bh=euisgbepjWDY3qN6Uzt3vMacRx
    Sy5Lu3yHrMVDxFlr4=; b=d7dH6dpllrGK6pppjsOHnsK30Ssxhp/fkDUKZ7F2xp
    3/MI08IXDNknVOi4YgJ0HkO/Atrs55e51m6RJbXAuJud+5UGBGgR2llwA4D70/RL
    dgRHWH2Oq9YyE1Yjx1rCWkw9tK546tJCAo3HmkdJ7UVzmng3/kFDD0jXo4nN29w9
    Eh0HSH+GsgkXCHEJqOFBxnvTXzulC9KrLN6/HDNl03fWsEGt0tQoV+riNghC/4qr
    YelLsdczuw4QIfmgq5OA9rH8DuTNT+BspK6HrdxSA6odqlz+um+MIVWyb7yGCaEJ
    1pCMeGXGVneTNcwrc9c/LNCjk/cRvAXLbqm4UQ8n+T0w==
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
X-CM-Envelope: MS4wfCgLTMbx3kpe8G+9STyQ9JFTcUCLoR+ZfGgtvJ3nZBVa72iASC4Fgq4/RwuQiVd8OYEzm+3DspB4KSrcxqj/Y5G1kt38n0wY+kZ96ELrWJSJYpbxTFLC
    CF4UuRi4crk4rqOJiUZyIO+KjvQIsIypN+NEBtWvzikyAJJru1cWLkT7tlHlaKiwzhYf9+CH77kPRC/L8q6aq78OG85QlnSvXk95frpTO6GFRJ08WNRKLVvu
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=Vxy2kpnnAAAA:8 a=WPyIoOwQAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=_qIf10yoEbF6jXucxO8A:9 a=QEXdDO2ut3YA:10 a=mQL3ssppXrSh16SuiSjD:22
    a=S-HzPIwwDS8t1QcwSuWs:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751257AbeC0Q2j (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Mar 2018 12:28:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40906 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeC0Q2i (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Mar 2018 12:28:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 01/43] MIPS: ralink: Remove ralink_halt()
Date: Tue, 27 Mar 2018 18:27:05 +0200
Message-Id: <20180327162716.495221326@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162716.407986916@linuxfoundation.org>
References: <20180327162716.407986916@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 891731f6a5dbe508d12443175a7e166a2fba616a upstream.

ralink_halt() does nothing that machine_halt() doesn't already do, so it
adds no value.

It actually causes incorrect behaviour due to the "unreachable()" at the
end. This tells the compiler that the end of the function will never be
reached, which isn't true. The compiler responds by not adding a
'return' instruction, so control simply moves on to whatever bytes come
afterwards in memory. In my tested, that was the ralink_restart()
function. This means that an attempt to 'halt' the machine would
actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.9+
Patchwork: https://patchwork.linux-mips.org/patch/18851/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/reset.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command
 	unreachable();
 }
 
-static void ralink_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
-	_machine_halt = ralink_halt;
 
 	return 0;
 }
