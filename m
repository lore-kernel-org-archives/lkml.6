Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C099C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE58D20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="c7D+Sk9x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE58D20666
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeJBVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:34:09 -0400
Received: from a9-99.smtp-out.amazonses.com ([54.240.9.99]:57718 "EHLO
        a9-99.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728177AbeJBVeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538491822;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=I2MayZBrUEXwNtt0E/zuGW8V5/zWtFXk+v6KADxyvhI=;
        b=c7D+Sk9xlCw9v0GMu51DeJrGZibywzZqIjSeSBdthcsqjZ11EYFTZ7WGQKDOEOTS
        l25Ehr9CW30raPx+UqxG7W+t1AZ/WCGk0eza5Hq6tKUCeEd33M9XDh8U5k8HFz/UlYc
        MiDWDQrSsQbl3TVZJOc/4nowXsuLzEqurjBdztI4=
Date:   Tue, 2 Oct 2018 14:50:22 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Matthew Wilcox <willy@infradead.org>
cc:     Greg KH <gregkh@linux-foundation.org>,
        zhong jiang <zhongjiang@huawei.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, mhocko@kernel.org, mgorman@suse.de,
        vbabka@suse.cz, andrea@kernel.org, kirill@shutemov.name,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [STABLE PATCH] slub: make ->cpu_partial unsigned int
In-Reply-To: <20180930132333.GA10872@bombadil.infradead.org>
Message-ID: <01000166354231f3-1e953571-f9ec-4a73-a228-ff3692825b41-000000@email.amazonses.com>
References: <1538303301-61784-1-git-send-email-zhongjiang@huawei.com> <20180930125038.GA2533@bombadil.infradead.org> <20180930131026.GA25677@kroah.com> <20180930132333.GA10872@bombadil.infradead.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.10.02-54.240.9.99
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2018, Matthew Wilcox wrote:

> > And the patch in mainline has Christoph's ack...
>
> I'm not saying there's a problem with the patch.  It's that the rationale
> for backporting doesn't make any damned sense.  There's something going
> on that nobody understands.  This patch is probably masking an underlying
> problem that will pop back up and bite us again someday.

Right. That is why I raised the issue. I do not see any harm in
backporting but I do not think it fixes the real issue which may be in
concurrent use of page struct fields that are overlapping.

