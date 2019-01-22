Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DADC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F38120684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbfAVXwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:52:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726175AbfAVXwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:52:13 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A2DB79FDCF;
        Tue, 22 Jan 2019 23:52:12 +0000 (UTC)
Received: from redhat.com (ovpn-124-136.rdu2.redhat.com [10.10.124.136])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD87C100194A;
        Tue, 22 Jan 2019 23:52:11 +0000 (UTC)
Date:   Tue, 22 Jan 2019 18:52:07 -0500
From:   Jerome Glisse <jglisse@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Page flags, can we free up space ?
Message-ID: <20190122235207.GC4747@redhat.com>
References: <20190122201744.GA3939@redhat.com>
 <87tvi074gg.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvi074gg.fsf@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Tue, 22 Jan 2019 23:52:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 01:44:15PM -0800, Andi Kleen wrote:
> Jerome Glisse <jglisse@redhat.com> writes:
> >
> > Right now this is more a temptative ie i do not know if i will succeed,
> > in any case i can report on failure or success and discuss my finding to
> > get people opinions on the matter.
> 
> I would just stop putting node/zone number into the flags. These
> could be all handled with a small perfect hash table, like the original
> x86_64 port did, which should be quite cheap to look up.
> Then there should be enough bits for everyone again.

Definitly something i will look into, i was scare to remove those.

Cheers,
Jérôme
