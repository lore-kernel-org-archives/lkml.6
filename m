Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C067AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8B21A94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 18:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BRvxwMO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B8B21A94
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbeHQVux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:50:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34742 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726888AbeHQVux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MeXStQC8D1dP4QVjGAnzFW7zHMI70peWTw2TiubU0tw=; b=BRvxwMO0ekI0t9KDE3Gw1dxiE
        rqwsJnbCWLlmbVfXNrxVR4oWuA2safonPsN3aIOncPlCZx+DmkrLRm8GKT0iSyXoQKuV/PhHtS54j
        207WuqpQ6oRRcTaEospLmQT5JAvrSTzQB9XWHfNX0Qz92woaGzJoVEYpE4l3sGJpKjyOxHaImo5uZ
        CcWYTIURTMeKvskMRbW+bN/GS4J+NzBxqO0XcOES0QUbjqNUjMxKl4Lpvy6jlzsyqFkW/W0Y5ccKq
        t+8r3Xe8DHYLcZ+GIdJ0JeiVmFZ+h5srbtUm/0jCzFMwa9+TPG1jJlTECoslzyhTjTmBEahCk1sLy
        R7P18mwFQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fqjlO-00073y-CW; Fri, 17 Aug 2018 18:46:22 +0000
Subject: Re: [PATCH] drm/amd/display: fix a compile warning
To:     Wen Yang <wen.yang99@zte.com.cn>, airlied@linux.ie
Cc:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        jiang.biao2@zte.com.cn, zhong.weidong@zte.com.cn
References: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <783744d1-29a2-c601-7d1f-b937308d407c@infradead.org>
Date:   Fri, 17 Aug 2018 11:46:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534475388-40036-1-git-send-email-wen.yang99@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/16/2018 08:09 PM, Wen Yang wrote:
> Fix comile warning like,
>   CC [M]  drivers/gpu/drm/i915/gvt/execlist.o
>   CC [M]  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.o
>   CC [M]  drivers/gpu/drm/radeon/btc_dpm.o
>   CC [M]  drivers/isdn/hisax/avm_a1p.o
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_dpp.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c: In function ‘dcn10_update_mpcc’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: missing braces around initializer [-Wmissing-braces]
>   struct mpcc_blnd_cfg blnd_cfg = {0};
>          ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_hw_sequencer.c:1903:9: warning: (near initialization for ‘blnd_cfg.black_color’) [-Wmissing-braces]
> 
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>

works for me.  Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
>  drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> index cfcc54f..a06a035 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
> @@ -1900,7 +1900,7 @@ static void update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state)
>  static void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  {
>  	struct hubp *hubp = pipe_ctx->plane_res.hubp;
> -	struct mpcc_blnd_cfg blnd_cfg = {0};
> +	struct mpcc_blnd_cfg blnd_cfg = {{0}};
>  	bool per_pixel_alpha = pipe_ctx->plane_state->per_pixel_alpha && pipe_ctx->bottom_pipe;
>  	int mpcc_id;
>  	struct mpcc *new_mpcc;
> 


-- 
~Randy
