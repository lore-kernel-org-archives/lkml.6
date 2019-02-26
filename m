Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53AA7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E9922184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551194340;
	bh=ZfUXW60lTmMHJodxznqxAxhb1fOgDa92tEHZx6J1my4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HQ+eDPSKQvuDv+GS6p/DUkC+NI+Ln4Z4JeuRJe6v1YLUs3ng7B02sXgLzEa5lJZ2S
	 1vnc5tFs7x+pbNXU/hfqwKt4XVb3msP0qzo28eKal2d1d50ObGUz+8iFlXR/yLz1Fn
	 HhUrrQJ1rH911rKGfHhdWJYwphobNzYb9VwP6OFw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbfBZPS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 10:18:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:45550 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726151AbfBZPS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 10:18:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 51C31AE83;
        Tue, 26 Feb 2019 15:18:57 +0000 (UTC)
Date:   Tue, 26 Feb 2019 16:18:56 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, akpm@linux-foundation.org, osalvador@suse.de
Subject: Re: [PATCH v2] mm/memory-hotplug: Add sysfs hot-remove trigger
Message-ID: <20190226151856.GE10588@dhcp22.suse.cz>
References: <49ef5e6c12f5ede189419d4dcced5dc04957c34d.1549906631.git.robin.murphy@arm.com>
 <20190212083310.GM15609@dhcp22.suse.cz>
 <faca65d7-6d4b-7e4f-5b36-4fdf3710b0e3@arm.com>
 <20190212151146.GA15609@dhcp22.suse.cz>
 <1ea6a40d-be86-6ccc-c728-fa8effbd5a8e@redhat.com>
 <8793f49d-756f-960d-9b26-7eaedfccd90e@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8793f49d-756f-960d-9b26-7eaedfccd90e@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-02-19 15:12:40, Robin Murphy wrote:
[...]
> The back of my mind is still ticking over trying to think up a really nice
> design for a self-contained debugfs or module-parameter interface completely
> independent of ARCH_MEMORY_PROBE - I'll probably keep using this hack
> locally to finish off the arm64 hot-remove stuff, but once that's done (or
> if inspiration strikes in the meantime) then I'll try to come back with a
> prototype of the developer interface that I'd find most useful.

Would it make more sense to add a module to the testing machinery?

-- 
Michal Hocko
SUSE Labs
