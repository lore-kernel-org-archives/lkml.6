Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3775DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F3021501
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:28:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F3021501
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732194AbeHBNTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:19:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:58432 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728767AbeHBNTZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:19:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C796AD18;
        Thu,  2 Aug 2018 11:28:40 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:28:38 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Anton Vasilyev <vasilyev@ispras.ru>
cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH v2] HID: intel_ish-hid: tx_buf memory leak on
 probe/remove
In-Reply-To: <20180801112651.6032-1-vasilyev@ispras.ru>
Message-ID: <nycvar.YFH.7.76.1808021328300.25787@cbobk.fhfr.pm>
References:  <20180801112651.6032-1-vasilyev@ispras.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Aug 2018, Anton Vasilyev wrote:

> ish_dev_init() allocates 512*176 bytes memory for tx_buf and stores it at
> &dev->wr_free_list_head.link list on ish_probe().
> But there is no deallocation of this memory in ish_remove() and in
> ish_probe() error path.
> So current intel-ish-ipc provides 88 KB memory leak for each
> probe/release.
> 
> The patch replaces kzalloc allocation by devm_kzalloc and removes
> ishtp_device *dev deallocation by kfree.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> v2: Fix align for multi line statements

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

