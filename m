Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31661C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D306E208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNzttwsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D306E208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389649AbeHAQ0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733151AbeHAQ0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:26:19 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2D3620894;
        Wed,  1 Aug 2018 14:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533134416;
        bh=oKfR7tlUdYTr5UBsEtYdehChaXrHQTBQ8stBPIe81BY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mNzttwsPajgJEplUqzcgg52EgWZk4WBjjbgnfgbRPdkjuZGQZwgssys+0AVYbkIoB
         NGmobh+ACNY0b5j6Hzawqsf6x74wndUuE+wgsjjYWuMu87PfFw59MbRUiMCXjT19I8
         iYNfMlkZcuzolE8sVy5sS36HuzvQC0UupFFJjmiA=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E77461403B8; Wed,  1 Aug 2018 11:40:11 -0300 (-03)
Date:   Wed, 1 Aug 2018 11:40:11 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Christophe LEROY <christophe.leroy@c-s.fr>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] perf tools: allow overriding MAX_NR_CPUS at compile time
Message-ID: <20180801144011.GA16449@kernel.org>
References: <20170922112043.8349468C57@po15668-vm-win7.idsi0.si.c-s.fr>
 <20180503134037.GB8442@kernel.org>
 <dc8f1911-fa9a-c1c8-0dd5-fd33236da69a@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc8f1911-fa9a-c1c8-0dd5-fd33236da69a@c-s.fr>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Aug 01, 2018 at 11:37:30AM +0200, Christophe LEROY escreveu:
> 
> 
> Le 03/05/2018 à 15:40, Arnaldo Carvalho de Melo a écrit :
> > Em Fri, Sep 22, 2017 at 01:20:43PM +0200, Christophe Leroy escreveu:
> > > After update of kernel, perf tool doesn't run anymore on my
> > > 32MB RAM powerpc board, but still runs on a 128MB RAM board:
> > 
> > Cleaning up my inbox, found this one, simple enough, still applies,
> > applied.
> 
> Did you finally apply it ? I can't see it in linux-next. Will it be merged
> into 4.19 ?

Sure, applied it finally, 

- Arnaldo
