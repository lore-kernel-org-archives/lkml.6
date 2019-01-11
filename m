Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A804C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D6921841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 09:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547198599;
	bh=uiM2cVfanZs0ZGhYatV5X4aqAFQuagFoODxsLBxQ874=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1AsINhQL/7r8aPZdp06oVgfes8DkI8HmF4xo/Kp5FPDF3vgKqaySKcn6YHoMPP8oJ
	 3hvrvqKW/VKu2re5iXr8UzyDBneawW9dp9RGkKIYhU/o+W83/uVm95hBtRi2WPn9tb
	 X/LkpIBNahb8z5DMJZBNcdrtxMtJzhXFoG0N1Tj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731427AbfAKJXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 04:23:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:47224 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727900AbfAKJXR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 04:23:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 25DB9AF97;
        Fri, 11 Jan 2019 09:23:16 +0000 (UTC)
Date:   Fri, 11 Jan 2019 10:23:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] mm/alloc: fallback to first node if the wanted node
 offline
Message-ID: <20190111092315.GB14956@dhcp22.suse.cz>
References: <20181210123738.GN1286@dhcp22.suse.cz>
 <CAFgQCTupPc1rKv2SrmWD+eJ0H6PRaizPBw3+AG67_PuLA2SKFw@mail.gmail.com>
 <20181212115340.GQ1286@dhcp22.suse.cz>
 <CAFgQCTuhW6sPtCNFmnz13p30v3owE3Rty5WJNgtqgz8XaZT-aQ@mail.gmail.com>
 <CAFgQCTtFZ8ku7W_7rcmrbmH4Qvsv7zgOSHKfPSpNSkVjYkPfBg@mail.gmail.com>
 <20181217132926.GM30879@dhcp22.suse.cz>
 <CAFgQCTubm9B1_zM+oc1GLfOChu+XY9N4OcjyeDgk6ggObRtMKg@mail.gmail.com>
 <20181220091934.GC14234@dhcp22.suse.cz>
 <20190108143440.GU31793@dhcp22.suse.cz>
 <CAFgQCTtdJ1mR6v2Y3ojHSmjg9U90cAUddhxG3Y_8zNDR5Aw9oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgQCTtdJ1mR6v2Y3ojHSmjg9U90cAUddhxG3Y_8zNDR5Aw9oQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 11-01-19 11:12:45, Pingfan Liu wrote:
[...]
> Hi, this patch works! Feel free to use tested-by me

Thanks a lot for your testing! Now it is time to seriously think whether
this is the right thing to do and sync all other arches that might have
the same problem. I will take care of it. Thanks for your patience and
effort. I will post something hopefully soon in a separate thread as
this one grown too large already.

-- 
Michal Hocko
SUSE Labs
