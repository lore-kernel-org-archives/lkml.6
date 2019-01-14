Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB4CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7665620656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 09:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfANJvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 04:51:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:40418 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfANJvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 04:51:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 01:51:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,477,1539673200"; 
   d="scan'208";a="134377868"
Received: from sdodaev-mobl.ger.corp.intel.com (HELO [10.252.43.116]) ([10.252.43.116])
  by fmsmga002.fm.intel.com with ESMTP; 14 Jan 2019 01:51:08 -0800
Subject: Re: [PATCH v2] drm/drm_vblank: Change EINVAL by the correct errno
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Gustavo Padovan <gustavo@padovan.org>, Sean Paul <sean@poorly.run>,
        Dave Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <20181015170529.dgzpbm37hbuvqatc@smtp.gmail.com>
 <20181016123541.GW31561@phenom.ffwll.local>
 <20181017124315.khhlykapxnug6ej6@smtp.gmail.com>
 <CAKMK7uF0ucof6gwAiY1SSp5oHt3BZ18Jkui5ugvkZc4u-NOJoA@mail.gmail.com>
 <20190113202323.co7upmn5fg32b7gn@smtp.gmail.com>
From:   Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Message-ID: <f4e3966d-bdc5-2816-2e4d-1b9046757b0f@linux.intel.com>
Date:   Mon, 14 Jan 2019 10:51:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190113202323.co7upmn5fg32b7gn@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Op 13-01-2019 om 21:23 schreef Rodrigo Siqueira:
> Hi,
>
> I resend this patch for CI via “intel-gfx@lists.freedesktop.org” as
> Daniel suggested, and I got a feedback that reported an issue as can be
> seen here:
>
>    https://patchwork.freedesktop.org/series/51147/
>
> After a careful analysis of what happened, I concluded that the problem
> is related to the function “igt_wait_for_vblank_count()” in “igt_kms.c”.
> This function has the following assert:
>
>    igt_assert(drmWaitVBlank(drm_fd, &wait_vbl) == 0)
>
> This function only checks if everything went well with the
> drmWaitVBlank() operation and does not make any other validation. IMHO
> the patch is correct, and the problem pointed out by CI is not related
> to this change.

Hey,

Thanks for finding the root cause. Before upstreaming can you send a fix for i-g-t so we don't lose CI coverage after changing the behavior?

~Maarten

