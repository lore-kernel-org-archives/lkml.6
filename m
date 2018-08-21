Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3398C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318A2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:44:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9318A2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeHUUFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:05:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52034 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbeHUUFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:05:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32B66ED1;
        Tue, 21 Aug 2018 09:44:25 -0700 (PDT)
Received: from e107564-lin.cambridge.arm.com (e107564-lin.cambridge.arm.com [10.2.131.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F236D3F5BC;
        Tue, 21 Aug 2018 09:44:22 -0700 (PDT)
Date:   Tue, 21 Aug 2018 17:44:17 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dri-devel@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        airlied@linux.ie, gustavo@padovan.org,
        maarten.lankhorst@linux.intel.com, seanpaul@chromium.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandru-cosmin.gheorghe@arm.com,
        liviu.dudau@arm.com, ayan.halder@arm.com
Subject: Re: [PATCH] drm/fourcc: Add DOC: overview comment
Message-ID: <20180821164416.GA11553@e107564-lin.cambridge.arm.com>
References: <20180821161611.10424-1-brian.starkey@arm.com>
 <20180821162639.GA21697@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180821162639.GA21697@bombadil.infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

On Tue, Aug 21, 2018 at 09:26:39AM -0700, Matthew Wilcox wrote:
>On Tue, Aug 21, 2018 at 05:16:11PM +0100, Brian Starkey wrote:
>> There's a number of things which haven't previously been documented
>> around the usage of format modifiers. Capture the current
>> understanding in an overview comment and add it to the rst
>> documentation.
>>
>> Ideally, the generated documentation would also include documentation
>> of all of the #defines, but the kernel-doc system doesn't currently
>> support kernel-doc comments on #define constants.
>
>Can you turn them into enums?  This seems to work ok:
>
>-/* color index */
>-#define DRM_FORMAT_C8          fourcc_code('C', '8', ' ', ' ') /* [7:0] C */
>-
>-/* 8 bpp Red */
>-#define DRM_FORMAT_R8          fourcc_code('R', '8', ' ', ' ') /* [7:0] R */
>+enum {
>+       /* color index */
>+       DRM_FORMAT_C8   = fourcc_code('C', '8', ' ', ' '), /* [7:0] C */
>+       /* 8 bpp Red */
>+       DRM_FORMAT_R8   = fourcc_code('R', '8', ' ', ' '), /* [7:0] R */
>+};
>
>but I appreciate this is user API and maybe there's some code out there
>that does #ifndef DRM_FORMAT_C8 ...

Thanks for the suggestion, Daniel did mention the same. However,
unfortunately I don't think we can safely change the UAPI header in
this manner.

Cheers,
-Brian
