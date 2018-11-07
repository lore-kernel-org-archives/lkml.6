Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414E4C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D46F20827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 16:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D46F20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbeKHBbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 20:31:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:59834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727546AbeKHBbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 20:31:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE160B65D;
        Wed,  7 Nov 2018 16:00:15 +0000 (UTC)
Date:   Wed, 7 Nov 2018 17:00:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Colascione <dancol@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2] Document /proc/pid PID reuse behavior
Message-ID: <20181107160015.GI27423@dhcp22.suse.cz>
References: <20181031150625.147369-1-dancol@google.com>
 <20181105132205.138695-1-dancol@google.com>
 <20181106130524.GC2453@dhcp22.suse.cz>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 15:48:20, Daniel Colascione wrote:
> On Tue, Nov 6, 2018 at 1:05 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > On Mon 05-11-18 13:22:05, Daniel Colascione wrote:
> >> State explicitly that holding a /proc/pid file descriptor open does
> >> not reserve the PID. Also note that in the event of PID reuse, these
> >> open file descriptors refer to the old, now-dead process, and not the
> >> new one that happens to be named the same numeric PID.
> >
> > This sounds quite obvious
> 
> Many people *on* *LKML* were wrong about this behavior. If it's not
> obvious to experienced kernel developers, it's certainly not obvious
> to the public.

Fair enough

> > otherwise anybody could simply DoS the system
> > by consuming all available pids.
> 
> People can do that today using the instrument of terror widely known
> as fork(2). The only thing standing between fork(2) and a full process
> table is RLIMIT_NPROC.

not really. If you really do care about pid space depletion then you
should use pid cgroup controller.
-- 
Michal Hocko
SUSE Labs
