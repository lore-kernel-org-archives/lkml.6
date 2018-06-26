Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2FCC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626A2660D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 07:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B626A2660D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932379AbeFZHcl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 03:32:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932089AbeFZHcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 03:32:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 62DF281A4EA4;
        Tue, 26 Jun 2018 07:32:35 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-109.ams2.redhat.com [10.36.116.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB9C2026D6A;
        Tue, 26 Jun 2018 07:32:34 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DD51811AB5; Tue, 26 Jun 2018 09:32:33 +0200 (CEST)
Date:   Tue, 26 Jun 2018 09:32:33 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, daniel.vetter@ffwll.ch,
        Kirti Wankhede <kwankhede@nvidia.com>,
        "open list:VFIO MEDIATED DEVICE DRIVERS" <kvm@vger.kernel.org>
Subject: Re: [PATCH 2/2] sample/mdev/mbochs: add mbochs_kunmap_dmabuf
Message-ID: <20180626073233.kievmdagzgtxs7j7@sirius.home.kraxel.org>
References: <20180625064453.19768-1-kraxel@redhat.com>
 <20180625064453.19768-2-kraxel@redhat.com>
 <20180626152012.530d9c16@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626152012.530d9c16@t450s.home>
User-Agent: NeoMutt/20180622
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:32:35 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.8]); Tue, 26 Jun 2018 07:32:35 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'kraxel@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  	.map		  = mbochs_kmap_dmabuf,
> > +	.unmap		  = mbochs_kunmap_dmabuf,
> >  	.mmap		  = mbochs_mmap_dmabuf,
> >  };
> >  
> 
> Is this a fix for v4.18?

Yes.

> AFAICT, the kmap_atomic removal is only in
> next, not yet upstream and hopefully includes this sample driver before
> hitting mainline.  Should we therefore have a v4.18-rc based patch for
> this to include before v4.18 to resolve this?

The kmap_atomic interface will be removed in 4.19 because nobody uses
it, so dropping the mbochs implementation already in 4.18 should not
cause any issues.

So just queue both for 4.18 would be the easiest way do deal with the
dependency I think.

cheers,
  Gerd

