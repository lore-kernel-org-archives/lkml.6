Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14730C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1842080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1842080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbeJ3Ezd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:55:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45474 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbeJ3Ezd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:55:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1D11AC04B2DA;
        Mon, 29 Oct 2018 20:05:22 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-158.ams2.redhat.com [10.36.116.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBB0C1850B;
        Mon, 29 Oct 2018 20:05:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E4E3C7731; Mon, 29 Oct 2018 21:05:20 +0100 (CET)
Date:   Mon, 29 Oct 2018 21:05:20 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
Message-ID: <20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org>
References: <20181029134507.7775-1-kraxel@redhat.com>
 <87in1kejgj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87in1kejgj.fsf@intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 29 Oct 2018 20:05:22 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
> On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > Recent qemu (latest master branch, upcoming 3.1 release) got support
> > for EDID data.  This patch adds guest driver support.
> >
> > EDID support in qemu is not (yet) enabled by default, so please use
> > 'qemu -device VGA,edid=on' for testing.
> 
> Any chance of making this use drm_get_edid() (requires an i2c_adapter)
> or at least drm_do_get_edid()?

I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
fly as there is no i2c adapter in the first place.

cheers,
  Gerd

