Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0785FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19442152A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH2e3mst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B19442152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbeJQPh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726994AbeJQPhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:37:55 -0400
Received: from localhost (unknown [188.88.119.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1399B21527;
        Wed, 17 Oct 2018 07:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762211;
        bh=L0LmpRvxaPxtXDUSmj3VMbXlMxfqhl9hGJFsEv0niMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RH2e3mstYgZtBat9p1/tvar/wt/vOcpURcHDbAeOLL6/PXTJXfcyGC3OxhVSRiBGV
         dgxNgtKX8TmPkvwZenh94IhcA+z0JDuC/5XEhhAvE1Z+hNJO2aweP72NbQQLcoZ3Z7
         HA99hkh1ersmp9slNfbfQgmP+8BFGI1dSG0UkmHc=
Date:   Wed, 17 Oct 2018 09:43:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Kyle McMartin <kyle@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        David Woodhouse <dwmw2@infradead.org>
Subject: Re: Fate of ihex2fw tool
Message-ID: <20181017074328.GB25537@kroah.com>
References: <CAHQ1cqGzq5k5xVzngJo03eKn03hg43AMQ6r2p129dic9wbm=jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHQ1cqGzq5k5xVzngJo03eKn03hg43AMQ6r2p129dic9wbm=jw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 10:36:15PM -0700, Andrey Smirnov wrote:
> Everyone:
> 
> Since commit 5620a0d1aacd554ebebcff373e31107bb1ef7769 ("firmware:
> delete in-kernel firmware"):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v4.19-rc7&id=5620a0d1aacd554ebebcff373e31107bb1ef7769
> 
> firmware/ihex2fw.c is gone from the source tree and with it ihex2fw
> tool used to generate sruct ihxed_binrec {} filled images (.ihex ->
> .fw) consumed by request_ihex_frimware().
> 
> I tried looking for that too in
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
> but couldn't find it there.
> 
> Is there a  new/different source tree it can be found nowadays?
> Or is there another established tool that can do .ihex -> .fw
> conversion that is expected to be used instead of ihex2bin?

We've all had to write this utility over and over again over the years,
so why not just submit a patch to add this tool back under tools/ ?

thanks,

greg k-h
