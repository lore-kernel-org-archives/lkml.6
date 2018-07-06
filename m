Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278C3C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1DA320844
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8iDwYMY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA320844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932925AbeGFXP4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:15:56 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49638 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeGFXPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:15:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1ewfEcIiV0QPyDNA9RVeMJFS8GnnAYAghDhZMMTtJy0=; b=Z8iDwYMYqa7kryhCWTdI7GTEf
        /paJvIPUGxAAqnISyli89TKS+my+EEIwvzlbBU2buFc9hoEaZ6AOQi+XTynonK8RGCxqS/eku8aTC
        rV8RWMvtR/Nr4V23JDPRrDgaAtI1Upyt+k5hDbmIEmFCj8eMAjk0GZCUQUi6zH/7aU/s4ND28su+g
        BldgG/NfHulkS45WJh+7AedW0IjT8vmu5TEeFQGsEsglOqbeeClLNWwRZQl+QtmgCS/lCmr2PdC+9
        bwfGZoBCdeVJVbmOnQpspg8a7iUwJ0G+x53+VTdZxoS77YEh9lCC3c6h1u9dxCGzSLiQxvRW7pV/j
        hMgIPirQQ==;
Received: from dvhart by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fbZx1-0004S5-PO; Fri, 06 Jul 2018 23:15:43 +0000
Date:   Fri, 6 Jul 2018 16:15:42 -0700
From:   Darren Hart <dvhart@infradead.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     "Lee, Chun-Yi" <jlee@suse.com>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: acer-wmi: mark expected switch
 fall-throughs
Message-ID: <20180706231542.GB3041@fury>
References: <20180705204221.GA11336@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180705204221.GA11336@embeddedor.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2018 at 03:42:21PM -0500, Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Warning level 2 was used: -Wimplicit-fallthrough=2
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/platform/x86/acer-wmi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
> index 8952173..114b028 100644
> --- a/drivers/platform/x86/acer-wmi.c
> +++ b/drivers/platform/x86/acer-wmi.c
> @@ -1018,6 +1018,7 @@ static acpi_status WMID_get_u32(u32 *value, u32 cap)
>  			*value = tmp & 0x1;
>  			return 0;
>  		}
> +		/* else: fall through */
>  	default:
>  		return AE_ERROR;
>  	}
> @@ -1344,6 +1345,7 @@ static acpi_status get_u32(u32 *value, u32 cap)
>  			status = AMW0_get_u32(value, cap);
>  			break;
>  		}
> +		/* else: fall through */
>  	case ACER_WMID:
>  		status = WMID_get_u32(value, cap);
>  		break;
> @@ -1386,6 +1388,7 @@ static acpi_status set_u32(u32 value, u32 cap)
>  
>  				return AMW0_set_u32(value, cap);
>  			}
> +			/* else: fall through */

I suspect you are correct, bu these last two weren't obviously intentional to
me. Has this seen any testing?

-- 
Darren Hart
VMware Open Source Technology Center
