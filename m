Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3D7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326262183F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbfAKTJb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:09:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44488 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbfAKTJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:09:31 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AAA4B73A6C;
        Fri, 11 Jan 2019 19:09:30 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C731F9F7B;
        Fri, 11 Jan 2019 19:09:27 +0000 (UTC)
Date:   Fri, 11 Jan 2019 14:09:26 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Artem Savkov <asavkov@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2] x86/tools/relocs: fix big section header tables
Message-ID: <20190111190926.GA9606@redhat.com>
References: <20181129153258.cutmesclgfadc5gu@treble>
 <20181129155615.2594-1-asavkov@redhat.com>
 <20181129155750.xskdusm2fvub6tqa@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129155750.xskdusm2fvub6tqa@treble>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 11 Jan 2019 19:09:30 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:57:50AM -0600, Josh Poimboeuf wrote:
> On Thu, Nov 29, 2018 at 04:56:15PM +0100, Artem Savkov wrote:
> > In case when the number of entries in the section header table is larger
> > then or equal to SHN_LORESERVE the size of the table is held in the sh_size
> > member of the initial entry in section header table instead of e_shnum.
> > Same with the string table index which is located in sh_link instead of
> > e_shstrndx.
> > 
> > This case is easily reproducible with KCFLAGS="-ffunction-sections",
> > bzImage build fails with "String table index out of bounds" error.
> > 
> > Signed-off-by: Artem Savkov <asavkov@redhat.com>
> 
> Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 

Gentle ping to nudge this patch along (I didn't see it in anyone's tree).

Thanks,

--- Joe
