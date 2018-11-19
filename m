Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B45C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998F320817
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 09:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 998F320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKSTh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 14:37:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbeKSTh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 14:37:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C4A3183F40;
        Mon, 19 Nov 2018 09:14:25 +0000 (UTC)
Received: from krava (ovpn-204-39.brq.redhat.com [10.40.204.39])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9D6F2105706A;
        Mon, 19 Nov 2018 09:14:22 +0000 (UTC)
Date:   Mon, 19 Nov 2018 10:14:21 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     David Miller <davem@davemloft.net>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        jolsa@kernel.org
Subject: Re: [PATCH RFC] hist lookups
Message-ID: <20181119091421.GB8967@krava>
References: <20181111232627.GC30042@krava>
 <20181111.153259.2003083478035551655.davem@davemloft.net>
 <20181113104054.GJ30042@krava>
 <20181118.205243.227550158553460819.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118.205243.227550158553460819.davem@davemloft.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 19 Nov 2018 09:14:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 08:52:43PM -0800, David Miller wrote:
> From: Jiri Olsa <jolsa@redhat.com>
> Date: Tue, 13 Nov 2018 11:40:54 +0100
> 
> > I pushed/rebased what I have to perf/fixes branch again
> > 
> > please note I had to change our compile changes, because
> > they wouldn't compile on x86, but I can't verify on sparc,
> > so you might see some compile fails again
> 
> I just checked your current perf/fixes branch.
> 
> It builds on Sparc ;-)
> 
> And it behaves better too.  I do get tons of drops and lost events,
> but it seems to keep going even during the hardest load.
> 
> Eventually I end up with a lot of unresolvable histogram entries,
> so that is something to look into.
> 
> I looked at your drop logic and it seems perfect, we avoid dropping
> all non-SAMPLE events which is what we want.  So that can't be the
> cause of the issues I am seeing.
> 

cool, I'll polish the patchset and send it out

thanks,
jirka
