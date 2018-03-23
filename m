Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1092440-1521803281-2-7018161991768223718
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
    t=1521803280; b=raGgb+h0JRiVibB8n1HzyQt3E8hzERB231eARmrw0EYHIHw
    0+mwJxbEPC9aoGCRI7q7TAuMMwCW5dttlk/M4z66nMgdKkHRBvsOaDeZIJUn2xtF
    Xixuq6/7yuW03GsnXauQzeoct1BCQBXCz/ImWrbV9PvYE1bVtX+duP2IQnAuws9Q
    LZeJV0yicPnIEitVIpPWalILx+eNMZu1ODCqL8KVvGy/2kJ2YhMenxYeikQSoVTs
    ImcOsvpYMm92pwI2hZsnAUZpChnqHpiiVLThskabSi85jcwtc+ESrv1X+obsGKty
    8QRH6wf9hklb5N5B70kPqNcCjeRlbJg4/hv57Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803280; bh=ZU/uQQljll/DjTCkqsv+e8Yn67
    AuYkQ/2gam30JQOOY=; b=UgXk5ieBWmyqtwq6X78j4cYTna5iDT0gI/159FhFzC
    FbxVCsE4JYr14TTAP7MQ/SCXw4WfuIAf79Pi81Je/xfF3z7zrcof4nV+q5OuuUZs
    iMKeQubvSc0gs8hBHUqOyyHcSEdFDwiETmRCWe83UpSDtioM59yyjhqDFaI0C6CA
    Mdan8CAzlH2810/h1dVpm3lTUlAH2rzCl6s5+vnW/n8Q8gzcF6dvNcuVVC0M84te
    FjaDOhq+0mH0YfrfsSY0JFMc0RVYZrYGcEQfAVf1KY4Dn9LByp5CojLBi+QuBA7e
    cXy9oq4kWIsgiwxCOl0oyGD9dBejJxDTJybPimxgVr1Q==
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
        id S932596AbeCWKLz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:11:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44086 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933060AbeCWKLy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:11:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 166/177] ARM: dts: aspeed-evb: Add unit name to memory node
Date: Fri, 23 Mar 2018 10:54:54 +0100
Message-Id: <20180323094212.490356786@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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
@@ -15,7 +15,7 @@
 		bootargs = "console=ttyS4,115200 earlyprintk";
 	};
 
-	memory {
+	memory@80000000 {
 		reg = <0x80000000 0x20000000>;
 	};
 };
