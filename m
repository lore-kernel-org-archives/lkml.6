Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3124918-1523472669-2-10030016774144926304
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
    1523472668; b=hUlLTrL7Wt2karkKeU9eh71Y4wyCfllG7CXyi9uC2Qavpb/3sm
    CRVj2GhJszeXmfGc3MvrHbguSw0tYRZarKEaji+DKBLOucC4Kxf1tYnELw/nImDq
    /lws7AS6GsLtmjK70qApN/+bthjLhmHncxUHKJ0TX/to1j0Ymak0MQ0T5PS6Xg4m
    t3NYwa53iTh1VxoS5urKZTrPQHnwMlDfP7r/bHyMjECIf8dbWkbEPZgyEpg51E78
    /yCL2vhYxbip2lh3Tvgji6VTbHOV/QNVq8PwisqyzRMiuED6SuNA63+SR9pPsJ+K
    Ad1D+vCLgwmXqoQkXz530doezAp1VYimNOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523472668; bh=rDBO24/xLQH8SkQCnQzIuPYgm7IMAB
    d07V5of9GokJI=; b=YbuMGOewLVoYdU4m4JJ8k7cv/mjQyYUZmkR8maGHHNqUNa
    nYHcpCwBl4zdQEukYGDo3nukHZSJqeZHHVlalAIWVX9xzp4FTVTXOFCsqjPjLBxz
    d5qFOAvQjEs0va7ky0Oz9XlUCacAXjUM9caYRlXxgx7vYpKXvYNQKAOctazOWl7o
    XNyqyKbjtSY9W+XgFSr3Fd+EDgKQREEMTnDRwQeZ5H5mg0BQ5mJ5yzz3zLjELfg3
    JdeyQpFD/40I55wBnR6ekEtw9bgDjYtQG4JYXSj0F+1QRD/8cEk0W93ixIig8iqq
    NwBNIjX5XkLzhQzQOsXWpeKoDhW6BNj8fUQptwBQ==
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
X-CM-Envelope: MS4wfMKUsTUg+nBw1n11G0O6BTusMjzsjskDQdwCrPKoq22viHDuAqfzxzDodnea49imb8gdCjNPjaiD201976acWjS/H8J1sh2vMRCWt9EAocpo7/0REQJV
    cX2kItX5N4wuoggLpT/DqfWKm7ip0CQlf4RzLsfhZ9jXZpY0yvpZjEbXCsjADQl+4U9Z8jMl+FvN4Vw05upO90+KWYLRQUVi4YRcw+tbLMLKKfQv+dVvG1+9
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=1XWaLZrsAAAA:8 a=ag1SF4gXAAAA:8 a=hyPygXLTy0dZ2T04cMcA:9
    a=QEXdDO2ut3YA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932363AbeDKSvE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:51:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:32904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932776AbeDKSvC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:51:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <mmarek@suse.com>,
        Matthias Kaehlcke <mka@google.com>
Subject: [PATCH 4.4 165/190] Kbuild: provide a __UNIQUE_ID for clang
Date: Wed, 11 Apr 2018 20:36:51 +0200
Message-Id: <20180411183602.163940151@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

commit b41c29b0527c7fd6a95d0f71274abb79933bf960 upstream.

The default __UNIQUE_ID macro in compiler.h fails to work for some drivers:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c:615:1: error: redefinition of
      '__UNIQUE_ID_firmware615'
BRCMF_FW_NVRAM_DEF(4354, "brcmfmac4354-sdio.bin", "brcmfmac4354-sdio.txt");

This adds a copy of the version we use for gcc-4.3 and higher, as the same
one works with all versions of clang that I could find in svn (2.6 and higher).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michal Marek <mmarek@suse.com>
Cc: Matthias Kaehlcke <mka@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/compiler-clang.h |    5 +++++
 1 file changed, 5 insertions(+)

--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -10,3 +10,8 @@
 #undef uninitialized_var
 #define uninitialized_var(x) x = *(&(x))
 #endif
+
+/* same as gcc, this was present in clang-2.6 so we can assume it works
+ * with any version that can compile the kernel
+ */
+#define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
