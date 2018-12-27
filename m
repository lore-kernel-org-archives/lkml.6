Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A40C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3D20866
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733194AbeL0WWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 17:22:16 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:42514 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730705AbeL0WWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 17:22:15 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 07D1D80431;
        Thu, 27 Dec 2018 23:22:10 +0100 (CET)
Date:   Thu, 27 Dec 2018 23:22:09 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Lechner <david@lechnology.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Alexey Brodkin <abrodkin@synopsys.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Subject: Re: [PATCH v1 7/7] drm: remove include of drmP.h from
 drm_gem_cma_helper.h
Message-ID: <20181227222209.GB29366@ravnborg.org>
References: <20181226210215.GA27610@ravnborg.org>
 <20181226210353.13993-7-sam@ravnborg.org>
 <6c792214-ed92-e942-0e3d-72628c037d00@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c792214-ed92-e942-0e3d-72628c037d00@lechnology.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=FkEfBJW9IQvnzsQHlycA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

Thanks for your comments.

On Thu, Dec 27, 2018 at 10:28:07AM -0600, David Lechner wrote:
> On 12/26/18 3:03 PM, Sam Ravnborg wrote:
> >Fix fallout in various files/drivers.
> >
> 
> What fallout is being fixed?

The removal of drmP.h from drm_gem_cma_helper.h resulted
in some build erros that is fixed by this patch.
drmP.h was removed from the header file to make it
possible to remove drmP.h on a file-by-file (or driver-by-driver)
basis for the rest of gpu/drm/*


> It would be helpful if we received the full
> patch series for context. It would also be nice to have a more detailed
> description in this commit message.

The cc: list was too long to include everyone in the cover letter.
In v2 I will make the individual commit message self explaning.

For v2 I also need to re-vist the changes as I have added include files in
some cases where a forward declaration would have been enough.

	Sam
