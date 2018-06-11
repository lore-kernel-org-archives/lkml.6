Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4TngGm9jHlsQXwAAmS7hNA
	; Mon, 11 Jun 2018 11:56:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D86C8607BB; Mon, 11 Jun 2018 11:56:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 70580601C3;
	Mon, 11 Jun 2018 11:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 70580601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933263AbeFKL4w (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:56:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:41163 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932548AbeFKL4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:56:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 40CD6AE64;
        Mon, 11 Jun 2018 11:56:48 +0000 (UTC)
Date: Mon, 11 Jun 2018 13:56:41 +0200
From: Michal Hocko <mhocko@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Young <dyoung@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Jaewon Kim <jaewon31.kim@samsung.com>, Jan Kara <jack@suse.cz>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Juergen Gross <jgross@suse.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Mel Gorman <mgorman@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miles Chen <miles.chen@mediatek.com>,
        Oscar Salvador <osalvador@techadventures.net>,
        Paul Mackerras <paulus@samba.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Reza Arbab <arbab@linux.vnet.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 00/10] mm: online/offline 4MB chunks controlled by
 device driver
Message-ID: <20180611115641.GL13364@dhcp22.suse.cz>
References: <20180523151151.6730-1-david@redhat.com>
 <20180524075327.GU20441@dhcp22.suse.cz>
 <14d79dad-ad47-f090-2ec0-c5daf87ac529@redhat.com>
 <20180524093121.GZ20441@dhcp22.suse.cz>
 <c0b8bbd5-6c01-f550-ae13-ef80b2255ea6@redhat.com>
 <20180524120341.GF20441@dhcp22.suse.cz>
 <1a03ac4e-9185-ce8e-a672-c747c3e40ff2@redhat.com>
 <20180524142241.GJ20441@dhcp22.suse.cz>
 <819e45c5-6ae3-1dff-3f1d-c0411b6e2e1d@redhat.com>
 <3748f033-f349-6d88-d189-d77c76565981@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3748f033-f349-6d88-d189-d77c76565981@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 11-06-18 13:53:49, David Hildenbrand wrote:
> On 24.05.2018 23:07, David Hildenbrand wrote:
> > On 24.05.2018 16:22, Michal Hocko wrote:
> >> I will go over the rest of the email later I just wanted to make this
> >> point clear because I suspect we are talking past each other.
> > 
> > It sounds like we are now talking about how to solve the problem. I like
> > that :)
> > 
> 
> Hi Michal,
> 
> did you have time to think about the details of your proposed idea?

Not really. Sorry about that. It's been busy time. I am planning to
revisit after merge window closes.
-- 
Michal Hocko
SUSE Labs
