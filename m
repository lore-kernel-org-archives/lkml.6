Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A953C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35AE26A40
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 02:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35AE26A40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752990AbeF0CBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 22:01:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38124 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbeF0CBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 22:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA3673082A3C;
        Wed, 27 Jun 2018 02:01:06 +0000 (UTC)
Received: from t450s.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D29755D6A5;
        Wed, 27 Jun 2018 02:00:53 +0000 (UTC)
Date:   Wed, 27 Jun 2018 09:55:48 +0800
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "open list:VFIO MEDIATED DEVICE DRIVERS" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] sample/mdev/mbochs: add mbochs_kunmap_dmabuf
Message-ID: <20180627095548.7c8735f2@t450s.home>
In-Reply-To: <20180626073233.kievmdagzgtxs7j7@sirius.home.kraxel.org>
References: <20180625064453.19768-1-kraxel@redhat.com>
        <20180625064453.19768-2-kraxel@redhat.com>
        <20180626152012.530d9c16@t450s.home>
        <20180626073233.kievmdagzgtxs7j7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 27 Jun 2018 02:01:07 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jun 2018 09:32:33 +0200
Gerd Hoffmann <kraxel@redhat.com> wrote:

> > >  	.map		  = mbochs_kmap_dmabuf,
> > > +	.unmap		  = mbochs_kunmap_dmabuf,
> > >  	.mmap		  = mbochs_mmap_dmabuf,
> > >  };
> > >    
> > 
> > Is this a fix for v4.18?  
> 
> Yes.
> 
> > AFAICT, the kmap_atomic removal is only in
> > next, not yet upstream and hopefully includes this sample driver before
> > hitting mainline.  Should we therefore have a v4.18-rc based patch for
> > this to include before v4.18 to resolve this?  
> 
> The kmap_atomic interface will be removed in 4.19 because nobody uses
> it, so dropping the mbochs implementation already in 4.18 should not
> cause any issues.
> 
> So just queue both for 4.18 would be the easiest way do deal with the
> dependency I think.

Ok, so I'll drop the fixes tag and apply both to my for-linus branch
for v4.18 and then Christian won't need to include it for the v4.19
patch.  Thanks,

Alex
