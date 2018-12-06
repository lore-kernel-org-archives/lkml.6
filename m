Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF27C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A550920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 23:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544139907;
	bh=CAmHRTgPT7GmnqCaI8RfvVOG8mcEPgqvh+E/3iPqCyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sl3+ZK7qhlf/VtDMG4F0S1XgssQwMgRxGHDKphnX2eug4DlOtVl4Fzeh8+rwPNypn
	 RlvLF0ln4tMjVIrNRbraX01aVDYrEyDNIz08CbPmccaeeNVICHMBIDTjNKrtnTr8FW
	 UxRCpyCztSm/fBy9JNfCteswp4cPtmQXZlojSmcs=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A550920868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeLFXoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 18:44:30 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41928 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeLFXo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 18:44:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id u16so2143581otk.8;
        Thu, 06 Dec 2018 15:44:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UJP2qD5rois//V7GQAZsC/vBxUdIIPON3mcv9TL9Xjs=;
        b=azEp04qDqKT9t6t27RImTYycqP7LmHWcKwKOIGC1xVpuYB60goQxUcQF+6ERHbmbWz
         ReuAD/WbhF9Xd9gISDxYENbc8Jt1XLYhSaUMxnf3qo2MpX2yApInOSEc7/IjTfmO5sLT
         8O14QgGKQAkWiIdURJuSyfQ6JXqPm7YPxLOv6Zq1Mpf9xc3cyRmLZs6WhCjl5+whdBK+
         m+O8swrPrR8o9Acg+fm+bEhSQthOFzEnb+TgOiij8olX/BP8gwG/ufXq6yUJifFO5pRc
         fBqxfkW9NFGEIPq58cAyilQM8GcrWU7faoAHitiDXsIHFZFxL/CUdeRIt7I+pqODxxWV
         3SSQ==
X-Gm-Message-State: AA+aEWaXIk7CL7oL5Y6hDc9YMmq65VLE+NPxmyNLi5EkFxUlNwu1j64A
        8xygLFuEBFAhityFth/BONM2LAY=
X-Google-Smtp-Source: AFSGD/UDU6WkClv6nwc9SYsaICQSPWjI3aJm+qlXcyRjnnsiCDjSpE0svntX5/5lm1OhUAQFM+ZE4w==
X-Received: by 2002:a9d:7653:: with SMTP id o19mr18950090otl.12.1544139867984;
        Thu, 06 Dec 2018 15:44:27 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l20sm680174otp.47.2018.12.06.15.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 15:44:27 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:44:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen.Hristev@microchip.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, thierry.reding@gmail.com,
        airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nicolas.Ferre@microchip.com, Cristian.Birsan@microchip.com,
        Eugen.Hristev@microchip.com
Subject: Re: [PATCH 1/3] dt-bindings: add vendor prefix for PDA Precision
 Design  Associates, Inc.
Message-ID: <20181206234426.GA2687@bogus>
References: <1542789804-4584-1-git-send-email-eugen.hristev@microchip.com>
 <1542789804-4584-2-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542789804-4584-2-git-send-email-eugen.hristev@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 08:47:57 +0000, <Eugen.Hristev@microchip.com> wrote:
> Precision Design Associates, Inc. (PDA) manufactures standard and custom
> capacitive touch screens, LCD's embedded controllers and custom embedded
> software. They specialize in industrial, rugged and outdoor applications.
> Website: http://www.pdaatl.com/
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
