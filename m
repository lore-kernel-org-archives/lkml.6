Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521806630-2-2564348067244096709
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
    t=1521806630; b=gGchV4yZOeVn2gkhOj/I40Y+uaOwrWuG0TE/H14PU7UVubP
    l6skL4fuWQ6tssPDjbGtn10iLzbKTWLYcAnIcKa5I+3RP/F4OCIWTko+ke7MBGkT
    4ZQuHDUZDBSzxO/3c1xgAdD88LCBtQPVAxMr/znBlweN0ypH0cav+lVrvEgSPWGV
    lpCrMDpktgo3/DBxLgfO2MKKzyfrcCn0Zt1H8rhpB9dYuMJXrAUk5FkXYK/vXOao
    +L5nONN71Islpb4IZ7492SpsYZd58mg1Hf8RNuuJyHKvf+erumAmcLrJPYQsxVZt
    m73qaqEfB2XxRTVWNcZ62JAlWjXtpnpJ1xFoBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806630; bh=O3W7WMPsCy8JuGEcmnGIc22TDg
    lG7TDHXHpnZL395PY=; b=u52mYpMX1XJmTUZJqsJp1PvuxF4tw0swos5UdwpCWe
    lZSyXh4nQAamVGXcWpDfH4i9dldUceDiMAlWX5MWTMS4jZncd96AEx9vkHPj4k6g
    r01edjYKigj4KMUb1wzejiAgAoLyHMo8PYtn2oMWY346B6arHJ0jxh1ogVoZYQ9a
    oPk86tBADt4kbMnhIUt+RHPyO14BEk/uSOeqySTO8yuz2I3V7eOpV7hZPTQx+4IC
    VugFxjbStXz1cQ8zsCw3gc3tbx4FiX6ugHrSOJv5Ah+HzLyRgj/guH7cS4HAvKAr
    A4YvabrPdMdVYiAXEdg5H4x9DaKw1tHaiw5I55xeR4Ow==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1753481AbeCWMDf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:03:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36248 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753386AbeCWJ7n (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 68/84] ARM: dts: aspeed-evb: Add unit name to memory node
Date: Fri, 23 Mar 2018 10:54:22 +0100
Message-Id: <20180323095422.251421107@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joel Stanley <joel@jms.id.au>


[ Upstream commit e40ed274489a5f516da120186578eb379b452ac6 ]

Fixes a warning when building with W=1.

All of the ASPEED device trees build without warnings now.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/aspeed-ast2500-evb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/aspeed-ast2500-evb.dts
+++ b/arch/arm/boot/dts/aspeed-ast2500-evb.dts
@@ -16,7 +16,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
