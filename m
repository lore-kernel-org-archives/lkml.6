Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id OQdkEkj+GltjCwAAmS7hNA
	; Fri, 08 Jun 2018 22:08:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2BF58607E4; Fri,  8 Jun 2018 22:08:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="VAB0yv7W"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 7CA9E607A4;
	Fri,  8 Jun 2018 22:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7CA9E607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbeFHWID (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 18:08:03 -0400
Received: from one.firstfloor.org ([193.170.194.197]:40034 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeFHWIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 18:08:02 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 5258286874; Sat,  9 Jun 2018 00:08:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1528495680;
        bh=GIiSi+LUbPWwh1sXRum6cQerWJV+TIWDNJU04rPoTIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAB0yv7WBnJ49KGxV127XGU8znM8DW//Y1zqs5CLI8rrZzYZaNtxLaXnQrrycR3/N
         l3gxcy2argkFOROOEJDU/f48o6lG0OI/c7zPexGsB5BcBNzCZavUSR/T6EwQMROokB
         ZL9BQ8lkuvoo4XwoczOdLQeCmSRA0R1Sf8IBAK/Q=
Date: Fri, 8 Jun 2018 15:08:00 -0700
From: Andi Kleen <andi@firstfloor.org>
To: Greg Thelen <gthelen@google.com>
Cc: Andi Kleen <andi@firstfloor.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kbuild@vger.kernel.org, akpm@linux-foundation.org,
        Andi Kleen <ak@linux.intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [PATCH] trace: fix SKIP_STACK_VALIDATION=1 build
Message-ID: <20180608220759.irqviu5g4a3w7nms@two.firstfloor.org>
References: <20180608214746.136554-1-gthelen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180608214746.136554-1-gthelen@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 02:47:46PM -0700, Greg Thelen wrote:
> Non gcc-5 builds with CONFIG_STACK_VALIDATION=y and
> SKIP_STACK_VALIDATION=1 fail.
> Example output:
>   /bin/sh: init/.tmp_main.o: Permission denied
> 
> commit 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace"),
> added a mismatched endif.  This causes cmd_objtool to get mistakenly
> set.
> 
> Relocate endif to balance the newly added -record-mcount check.
> 
> Fixes: 96f60dfa5819 ("trace: Use -mcount-record for dynamic ftrace")
> Signed-off-by: Greg Thelen <gthelen@google.com>

Looks good thanks.

Acked-by: Andi Kleen <ak@linux.intel.com>

-Andi
