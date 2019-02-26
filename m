Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77C0217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 13:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551186726;
	bh=9lBD8KEjC0Y4UflDI2Q06bQ3H0VXS+WRX6Gi1d+WkRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KYRQSlEHvgRKOCf5LP4zZcssqQhThrWhRrJJTn0zf027feVvxDjUuyiviXblQqaFa
	 623Zq72zwBDfTqe82irmj7mlSbA9FCA3t3oqPwLD1iQtaSaDT2OkBUrhjV2dwPCgdL
	 Bkv+fmmzxVTJs4yzfBSjnYQeB5xEgIzmaEEbrRf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbfBZNMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 08:12:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:46822 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfBZNMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 08:12:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1D6C1AF72;
        Tue, 26 Feb 2019 13:12:02 +0000 (UTC)
Date:   Tue, 26 Feb 2019 14:12:01 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-mm@kvack.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 0/2] x86, numa: always initialize all possible nodes
Message-ID: <20190226131201.GA10588@dhcp22.suse.cz>
References: <20190212095343.23315-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190212095343.23315-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-02-19 10:53:41, Michal Hocko wrote:
> Hi,
> this has been posted as an RFC previously [1]. There didn't seem to be
> any objections so I am reposting this for inclusion. I have added a
> debugging patch which prints the zonelist setup for each numa node
> for an easier debugging of a broken zonelist setup.
> 
> [1] http://lkml.kernel.org/r/20190114082416.30939-1-mhocko@kernel.org

Friendly ping. I haven't heard any complains so can we route this via
tip/x86/mm or should we go via mmotm.
-- 
Michal Hocko
SUSE Labs
