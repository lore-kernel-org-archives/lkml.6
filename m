Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713601-1523399840-2-10327554575503999135
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
    1523399839; b=b4W2joyutORfAvXbtQzn5enmgItwSBMvHJa2YHL7ZqgYLDBzK2
    m0onFoIWx2+ns7Qzdb5ibOs6xoD43wIb6/o6OvdV8KuP2e+w9UQ88KYfFYgAkjlX
    z5X9isIfvXnHjjb/5g25lU+LRbI6/SHFVP75VyDS8deNmxqrPxJFTBOpqhRwZXH2
    xPP4HZyPYqsJcE+3s4MKEF76orMOsHqxPK4xmGxNxtAs3U76D3Gj/YZk8EozI+Oq
    tXM5w5Xpk0cUwcwsv26CxXqqaJ0HxqtYsgaFilUMY+MP9BPWWBHBvIF6LSW4SUvr
    T4sZviReaV4N5H2wxoMIpKGRWf2e1Vn2RD+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523399839; bh=9ryAfHl3elZ0saUVeskn5sPnlivuTw
    LzY6mzHCqwN7s=; b=bAMv/FLo4lyr3M5gSjzzjLrq+GlWpe7NWgADPzepoRubSr
    4yaAdRmuTYlmW4uKAxSUGncobLMrv/zqltVScPgFKisFmhXjIEXW2zhFdr7OsjZe
    44+/MUMOV+oyQA+y+kqWr+kBQnbZ2VPuSV1RxjZdw5af/x+lNxzfUkGf7Ks7n8+9
    iImc/IBVsvBVFYUfrAIoyxnCNio6UMTV/6oOJPDgilSmRj/dT6cGXv6jHX7CM/xG
    +oh6vDfwxYdm0KtuOuDa8UJ0bZjD7a3UU72/wVNZuMCWWnGUqmsMa6zf1wfzTxwk
    D35LZ5mJlYA5K9sDXuIFRcnMRrQiQBF3O/No75Rg==
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
X-CM-Envelope: MS4wfIa12jh/Y3EXgCltvLCAx2Vau6nGM6ctmmWQLcfgv4GszLXDqn082TBonQHfUywHSznrOIQgR9/9RaSE/3MFy1Ni9sju+jvraO1j61SM3PyCYBhsLA/H
    7G6xtzZ47uj2SJknpRdFojhs9a45m9jC9WRbDqXTxJlq+iYwnq1eEEV4u/1+/H7iKkZUj4pKN4pJdYjdA5LAzOaoi5vODhpfX9B6VOohOKjlWJUNQLHxaFql
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=JfrnYn6hAAAA:8
    a=20KFwNOVAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=y_L7MMOgF-3D9RAZX5MA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932415AbeDJWhP (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 18:37:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:43718 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932413AbeDJWhO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 18:37:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 080/138] perf tools: Fix copyfile_offset update of output offset
Date: Wed, 11 Apr 2018 00:24:30 +0200
Message-Id: <20180410212911.411502312@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180410212902.121524696@linuxfoundation.org>
References: <20180410212902.121524696@linuxfoundation.org>
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

From: Jiri Olsa <jolsa@kernel.org>


[ Upstream commit fa1195ccc0af2d121abe0fe266a1caee8c265eea ]

We need to increase output offset in each iteration, not decrease it as
we currently do.

I guess we were lucky to finish in most cases in first iteration, so the
bug never showed. However it shows a lot when working with big (~4GB)
size data.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Fixes: 9c9f5a2f1944 ("perf tools: Introduce copyfile_offset() function")
Link: http://lkml.kernel.org/r/20180109133923.25406-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/util/util.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -196,7 +196,7 @@ int copyfile_offset(int ifd, loff_t off_
 
 		size -= ret;
 		off_in += ret;
-		off_out -= ret;
+		off_out += ret;
 	}
 	munmap(ptr, off_in + size);
 
