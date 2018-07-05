Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBFBC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 870AD24065
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 15:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HhOp/Pcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 870AD24065
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754118AbeGEPJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 11:09:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40957 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeGEPJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 11:09:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id z13-v6so11547327wma.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 08:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qN+savN08cVMg3cpWpTASFGssVp/aL4JtxMUHV3wAJI=;
        b=HhOp/PcgFuggzrhZ2yevQUXEMEUVCMyeOAYme71MKz+iZQlAwixM4tCRt2m9Vjcy1z
         ee6GsyvNcimCU8Z9sqAE8+HDoeoeyGNmuQCB67Z3VW0T2CG6LKySLrZn3o7oJSH4CWdu
         38KTIdktMezmMjEKFLU9iUqSgepKIozZ0vArM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qN+savN08cVMg3cpWpTASFGssVp/aL4JtxMUHV3wAJI=;
        b=tpdDperH3xfvBePsGXT/vRNss4gauMR+Kq3pl0c1a6MSHuNR0ps9Yyqg3WxUD2sJaC
         SHTWyAp0nlBIo1whJlHrWNjS4ClmLZI+m47br6hAvXOOHDFLlcO5fG/5gMBqSZwbhbTJ
         astmyVT9fL/uq+Yn/cy/5ZYzhVH7g1EAkHa33NwDIIfgx9EL9va3f7hmxx/HwSiRB3zo
         i+y2GMeCAhr30YpBwoh4LOBfeKK7rgpKcVV/2MWqmYlKp/sdYZ/mHW771mSCR9KHR92z
         6XElUl9wdFw3wkf0L/K+IFxkjEBGHjpMnIxPezUzXokmbwZ3xMIhfQ1asE3TBzh2kudx
         DTjA==
X-Gm-Message-State: APt69E2Xjg8LJuHjMD8b/wPVN8XZsaITcfG8Kj0AA2P5P/+iG0+CFVes
        UKPQH3DqrV7G0lrcjibJSEh0Eg==
X-Google-Smtp-Source: AAOMgpfUWdlGEFM7zgAt+kD8NWmrG4nodwVpyfaajVKuihnroEDajP1xQEyAGREvm4OE75oomE/pjg==
X-Received: by 2002:a1c:c90:: with SMTP id 138-v6mr4163078wmm.110.1530803391727;
        Thu, 05 Jul 2018 08:09:51 -0700 (PDT)
Received: from andrea ([94.230.152.15])
        by smtp.gmail.com with ESMTPSA id 189-v6sm8168580wmd.17.2018.07.05.08.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 08:09:51 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:09:45 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Will Deacon <will.deacon@arm.com>,
        LKMM Maintainers -- Akira Yokosawa <akiyks@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kernel development list <linux-kernel@vger.kernel.org>,
        dlustig@nvidia.com
Subject: Re: [PATCH 2/2] tools/memory-model: Add write ordering by
 release-acquire and by locks
Message-ID: <20180705150945.GA3699@andrea>
References: <20180704121103.GB26941@arm.com>
 <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1807051010380.1697-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> At any rate, it looks like instead of strengthening the relation, I
> should write a patch that removes it entirely.  I also will add new,
> stronger relations for use with locking, essentially making spin_lock
> and spin_unlock be RCsc.

Thank you.

Ah let me put this forward: please keep an eye on the (generic)

  queued_spin_lock()
  queued_spin_unlock()

(just to point out an example). Their implementation (in part.,
the fast-path) suggests that if we will stick to RCsc lock then
we should also stick to RCsc acq. load from RMW and rel. store.

  Andrea


> 
> Alan
> 
