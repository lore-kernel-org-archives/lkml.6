Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691124-1527154933-2-4747678131255986884
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
    1527154933; b=Sh0LywcqDJP3sfRjcZcBHwkP/fy40lXtb7tljgzz1udUbQlQ47
    +6ZKUyxTKEtGtoxL2SRCyYZx9Q+SMjggILDMDIuTt1xggFs2fKg6J11ecbZ5ovee
    7LVSIwxyqYFI48T/25SzVBtg2snAsEtBdTHJKRn6Od0ilzDKJAFwfmuA2Vi+TzaL
    jc9hWOS/mbnLdwZjrCrvK8JDkVtXXSMoC360CDrb9WXNUgx7sNI6ykOyTrMFWbCO
    o+RdbK5JKWPc/Pt3Sf/sq5BLr1zgVUNxWZkQYoTP9IX9Spdtd6lOBBKigmkPHnAv
    mbvMHAdSpUK68ZJ6D4r2afV7XrZQiqJ4jqiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154933; bh=wkd9Z68I7PyAyK0nH9sPDX8hOe4IEs
    QPBlXFg8uqL/s=; b=JCGQ3Gkksw2NaoXjv6iG0Sp0SqDI7yWTeI5Uvy2B0afv3P
    rc0aDagOcDXrfwFvKV4bhQfhz3b4VAeyWP3abKUmzt+pjtjajBBb+umXSuE5/TDF
    JaUeFG9VjYt79Cs92j86bDuO1WSnQysqwchqhZeYwnR7e6uIzEP1oow2aEep5C2j
    TzzGdzcGdKIMOETHYCJuJYTxgyAsai3Wgu3rpB+5vut158BWcwbI3RGvHDkoYmQW
    DgP1MjQu8b0Aub3s9r5gWWXO3Pmo9qGULtznHOaJqGmxtTvgYU8NZSITdOqxBUCP
    vfdZ5Ski4riTifTvCbJFeIipNIzptG+AxqasVmeQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CfJvR2ZV x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=CfJvR2ZV x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfNtTf9oHniWmp5s2/bUbK8NB+BwtZsNdlEfrn0acECma/SUveESGyB4LN1BB+SJMZRYNi8vCvOCxYyLgl/UCoHEXhi7VRfP9mEJu1RjePBow8kMxGFze
    H71PQohia1Ta4rYDOA0rv/QNum0QueFmfgBLwn1iSpLKK1ltGFpID03A/5tCXLz7y3nytj1Z5vdqng7wEBgw0YyXY0MkF+jbwHY1wrye1z8au1Va1quqIyH3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=ag1SF4gXAAAA:8 a=8AirrxEcAAAA:8 a=1EsaE_6oAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=8loL1zC9vO88QqH-WeIA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=ST-jHhOKWsTCqRlWije3:22 a=3ZumFrijQQ-2J9H5h8ct:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966298AbeEXJmL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966025AbeEXJmF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 19/45] Revert "ARM: dts: imx6qdl-wandboard: Fix audio channel swap"
Date: Thu, 24 May 2018 11:38:27 +0200
Message-Id: <20180524093122.989133479@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
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

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 2ebf343cbed76773563223761586fd5edcd0dc61 which was
commit 79935915300c5eb88a0e94fa9148a7505c14a02a upstream.

As Ben points out:
	This depends on:

	commit 570c70a60f53ca737ead4e5966c446bf0d39fac9
	Author: Fabio Estevam <fabio.estevam@nxp.com>
	Date:   Wed Apr 5 11:32:34 2017 -0300

	    ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

which did not show up until 4.13, so this makes no sense to have in this
stable branch.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -86,7 +86,6 @@
 		clocks = <&clks 201>;
 		VDDA-supply = <&reg_2p5v>;
 		VDDIO-supply = <&reg_3p3v>;
-		lrclk-strength = <3>;
 	};
 };
 
