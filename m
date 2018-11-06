Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18668C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F6D2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F6D2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387738AbeKFVjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:39:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:42514 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387454AbeKFVjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50B1FB611;
        Tue,  6 Nov 2018 12:14:47 +0000 (UTC)
Date:   Tue, 6 Nov 2018 13:14:46 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Kuo-Hsin Yang <vovoy@chromium.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v6] mm, drm/i915: mark pinned shmemfs pages as unevictable
Message-ID: <20181106121446.GL27423@dhcp22.suse.cz>
References: <20181106093100.71829-1-vovoy@chromium.org>
 <154150241813.6179.68008798371252810@skylake-alporthouse-com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154150241813.6179.68008798371252810@skylake-alporthouse-com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 06-11-18 11:06:58, Chris Wilson wrote:
[...]
> The challenge for the patch as it stands, is who lands it? We can take
> it through drm-intel (for merging in 4.21) but need Andrew's ack on top
> of all to agree with that path. Or we split the patch and only land the
> i915 portion once we backmerge the mm tree. I think pushing the i915
> portion through the mm tree is going to cause the most conflicts, so
> would recommend against that.

I usually prefer new exports to go along with their users. I am pretty
sure that the core mm change can be routed via whatever tree needs that.
Up to Andrew but this doesn't seem to be conflicting with anything that
is going on in MM.
-- 
Michal Hocko
SUSE Labs
