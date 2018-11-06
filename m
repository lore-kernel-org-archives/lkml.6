Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4B9C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150382086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 10:00:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 150382086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbeKFTYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 14:24:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34186 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729711AbeKFTYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 14:24:37 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 512BE31256B1;
        Tue,  6 Nov 2018 10:00:11 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8024D5D75D;
        Tue,  6 Nov 2018 10:00:10 +0000 (UTC)
Date:   Tue, 6 Nov 2018 18:00:07 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stable tree <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, memory_hotplug: teach has_unmovable_pages about of
 LRU migrateable pages
Message-ID: <20181106100007.GN27491@MiWiFi-R3L-srv>
References: <20181105091407.GB4361@dhcp22.suse.cz>
 <20181105092851.GD4361@dhcp22.suse.cz>
 <20181105102520.GB22011@MiWiFi-R3L-srv>
 <20181105123837.GH4361@dhcp22.suse.cz>
 <20181105142308.GJ27491@MiWiFi-R3L-srv>
 <20181105171002.GO4361@dhcp22.suse.cz>
 <20181106002216.GK27491@MiWiFi-R3L-srv>
 <20181106082826.GC27423@dhcp22.suse.cz>
 <20181106091624.GL27491@MiWiFi-R3L-srv>
 <20181106095109.GJ27423@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106095109.GJ27423@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Tue, 06 Nov 2018 10:00:11 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/18 at 10:51am, Michal Hocko wrote:
> > I just tested the movable zone checking yesterday, will add your
> > previous check back, then test again. I believe the result will be
> > positive. Will udpate once done.
> 
> THere is no need to retest with that patch for your movable node setup.

OK, thanks.
