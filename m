Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523472881-2-7656021965088987774
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
    1523472881; b=Ej8pNt9+slQLKU3UK0QqVUpUqDxxzvPsLOOsMIFiPWuba7frs3
    srHWl+8o5lv8jCVXathL/a60poDnFT4jRDt+0+SgtZO6QmhQyZ91n+VWzfaeiB7C
    Bld6hAQ4NrhDHnxzILeGBh3/R44dyM1QrD0mphGwgNy+N22iEI3kUbiO91B2KajF
    hnTz9SK8CupZE+lu2ykFO/lUeoqVK/17wL5bXZnKZTf2JZ7ds4Mt0YIV3LKRtmJW
    Dx6BqWpoNtMXmq/tMGNX5GaoH5umdLR/mqZSXcQ+XSHqsSkdSSl2xaSRxUuVVUZS
    gYGuJaH5QEYqCTMo93C8EEUn3gps3dOC2CKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472881; bh=OkXQhEa4BAIbk6JIFI7luQGptEcicc
    RP1gXEAFYjfSo=; b=kwauxcJOOWzMhr7eBmxfQ5j6MIuq0mepEU03GbEyJUXU/D
    sziajQM/1MplILv243MGgv7SD+v9JdXdoIcBecqE84FrSr+VMZUeZdAb5KIV2MNM
    +2i9R5JXB7qDQN1fMAQThq5aJoXS1RijddwUTOAJY+UwBLLw4WX24bLSW8MTr3Rp
    VdZydIQjwbxnCs8wwWfwo5kybkN0geNMXFnTIP7jQHEjf+LTADcV7levMdKZMCj5
    dwaNAYmeuCn2QZ4DbY0eusshZEbotXiWEmQB50HBgDNUr5JrUnttRaO0FYlEQ938
    HvWOPVSDF7wYxhX8D+5xjAkZPHO0IK0nFVoKYmVQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOQcT9Mhs4F6M2ELn3mDPauVRiW3FFQqFREIdDbzl7VpTh6VbkqveGHMk+UPe4ulN+CImQyOeD1lsD57icr3Thf4axPAaLkHaxothq+E8yoIHGSZjAxA
    OsqcPZPs2uZQ1ZCqSDRzkvlWd+S9KUZtJ2Ns7TjvlwaLx4lkfAaFR3veleAw7MfMTYi+0suqexmuaiRTzlbGc4WguRpMBQyB8yibVLjcjUURXVt9yohCnxRp
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=XsmskROauiS9Y1dqrRkA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932686AbeDKSyi (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:54:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932610AbeDKSyg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:54:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 031/310] netxen_nic: set rcode to the return status from the call to netxen_issue_cmd
Date: Wed, 11 Apr 2018 20:32:50 +0200
Message-Id: <20180411183623.624403347@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 0fe20fafd1791f993806d417048213ec57b81045 ]

Currently rcode is being initialized to NX_RCODE_SUCCESS and later it
is checked to see if it is not NX_RCODE_SUCCESS which is never true. It
appears that there is an unintentional missing assignment of rcode from
the return of the call to netxen_issue_cmd() that was dropped in
an earlier fix, so add it in.

Detected by CoverityScan, CID#401900 ("Logically dead code")

Fixes: 2dcd5d95ad6b2 ("netxen_nic: fix cdrp race condition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -247,7 +247,7 @@ nx_fw_cmd_set_mtu(struct netxen_adapter
 	cmd.req.arg3 = 0;
 
 	if (recv_ctx->state == NX_HOST_CTX_STATE_ACTIVE)
-		netxen_issue_cmd(adapter, &cmd);
+		rcode = netxen_issue_cmd(adapter, &cmd);
 
 	if (rcode != NX_RCODE_SUCCESS)
 		return -EIO;
