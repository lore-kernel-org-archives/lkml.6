Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481498-2-12938274309844308935
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
    1523481497; b=Yav/vOVnjpVGASnNZo9OeO7+XFM7JEDgh9hGR9YJkIdzd/Jdiq
    21QUYzeTRChrGZijKtAWk0nnnNoVDOpDWdB9n55INHKB17eANpHVJOPnKmhYORyF
    7CMLdukRSwgnt3MXokV1t+ffPp132wU1N3CgOvOjCVN8YC63Djxgqy1RV/x1zkO/
    PO3xtjo0y9fwcBoOmwZcd/7JGWeAWML4yMinn3WkWeVQXM4ezdoR1jmRzb0GWDlS
    F5h0dPHrwqrc5IR3W0tr9g1eCx9Apz9nbB1QDDKKJBFuitq0tui4+wnQOiXoY0DJ
    P7/t61Gq9Wie8Q1eHQLqAZIBnlc2v84awN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481497; bh=Ijm8vVwoRgp+WObauNFy8P/zoHQn8h
    hqA3DMr+oiyO0=; b=Utei4iHm5L3HjQJqkRqHIeBzbQmNxJqbhu4YMK4hfnYmXx
    wlnPCaAnmZTNsTcNwIsGGj25t9hsh7uyRc1Cd1JaWZUffALuX+ut/Mx5EQRq9MIY
    96cFMoKqO/PjmldmsN6/TmIkREiPY5N9w0TiAIVkEUozYfBlVdb9o0aYLmjB75ID
    n2xbvQ01Gq6zGYjs7JFy1U4EPPbD3r4LjqxRmjuCP7wKb+QCNa9wBAh477s8U/mg
    oEU4xJ18m+raTbGCPCHLMrWv49/s5si5jrEZ7i5kddxePwwrp6W8ANDvIUiGabNW
    chzJBX3m1LKmmYLg2vIhh+8xGdLAIE/biGmtVYbg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMI4wPZAxXBhmIcr7vEd+hrfTBsMiXFKTscY/7Ba8Atp/GIrChWLJmojYxywz9HHFNuy1ziU8zboEP7K8kGZ5Bcc48jJT0ZOQqztfVeEby/ErQ48INMI
    7f3+oH1atbcmnaHDd0CHW/eHjW575e8aMvDfg+N0siFTZBLjpqxrZ4ooHGoFSp8RuntAwJc0JKKxIXkVVEwWx40FjGMuhvzrz9JiycaSO2oD3NrvjkqF10lo
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=8QyaLQAlnL_XF40ULzwA:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754893AbeDKVSA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:18:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754555AbeDKSkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:09 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lin Zhang <xiaolou4617@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 048/121] net: llc: add lock_sock in llc_ui_bind to avoid a race condition
Date: Wed, 11 Apr 2018 20:35:51 +0200
Message-Id: <20180411183459.263283872@linuxfoundation.org>
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

From: linzhang <xiaolou4617@gmail.com>


[ Upstream commit 0908cf4dfef35fc6ac12329007052ebe93ff1081 ]

There is a race condition in llc_ui_bind if two or more processes/threads
try to bind a same socket.

If more processes/threads bind a same socket success that will lead to
two problems, one is this action is not what we expected, another is
will lead to kernel in unstable status or oops(in my simple test case,
cause llc2.ko can't unload).

The current code is test SOCK_ZAPPED bit to avoid a process to
bind a same socket twice but that is can't avoid more processes/threads
try to bind a same socket at the same time.

So, add lock_sock in llc_ui_bind like others, such as llc_ui_connect.

Signed-off-by: Lin Zhang <xiaolou4617@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/llc/af_llc.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -309,6 +309,8 @@ static int llc_ui_bind(struct socket *so
 	int rc = -EINVAL;
 
 	dprintk("%s: binding %02X\n", __func__, addr->sllc_sap);
+
+	lock_sock(sk);
 	if (unlikely(!sock_flag(sk, SOCK_ZAPPED) || addrlen != sizeof(*addr)))
 		goto out;
 	rc = -EAFNOSUPPORT;
@@ -380,6 +382,7 @@ static int llc_ui_bind(struct socket *so
 out_put:
 	llc_sap_put(sap);
 out:
+	release_sock(sk);
 	return rc;
 }
 
