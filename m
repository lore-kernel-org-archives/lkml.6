Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C737C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33AA220821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544483889;
	bh=NIFgtJX03kRRDV9/rOw6dnUcSJgSR4hMtAaMmnIr7Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1gTwMtnAtMcbk5o3DmHBkwQ8FCSpyhoS5L1ZkNDoGOsDxxtbhhsFwF+EoXgqCDVHl
	 LpzavSOQgFjBq5j7esXUS1Y/aYsmu9pg+C4qcBMV09vlay/OLXWv+2GjglsiH8FYuO
	 x6Js66c8JyABRMVpNqLRKhcRp/x1Fmj9yKBdGH9g=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33AA220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbeLJXSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:18:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37449 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbeLJXSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:18:06 -0500
Received: by mail-oi1-f194.google.com with SMTP id y23so10500387oia.4;
        Mon, 10 Dec 2018 15:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=R8QGBQMeO7Gg4s3Odcvvrc780dOTqvreb7BMewOH3bQ=;
        b=KTyBNVFzZBQjghm0aBv5PKeHZoLXbjNGxmhMSyrB35E19etVhxrhLQ1Urbz4BnA6jn
         VglnfY0LoRyagk4v5lhzd+CBR91Nh4OSzZhLm71ebGVfUKttm/X/bkn8/JHHvRmcPTII
         qZxFzQKAGxA3SBBTB1NXtlyNH0JNQaBirfwymR4EpMjmGNMkJu3yOCD2wekqafRP7ykO
         aGmv6C5wyHoOmstDHATabqUF1OT9HYLFfwPrTBP+gMtQWGnbrl/bBj+spTLP26eMPb1e
         OTjFRTzc2YasNfmIzAh8TrKu9Gvmi93nZ0wp5udcy4E0DPsk76ZGCzk4MXFXlmE39yBG
         tpIw==
X-Gm-Message-State: AA+aEWbpFgn5DgToQyq+7jZ6Y2NgbzM2d4dYaxJviKKVEvO3tSj+5H8L
        wQzyoHzkeqlPCeNffJRqkg==
X-Google-Smtp-Source: AFSGD/Wbo87LJ2tlpfGXIM7w8TjqQsfl5seAoX0PM8+pHno4A8HP7TGKk8SJyBVla6OORZMewjQ3cA==
X-Received: by 2002:aca:db41:: with SMTP id s62mr8073oig.349.1544483884342;
        Mon, 10 Dec 2018 15:18:04 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e6sm5646915otp.68.2018.12.10.15.18.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Dec 2018 15:18:03 -0800 (PST)
Date:   Mon, 10 Dec 2018 17:18:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     TheSven73@googlemail.com, Shawn Guo <shawnguo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: bus: imx-weim: document multiple
 address ranges per child node
Message-ID: <20181210231803.GA1466@bogus>
References: <20181206192633.25319-1-TheSven73@googlemail.com>
 <20181206192633.25319-3-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206192633.25319-3-TheSven73@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  6 Dec 2018 14:26:32 -0500, Sven Van Asbroeck wrote:
> The imx-weim driver was patched to allow correct WEIM configuration
> when multiple address ranges are used in a child node.
> Update the dt-bindings to reflect this.
> 
> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> ---
>  .../devicetree/bindings/bus/imx-weim.txt      | 32 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
