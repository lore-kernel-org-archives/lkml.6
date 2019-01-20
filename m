Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5646EC26640
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD302084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 18:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfATSkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:40:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57686 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726541AbfATSkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 13:40:47 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3AA6F81F12;
        Sun, 20 Jan 2019 18:40:47 +0000 (UTC)
Received: from krava (ovpn-204-22.brq.redhat.com [10.40.204.22])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0B64A60462;
        Sun, 20 Jan 2019 18:40:44 +0000 (UTC)
Date:   Sun, 20 Jan 2019 19:40:43 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     He Kuang <hekuang@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf top: Fix wrong hottest instruction highlighted
Message-ID: <20190120184043.GD8591@krava>
References: <20190120160523.4391-1-hekuang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120160523.4391-1-hekuang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Sun, 20 Jan 2019 18:40:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 12:05:22AM +0800, He Kuang wrote:
> Annotation line's percentage is compared and inserted into rbtree, but the
> percent field of 'struct annotation_data' is an array, the comparison
> result between them is the address difference.
> 
> This patch compares the right slot of percent array according to
> opts->percent_type and makes things right.
> 
> The problem can be reproduced by pressing 'H' in perf top annotation view.
> It should highlight the instruction line which has the highest sampling
> percentage.
> 
> Signed-off-by: He Kuang <hekuang@huawei.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
