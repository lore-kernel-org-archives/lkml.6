Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934961AbeCHNSi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 08:18:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:5725 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752041AbeCHNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 08:18:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,441,1515484800";
   d="scan'208";a="23527420"
Message-ID: <1520515113.20980.31.camel@gmail.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Date: Thu, 08 Mar 2018 15:18:33 +0200
In-Reply-To: <20180308105358.1506-1-ming.lei@redhat.com>
References: <20180308105358.1506-1-ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 (3.26.5-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-08 at 18:53 +0800, Ming Lei wrote:
> Hi,
> 
> This patchset tries to spread among online CPUs as far as possible, so
> that we can avoid to allocate too less irq vectors with online CPUs
> mapped.
> 
> For example, in a 8cores system, 4 cpu cores(4~7) are offline/non present,
> on a device with 4 queues:
> 
> 1) before this patchset
> 	irq 39, cpu list 0-2
> 	irq 40, cpu list 3-4,6
> 	irq 41, cpu list 5
> 	irq 42, cpu list 7
> 
> 2) after this patchset
> 	irq 39, cpu list 0,4
> 	irq 40, cpu list 1,6
> 	irq 41, cpu list 2,5
> 	irq 42, cpu list 3,7
> 
> Without this patchset, only two vectors(39, 40) can be active, but there
> can be 4 active irq vectors after applying this patchset.

Tested-by: Artem Bityutskiy <artem.bityutskiy@intel.com>
Link: https://lkml.kernel.org/r/1519311270.2535.53.camel@intel.com

Ming,

this patchset fixes the v4.16-rcX regression that I reported few weeks
ago. I applied it and verified that Dell R640 server that I mentioned
in the bug report boots up and the disk works.

So this is not just an improvement, it also includes a bugfix. 

Thanks!
