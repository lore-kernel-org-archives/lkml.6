Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24457C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:20:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB65B20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544523620;
	bh=L/TsCmRZMffFpe7+v4aDmnZG9LTZ2hf4G98qMrLYXPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QW4Lr3tfUH4fPq4594fcyRfHUNw6/Knimt5PomSaC7Mk40gLKZzLfqFGpCoYIEfI2
	 zFwiQAM32alcalw3s32b4beEQQIJfok5yCcGS8O+Wbyof7vpJoWYpmEvWZweq74a9d
	 B0n038LDiA1FQiZozAROpMYS+HQ6oxo6Wun7TDD8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB65B20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbeLKKUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:20:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:55910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726318AbeLKKUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:20:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 59FCAAE06;
        Tue, 11 Dec 2018 10:20:15 +0000 (UTC)
Date:   Tue, 11 Dec 2018 11:20:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, akpm@linux-foundation.org,
        pasha.tatashin@soleen.com, dan.j.williams@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memory_hotplug: Don't bail out in do_migrate_range
 prematurely
Message-ID: <20181211102014.GF1286@dhcp22.suse.cz>
References: <20181211085042.2696-1-osalvador@suse.de>
 <5e3e33e3-bea8-249c-2b05-665f40d70df4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3e33e3-bea8-249c-2b05-665f40d70df4@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-12-18 10:35:53, David Hildenbrand wrote:
> So somehow remember if we had issues with one page and instead of
> reporting 0, report e.g. -EAGAIN?

There is no consumer of the return value right now and it is not really
clear whether we need one. I would just make do_migrate_range return void.
-- 
Michal Hocko
SUSE Labs
