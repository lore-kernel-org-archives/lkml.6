Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98028C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58CCA20818
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CCA20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727297AbeKNFhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:37:52 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:42718 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbeKNFhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:37:51 -0500
Received: by mail-ed1-f45.google.com with SMTP id j6so6557631edp.9;
        Tue, 13 Nov 2018 11:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0n/qxSoON2phZgYFSKD6jSe7+TthZ1bA59lqeWhxMeM=;
        b=JBSto4QBXUwzDKlKKkxUEIaMr55fEkKYPIY7g9w46zMkH0HjF7SNYqxGmABHfn8UyT
         vMX/TNFeKiRbc5KQTedvmBfO+IcuWwUKNb9I5096dr/7Lucx4LI1WFMe2w7uPuuzF0vc
         RDMr/avMnMGM2anwhXJmYhRxXi6WYlECQh8h9+70a3qB2JCSntema6NKUGhsF0LBZFFq
         b4WJYSG9eJt+GAmIOE2/ad3jh07V8YlxInkIDdrn4QsQTlOkTmBSUd5Hy8vVuqmEK4Gp
         el4aQMmEeosBSXfBanEBb9o/D4vQ1bCNnvWamBZS11EdiBuoSgsled5thwzUwighRRJl
         FWrg==
X-Gm-Message-State: AGRZ1gI4bu8IWx4si2nZJoCocPKD4aavYnoRvUTu3HohQuCxwnRbjQAf
        Eu3ID9sUZsnZmJ2VJ/cyZIg=
X-Google-Smtp-Source: AJdET5dUW6RxnoZJ9sGiyT/xCt5b0YMxthNNjct9ka1JnTBM5WPM+wNhut1D/OHQTwp4Cd+cw78/Sg==
X-Received: by 2002:a50:cb85:: with SMTP id k5-v6mr17731572edi.171.1542137895761;
        Tue, 13 Nov 2018 11:38:15 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id l19-v6sm6099263edc.3.2018.11.13.11.38.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:38:15 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:38:13 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv5 3/6] ARM: dts: exynos: update maximum frequency for
 sdcard to 200MHz
Message-ID: <20181113193813.GD2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-4-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-4-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:35PM +0000, Anand Moon wrote:
> set the max-frequency to 200MHz for optimal performace.
> 

Thanks, applied.

Best regards,
Krzysztof

