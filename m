Return-Path: <SRS0=M2MR=LX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E34C4321E
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5054204EC
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Sep 2018 16:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5054204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbeIIVfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Sep 2018 17:35:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:44364 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeIIVfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Sep 2018 17:35:52 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 45B2jePJy4ge; Sun,  9 Sep 2018 18:45:37 +0200 (CEST)
Received: from zn.tnic (p200300EC2BDD0A00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bdd:a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 44A711EC0104;
        Sun,  9 Sep 2018 18:45:37 +0200 (CEST)
Date:   Sun, 9 Sep 2018 18:45:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel/sched/core.c: Avoid unused variable on non-SMP
 configs
Message-ID: <20180909164530.GB3873@zn.tnic>
References: <20180908190553.GA4573@gmail.com>
 <20180909093611.GA4614@zn.tnic>
 <CANiq72=RbankDmDSmD+jtvAFArGG-orMSayooGCAEa73_aOAuw@mail.gmail.com>
 <20180909160601.GA3873@zn.tnic>
 <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiq72mXK8EGt7x4EVgU6H0ve9c-wGWuV06=TUfLbzB89_qYeQ@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 09, 2018 at 06:36:01PM +0200, Miguel Ojeda wrote:
> No, you get a different warning depending on whether you have enabled
> CONFIG_PARAVIRT_TIME_ACCOUNTING or CONFIG_IRQ_TIME_ACCOUNTING.

Ok.

Still, adding __maybe_unused to both (or writing it before the name,
whatever works!) and dropping the ifdeffery is still better for
readability's sake than having more ifdeffery, IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
