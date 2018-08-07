Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B7C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6892E21775
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 13:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6892E21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389320AbeHGPxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 11:53:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:43804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388929AbeHGPxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 11:53:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10ACFAD1B;
        Tue,  7 Aug 2018 13:38:56 +0000 (UTC)
Date:   Tue, 7 Aug 2018 15:38:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Bart Van Assche <bart.vanassche@wdc.com>
Cc:     linux-kernel@vger.kernel.org,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Joe Perches <joe@perches.com>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] lib/vsprintf: Do not handle %pO[^F] as %px
Message-ID: <20180807133855.d2yry6it5wnu6pqt@pathway.suse.cz>
References: <20180806223421.11995-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806223421.11995-1-bart.vanassche@wdc.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2018-08-06 15:34:21, Bart Van Assche wrote:
> This patch avoids that gcc reports the following when building with W=1:
> 
> lib/vsprintf.c:1941:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    switch (fmt[1]) {
>    ^~~~~~
> 
> Fixes: ce4fecf1fe15 ("vsprintf: Add %p extension "%pOF" for device tree")

To be precise, the above commit was fine because it was the last
"case" in "switch". It has got broken by the commit
7b1924a1d930eb2 ("vsprintf: add printk specifier %px").

Other than that the patch fixes a real problem. I have updated the "Fixes"
tag, added stable tag and pushed it into printk.git, for-4.19 branch.

Best Regards,
Petr
