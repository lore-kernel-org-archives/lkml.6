Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D261C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34BE620C03
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 07:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phP0yv54"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34BE620C03
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeHQKS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 06:18:57 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40579 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbeHQKS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 06:18:56 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so6195304wrs.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 00:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9HOGgaBBKntNDyFaDgYUOpwTNyVoCsQZifAjMq13KNo=;
        b=phP0yv54g/ezlixvwQ919NkzUrRNu5pa/JZjtTtbKxIV6pGvOPlchOXN5mnSX7j4YP
         sq5DbyMRL65asO3YEr40XX8KsMsCmFx47adDzdPExG0GZ+VDzYHbkM7xDpAOcrl/Kbl9
         3YDrS8ZO0HgOmx4ctir+UBlkbblyYJzsrtgOC2b6QsOgatnpb5dtge8iv2rQ8xTnJ2T5
         A6k5iSOGWIGxBObKjyxHsKDfEVb14KDmjJeAu6MLN6gY8yhLSmlzz4qNdd5suJ1LQCzi
         UmD4aent+27/ykBz+v3JWHtG5YJKffrY/ckPw3yoKTEz8t50wnhM45mN3mgkOPHux7hK
         gVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=9HOGgaBBKntNDyFaDgYUOpwTNyVoCsQZifAjMq13KNo=;
        b=bim7ChOR5VvNQc2/kRYdPztFoLGG4FgXq4OUr12DnH4kZ/rFKZiiMbQQNltqOy90Sm
         JL29Dc5w7rsQTNtEskbN3biHmUebrK1C3a8YEbKobxvCZVFjV27l7PZN4o6xIgucWv7a
         wyQJFzgVZYuomVUUA/5Ra7VUpRDfj4mfBoTTHNU1xcR/L7bA6F6Xmc8HNwL55Qawrpos
         GVj3uGXrjPes0h9SN0bO7hlrIkPKlytmuoz9aI/fUiHb55KNWRvCSm+GN6bk+1VG2Vmz
         99ioraDaFU3B8O1zXK8iTGunBQfG0pylqNN+9SGsOyEoEZ5HlVgg7/+ixWlVW5C9Ng+D
         BtYA==
X-Gm-Message-State: AOUpUlEH4nedfbm5yuOkPiiI8+eJM1UiTRI9CD4Bu64NRg95j6dxMDZB
        2m7/Cy6PV5/LiqGOx/mZeKE=
X-Google-Smtp-Source: AA+uWPxL0x9aOPpRbQiAAn81o0UK79z+T9l/t6fhAZy32mDs+B+k2NVy1VKSDgIpLCTK0dSETe0jWw==
X-Received: by 2002:adf:9d46:: with SMTP id o6-v6mr21140928wre.51.1534490199601;
        Fri, 17 Aug 2018 00:16:39 -0700 (PDT)
Received: from ?IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740? ([2a02:908:1257:4460:1ab8:55c1:a639:6740])
        by smtp.gmail.com with ESMTPSA id l72-v6sm9895644wma.17.2018.08.17.00.16.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 00:16:38 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH 1/2] Revert "drm/amdgpu/display: Replace
 CONFIG_DRM_AMD_DC_DCN1_0 with CONFIG_X86"
To:     sunpeng.li@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, arnd@arndb.de, michel.daenzer@amd.com
Cc:     airlied@linux.ie, Jordan.Lazare@amd.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        harry.wentland@amd.com
References: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8d7c294c-6585-01f1-cd78-5c30cd30142d@gmail.com>
Date:   Fri, 17 Aug 2018 09:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534448679-13823-1-git-send-email-sunpeng.li@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 16.08.2018 um 21:44 schrieb sunpeng.li@amd.com:
> [SNIP]
> +config DRM_AMD_DC_DCN1_0
> +	bool "DCN 1.0 Raven family"
> +	depends on DRM_AMD_DC && X86
> +	default y
> +	help
> +	  Choose this option if you want to have
> +	  RV family for display engine
> +

Probably better to follow Michel's suggestion and not make that an use 
configurable option.

Instead just select it based on the dependencies.

Christian.
