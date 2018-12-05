Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 470ADC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104A02081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104A02081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeLEAnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:01 -0500
Received: from mga04.intel.com ([192.55.52.120]:44396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbeLEAm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:42:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2018 16:42:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,316,1539673200"; 
   d="scan'208";a="98694711"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga008.jf.intel.com with ESMTP; 04 Dec 2018 16:42:57 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id E699D300F9B; Tue,  4 Dec 2018 16:42:55 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Larry Bassel <larry.bassel@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: RFC: revisiting shared page tables
References: <20181204231623.GA19227@ubuette>
Date:   Tue, 04 Dec 2018 16:42:55 -0800
In-Reply-To: <20181204231623.GA19227@ubuette> (Larry Bassel's message of "Tue,
        4 Dec 2018 15:16:24 -0800")
Message-ID: <87y3947qi8.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Larry Bassel <larry.bassel@oracle.com> writes:
>
> Isn't Linux kernel archaeology fun :-)
>
> 13 years have elapsed. Given the many changes in the kernel since the original
> patch submission, I'd appreciate your insight into the following questions:

I believe the main objection (from Linus) back then that it would
complicate page table locking significantly, and also add overhead for
it. If anything locking (or even lack of locking, as in lockless code)
has gotten far more hairy in the 13 years, so this issue likely got
far worse.

So if you would work on it I would start with some investigation
what the locking scheme would take, how maintainable it would be,
and how many atomics in hot paths it would add.

-Andi
