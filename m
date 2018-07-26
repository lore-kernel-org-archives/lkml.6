Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E8FC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0935F206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 22:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0935F206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwn.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGZX1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 19:27:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:34452 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731394AbeGZX1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 19:27:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7E8BD2B6;
        Thu, 26 Jul 2018 22:08:26 +0000 (UTC)
Date:   Thu, 26 Jul 2018 16:08:25 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] docs/mm: make GFP flags descriptions usable as
 kernel-doc
Message-ID: <20180726160825.0667af9f@lwn.net>
In-Reply-To: <1532626360-16650-7-git-send-email-rppt@linux.vnet.ibm.com>
References: <1532626360-16650-1-git-send-email-rppt@linux.vnet.ibm.com>
        <1532626360-16650-7-git-send-email-rppt@linux.vnet.ibm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 20:32:39 +0300
Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:

> This patch adds DOC: headings for GFP flag descriptions and adjusts the
> formatting to fit sphinx expectations of paragraphs.

So I think this is a great thing to do.  Adding cross references from
places where GFP flags are expected would be even better.  I do have one
little concern, though...

> - * __GFP_MOVABLE (also a zone modifier) indicates that the page can be
> - *   moved by page migration during memory compaction or can be reclaimed.
> + * %__GFP_MOVABLE (also a zone modifier) indicates that the page can be
> + * moved by page migration during memory compaction or can be reclaimed.

There are Certain Developers who get rather bent out of shape when they
feel that excessive markup is degrading the readability of the plain-text
documentation.  I have a suspicion that all of these % signs might turn
out to be one of those places.  People have been trained to expect them in
function documentation, but that's not quite what we have here.

I won't insist on this, but I would suggest that, in this particular case,
it might be better for that markup to come out.

Then we have the same old question of who applies these.  I'd love to have
an ack from somebody who can speak for mm - or a statement that these will
go through another tree.  Preferably quickly so that this stuff can get
in through the upcoming merge window.

Thanks,

jon
