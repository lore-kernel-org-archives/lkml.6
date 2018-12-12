Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7DCC67839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2532080F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 15:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2532080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbeLLPcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 10:32:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:38998 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbeLLPcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 10:32:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 85BA5AF97;
        Wed, 12 Dec 2018 15:31:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Dec 2018 07:31:55 -0800
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, sramana@codeaurora.org
Subject: Re: [PATCH] percpu_rwsem: fix missed wakeup due to reordering of load
Organization: SUSE Labs
In-Reply-To: <a0008e63-0a97-5962-1a92-7770b9347397@codeaurora.org>
References: <1543590656-7157-1-git-send-email-prsood@codeaurora.org>
 <734eb2ec2c3aeba1c4d054c1fceacef1@suse.de>
 <7803e498-5fc8-9b72-3e1b-76005f7673a3@codeaurora.org>
 <a0008e63-0a97-5962-1a92-7770b9347397@codeaurora.org>
Message-ID: <aa864e194ee4c987b7e2025d1fe6e88b@suse.de>
X-Sender: dbueso@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-12-12 06:26, Prateek Sood wrote:
> Please confirm if the suspicion of smp_rmb is correct.
> IMO, it should be smp_mb() translating to dmb ish.

Feel free to add my ack. This should also be Cc to stable as of v4.11.

Fixes: 8f95c90ceb54 (sched/wait, RCU: Introduce rcuwait machinery)

Thanks,
Davidlohr
