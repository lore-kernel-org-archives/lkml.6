Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 56EA5C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195C920891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 22:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195C920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935099AbeFLWyQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 18:54:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:52627 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934733AbeFLWyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 18:54:11 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w5CMrxkw014667;
        Tue, 12 Jun 2018 17:54:01 -0500
Message-ID: <9906dd0ed56e71468291ad68e24f43dd5d9b5269.camel@kernel.crashing.org>
Subject: Re: [PATCH] drivers/of: Make of_io_request_and_map() "name"
 argument optional
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 13 Jun 2018 08:53:59 +1000
In-Reply-To: <20180612221815.GA28761@rob-hp-laptop>
References: <22064afa92ed2e4b33a93685aabb1d07c7c8846d.camel@kernel.crashing.org>
         <20180612221815.GA28761@rob-hp-laptop>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1 (3.28.1-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-12 at 16:18 -0600, Rob Herring wrote:
> On Tue, Jun 12, 2018 at 10:01:07AM +1000, Benjamin Herrenschmidt wrote:
> > These days of_address_to_resource() puts a reasonable name
> > in the resource struct, thus make the "name" argument an
> > optional override.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > ---
> > 
> > Just something I noticed ... we should probably update the
> > callers to stop passing stupid names..
> 
> Sounds like a coccinelle patch.

Quite possibly, though I'm absolutely not proficient with coccinelle :-)

> When do we need an actual name passed in? It does get exposed to 
> userspace, but no one seemed to care when names changed from full path 
> (which is commonly used) to just the node name.

Not sure, I had a look at the names looked rather random.

> 
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
