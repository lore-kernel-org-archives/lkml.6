Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BF9C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1B720862
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 13:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1B720862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731740AbeGSOad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 10:30:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:57744 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730521AbeGSOad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 10:30:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C3D1BACB7;
        Thu, 19 Jul 2018 13:47:16 +0000 (UTC)
Date:   Thu, 19 Jul 2018 15:47:16 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     osalvador@techadventures.net, akpm@linux-foundation.org,
        vbabka@suse.cz, aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2 2/5] mm: access zone->node via zone_to_nid() and
 zone_set_nid()
Message-ID: <20180719134716.GF7193@dhcp22.suse.cz>
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-3-osalvador@techadventures.net>
 <20180719134018.GB7193@dhcp22.suse.cz>
 <760195c6-7cfb-76db-1c5c-b85456f3a4ad@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <760195c6-7cfb-76db-1c5c-b85456f3a4ad@oracle.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 19-07-18 09:44:09, Pavel Tatashin wrote:
> 
> 
> On 07/19/2018 09:40 AM, Michal Hocko wrote:
> > On Thu 19-07-18 15:27:37, osalvador@techadventures.net wrote:
> >> From: Pavel Tatashin <pasha.tatashin@oracle.com>
> >>
> >> zone->node is configured only when CONFIG_NUMA=y, so it is a good idea to
> >> have inline functions to access this field in order to avoid ifdef's in
> >> c files.
> > 
> > Is this a manual find & replace or did you use some scripts?
> 
> I used opengrok:
> 
> http://src.illumos.org/source/search?q=%22zone-%3Enode%22&defs=&refs=&path=&hist=&project=linux-master
> 
> http://src.illumos.org/source/search?q=%22z-%3Enode%22&defs=&refs=&path=&hist=&project=linux-master

Then it is good to mention that in the changelog so that people might
use the same tool locally and compare the result or even learn about the
tool ;)
 
> > The change makes sense, but I haven't checked that all the places are
> > replaced properly. If not we can replace them later.
> > 
> >> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> >> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> >> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> > 
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thank you,
> Pavel

-- 
Michal Hocko
SUSE Labs
