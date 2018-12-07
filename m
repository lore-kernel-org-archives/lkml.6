Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8B8C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E77F20892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 13:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E77F20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbeLGNee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 08:34:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:36120 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbeLGNed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 08:34:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BF8E7AF58;
        Fri,  7 Dec 2018 13:34:31 +0000 (UTC)
Date:   Fri, 7 Dec 2018 13:34:28 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Giovanni Gherdovich' <ggherdovich@suse.cz>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'Peter Zijlstra' <peterz@infradead.org>,
        'LKML' <linux-kernel@vger.kernel.org>,
        'Frederic Weisbecker' <frederic@kernel.org>,
        'Daniel Lezcano' <daniel.lezcano@linaro.org>,
        'Linux PM' <linux-pm@vger.kernel.org>,
        "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Subject: Re: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor
 for tickless systems
Message-ID: <20181207133428.GG31508@suse.de>
References: <42865872.dmYH3PmblP@aspire.rjw.lan>
 <001a01d48b24$9aa38c00$cfeaa400$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <001a01d48b24$9aa38c00$cfeaa400$@net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 03, 2018 at 08:23:56AM -0800, Doug Smythies wrote:
> In the README file, I did see that for reporting I am 
> somehow supposed to use compare-kernels.sh, but
> I couldn't figure that out.
> 

cd work/log
../../compare-kernels.sh

> By the way, I am running these tests as a regular user, but
> they seem to want to modify:
> 
> /sys/kernel/mm/transparent_hugepage/enabled
> 

Red herring in this case. Even if transparent hugepages are left as the
default, it still tries to write it stupidly. An irritating, but
harmless bug.

-- 
Mel Gorman
SUSE Labs
