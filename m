Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id l6VxARYfGltCNgAAmS7hNA
	; Fri, 08 Jun 2018 06:17:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 1EC5D6089E; Fri,  8 Jun 2018 06:17:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="E4XMvtrz"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6337C606FA;
	Fri,  8 Jun 2018 06:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6337C606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751125AbeFHGRv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:17:51 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:11962 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750898AbeFHGRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:17:50 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w586HM7O026675;
        Fri, 8 Jun 2018 01:17:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528438642;
        bh=mCZcp4XOUFAFNnK7GXNwgv0DV1/ocKDqwQX5g/I0FkY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=E4XMvtrz+2CrwE4efu/LtjgnYdbvE6//tLQl5bETJfI/W9ABI9OS1Ff8sJEiAUz8d
         K9ve1+cHT2SAWQ2OjUb0+O1V4TQuTeCIZWc1jKzb09iaRGssyM+oddkZLSLaI50XgF
         0IpKLJAQJpS74driBq5RbTBkotsHJIYPp6VwOgS0=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w586HMvN027601;
        Fri, 8 Jun 2018 01:17:22 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 8 Jun
 2018 01:17:22 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 8 Jun 2018 01:17:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w586HKHR006081;
        Fri, 8 Jun 2018 01:17:20 -0500
Subject: Re: [PATCH v2] gpu: drm: omapdrm: Adding new typedef vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, <airlied@linux.ie>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <willy@infradead.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20180522181357.GA31257@jordon-HP-15-Notebook-PC>
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <cf6ee7ab-5818-3309-5a0d-ba047d3f900c@ti.com>
Date: Fri, 8 Jun 2018 09:17:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180522181357.GA31257@jordon-HP-15-Notebook-PC>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 22/05/18 21:13, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler. For
> now, this is just documenting that the function returns
> a VM_FAULT value rather than an errno. Once all instances
> are converted, vm_fault_t will become a distinct type.
> 
> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
> 
> Previously vm_insert_mixed() returns err which driver
> mapped into VM_FAULT_* type. Also return value of
> vm_insert_mixed() not handled correctly and 0 was
> returned inside fault_2d() as default. The new function
> vmf_insert_mixed() will replace this inefficiency by
> returning correct VM_FAULT_* type.
> 
> vmf_error() is the newly introduce inline function
> in 4.17-rc6.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Reviewed-by: Matthew Wilcox <mawilcox@microsoft.com>
> ---
> v2: Fixed kbuild error by initialized ret
>     in fault_2d().
> 
>  drivers/gpu/drm/omapdrm/omap_gem.c | 51 +++++++++++++++++---------------------
>  drivers/gpu/drm/omapdrm/omap_gem.h |  3 ++-
>  2 files changed, 25 insertions(+), 29 deletions(-)

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

It's too late to get this to 4.18 via my normal routes. If you have
other similar patches queued and Linus/maintainers are ok to merge this
late, feel free to queue this that way.

Otherwise I can pick this up for my 4.19 patches.

Laurent, this will conflict omap_gem cleanups you did, but I don't think
there's anything problematic there.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
