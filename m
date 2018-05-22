Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2183125-1526976590-2-16261058748034512685
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='fr',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526976590; b=Yl0k2nq9UE6wYqD92cq/zhzKkJf4zi+DfiWvFvzxmL3enKWa9V
    MJ6YF/aPSDhqs3naMeTfKyydja/89mOXd+9wWiZRGgcUoejlePFQyaK2ywHQXOUx
    XVrp145goicn7BDBIFP4JJdw5gTuF5buhlsKZDlV78bx5E17IiywSOrlIQYS3xRF
    Ka+XefXhVx2pM6CgVgFHWbIZXuLp4hn1R+RsvMVcwD0O7xFVAtPXj9jb2mM+pxeW
    z+4rIZ60RzXtCnq1zsr8EIm8GoZsh8eV4VO65Q2Fw1J962jeypLVh637P0OQ9inF
    2txUd6BJsIgnZcRBPJsKnjCHbdMMqK2P5lNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526976590;
    bh=OsayVEZELY3Ug6QG0+jKZLBnkOaU8wTXDUUuQOgJxZk=; b=hGLL8sQFnfAN
    cW2Pfue9kqIsWRc/4MpweB65y5rBU5KQJpeYnsUN2KCoQMYbAdFmisH3bEwfwo72
    kNConGDknynj7TedjtYcfn6vfZbuehRrfKUZ6HLVMO8eUnOmaximd4zfye6px6Ty
    UFm+svgZX3gbSXxGnOz0DezH0M2sNGpAaSMve3TnTiuim+avp3T2MTgvky1F6Fqs
    +emJLqrPQiOKPYxlDxFXRPJ+8pT5taYPBMXc7G3t+yXrEyiQ9+8eQVmXAku7k+I0
    XE3VlKfiMDa3BmL9OaRg68itszKDRG2g248S5YJUrFi/9oLzHve0s4Yf8ABfiJJR
    HLYBswYGeg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=free.fr;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=free.fr header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDcQItvjrfmHQ1f2eXSivnQ2OsTXRd11zXfV5NcD1pYO12s+UJKEvMVKr5au4BHk0nxfRY/CK1XFHQxbGlW4N9o/actoP2Y/9yZ5aIbI70Mt6+q/BrfA
    FgLQTvenacBAqpVxKvZMzIhNBPLYp+alcZ8E91WzVgO1Vq+HA8UZVv7z2KZTyvEnVyQQT/3/dOXPKGTYDF8QJqZBlxk6ZN1h+06xiBt+VPlljoSMxU7uU53e
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=e5mUnYsNAAAA:8 a=QyXUC8HyAAAA:8 a=taGs_qngAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=Gx5fhz3cx2a0_F4GoB0A:9 a=QEXdDO2ut3YA:10
    a=Vxmtnl_E_bksehYqCbjh:22 a=DM_PlaNYpjARcMQr2apF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751039AbeEVIJp (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 04:09:45 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:56328 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeEVIJn (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 04:09:43 -0400
Subject: Re: [Mesa-dev] [PATCH 4.16 039/110] drm/i915/gen9: Add
 WaClearHIZ_WM_CHICKEN3 for bxt and glk
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: Oscar Mateo <oscar.mateo@intel.com>,
        Michel Thierry <michel.thierry@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        stable@vger.kernel.org,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        mesa-dev@lists.freedesktop.org
References: <20180521210503.823249477@linuxfoundation.org>
 <20180521210507.389445775@linuxfoundation.org>
From: Martin Peres <martin.peres@free.fr>
Message-ID: <f70c125c-605c-db9b-9c3b-2e3abf1359f9@free.fr>
Date: Tue, 22 May 2018 01:09:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180521210507.389445775@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry for top-posting, but why is this email on mesa-dev, and not on
intel-gfx? I mean, the latter is for the kernel driver while the former
is the userspace 3d driver, so intel-gfx@lists.freedesktop.org is
definitely the prefered mailing list for these discussions.

Martin

On 21/05/18 14:11, Greg Kroah-Hartman wrote:
> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Michel Thierry <michel.thierry@intel.com>
> 
> commit b579f924a90f42fa561afd8201514fc216b71949 upstream.
> 
> Factor in clear values wherever required while updating destination
> min/max.
> 
> References: HSDES#1604444184
> Signed-off-by: Michel Thierry <michel.thierry@intel.com>
> Cc: mesa-dev@lists.freedesktop.org
> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Cc: Oscar Mateo <oscar.mateo@intel.com>
> Reviewed-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Link: https://patchwork.freedesktop.org/patch/msgid/20180510200708.18097-1-michel.thierry@intel.com
> Cc: stable@vger.kernel.org
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20180514165445.9198-1-michel.thierry@intel.com
> (backported from commit 0c79f9cb77eae28d48a4f9fc1b3341aacbbd260c)
> Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/gpu/drm/i915/i915_reg.h        |    3 +++
>  drivers/gpu/drm/i915/intel_engine_cs.c |    4 ++++
>  2 files changed, 7 insertions(+)
> 
> --- a/drivers/gpu/drm/i915/i915_reg.h
> +++ b/drivers/gpu/drm/i915/i915_reg.h
> @@ -7139,6 +7139,9 @@ enum {
>  #define SLICE_ECO_CHICKEN0			_MMIO(0x7308)
>  #define   PIXEL_MASK_CAMMING_DISABLE		(1 << 14)
>  
> +#define GEN9_WM_CHICKEN3			_MMIO(0x5588)
> +#define   GEN9_FACTOR_IN_CLR_VAL_HIZ		(1 << 9)
> +
>  /* WaCatErrorRejectionIssue */
>  #define GEN7_SQ_CHICKEN_MBCUNIT_CONFIG		_MMIO(0x9030)
>  #define  GEN7_SQ_CHICKEN_MBCUNIT_SQINTMOB	(1<<11)
> --- a/drivers/gpu/drm/i915/intel_engine_cs.c
> +++ b/drivers/gpu/drm/i915/intel_engine_cs.c
> @@ -1098,6 +1098,10 @@ static int gen9_init_workarounds(struct
>  	WA_SET_FIELD_MASKED(GEN8_CS_CHICKEN1, GEN9_PREEMPT_GPGPU_LEVEL_MASK,
>  			    GEN9_PREEMPT_GPGPU_COMMAND_LEVEL);
>  
> +	/* WaClearHIZ_WM_CHICKEN3:bxt,glk */
> +	if (IS_GEN9_LP(dev_priv))
> +		WA_SET_BIT_MASKED(GEN9_WM_CHICKEN3, GEN9_FACTOR_IN_CLR_VAL_HIZ);
> +
>  	/* WaVFEStateAfterPipeControlwithMediaStateClear:skl,bxt,glk,cfl */
>  	ret = wa_ring_whitelist_reg(engine, GEN9_CTX_PREEMPT_REG);
>  	if (ret)
> 
> 
> _______________________________________________
> mesa-dev mailing list
> mesa-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/mesa-dev
> 
