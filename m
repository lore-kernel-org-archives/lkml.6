Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-667456-1519840075-2-454758794049894220
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519840074; b=Od1jycR9EmTOfjGYqGGSPWzKARkG/121f98itytf3SaPpiS
    D/J32uj9tAObvVhgHA8RTCuAsjwJllRbSUUAqKsSfDH3rbTh89uyM6NA+RwXQ85X
    R61ELDLTxtGjs++n8lWOqw/SmLQD7qHpx0fVYzOODwddgR/D362pWF+0Z48KM/LN
    kvOV2VWzATh7p/vO+a1lGph4zVfWIxS6cOUlwc2hGGprkQJv9If1kZkWbGUySGwt
    mWe6eBZdBdAkUJpcwgZuDLe58+bNuuiQdb6AUy2V4ix44GARrHpeblq2tfUQHVPq
    H+528znRjTkTv+buvDmhTABwErI61w9ejQendUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519840074; bh=PVPAg1hCeux/ACgPbaJN7PZxkGqtWtOWSUBEbVwS8Aw=; b=s
    98P24FSMnaoNJo97LXQA9OVjMmohHdavZudMdfZm3JjmP1iosLSg9vTnwrnQzbxl
    31YgUrgpiXdIgepAMaBCPUXvUMnkBGqJ0ZJylQ96G/OEkt2lMn9zgppqFEznFoD7
    iQEx8aweBIFFeY5R8w5qsAHp+QAWnX9msT+Zv9QsjZIqOdJ7vMHl8dBFNKysjwl8
    kALt+rBG0uK7jUmnaLSCmHqaeISG4h1lVFHKABp5QNfyZlloi7+HWQnJp6bA6uIe
    E1cfn0yoQgmH7fp5rceGTbjTxGa7z0iBvm/Y5CpIrunGz0Sn4Uc5AkRctoFKT2Ah
    HHcajLork8SX4AVtQieOQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AySEs9cF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=bAgzMQh5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=AySEs9cF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=bAgzMQh5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeB1Rru (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 12:47:50 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:49774 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932146AbeB1Rrr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 12:47:47 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54470601CF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=awallis@codeaurora.org
Subject: Re: [PATCH 3.16 083/254] dmaengine: dmatest: move callback wait queue
 to thread context
To: Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Sinan Kaya <okaya@codeaurora.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>
References: <lsq.1519831218.227690932@decadent.org.uk>
From: Adam Wallis <awallis@codeaurora.org>
Message-ID: <ff67c838-e4e4-c254-1a6d-4b395e63604b@codeaurora.org>
Date: Wed, 28 Feb 2018 12:47:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <lsq.1519831218.227690932@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ben

On 2/28/2018 10:20 AM, Ben Hutchings wrote:
> 3.16.55-rc1 review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Adam Wallis <awallis@codeaurora.org>
> 
> commit 6f6a23a213be51728502b88741ba6a10cda2441d upstream.
> 
> Commit adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> introduced a bug (that is in fact documented by the patch commit text)
> that leaves behind a dangling pointer. Since the done_wait structure is
> allocated on the stack, future invocations to the DMATEST can produce
> undesirable results (e.g., corrupted spinlocks).
> 
> Commit a9df21e34b42 ("dmaengine: dmatest: warn user when dma test times
> out") attempted to WARN the user that the stack was likely corrupted but
> did not fix the actual issue.
> 
> This patch fixes the issue by pushing the wait queue and callback
> structs into the the thread structure. If a failure occurs due to time,
> dmaengine_terminate_all will force the callback to safely call
> wake_up_all() without possibility of using a freed pointer.
> 
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=197605
> Fixes: adfa543e7314 ("dmatest: don't use set_freezable_with_signal()")
> Reviewed-by: Sinan Kaya <okaya@codeaurora.org>
> Suggested-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
> Signed-off-by: Adam Wallis <awallis@codeaurora.org>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
[..]

Make sure you pick up the following bug fix on whatever branch you apply the
above patch to


>From 66b3bd2356e0a1531c71a3dcf96944621e25c17c Mon Sep 17 00:00:00 2001
From: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Date: Mon, 29 Jan 2018 14:40:11 +0800
Subject: dmaengine: dmatest: fix container_of member in dmatest_callback

From: Yang Shunyong <shunyong.yang@hxt-semitech.com>

commit 66b3bd2356e0a1531c71a3dcf96944621e25c17c upstream.

The type of arg passed to dmatest_callback is struct dmatest_done.
It refers to test_done in struct dmatest_thread, not done_wait.

Fixes: 6f6a23a213be ("dmaengine: dmatest: move callback wait ...")
Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
Acked-by: Adam Wallis <awallis@codeaurora.org>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>



-- 
Adam Wallis
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
