Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE753C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:02:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FD220831
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 23:02:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NQ0qH8yN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94FD220831
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeLIXCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 18:02:23 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37579 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbeLIXCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 18:02:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so4440959pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 15:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=D5Oat1hTwep3QcyUUzhhIIbWo+ArAwmB9qovC2BFFIA=;
        b=NQ0qH8yNMvM8rcj2kzZA/zTuM94nQo2Y5mrAw2Ik3c7GQZbEVpxlefKWaol8KEYonu
         BpDu8CcrVguM9wEcXGZjaAILY+8Nj2sH/zL881blr1m5DBmQm15b2+syPeDwXFiBlbGq
         6CohlQJdCI5xPdrJcxzeQ/ovYr8eL9822jyBeXmkiNSqbwG0PMsPhbr/+bvDvbYqD8+3
         gdRn2A5yJpf05RTNiOhapyEyCk9O6pq78tga3eJb6U56s9L6oE9/5U2uSFE08imcGw8y
         M6sL9vg8NxV9nzidZRnJSzclbjtgft40Ju8pMaamT1y9cIsrWbNoLzT62SAi5YwtXq0v
         T/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=D5Oat1hTwep3QcyUUzhhIIbWo+ArAwmB9qovC2BFFIA=;
        b=UvPFw4DpkoAblTYY4NMG64DjuIBTWmdWbkbwnzfv3wDCvDVdTh3FYujasK4b5QHvtw
         rSyAnPwLABGeeM+v5CC5o3kkKRdkXNLNenYyNkv78NwiKhcGBFYE2Xln7Aqbsxn4F/uQ
         cj6aFI94dJUrRPjv3CJMcdhUhYAOo1iVaCL5u9MM+ttRNkZYGWw5Z9n/VCvw4JIrHmqb
         1jjO2y6EvxksEh2iWdCUsmN4FhUs3dCYudcF1xPbq4Mu9NrMT1W495kX1dzj1LmiiPAT
         7g2ArifrTW65LRqEAAASCUl5c+UdD7XHFCm/vcCZhBZRAKK6s85vbJAunR2bgu/qv//P
         MJbg==
X-Gm-Message-State: AA+aEWZPHCtpJrTSBkS9SaAs5hZqpbbhm/cHhNU10WCsfiB8gF1BkNPn
        bXN54lFSYsnlj3A91kKsW32Mww==
X-Google-Smtp-Source: AFSGD/VvmJVBeopuZ1ffLyHckP4egtr0JNSa4uiIE75nkdqUf8S1tpFylGl9S2dJenxSgY6gGE2GGw==
X-Received: by 2002:a62:2f06:: with SMTP id v6mr10322382pfv.216.1544396542132;
        Sun, 09 Dec 2018 15:02:22 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id n21sm18582015pfg.84.2018.12.09.15.02.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Dec 2018 15:02:21 -0800 (PST)
Date:   Sun, 9 Dec 2018 15:02:21 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Rapoport <rppt@linux.ibm.com>
cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] docs/mm-api: link slab_common.c to "The Slab Cache"
 section
In-Reply-To: <1544130781-13443-3-git-send-email-rppt@linux.ibm.com>
Message-ID: <alpine.DEB.2.21.1812091502070.206717@chino.kir.corp.google.com>
References: <1544130781-13443-1-git-send-email-rppt@linux.ibm.com> <1544130781-13443-3-git-send-email-rppt@linux.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018, Mike Rapoport wrote:

> Several functions in mm/slab_common.c have kernel-doc comments, it makes
> perfect sense to link them to the MM API reference.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>
