Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6F7ECDFB4
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C81A20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 23:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C81A20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeGRAGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:06:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45644 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729805AbeGRAGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:06:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E98B0406E968;
        Tue, 17 Jul 2018 23:31:04 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D61522026D68;
        Tue, 17 Jul 2018 23:31:03 +0000 (UTC)
Date:   Wed, 18 Jul 2018 07:31:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     David Rientjes <rientjes@google.com>
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, corbet@lwn.net,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: Deprecate kernelcore=nn and movable_core=
Message-ID: <20180717233100.GH1724@MiWiFi-R3L-srv>
References: <20180717131837.18411-1-bhe@redhat.com>
 <alpine.DEB.2.21.1807171344320.12251@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1807171344320.12251@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 17 Jul 2018 23:31:05 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Tue, 17 Jul 2018 23:31:05 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/17/18 at 01:46pm, David Rientjes wrote:
> On Tue, 17 Jul 2018, Baoquan He wrote:
> 
> > We can still use 'kernelcore=mirror' or 'movable_node' for the usage
> > of hotplug and movable zone. If somebody shows up with a valid usecase
> > we can reconsider.
> > 
> 
> We actively use kernelcore=n%, I had recently added support for the option 
> in the first place in 4.17.  It's certainly not deprecated.

Thanks for telling. Just for curiosity, could you tell the scenario you
are using kernelcore=n%? Since it evenly spread movable area on nodes,
we may not be able to physically hot unplug/plug RAM.

Thanks
Baoquan
