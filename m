Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806112-2-9031129787228439390
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
    t=1521806112; b=QSFVmiXMrgK7QL7tFbtHGRwBMonAi84LiKxoFqflxOslCa/
    l7n8dTLHY/jaWfguECCWJbqvAmJohWDQ3sjTClQwNMR7yz/wtYYzzZv41lcAj1kZ
    Esdk8+TCX8YZnhoTod0RghMF3+f3dEH2G/BM5mrc6dCFPaqdf/OjgJhLmTkfEwvg
    vIao0RuIVSE5WlrIPtaNDfKpQHgtes31igZGeOOWIiqARZ6IUMU3RvjDx8g9Wbto
    OE0SEaJOOJe0MIPQ2X5k6AVKxk9uDJCQh3HdEdfnDYB/0WKxgPEMOkrLU5oQFXkC
    a8UHUqQAA0U50Zsfy9Emm5cuSU/2XOgBfdWHyFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806112; bh=BaUDnG93/PQKB85YPkmJuawTzs
    FAGBj8sCQf+BAxNlw=; b=SAnfuEyCw1XmDiusHKp230D2vb20Uq9VqYOUyRQYMv
    7WNvKslzxMiqP9nQzjA+6BtYDU32d5ajh0vbxGSzZgTl79cFlpka0DlDyuiOi9nh
    OsZjUffMQSEZjJVmT4Vy8tGHEnm+ZHJxcFIJog/mLGHJ1n8Ul9tl/uG00bDG/bEr
    CopHrJYJj0MKmI9JGK3FgVvTRZ90u3yO+LktNxnbjjgl/HE2usK6Z78Zw59B3P6e
    9fYfItVK3V1wyV5VXGiUkq9ztHNxSCIbBYy7S4JhM9uh9c55gMVCXC5iv3rZtAGt
    V32f/X4tolX8N9lGsoiua/Bp1U44cg+5Vs+HIeQ2ua7Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753852AbeCWKBR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeCWKBP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Changcheng <changcheng.liu@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 28/77] mmc: block: fix logical error to avoid memory leak
Date: Fri, 23 Mar 2018 10:54:02 +0100
Message-Id: <20180323094144.114193711@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "Liu, Changcheng" <changcheng.liu@intel.com>


[ Upstream commit 0be55579a127916ebe39db2a74d906a2dfceed42 ]

If the MMC_DRV_OP_GET_EXT_CSD request completes successfully, then
ext_csd must be freed, but in one case it was not. Fix that.

Signed-off-by: Liu Changcheng <changcheng.liu@intel.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/block.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2387,6 +2387,7 @@ static int mmc_ext_csd_open(struct inode
 
 	if (n != EXT_CSD_STR_LEN) {
 		err = -EINVAL;
+		kfree(ext_csd);
 		goto out_free;
 	}
 
