Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481528-2-4361799841944911541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481527; b=gj1JriDNvOP28yk0mKgiVr8RJUmy8DnNPPmrBQ9RZVT6WAEEBB
    pgUiIvzovKL8+oPwVyUfqMIJIiGh+/PZdn5ZkGOC0nsYP9PBFeVsp5TCYjFpnwKb
    KiM1+plxC33ZUydxYRvm/Vxpqkqn0ZcKIXxGpGXj6Fzd6Z7abK2uogJz3ZpXKb+J
    49k2DdhiPYx7PjXI1zNTcuGuvy4oyA1t/iJJMhzb5SV51fQ9p50aar1Cad55IYp2
    KnH/Jb+xmqIsKc4ATUerZ/ZeEnA+++YlhkCcoSkER0UtpD/2kIhInb36yblhsT23
    4VZ6eOEfbxDeXNRkWv2GEBxAK/3LFPImzn5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481527; bh=3KOAx10DPvgAsG54BuOouWKHzLNCjd
    6vF2snSaNpR/k=; b=ioflZLeEpHUD5F/3+pOgs4qLW3Js8VU10gCkOfahJfAY9n
    xIl97HuapG+w4E2b3ouMKNKo2qH3KNPwbSIOQsJq5tfYM2mXVJoLl3ClQKyii2tt
    Na0BfupZHuKUPsntlECjnV1Qnk3GlGvs7MtSZ3IgnUnv5z77foDFH05x8bkzGiLs
    l2EkvOMMC4BUTKJSxY3cVpI27XMnsoxNnoh+Ju+AFx08Ow1haIWiu7D1hsaE7tc+
    zvLgUqH85M+BaBFKrz2OwcnWviaSoPTIWFsL2R8hQQJA4hguhlMsiWEIoqc386LU
    n5BD08517Xn3N+OAdUZ3Bhn5/EbP3Icfd1cq01Bg==
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
X-CM-Envelope: MS4wfAc8UxqyAwjKi08VeBuFwSufJLx1U3b6YOGwsRUdAC+0yGu47v2nEu78U6BxOiMsKIXTpGMQECdwSsXMzzAElXcl5T2usjmBt/w8cCrSweXvOoONdX4D
    cLk1YcOw5aUli31VzgnHbHROVZX5N0M9dV21+w0zQHnS1YeK4XwWCYSruZQ/g1PJZwxD8MIdx0sAwfFflstbiirL8miTyfMVJKHO1vc9hGKXn/FGSpEF9N2l
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=vtgIYqmDHQ2uLMhSwQ8A:9 a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754762AbeDKVSb (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:18:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754518AbeDKSj6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <smfrench@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 017/121] SMB2: Fix share type handling
Date: Wed, 11 Apr 2018 20:35:20 +0200
Message-Id: <20180411183457.195150706@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>


[ Upstream commit cd1230070ae1c12fd34cf6a557bfa81bf9311009 ]

In fs/cifs/smb2pdu.h, we have:
#define SMB2_SHARE_TYPE_DISK    0x01
#define SMB2_SHARE_TYPE_PIPE    0x02
#define SMB2_SHARE_TYPE_PRINT   0x03

Knowing that, with the current code, the SMB2_SHARE_TYPE_PRINT case can
never trigger and printer share would be interpreted as disk share.

So, test the ShareType value for equality instead.

Fixes: faaf946a7d5b ("CIFS: Add tree connect/disconnect capability for SMB2")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <smfrench@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/smb2pdu.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -921,15 +921,19 @@ SMB2_tcon(const unsigned int xid, struct
 		goto tcon_exit;
 	}
 
-	if (rsp->ShareType & SMB2_SHARE_TYPE_DISK)
+	switch (rsp->ShareType) {
+	case SMB2_SHARE_TYPE_DISK:
 		cifs_dbg(FYI, "connection to disk share\n");
-	else if (rsp->ShareType & SMB2_SHARE_TYPE_PIPE) {
+		break;
+	case SMB2_SHARE_TYPE_PIPE:
 		tcon->ipc = true;
 		cifs_dbg(FYI, "connection to pipe share\n");
-	} else if (rsp->ShareType & SMB2_SHARE_TYPE_PRINT) {
-		tcon->print = true;
+		break;
+	case SMB2_SHARE_TYPE_PRINT:
+		tcon->ipc = true;
 		cifs_dbg(FYI, "connection to printer\n");
-	} else {
+		break;
+	default:
 		cifs_dbg(VFS, "unknown share type %d\n", rsp->ShareType);
 		rc = -EOPNOTSUPP;
 		goto tcon_error_exit;
