Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1387311-1523021170-2-10768527952565477781
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021169; b=bt7bu3Utb/ISHCcY5K0708Yw6+Gpv+13rHvDKNmxyEMK72o+z0
    15XBPFRQiYdf+aNPjnRGGeu1N48ZuhAsryUgVWbPrGryrKdnzqJqW+c94XFLtwGA
    RI5+vFc/tw4nMAJkc0sw1aM95T1eOi0AtuJ6oYs3p6Lmd3c5nGpj9HRHqPQbIMYS
    k6BmFVneyH//CEHY3w30HG2ZFBVqlze6gGMkXCmB1cL7AoZr+3b5nlV+hawFb5KW
    cukdO/5lbz5E5YL6Pd96J9DXPlp3xgjUTuGYdUVs99qoRkBH5v5gldkreh+39WjR
    7nKLBncXfSEZUycM/IKblwJATwPKo7Tj04IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021169; bh=vzQJGe6SB+Dzq2mRwJBXjFOzsw3Rgd
    68FY7PQsO+Kv8=; b=iuAHAhSsnjMPikDDLwse/6ha42n4oEY7SClHfPTjf1H/YI
    Ip31cypNWE91+JYdQvETVW8AJU4bMQZ/PRw1O0EQvAt2YcF/gstcns3sYs7RmYX5
    r/8iGh1Q2IudhkqQXSEwJ8ZGhA6APUqV1mffpfVSej8PN91jEhAjsqaiO0ZzdMWw
    f9RMUw7j9CtjIKDFREwhB6eYmYlm9Dh48ifgiqCrUDqL5+gf5bxynsKYh4Ot7z7z
    Bp6oaauDeXgDCGp72P4YClXfhpellVRcpg86mSCtxwnDUOLdoWH/sJRP3RNU40s0
    jFZYk5z2E+90Ecl3lRMtTmqZ+0vXXAFCCaeyQGCQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFj7yhOO2Vw0yhQHrAqmVzPwEaiudC8/f+LQZaA/rUegNgBh1DFICKKiVUCPTenfO6NA299jDVAcDdO5yULtYfRyt9iqrXXRbfnK16xAgl0/FnC2ORH/
    sXk1yaR11QNXQbvj43k+JJbej0t79YV/ji+fv7Dw5hwDdn8zhPKGXDQFTE0nw5TwAtTCRybwSkDsqSbB0JxeQOfE6y58AyCGzlC5vmpkl2FBK9ufXDfktxKF
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=CbDCq_QkAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=vaY82krVgZPQqbDzlp4A:9
    a=QEXdDO2ut3YA:10 a=1qrBK16LubpBFNPVNq2M:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753774AbeDFN0F (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:26:05 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54288 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753766AbeDFN0E (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:26:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arkadi Sharshevsky <arkadis@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 31/93] team: Fix double free in error path
Date: Fri,  6 Apr 2018 15:23:00 +0200
Message-Id: <20180406084226.307848447@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084224.918716300@linuxfoundation.org>
References: <20180406084224.918716300@linuxfoundation.org>
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

From: Arkadi Sharshevsky <arkadis@mellanox.com>


[ Upstream commit cbcc607e18422555db569b593608aec26111cb0b ]

The __send_and_alloc_skb() receives a skb ptr as a parameter but in
case it fails the skb is not valid:
- Send failed and released the skb internally.
- Allocation failed.

The current code tries to release the skb in case of failure which
causes redundant freeing.

Fixes: 9b00cf2d1024 ("team: implement multipart netlink messages for options transfers")
Signed-off-by: Arkadi Sharshevsky <arkadis@mellanox.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -2368,7 +2368,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
@@ -2648,7 +2648,7 @@ send_done:
 	if (!nlh) {
 		err = __send_and_alloc_skb(&skb, team, portid, send_func);
 		if (err)
-			goto errout;
+			return err;
 		goto send_done;
 	}
 
