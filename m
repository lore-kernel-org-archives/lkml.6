Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4028EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A710206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550860697;
	bh=9XgsoIFXKGdVcesmlFfqJ0gMoWT78D8WsS9vTCuJsm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IbxjsS36M+iDjSvD8jIZkqHBnZ3PUUNv798pQrcIxMlZ1PW0PAo2Sr6Tr3WOrcfs+
	 97Y4t2tZeZomCdeksrTsjtEosUR0pVqZ89JJUYcACeMTc6T8y41rYZe3REoPx2k6wl
	 fMzS8ljOICNn3nGCbbQzh+TS5jPAuLyBiL6YptYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfBVSiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:38:15 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39751 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBVSiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:38:14 -0500
Received: by mail-oi1-f196.google.com with SMTP id b4so2487368oif.6;
        Fri, 22 Feb 2019 10:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=10Dgi2QHVM3b3MGiOV+JfGuM6InqoSZA30FHUFZk4hY=;
        b=muO5qHD5DwysMnNfIzuA2Mm6p6Y2+SNwC1B+f70zDzawHP+qfRmDQbW+riKaCz9Fg5
         Oboagh+uyMaIqfnwcwrVD6/zHeJR5nEJ7S/B2UbnbNKj9U/X4cAMfd6gJl/1mFhMCUwv
         yIyHFbTYGhFlUMgAXQ3toImJpWByh3AmjoeB2IppNALNUc8VPmUEt2o9YEKwyf+BZGcA
         r91T0dV5YTEYh6AkopLv3uMOx9pfumykXjLOELwo15YCz9bFmKIXvQmXuBFlgS6RAaAc
         NBkaqLll3URceMCTZhLRHpoN0pbHlzHx+ORF7csJcTgr5v56wSV3JIS1EEcDjv96eTor
         mLyQ==
X-Gm-Message-State: AHQUAubAHl99fU7UcdaYH8jq7mImDsDhl+CudFXXLdJELrAcWLBlvad1
        HW/2OK5eJKcskX6JKjyqag==
X-Google-Smtp-Source: AHgI3IbSgwseEMdVBw/Qy/2P6RYugN5ZaKjThInL+olOyRnlN90LSp2j3bUU/joQPKwdMUXfCsT6Sg==
X-Received: by 2002:aca:e345:: with SMTP id a66mr3228574oih.41.1550860693707;
        Fri, 22 Feb 2019 10:38:13 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f43sm816316otf.23.2019.02.22.10.38.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 10:38:12 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:38:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sugaya Taichi <sugaya.taichi@socionext.com>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        soc@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
Subject: Re: [PATCH v3 7/9] dt-bindings: serial: Add Milbeaut serial driver
 description
Message-ID: <20190222183812.GA20616@bogus>
References: <1550648677-11164-1-git-send-email-sugaya.taichi@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550648677-11164-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Feb 2019 16:44:37 +0900, Sugaya Taichi wrote:
> Add DT bindings document for Milbeaut serial driver.
> 
> Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
> ---
>  .../devicetree/bindings/serial/milbeaut-uart.txt    | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/milbeaut-uart.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
