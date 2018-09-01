Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6054CC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877D2083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E877D2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeIBCCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 22:02:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:51864 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727045AbeIBCCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 22:02:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40E84ACEF;
        Sat,  1 Sep 2018 21:48:41 +0000 (UTC)
Date:   Sat, 1 Sep 2018 23:48:39 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Al Viro <viro@ZenIV.linux.org.uk>
cc:     Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: Access to non-RAM pages
In-Reply-To: <20180901171330.GF19965@ZenIV.linux.org.uk>
Message-ID: <nycvar.YFH.7.76.1809012347390.25787@cbobk.fhfr.pm>
References: <3009b28a-971c-920a-9184-900f1f3b2203@suse.com> <alpine.LRH.2.00.1808312312480.14475@gjva.wvxbf.pm> <b1b5ef64-d49b-e3f7-98b4-0ae3fd57b812@suse.com> <20180901171330.GF19965@ZenIV.linux.org.uk>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Sep 2018, Al Viro wrote:

> IMO that's crap.  In absolute majority of cases there is a guaranteed gap
> between the end of accessed object and the next page boundary.  

So if that's the case, you're absolutely right. But I am unable to find 
any such guarantee in our current code though.

Thanks,

-- 
Jiri Kosina
SUSE Labs

