Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7DAECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCEB20856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSuzWt19"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCEB20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388088AbeGWVWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:22:09 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37923 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeGWVWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:22:08 -0400
Received: by mail-pg1-f196.google.com with SMTP id k3-v6so1158153pgq.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zfIOu6I+VMvqJb21nGaIWFGtwjDVm0m83vxTeTxFn1A=;
        b=mSuzWt19kXqMLFTkxaTUoXVOoTasW/Bkxi6IoRr5hlqaaJG/utc4e1xJS77GFuCFLk
         Qra5UCrhHwFwXK3iT7ihXNkU0fz/LUehn75bknVCBo2e0LlM3BalCtSy6jkkyweWZ5Yd
         H1p6weHd/dnFiuzMTM3l+pBNBuftt6Va+0kcljCzMKsaSnAPLdN0LQEDvu22QBbN7fd4
         VW29ixkxB1PoEWBcm9/LMybdEZBuRXUfDRNQE3LnrMlzVYCC+QMQfSr1A/fgZdvD/cud
         gIENiiX2GY8AeejqzQLEah7fdeJr+6KkYiKumfay9APfev4kkSvlnmaMQC1n9NkWle5/
         D6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zfIOu6I+VMvqJb21nGaIWFGtwjDVm0m83vxTeTxFn1A=;
        b=RMsurrv5VRVUEernOEncepwfl2/ZEygcAYmoOiuik6ane3XhqEBr5O+4boej/TUhwb
         dDkVrRU4ivuIvX8RQDLsKCisi4uXDq+n/uDtrRm5lIlWrE6DvJFJrS1LUAASNfnCmJmk
         XZhoUqQvXwRJC37WfpivFvT9Qci+7/ue51iiWYnBlxYwdAPwBXcPiuKdcmZG+G1+8ar1
         i/dHZ+hQhWwNTobG42AINSbT/2z+qUKPCJ0Z069PxNxpwzLq5wpyEZMOS0u3lGfOLKpy
         DZnNEXpvITBLu+IyZgTjVaIJbICFIFQGWjczkVfhSo5vLBORhbNhpJJEI83o/5kbnOSw
         myJQ==
X-Gm-Message-State: AOUpUlFRLLvRhJ5Q9PcHUgpDGTX6H2K7oxLnIBdTDNTBPKL4lMI0zt9K
        S7HEOKDgKe6cB58gMpW6My/pjw==
X-Google-Smtp-Source: AAOMgpcheeCrrsxANQpt3f9hpBeWB/Czf4ZCuw4xHp4M7qnsYVAH+d2zQZ1t50jnve9l2m0a0CcP8w==
X-Received: by 2002:a65:45cc:: with SMTP id m12-v6mr13542531pgr.160.1532377158077;
        Mon, 23 Jul 2018 13:19:18 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id l13-v6sm11915388pgs.15.2018.07.23.13.19.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 13:19:17 -0700 (PDT)
Date:   Mon, 23 Jul 2018 13:19:16 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempool: add missing parameter description
In-Reply-To: <1532336274-26228-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1807231319040.105582@chino.kir.corp.google.com>
References: <1532336274-26228-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jul 2018, Mike Rapoport wrote:

> The kernel-doc for mempool_init function is missing the description of the
> pool parameter. Add it.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Acked-by: David Rientjes <rientjes@google.com>

My b.
