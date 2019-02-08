Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E7EC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A4BA218DA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549626688;
	bh=METkOge75pLV/uiy071Rd3hvhyL1wB02Hbto6vUyepM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zhJh6ejpUDuO2oK8JhBrBI/cQXltWW5QkCZJxZwDzJt6tmXsT6H0fCJpBX5skLx71
	 dtp7NstE7TtMOluthuq4Q6wjgif3VaQcqvJ/tH+d6hDutRusRdxHsAlpSyf9WvuKBz
	 8KPYCM7FLH/uum2caOKsYiOtwOLWaINjQX6QWyug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbfBHLv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 06:51:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbfBHLv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 06:51:26 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12C3D20857;
        Fri,  8 Feb 2019 11:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549626685;
        bh=METkOge75pLV/uiy071Rd3hvhyL1wB02Hbto6vUyepM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjNTKza/9UhJVRhhVz12Ol9g4lAoujDg/BbkeZ9Aq3UATah3D3RmVHvajcPZy5tV+
         orstKNZSix2wUTC4b0SF+c5054/R16xMbyV64Q24Ssj8vd9pZjLY/+vJE17qsQL7gJ
         N983okLf/8Z6Hn+CTNHCn6gfRc+hdvjG1qpY9/iY=
Date:   Fri, 8 Feb 2019 12:51:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/4] component: Add documentation
Message-ID: <20190208115123.GA19392@kroah.com>
References: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190207232759.14553-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 12:27:56AM +0100, Daniel Vetter wrote:
> While typing these I think doing an s/component_master/aggregate/
> would be useful:
> - it's shorter :-)
> - I think component/aggregate is much more meaningful naming than
>   component/puppetmaster or something like that. At least to my
>   English ear "aggregate" emphasizes much more the "assemble a pile of
>   things into something bigger" aspect, and there's not really much
>   of a control hierarchy between aggregate and constituing components.
> 
> But that's way more than a quick doc typing exercise ...
> 
> Thanks to Ram for commenting on an initial draft of these docs.
> 
> v2: Review from Rafael:
> - git add Documenation/driver-api/component.rst
> - lots of polish to the wording + spelling fixes.
> 
> v3: Review from Russell:
> - s/framework/helper
> - clarify the documentation for component_match_add functions.
> 
> v4: Remove a few superflous "This".
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: "C, Ramalingam" <ramalingam.c@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Thanks for doing this!

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
