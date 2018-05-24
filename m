Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162778-2-7651498922224468935
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
    1527162777; b=mw5iDIE7O++whZKwsqY1XCHj7b0yk7Gm5CCgX4bTe8dffz1eWX
    bnzJIbG/g5Xk7XU0/OvkwNMn4otUPYas5GKrL4OlzLGb54whjTZPdwiWCuQ4G7Cm
    pFqGZ8FbPKk3QRLIXQPwEtFM4EFP4LTAg/gATHhiOoSe79Jm8KRaW7eBrXDeLh/k
    Q5HIVllTFvt4hZ2Tcrr5swaeGgJ2yVdigMESAoEFwDVjw9EoPX/cBdPnd69/iIGT
    Rql6xMD+AmXSgMfspx8DF8cIQ7k5vtChYMl8ff2HYOzJqoadIRaBg4S6bDIErogK
    BQLbPCgy+4d+zgnyXTZuEJ05zhRnK8duWO7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162777; bh=AQeioIyQs8LPTVxIuwVHgNxf0CyN2c
    cBpVNviLIO1c4=; b=XwVRvn3xkey/XXiOZZTtCxI3b1uAG7nQn3Jl+vZrhjbcrO
    LoH/YUaW178N+Vlt51injHVO2JqSKWCQ0pWXiAgRyQFORDIEUPWGCt/mX7aeVGIC
    h0Biw/Izgaw7V2zFnLQhKsotDLgrq3I8whpdffiL0xnm5NPn3axDBEVNt2ZdOk6P
    MdJEJQv47IacKlSj1VV5AGYrdSh8t9IoDkybUT8LmIsoFQsFfd8/vNSClhX28CAR
    N+0g8pED9Q1P4gpYcUWXk0pW3IflQqQo/klVZvyw2yKeDYd3UVJviVlvHHhmtY8D
    i2OWxAWIaKiRrVZ9Kat1YGDmb0wEU4qo+hxxgebA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1rku6pQD x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=1rku6pQD x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKYbZLk06LLEqI7YVEaqCvbGQw4LfL/6fcFusQnUN1ByxqQ9yX3ogtcL1ejzOhAJr9cX3FszZSbAHo7un6X6136Xj4VkcVnTOYwf/l0NGItKRviqWOla
    7H7k3MLUkMC5XSlzeTln3XrYd/UV1XsR0WDoweYcws/rJ8jsLRSFFrpxKiPE5I9A6aHWIKlkcC0GrYzAv+/0/vD1QKacXiABW7cgXQn5Zv5c7R5gmz+ZK12T
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=ag1SF4gXAAAA:8 a=v0RnbwQso9w9YEYU3twA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966920AbeEXJq3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966482AbeEXJqY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:46:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Galbraith <mgalbraith@suse.de>
Subject: [PATCH 4.4 42/92] powerpc/powernv: panic() on OPAL < V3
Date: Thu, 24 May 2018 11:38:19 +0200
Message-Id: <20180524093203.069363412@linuxfoundation.org>
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

From: Stewart Smith <stewart@linux.vnet.ibm.com>

commit 786842b62f81f20d14894925e8c225328ee8144b upstream.

The OpenPower Abstraction Layer firmware went through a couple
of iterations in the lab before being released. What we now know
as OPAL advertises itself as OPALv3.

OPALv2 and OPALv1 never made it outside the lab, and the possibility
of anyone at all ever building a mainline kernel today and expecting
it to boot on such hardware is zero.

Signed-off-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Mike Galbraith <mgalbraith@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/opal.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -103,11 +103,8 @@ int __init early_init_dt_scan_opal(unsig
 		powerpc_firmware_features |= FW_FEATURE_OPALv2;
 		powerpc_firmware_features |= FW_FEATURE_OPALv3;
 		pr_info("OPAL V3 detected !\n");
-	} else if (of_flat_dt_is_compatible(node, "ibm,opal-v2")) {
-		powerpc_firmware_features |= FW_FEATURE_OPALv2;
-		pr_info("OPAL V2 detected !\n");
 	} else {
-		pr_info("OPAL V1 detected !\n");
+		panic("OPAL != V3 detected, no longer supported.\n");
 	}
 
 	/* Reinit all cores with the right endian */
