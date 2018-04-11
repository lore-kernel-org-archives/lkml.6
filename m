Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481312-2-8503008766296909390
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
    1523481310; b=NOsqtBbjUq2ZHzgM89aXphhDAn9w8x1YXMi3S6HOdUVJ1NLEKx
    fDWimwEJMFqV3gDwXCvf466cVM8AiS04rAWI4yWaTE8yp9AC4XfnmOXJJ419YtEw
    jhScs5h+2ktmV3r/rAW8LPLr6SMpzeWo8rmGuJHzahabQJuw292oCPIgbh4eHkRB
    00UHstn0XdOxf6zE/wLxKZjWl5bhiylf0TQMADdSKXhPcvM9dG4gT+HBP6t4WfkH
    JS+RG7YbHcOUdoSRQszcaLxDbg5Exi+h3Ry2mnLGo6lwMdiaerxwz3ngouWw20wp
    X1WMrc3QRWlfTe4KmmJ8Bg0JH6gO18hc78wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481310; bh=MXr8Q1XLsqSEESSwpqlmFjT/a2nIGE
    D/Cxsu+/Ds134=; b=WQ5yBRShXSiTZ4a6GqqUccMZmpWkqHgP8s6MixBNHZbNr/
    1RPOT7/EsEef5nAmqp3j3HnSESVsp6ZuVrlnPe6syjA0wRlgaFa2KoHZbsFa0Oe8
    IjC29tV0y6X+d1BYUxspU82DqHZ8GkbrTlFJqV/P2gspnbLqb760pyRtEufVTXNv
    M8Kx9P7ksbDYaK2/XAbQLZNVL9RQ0eiEvEDDyGUcB5nRZZmyTJHZCHNnc2lnxInF
    X1kdlAPPQoSYrO494YbwzbOFX6qqgZ8zaVtvuof+QHy+QzDD8zVDudzvW3nBpj2n
    yAGIwnaR6t9c1PoTPy+rWMr6QA29MeEG1jOPES7g==
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
X-CM-Envelope: MS4wfD+6vB3ezYffeuRzol7FvfsBlGkjz6RDnw1Yx/rgHM0z4a/mQGXjZod64tEmw9tqMBcpULAtlzomh6UmEEbid5iHVt4186pkk7/OmoVD9sze5sNQD5B5
    ZgbfV+5cMvL7jxiTp8hWAx9a/x9pvak89L8xky+kVAm5/aG8TxlbOt1P+rfJQ5xKv3zWGKhx0eo31cLQetT1ZIxwkqWDdrsmoFcRa1aAQSpvQNoVDrj7Jedd
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=c-n4J4-pAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=WWKxpUl2dnY64VEuUGEA:9
    a=QEXdDO2ut3YA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754093AbeDKVOu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:14:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754734AbeDKSk4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Jarzmik <robert.jarzmik@free.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 070/121] tags: honor COMPILED_SOURCE with apart output directory
Date: Wed, 11 Apr 2018 20:36:13 +0200
Message-Id: <20180411183500.416557451@linuxfoundation.org>
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

From: Robert Jarzmik <robert.jarzmik@free.fr>


[ Upstream commit cbf52a3e6a8a92beec6e0c70abf4111cd8f8faf7 ]

When the kernel is compiled with an "O=" argument, the object files are
not in the source tree, but in the build tree.

This patch fixes O= build by looking for object files in the build tree.

Fixes: 923e02ecf3f8 ("scripts/tags.sh: Support compiled source")
Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/tags.sh |    1 +
 1 file changed, 1 insertion(+)

--- a/scripts/tags.sh
+++ b/scripts/tags.sh
@@ -106,6 +106,7 @@ all_compiled_sources()
 		case "$i" in
 			*.[cS])
 				j=${i/\.[cS]/\.o}
+				j="${j#$tree}"
 				if [ -e $j ]; then
 					echo $i
 				fi
