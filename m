Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbeCHXUN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 18:20:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:39958 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750824AbeCHXUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 18:20:12 -0500
Date: Fri, 9 Mar 2018 00:20:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Ming Lei <ming.lei@redhat.com>
cc: Artem Bityutskiy <dedekind1@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH V3 0/4] genirq/affinity: irq vector spread among online
 CPUs as far as possible
In-Reply-To: <20180308133440.GA2713@ming.t460p>
Message-ID: <alpine.DEB.2.21.1803090011150.1454@nanos.tec.linutronix.de>
References: <20180308105358.1506-1-ming.lei@redhat.com> <1520515113.20980.31.camel@gmail.com> <20180308133440.GA2713@ming.t460p>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Mar 2018, Ming Lei wrote:
> Actually, it isn't a real fix, the real one is in the following two:
> 
> 	0c20244d458e scsi: megaraid_sas: fix selection of reply queue
> 	ed6d043be8cd scsi: hpsa: fix selection of reply queue

Where are these commits? Neither Linus tree not -next know anything about
them....

> This patchset can't guarantee that all IRQ vectors are assigned by one
> online CPU, for example, in a quad-socket system, if only one processor
> is present, then some of vectors are still assigned by all offline CPUs,
> and it is a valid case, but still may cause io hang if drivers(hpsa,
> megaraid_sas) select reply queue in current way.

So my understanding is that these irq patches are enhancements and not bug
fixes. I'll queue them for 4.17 then.

Thanks,

	tglx
