Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523471896-2-8099608018936876908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523471896; b=pnO6Zj9X/vooiXEyHrW/i37ntS3lfOrLgNs+G1n5pJ7a1t92Fx
    qAX1UVKjjxIDsthOs6GesUJSen35SkKf2aqWxb+wV0vCwVuL8Iacd/gllwQPU627
    y/TxNjTr36f6miupy4h/F/vOGjwKate5hg9rQ7arJKwsJrD2lKKc5OkH7ZIRWgfI
    fQsbXa/YBpJtyx+VoL8mEodHuIEA9Z5ypdBiwqTC388xrJEe10k4v3qvRb5xwmKr
    KMYnSj8S2oyXb2dxBN/RAjNl9pVWAYeT5CxlHn7xW3uE7tBW3xWG9ORBmit8fZUo
    vR0ntCcWOmCAQQq7xpORq8FzIeF9WIPosqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523471896; bh=/Q+KwF7devfqmAhxTsWIQ2Od5GyVJr
    TSmWSZQCqwAWw=; b=B8XdcqKmqn9JboOK3HaEqlCZFSEgkWOW5yZ9qHoUkl609o
    4l6rlHaxrH+6jBwoFiUrVXroNFPzHjkqhDPjTEFkawpGnVHVkMrCnFLnUb/AEvEz
    PJ0LTP4oibyk2lTPJV7x1wI3Lt6GxtzwpNliUqoHcZMNz0A6ejorxbM5MgkrnPxf
    7YpN6zBZv0N2oaRbvCcsDxtDock7xgkXR87INdc4XUZtP2zD5f3OjCamqf/nHfDR
    y6VVArLJgY22Xe0tpOgJovEAhtEgby7OzHo/FOlATH+ll3RABoFqUy4HfA6Cxpkj
    SjwAOeinpapqhi/OsZJQwRRcIFT2zl+N5UzSqLEw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfIl3G/hMBW/2ESEsqpdZ2PUTN0B23bHEFvI1ITYlQR+E24d0N0Lf88+R/nsVUFzaZAKVzfDo72SeRRTr2PvxdzRG6GWgQIVPtovIuJED70wrP8sIWdRk
    1kDs/sdScrJM8YmhcYpIAjUaPJ8gibrURn6oUbIsJQL0EWsrBpVZ4l8T10j4z+GV2PsjmByyobuXZSKsdtznasXJCu4RZiVzNf6E2JO6GtCre/BipXfbhNB8
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=EosJnc-uYw2q1s0pUq4A:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbeDKSiM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:38:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55276 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753958AbeDKSiL (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:11 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 006/121] qlge: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:35:09 +0200
Message-Id: <20180411183456.621950968@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>


[ Upstream commit df5303a8aa9a0a6934f4cea7427f1edf771f21c2 ]

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
 drivers/net/ethernet/qlogic/qlge/qlge_dbg.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
+++ b/drivers/net/ethernet/qlogic/qlge/qlge_dbg.c
@@ -765,7 +765,7 @@ int ql_core_dump(struct ql_adapter *qdev
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =
 		sizeof(struct ql_mpi_coredump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
 
 	/* Get generic NIC reg dump */
@@ -1255,7 +1255,7 @@ static void ql_gen_reg_dump(struct ql_ad
 		sizeof(struct mpi_coredump_global_header);
 	mpi_coredump->mpi_global_header.imageSize =
 		sizeof(struct ql_reg_dump);
-	memcpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
+	strncpy(mpi_coredump->mpi_global_header.idString, "MPI Coredump",
 		sizeof(mpi_coredump->mpi_global_header.idString));
 
 
