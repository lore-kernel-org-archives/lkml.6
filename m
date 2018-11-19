Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF40C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3077F20659
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 18:51:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3077F20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbeKTFQr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:16:47 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46268 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729608AbeKTFQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:16:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id q1so50357950qkf.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 10:51:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+bYoVh0A8+aWuarnNnm9+V3LNM1aQlROIP9n4VygBS8=;
        b=PQpQev1n3u9XQLJwbhfQ+pIxoIzDeNf597NFZC/6Syx9X7lp/OAFo+FZV6WsuyMA8E
         iBNkKfBx4hbdAqh4IOr46vHcgmhR9RWspHfD5cdnat0OOE99axoVViaQzjai6GN4ZMuj
         AEUsPI24OJNkyi/U3YP9bIh+qAqDECG/y12fUZ9YQqEK4NZPzqUwe+RL6qLrMw4BpOmb
         sorX+bFELUbJYg6quthgam2OWyQR4aJ89F4nujS+Vu/hYjKfqUbkns5iwgot6lyGVU4z
         0jvNQw/qYjTS0KExLCpAA3bbHhZhlZm+1BJLl6EYDqrx8IofMpSyhn40Kn8HAweaXqPW
         UxLA==
X-Gm-Message-State: AGRZ1gKz2DkOMrEgnMcDP8FIryiw1DpVZ3iJhnN5H7PpX+gg0REtNk9Q
        U3Ub2KCwRX4n3lo08u+pIVClxA==
X-Google-Smtp-Source: AJdET5fxcrG9AsCn8W1OJikFOCUYiszz3t+0wQvL6lvVebNw0m2JYkuY2cObfkmElxQTN5IO2+mDhQ==
X-Received: by 2002:a0c:d792:: with SMTP id z18mr23094403qvi.183.1542653515286;
        Mon, 19 Nov 2018 10:51:55 -0800 (PST)
Received: from dhcp-10-20-1-11.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id e17sm22982420qte.12.2018.11.19.10.51.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:51:54 -0800 (PST)
Message-ID: <6033a16ccbc6e1286b4bfd082f0de9f0d60594b7.camel@redhat.com>
Subject: Re: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
From:   Lyude Paul <lyude@redhat.com>
To:     "Zuo, Jerry" <Jerry.Zuo@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Li, Roman" <Roman.Li@amd.com>, "S, Shirish" <Shirish.S@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 19 Nov 2018 13:51:53 -0500
In-Reply-To: <BY1PR12MB0406C1EC0BCD2F6A295CCE3AE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
References: <20181116232443.1709-1-lyude@redhat.com>
         <20181116232443.1709-2-lyude@redhat.com>
         <BY1PR12MB0406C1EC0BCD2F6A295CCE3AE5D80@BY1PR12MB0406.namprd12.prod.outlook.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cool! If it did actually fix those problems, would you mind making sure this
gets Cc'd to stable when it gets pushed upstream?

On Mon, 2018-11-19 at 15:00 +0000, Zuo, Jerry wrote:
> Reviewed-by: Jerry (Fangzhi) Zuo <Jerry.Zuo@amd.com>
> 
> The change fixed MST + SST daisy chain and S3 scenarios. The issue shows
> huge delay in MST + SST daisy chain, and soft hang in S3 resume.
> 
> The aux sequence is changed by failed iteration search in
> drm_connector_for_each_possible_encoder(). 
> The failure of searching for the best encoder for the connector due to the
> miss of attached encoder in the process of adding MST connector. The
> iteration search takes time to push drm_dp_send_enum_path_resources() aux
> transaction after the mode probe, and causes conflict to
> drm_dp_mst_i2c_xfer(), leading to the aux transaction timeout.
> 
> -----Original Message-----
> From: Lyude Paul <lyude@redhat.com> 
> Sent: November 16, 2018 6:25 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zuo, Jerry <Jerry.Zuo@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>
> ; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Deucher, Alexander <
> Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>;
> Zhou, David(ChunMing) <David1.Zhou@amd.com>; David Airlie <airlied@linux.ie>
> ; Li, Roman <Roman.Li@amd.com>; S, Shirish <Shirish.S@amd.com>; Daniel
> Vetter <daniel.vetter@ffwll.ch>; dri-devel@lists.freedesktop.org; 
> linux-kernel@vger.kernel.org
> Subject: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
> 
> Drive-by fix, this is bound to cause problems somewhere.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Jerry Zuo <Jerry.Zuo@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index d02c32a1039c..0cca1809fdcd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -342,6 +342,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr
> *mgr,
>  		master->connector_id);
>  
>  	aconnector->mst_encoder = dm_dp_create_fake_mst_encoder(master);
> +	drm_connector_attach_encoder(&aconnector->base,
> +				     &aconnector->mst_encoder->base);
>  
>  	/*
>  	 * TODO: understand why this one is needed
-- 
Cheers,
	Lyude Paul

