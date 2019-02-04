Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5ABC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB9832082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:54:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbfBDSyW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:54:22 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:43623 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729570AbfBDSyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:54:20 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9A5E720030;
        Mon,  4 Feb 2019 19:54:17 +0100 (CET)
Date:   Mon, 4 Feb 2019 19:54:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Nicholas Mc Guire <der.herr@hofr.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Fabio Rafael da Rosa <fdr@pid42.net>
Subject: Re: [PATCH 2/2] staging/vboxvideo: Add TODO
Message-ID: <20190204185416.GC2834@ravnborg.org>
References: <20190204103114.30772-1-daniel.vetter@ffwll.ch>
 <20190204103114.30772-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204103114.30772-2-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=mhguMBvjAAAA:8
        a=20KFwNOVAAAA:8 a=7gkXJVJtAAAA:8 a=XgKwcX58caiBZInWmdwA:9
        a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=suj-f_xPwWGbp6UAD3fP:22
        a=E9Po1WZjFZOl8hwRPBS3:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel

On Mon, Feb 04, 2019 at 11:31:14AM +0100, Daniel Vetter wrote:
> Noticed why wonder what vboxvideo is using the ->master_set/drop hooks
> for.
Can you improve the gammar a little, I find it hard to read.

> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Fabio Rafael da Rosa <fdr@pid42.net>
> Cc: Nicholas Mc Guire <der.herr@hofr.at>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/staging/vboxvideo/TODO | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/vboxvideo/TODO b/drivers/staging/vboxvideo/TODO
> index 2e0f99c3f10c..2953e7f794fb 100644
> --- a/drivers/staging/vboxvideo/TODO
> +++ b/drivers/staging/vboxvideo/TODO
> @@ -1,5 +1,7 @@
>  TODO:
>  -Get a full review from the drm-maintainers on dri-devel done on this driver
> +-Drop all the logic around initial_mode_queried/master_set&_drop and everything
> +related to this. kms clients can handle hotplugs.
>  -Extend this TODO with the results of that review
>  
>  Please send any patches to Greg Kroah-Hartman <gregkh@linuxfoundation.org>,

The syntax around "master_set&_drop" could be better.
I wondered if the "&" was some rst syntax.

But anyway, despite grammar nit and syntax nit:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Which bring me back to a question asked a week ago or so.
What is missing before we can move vboxvideo out of staging/

Could we carry a few TODO items over in drm/ ar do we need a clean TODO?

	Sam
