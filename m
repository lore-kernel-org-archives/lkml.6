Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755395AbeEaOae (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 10:30:34 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:40694 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755291AbeEaOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 10:30:30 -0400
Date: Thu, 31 May 2018 14:30:29 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Matthew Wilcox <willy@infradead.org>
cc: Jia-Ju Bai <baijiaju1990@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can kfree() sleep at runtime?
In-Reply-To: <20180531141452.GC30221@bombadil.infradead.org>
Message-ID: <01000163b69b6b62-6c5ac940-d6c1-419a-9dc9-697908020c53-000000@email.amazonses.com>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com> <20180531140808.GA30221@bombadil.infradead.org> <01000163b68a8026-56fb6a35-040b-4af9-8b73-eb3b4a41c595-000000@email.amazonses.com> <20180531141452.GC30221@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.31-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 May 2018, Matthew Wilcox wrote:

> > Freeing a page in the page allocator also was traditionally not sleeping.
> > That has changed?
>
> No.  "Your bug" being "The bug in your static analysis tool".  It probably
> isn't following the data flow correctly (or deeply enough).

Well ok this is not going to trigger for kfree(), this is x86 specific and
requires CONFIG_DEBUG_PAGEALLOC and a free of a page in a huge page.

Ok that is a very contorted situation but how would a static checker deal
with that?
