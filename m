Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F786C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F17120827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F17120827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJ3SUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:20:16 -0400
Received: from mga11.intel.com ([192.55.52.93]:40858 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbeJ3SUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:20:16 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 02:27:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,444,1534834800"; 
   d="scan'208";a="103722239"
Received: from jnikula-mobl3.fi.intel.com (HELO localhost) ([10.237.72.61])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 02:27:33 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, David Airlie <airlied@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        "open list\:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3] drm/bochs: add edid support.
In-Reply-To: <20181030090632.GJ21967@phenom.ffwll.local>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20181029134507.7775-1-kraxel@redhat.com> <87in1kejgj.fsf@intel.com> <20181029200520.jfnmvbkng2er5qbc@sirius.home.kraxel.org> <20181030090632.GJ21967@phenom.ffwll.local>
Date:   Tue, 30 Oct 2018 11:28:24 +0200
Message-ID: <87y3afokav.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Mon, Oct 29, 2018 at 09:05:20PM +0100, Gerd Hoffmann wrote:
>> On Mon, Oct 29, 2018 at 07:44:28PM +0200, Jani Nikula wrote:
>> > On Mon, 29 Oct 2018, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> > > Recent qemu (latest master branch, upcoming 3.1 release) got support
>> > > for EDID data.  This patch adds guest driver support.
>> > >
>> > > EDID support in qemu is not (yet) enabled by default, so please use
>> > > 'qemu -device VGA,edid=on' for testing.
>> > 
>> > Any chance of making this use drm_get_edid() (requires an i2c_adapter)
>> > or at least drm_do_get_edid()?
>> 
>> I'll have a look at using drm_do_get_edid().  drm_get_edid() will not
>> fly as there is no i2c adapter in the first place.
>
> Hm, not sure that makes sense. drm_do_get_edid is to handle the real-world
> flakiness of sinks (it's where all the retry logic resides), if you don't
> have a i2c_adapater (because the hw has some magic "give me an edid"
> block). For virtual hw we hopefully don't randomly drop bits on the floor
> between the guest and host. Imo totally fine as-is.
>
> E.g. we also don't feed the VBT edid through drm_do_get_edid either.

But nowadays we do handle the debugfs EDID override and the EDID
firmware loading in drm_do_get_edid(), so using that gives you those
features.

BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
