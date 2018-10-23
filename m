Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3973C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BBF2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 07:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BBF2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJWPpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:45:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:49374 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726837AbeJWPpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:45:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AD68FAFF0;
        Tue, 23 Oct 2018 07:23:07 +0000 (UTC)
Date:   Tue, 23 Oct 2018 09:23:06 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Uladzislau Rezki <urezki@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH 0/2] improve vmalloc allocation
Message-ID: <20181023072306.GN18839@dhcp22.suse.cz>
References: <20181019173538.590-1-urezki@gmail.com>
 <20181022125142.GD18839@dhcp22.suse.cz>
 <20181022165253.uphv3xzqivh44o3d@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181022165253.uphv3xzqivh44o3d@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

On Mon 22-10-18 18:52:53, Uladzislau Rezki wrote:
> On Mon, Oct 22, 2018 at 02:51:42PM +0200, Michal Hocko wrote:
> > Hi,
> > I haven't read through the implementation yet but I have say that I
> > really love this cover letter. It is clear on intetion, it covers design
> > from high level enough to start discussion and provides a very nice
> > testing coverage. Nice work!
> > 
> > I also think that we need a better performing vmalloc implementation
> > long term because of the increasing number of kvmalloc users.
> > 
> > I just have two mostly workflow specific comments.
> > 
> > > A test-suite patch you can find here, it is based on 4.18 kernel.
> > > ftp://vps418301.ovh.net/incoming/0001-mm-vmalloc-stress-test-suite-v4.18.patch
> > 
> > Can you fit this stress test into the standard self test machinery?
> > 
> If you mean "tools/testing/selftests", then i can fit that as a kernel module.
> But not all the tests i can trigger from kernel module, because 3 of 8 tests
> use __vmalloc_node_range() function that is not marked as EXPORT_SYMBOL.

Is there any way to conditionally export these internal symbols just for
kselftests? Or is there any other standard way how to test internal
functionality that is not exported to modules?
-- 
Michal Hocko
SUSE Labs
