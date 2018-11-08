Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C91ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44B620827
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A44B620827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbeKHXAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:00:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:38162 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726571AbeKHXAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:00:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DFB0AC9C;
        Thu,  8 Nov 2018 13:25:14 +0000 (UTC)
Date:   Thu, 8 Nov 2018 14:25:12 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Daniel Colascione <dancol@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, rppt@linux.ibm.com,
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
Message-ID: <20181108132512.GZ27423@dhcp22.suse.cz>
References: <20181031150625.147369-1-dancol@google.com>
 <CAKOZueu5aDtHDBzp6qKECTHEejjb=dyegQkuHh8NfwgNktzFow@mail.gmail.com>
 <20181107160015.GI27423@dhcp22.suse.cz>
 <4536090.43ZsV6LvYe@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4536090.43ZsV6LvYe@merkaba>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 07-11-18 18:04:59, Martin Steigerwald wrote:
> Michal Hocko - 07.11.18, 17:00:
> > > > otherwise anybody could simply DoS the system
> > > > by consuming all available pids.
> > > 
> > > People can do that today using the instrument of terror widely known
> > > as fork(2). The only thing standing between fork(2) and a full
> > > process table is RLIMIT_NPROC.
> > 
> > not really. If you really do care about pid space depletion then you
> > should use pid cgroup controller.
> 
> Its not quite on-topic, but I am curious now: AFAIK PID limit is 16 
> bits. Right? Could it be raised to 32 bits? I bet it would be a major 
> change throughout different parts of the kernel.
> 
> 16 bits sound a bit low these days, not only for PIDs, but also for 
> connections / ports.

Do you have any specific example of the pid space exhaustion? Well
except for a fork bomb attacks that could be mitigated by the pid cgroup
controller.
-- 
Michal Hocko
SUSE Labs
