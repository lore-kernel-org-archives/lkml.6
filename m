Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365C5C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC9F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:21:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC9F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754104AbeFUKVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:21:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53325 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751691AbeFUKVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:21:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A031EACEE;
        Thu, 21 Jun 2018 10:21:21 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Zong Li <zong@andestech.com>, palmer@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, greentime@adnestech.com
Subject: Re: [PATCH 5/5] RISC-V: Use fixed width integer types for 32-bit compatible
References: <cover.1529506497.git.zong@andestech.com>
        <37a6523947397cd72320676030b96926e373d05a.1529506497.git.zong@andestech.com>
        <20180621064322.GE19319@infradead.org>
X-Yow:  Do you need any MOUTH-TO-MOUTH resuscitation?
Date:   Thu, 21 Jun 2018 12:21:19 +0200
In-Reply-To: <20180621064322.GE19319@infradead.org> (Christoph Hellwig's
        message of "Wed, 20 Jun 2018 23:43:22 -0700")
Message-ID: <mvmwousjv8g.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 20 2018, Christoph Hellwig <hch@infradead.org> wrote:

>>  static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
>>  {
>>  	if (v != (u32)v) {
>> -		pr_err("%s: value %016llx out of range for 32-bit field\n",
>> +		pr_err("%s: value %016" PRIxX "out of range for 32-bit field\n",
>>  		       me->name, v);
>>  		return -EINVAL;
>
> But in general Linux uXX and sXX values are always the same underlying
> fundamental C type.  What is the mismatch here?

The mismatch is that v is Elf_Addr, not u32.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
