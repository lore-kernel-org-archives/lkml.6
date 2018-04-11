Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477795-2-10670608880748879724
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
    1523477794; b=KkSAXuSiMtra9OK/hFpyNOhkYKQzjo0AqwcI6b0uQReXeIpPR6
    VWroR3Dlg4ORLv6QYTxnQ0o3U1D3UPh66Yeg5oakP+Xy+GpMHv86er64SrT3ktDc
    5sD7K586FavlV299KUS+qJhj5SZVCjWcxN0lhzNLxY2BzOFVnnUHcrLwJfY1IRtY
    nmZIffdERn6DVx+wrZzMDk0ZqsZ2KEPhJHjHgqDP+X/rymfhYqtgsc9/617P0QlF
    7KGkX3u6K0Z6/UEMTIhZpYWqDp6mgbYk/UslJ6B7VgBRUVKlbrNm70bgVxGiBYk7
    ChISWrogMr8/1JWTzMR3g/gmClkFGhIz2eFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477794; bh=4zIaDJXf53yepR/8rO4Q2aleMXrcYn
    /iXISPHc/9zj0=; b=RXV9KaM+rHyx/WRDgPNu2bjsuD3rifTDKGIRQxx89ULm5b
    EjFjkgVqAKgBA2e/57EbG2pvK/sCZy74v5GVwKKFqzWAXWPqiRFQLWIrUyfZWANh
    G7+4uD+/7LAUWrhq4GX3xr2ks1ZRvA/tRK2+D6gZU3nCXieWHXXnBQo4TRYEh99A
    VaVgs83ktln1ME377iD14eELqNfRGOsCF/EYVxr3Tc0fMu+oL0LeLohGfvoNIIrF
    0sgrlk94LazVal4KcMXh5bny12iUy0LcHhd74/H6JWZDAvqfPo9g7HrZfDVlbMYH
    qHTzHGZwfStX/oQp2YlgecIHzPVQJlS87NWRdwIw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHqyQ5j8Xqm/aqMx/Zz9FmgHlFKk9iOUUjQ+hQvg7dcLUoncFacV4A9gyYKGoU4Xy59c9V7r+Su5DHSLsxPIcvBnEgCMyoB9Y/l4m6LBt4OyJADnRq1d
    Mp7YxZpDsxXKGmtN4wMgA3rQPuB6cFwEsOg++JMWGVD3m54z9jOPJDSYXMWJQCamWPmTziYDEVByNmBKdXuaOFQNTKSyp8FvLcUZqXyspNAv2/6qjgzLANap
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=Bz2UWhLJlFZaMJpv9z8A:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932432AbeDKSw4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:52:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33570 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933172AbeDKSwz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:52:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 014/310] bna: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:32:33 +0200
Message-Id: <20180411183622.918917915@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 9e4eb1ce472fbf7b007f23c88ec11c37265e401c ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2845,7 +2845,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bf
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	memcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
 
 static void
