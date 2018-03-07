Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtPY61T2mwhDckn5sCLO5IyphKtfAfWetLx3Hee7gr56jmvyCIL5pCT9QDZ1aCL9jYODPCW
ARC-Seal: i=1; a=rsa-sha256; t=1520452822; cv=none;
        d=google.com; s=arc-20160816;
        b=CDYZN3tiS4YEILhwPYXVfqJoco2G4XnXPTd+yVK6B5MT1akUdtr6c40VAVWb9icmha
         mNxr806OldC4jYaWyQag8WEUQsg+qZgbotgPxIrP5Tbz3wLSnRWQa36teLEiDw3/8mBe
         rEU4uU4D0ekDst8tGcWfP1tYC5BK1/jwdTd8FHx3+ysRYaSxuA5cYg7IQHwWaCPUzg5h
         AGsE+MPGYo+zyW3FPUXdnso88HX5WCYOQ37e3VTD5HHGZHfpeD74ASqscD/h5hmfBB88
         Cu/gZp4KbauvBbZg1ICAFA/zvrBVe6psub8WXozMmkRiF3+O9UIBd6c76/reU/EGTwit
         F6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:from:subject:cc:to:message-id:date
         :arc-authentication-results;
        bh=TckQ75j6PC4H0jR1WVEbtlX2jxzMXdWRSGsiJ/uIo00=;
        b=mzKKoqsO19oKV7tpNSQX/yAiybdc62ktR5MbeGryDYgmDixp1r4HkljZit9LW0WURI
         TDgOZLzfdJrTYBJwLvjJzaRXWCHLmkLxOmmsfN8U2O0VBPzPkG6DmLdIoMt1UifXU8Pa
         aFiPoPGkipcHdW7+3kjvoQF7yCPi1rVi3A2U9iE+/idgTlmRH8JE0XjUI9Bk0xqddZRc
         ako780LKuwWvfL8m9Gd6hlJhoagIpQZVLv35nI3Pq4MXu2l1VVIbHv5X4HQ5UVFv1aOb
         xoRzUflEZyQ8/qebTtHKh78tFGOJREKQ6v/rvJ0lftnROfwwOznpKjP3+fgrIIWjTooP
         RUGg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964895AbeCGT7m (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 7 Mar 2018 14:59:42 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:56424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965521AbeCGT7b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Mar 2018 14:59:31 -0500
Date: Wed, 07 Mar 2018 14:59:28 -0500 (EST)
Message-Id: <20180307.145928.456070038633384401.davem@davemloft.net>
To: shuah@kernel.org
Cc: anders.roxell@linaro.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        shuahkh@osg.samsung.com
Subject: Re: [PATCH] selftest: net: reuseport_bpf_numa: don't fail if no
 numa support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1a84294d-babc-e4ff-1e2f-9265450fee8f@kernel.org>
References: <20180306151004.31336-1-anders.roxell@linaro.org>
        <20180307.132500.40232199631094354.davem@davemloft.net>
        <1a84294d-babc-e4ff-1e2f-9265450fee8f@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594201505777703046?=
X-GMAIL-MSGID: =?utf-8?q?1594310338657215314?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Shuah Khan <shuah@kernel.org>
Date: Wed, 7 Mar 2018 12:51:06 -0700

> That said, I am open to adding a distinct state for skipped because
> can't be run.

That is what I think should happen.
