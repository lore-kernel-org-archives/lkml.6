Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E216C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C2320870
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548407587;
	bh=VG7qH3ppAfifYXP3+jUAATZ3hWeA26I0dxdSWygvPNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iJinsn5mv8OK4Uk6x/gFumstr2+F/yYVmIuvQuKkj8nu4DMpAhx2yPNbiAB1+ND13
	 hkdU0Ki+dlxyGYWV2ivkowBlYPa+WRsChXmGK10Ux19gk+Tj4XKhWKD8pxHHWFf8nQ
	 spb1YrvNTK99fss5j5pwKZ1sT7+Z8M3NM0xZVZuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbfAYJNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:13:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46843 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfAYJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:13:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id v15-v6so7723715ljh.13;
        Fri, 25 Jan 2019 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LQ44fZmqYtGeW5F/n2jrFDteHxp9GGkSJWCW+fdudJ8=;
        b=baCcOkjbr3mdjrO8oVm62iUA2r8j7k2D8zV+wATO3n+kfIQ0MQ1VN/xZOEPenHCCVD
         tes5A53YkCOISoNz2mtr4Gz2ADVumznP3m0Ius21TYud7hdaBDDf459Lz9ksa4JWsj49
         KrNzETJyhOR2rV7Us2IV2axKG2p6YJTO2Ak4+26fK5POC20B0I5JlqIbCrZ+2v/hWd01
         +tjbo5IPVC4fs+tk5jT+ClQQBzXBX/+b7WvWW39Eu070+lD/ChQYvCEPZflJIyneIYKp
         eyY+y9CjoSOxUJB9KhMOC1TA0oABKOdq5OVIjO6Bnzzjdw4nn/M3QmfxxvUwXgj1Ax3f
         Imjw==
X-Gm-Message-State: AJcUukcf2W/9sep6GzET7WWTbc9Idebnk7bPx8NhqWZoXa/9gg+Pe4r3
        799PdkIBf1TBRo3HRd2FIfdzzhfD
X-Google-Smtp-Source: ALg8bN46wgzeffg+A48b2CVK6j+VylLkMph4ohZEx0Aa+pDQARjUIwYBp6sKuFbjkO5jI7xSVa4csg==
X-Received: by 2002:a2e:2d11:: with SMTP id t17-v6mr8401264ljt.159.1548407582221;
        Fri, 25 Jan 2019 01:13:02 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1379976ljv.1.2019.01.25.01.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 01:13:01 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gmxXk-00087N-V0; Fri, 25 Jan 2019 10:12:57 +0100
Date:   Fri, 25 Jan 2019 10:12:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v2 3/4] gnss: add mtk receiver type support
Message-ID: <20190125091256.GC3691@localhost>
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547744074-28308-4-git-send-email-lollivier@baylibre.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:54:33PM +0100, Loys Ollivier wrote:
> Add an MTK (Mediatek) type to the "GNSS_TYPE" attribute.
> 
> Note that MTK receivers support a subset of NMEA 0183 with vendor
> extensions (e.g. to allow switching to the vendor protocol).

Copy paste error? AFAICT there is no Mediatek vendor protocol, only the
extensions to NMEA.

> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> ---
> 
> v2: renamed from GTOP to MTK.
> 
>  include/linux/gnss.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/gnss.h b/include/linux/gnss.h
> index 43546977098c..36968a0f33e8 100644
> --- a/include/linux/gnss.h
> +++ b/include/linux/gnss.h
> @@ -22,6 +22,7 @@ enum gnss_type {
>  	GNSS_TYPE_NMEA = 0,
>  	GNSS_TYPE_SIRF,
>  	GNSS_TYPE_UBX,
> +	GNSS_TYPE_MTK,
>  
>  	GNSS_TYPE_COUNT
>  };

Add the gnss_type_names string in this patch along with the define.

Johan
