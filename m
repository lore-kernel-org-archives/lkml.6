Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163547-2-17243420069917944024
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
    1527163546; b=ViDDDfc0qi0mmxCo/Ky8qr4wtOgPt82NSiLJdLS8i39PnyQkYr
    1Rae8F9AtEt2CbBIzXZQbc+BemOKx+a8eWeKJLzGq3Gs9aN386DtEl846QMXG1qb
    uHeIhmdInrHRRVk8zhT9xJJSPaE2/ZYi5pZiMVDSyom03uJdLY3tvFcG73WpF4Dq
    5AplEjyl7G+H7WMxzzfl3BwKEBmQPCQhd4HxsOHfMNukOWILWjD15ePTYxiVsbhF
    Z+t91IebIbQHq8BX3Gs4zt3QDN8R87yry8H+ifS1FTNW+mBonPitIxfMu6TbRSg+
    FPmwKKYALhZUtiHqrJOfHcrH2QzzUhHL1EPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163546; bh=N3sDFki5M39jD8qam0YEDJ8oY92ri2
    WrbwgWow1yh9w=; b=J+g+rpHWbJs7T6g5ee1MrvivyhX6/HzGVnPxQ4yGspReVz
    uEFEFZTKdnY0lXqBTekCP9+6tZT0++m577sDC4nAWG7UGdj1K6tTXl7EW7Q3GWm3
    xVXm2aPTApscDvao3HSQdh0lq+aa/Yv7Lolo9T1KgtHraK2BPO+iof/dEIrvzSd6
    HQz9kGRrz6k9vsgFjD+zh5OjAYYuLmjoYH372WHCktVmpXgonOhsyeujLuSboQV3
    DNgXhPChXCo+pTPc63noL61BVWo+eE+298mVo9HI+02mLXSVfIlzVwqPKbX+a28s
    ePoVxr2vBP1lDiYW8E4rQhf6XA4rMw9Of8nQDmAA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dVSM/HmS x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=dVSM/HmS x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfKkU1mviYrLGfnMMUmGkXOaQY503POW1mNewxq1/QCNjKqJRIAHWXXMCSqa8QZtm4/5Zb/5uNJOX5JycZQbNFjII+Y/5LG5mBBjZyjzvnmGe6T+hSlmb
    hcg/zxUGKWo7p1ZvhuNqnlssxLyHyvoNeqAQh+F8Xv09J+XoK2afJnOE9TS4Xgmp4XFNqIIkAyH2UCNlquEIhcng7g1OJMhZLQULCTI+OcqBOdIE/AB5r8VF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=qTCTqAxlTHOC2uTrnRkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966614AbeEXJoQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966176AbeEXJoP (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.4 37/92] usbip: usbip_host: fix bad unlock balance during stub_probe()
Date: Thu, 24 May 2018 11:38:14 +0200
Message-Id: <20180524093202.540404837@linuxfoundation.org>
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

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit c171654caa875919be3c533d3518da8be5be966e upstream.

stub_probe() calls put_busid_priv() in an error path when device isn't
found in the busid_table. Fix it by making put_busid_priv() safe to be
called with null struct bus_id_priv pointer.

This problem happens when "usbip bind" is run without loading usbip_host
driver and then running modprobe. The first failed bind attempt unbinds
the device from the original driver and when usbip_host is modprobed,
stub_probe() runs and doesn't find the device in its busid table and calls
put_busid_priv(0 with null bus_id_priv pointer.

usbip-host 3-10.2: 3-10.2 is not in match_busid table...  skip!

[  367.359679] =====================================
[  367.359681] WARNING: bad unlock balance detected!
[  367.359683] 4.17.0-rc4+ #5 Not tainted
[  367.359685] -------------------------------------
[  367.359688] modprobe/2768 is trying to release lock (
[  367.359689]
==================================================================
[  367.359696] BUG: KASAN: null-ptr-deref in print_unlock_imbalance_bug+0x99/0x110
[  367.359699] Read of size 8 at addr 0000000000000058 by task modprobe/2768

[  367.359705] CPU: 4 PID: 2768 Comm: modprobe Not tainted 4.17.0-rc4+ #5

Fixes: 22076557b07c ("usbip: usbip_host: fix NULL-ptr deref and use-after-free errors") in usb-linus
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_main.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -96,7 +96,8 @@ struct bus_id_priv *get_busid_priv(const
 
 void put_busid_priv(struct bus_id_priv *bid)
 {
-	spin_unlock(&bid->busid_lock);
+	if (bid)
+		spin_unlock(&bid->busid_lock);
 }
 
 static int add_match_busid(char *busid)
