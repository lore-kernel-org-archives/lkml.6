Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1900590-1519231373-2-11907216808547772885
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', from='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519231372; b=qdrtKP5s0u92tUGnEte8kFJrg+ZZ2holNe8VnKL1uyp2tol
    3rLPU9Is5sCZGh0A0Ee+HZzdPVZg0sSbObu8472oXv9Y46fqKIsmmr/ikEVVDUg6
    Swfxlu3TifdRe5qMmZ+rrwR76wy5XxTR3rAENdVaLpHHxlszH3Hza1asjIjH1rmI
    JIrZH+ZGlGiSgL3XvevlzAbdG9zuDSSMk29lXV04Q1qXrQ07QqX4cuXczP+0aMaO
    XuAAWSVxiHZffrRLzN89lWyzmyme1XK30qp+0kNS2yoEK7tz6gcgOOXFujHOekuJ
    aso9p5SsD+IuUHrOe8G1L+3KMWsOX8ip2TZBYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519231372; bh=rZ+b3DuFSmAEtNpe31mkJ3r2/vpu1ybN/j3CyoPkOJg=; b=W
    yp4B+gsF+pHMcQTdsxkg7P8xRjLvfbF3WRg14vMN/twpS8nxCybe5s3b9XQcyfc6
    MuJQ1d77ZNYOfj4OdizrabMuFHA81LgWHFGzoRtDsqTLj3HBLKLlPUlPVwapuUwv
    oaAuHkCg0URi01pUWcDEBjC+F5RNUQXv8EeHMimFkGH0PAB8EPsFLEKwy9vUhwt4
    JZkcgoifkYYsqXgNITFLGpJUSFXh0ZkUUvlQmn/167mdAiQt7l0gX+osNlGulyV+
    myA8uPo0I1lpqBVc84IFb+Yt1NjdanHkSn2PjV5n4x19/xsyPuOwKsTmPzzO+d2J
    0cUFKy8LdWwi7KHi37CNw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=daenzer.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=daenzer.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=daenzer.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=daenzer.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbeBUQms (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 11:42:48 -0500
Received: from mail.netline.ch ([148.251.143.178]:47621 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbeBUQmr (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 11:42:47 -0500
Subject: Re: [PATCH] radeon: hide pointless #warning when compile testing
To: Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Cihangir Akturk <cakturk@gmail.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org,
        Christopher James Halse Rogers
        <christopher.halse.rogers@canonical.com>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Julien Isorce <julien.isorce@gmail.com>,
        Kent Russell <kent.russell@amd.com>
References: <20180216152713.1628013-1-arnd@arndb.de>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Message-ID: <f5a5c1fe-bebc-90a2-0ac2-49a909c54f9c@daenzer.net>
Date: Wed, 21 Feb 2018 17:42:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216152713.1628013-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-02-16 04:26 PM, Arnd Bergmann wrote:
> In randconfig testing, we sometimes get this warning:
> 
> drivers/gpu/drm/radeon/radeon_object.c: In function 'radeon_bo_create':
> drivers/gpu/drm/radeon/radeon_object.c:242:2: error: #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance thanks to write-combining [-Werror=cpp]
>  #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
> 
> This is rather annoying since almost all other code produces no build-time
> output unless we have found a real bug. We already fixed this in the
> amdgpu driver in commit 31bb90f1cd08 ("drm/amdgpu: shut up #warning for
> compile testing") by adding a CONFIG_COMPILE_TEST check last year and
> agreed to do the same here, but both Michel and I then forgot about it
> until I came across the issue again now.
> 
> For stable kernels, as this is one of very few remaining randconfig
> warnings in 4.14.
> 
> Cc: stable@vger.kernel.org
> Link: https://patchwork.kernel.org/patch/9550009/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/radeon/radeon_object.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
> index 093594976126..54c2b4fc5ead 100644
> --- a/drivers/gpu/drm/radeon/radeon_object.c
> +++ b/drivers/gpu/drm/radeon/radeon_object.c
> @@ -238,9 +238,10 @@ int radeon_bo_create(struct radeon_device *rdev,
>  	 * may be slow
>  	 * See https://bugs.freedesktop.org/show_bug.cgi?id=88758
>  	 */
> -
> +#ifndef CONFIG_COMPILE_TEST
>  #warning Please enable CONFIG_MTRR and CONFIG_X86_PAT for better performance \
>  	 thanks to write-combining
> +#endif
>  
>  	if (bo->flags & RADEON_GEM_GTT_WC)
>  		DRM_INFO_ONCE("Please enable CONFIG_MTRR and CONFIG_X86_PAT for "
> 

Merged on the internal amd-staging-drm-next branch, thanks!


-- 
Earthling Michel Dänzer               |               http://www.amd.com
Libre software enthusiast             |             Mesa and X developer
