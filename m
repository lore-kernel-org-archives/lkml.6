Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 62976C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:25:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BED20839
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21BED20839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934435AbeFKSZb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:25:31 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:38985 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933818AbeFKSZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:25:29 -0400
Received: by mail-yw0-f196.google.com with SMTP id 81-v6so6635022ywb.6;
        Mon, 11 Jun 2018 11:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1Zu7zdhs7aosd8bJ9S29UIILs59sJcnhBpq7XFFcwK0=;
        b=Ae745Q/impeUCdk8HJWQD67pRi2BONBjfCS8h1ru1CebQGFxdclSp4Q81eXcKoNVl/
         +Ott0cgWqQpJv6FG5OxZRthjCh97lQTFfZgUcyQCAo4ufSsooDxpvao/til18f5+n7EA
         iBwWOuvilbMIILL54/xRHwSQduNu5ySdkWlARUY6YSglsOwnAONK9Mu7/rg9ejEx3CvX
         BsQPXnq0FTrrsFIfkL7EciVDf5WmxCSTufKFCV23P3cwFStmh8j1wJ/X4ZWBpJrrsOFd
         O1Tpl2shmSvChttipNeJvuv1KAjKDDX47UYo3B0tbZ4PKfUmLMR7dlsFtiyepIJDlGoc
         QABQ==
X-Gm-Message-State: APt69E1ZnPty4fujbNUMPvBDQQqzK8ikyQpDJXcCk/A+pbMNRqhxfxoV
        fJVWqPFIsStNINTHHS9YpA==
X-Google-Smtp-Source: ADUXVKLp0UCMLOOm0rbAlZVrAWGZ0C90Iydo84RaB5dVOsJqYHee46poiEiye2d2V8P1ZcwGkVr8mQ==
X-Received: by 2002:a0d:d957:: with SMTP id b84-v6mr146518ywe.257.1528741528956;
        Mon, 11 Jun 2018 11:25:28 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id d7-v6sm11466128ywb.99.2018.06.11.11.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:25:28 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:25:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     netdev@vger.kernel.org, madalin.bucur@nxp.com,
        Richard Cochran <richardcochran@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [v3, 03/10] dt-binding: ptp_qoriq: add DPAA FMan support
Message-ID: <20180611182527.GA13639@rob-hp-laptop>
References: <20180607092050.46128-1-yangbo.lu@nxp.com>
 <20180607092050.46128-4-yangbo.lu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607092050.46128-4-yangbo.lu@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 05:20:43PM +0800, Yangbo Lu wrote:
> This patch is to add bindings description for DPAA
> FMan 1588 timer, and also remove its description in
> fsl-fman dt-bindings document.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- None.
> Changes for v3:
> 	- None.
> ---
>  Documentation/devicetree/bindings/net/fsl-fman.txt |   25 +-------------------
>  .../devicetree/bindings/ptp/ptp-qoriq.txt          |   15 +++++++++--
>  2 files changed, 13 insertions(+), 27 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
