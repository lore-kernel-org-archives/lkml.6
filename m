Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E204CECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C79E2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C79E2084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbeGTNjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:39:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:36652 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730130AbeGTNjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:39:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 77080AEC8;
        Fri, 20 Jul 2018 12:51:01 +0000 (UTC)
Date:   Fri, 20 Jul 2018 14:50:59 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 05/12] dmar: Use for_each_If
Message-ID: <20180720125059.44d5werxu6w24vzk@suse.de>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
 <20180709083650.23549-5-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083650.23549-5-daniel.vetter@ffwll.ch>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:36:43AM +0200, Daniel Vetter wrote:
>  #define for_each_active_drhd_unit(drhd)					\
>  	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
> -		if (drhd->ignored) {} else
> +		for_each_if (!drhd->ignored)

Hmm, in my tree the macro comes from

	include/drm/drmP.h:#define for_each_if(condition) if (!(condition)) {} else

Please re-submit when the macro is in a generic header upstream.


	Joerg

