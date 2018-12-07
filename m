Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAA0C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EEE62083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544180159;
	bh=+7AiQI9MXw+gQCsOSsPjm4BnKL6wTB43lxpzDDwUw9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tJL1DAYNAG8smPB42B6V7IL0OCRMbZriPDxE+pa/EvKbxUaBMLWYT4dgTkUHG22It
	 j90OQwWdm/ys99fNwDl0fDTwgAeKqUE8NdZwXTk4jVmOXJEes5P/XPDhqErzRAKf5U
	 C/WlcG1hExnvswUDk9xxSkxpU/aFsNZDGgGWrK14=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEE62083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbeLGKz6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 05:55:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:38856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725987AbeLGKz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 05:55:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BE1A1AF0E;
        Fri,  7 Dec 2018 10:55:55 +0000 (UTC)
Date:   Fri, 7 Dec 2018 11:55:54 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     linux-api@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 0/3] THP eligibility reporting via proc
Message-ID: <20181207105554.GX1286@dhcp22.suse.cz>
References: <20181120103515.25280-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120103515.25280-1-mhocko@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 20-11-18 11:35:12, Michal Hocko wrote:
> Hi,
> this series of three patches aims at making THP eligibility reporting
> much more robust and long term sustainable. The trigger for the change
> is a regression report [1] and the long follow up discussion. In short
> the specific application didn't have good API to query whether a particular
> mapping can be backed by THP so it has used VMA flags to workaround that.
> These flags represent a deep internal state of VMAs and as such they should
> be used by userspace with a great deal of caution.
> 
> A similar has happened for [2] when users complained that VM_MIXEDMAP is
> no longer set on DAX mappings. Again a lack of a proper API led to an
> abuse.
> 
> The first patch in the series tries to emphasise that that the semantic
> of flags might change and any application consuming those should be really
> careful.
> 
> The remaining two patches provide a more suitable interface to address [1]
> and provide a consistent API to query the THP status both for each VMA
> and process wide as well.

Are there any other comments on these? I haven't heard any pushback so
far so I will re-send with RFC dropped early next week.

> 
> [1] http://lkml.kernel.org/r/http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> [2] http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> 

-- 
Michal Hocko
SUSE Labs
