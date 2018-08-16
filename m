Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D244AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F247214C2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 09:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JYzjFbQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F247214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390338AbeHPMJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 08:09:55 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:39137 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeHPMJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 08:09:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so3656411wmq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=dQXB3XbKb4lq83X5qoG2vmD4HiWZuEhQuTiwPKNXM/0=;
        b=JYzjFbQ1QNU9oKT6TSj06HG/+IOz91Kgb86WbaWI89oUkaasinUGHvnYCubu3NXv3R
         TnV7Kci4jMJdaWRg1r88RbmW7cx9H8aBVub7epH2gLqRz53Jf49HzXks7xjxXXAVEj4W
         FFm2PuiQhBWdut8iAs9iIUod1c79GMZS47paA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=dQXB3XbKb4lq83X5qoG2vmD4HiWZuEhQuTiwPKNXM/0=;
        b=lpl9t0/780PnAOTccuO7Q0/g+9Bv84zH1emyLOBQslhWl9hLOoTi2FLnJ2Mt+7LrU+
         U6pkaSA7F9wu3Rj0Armo+gkGnYsKaVxJBLDPTSzTVLgJD+7thZEb6W9wFILsnAgSA7Bs
         4Bc86KPkSbzi0/uMrCWknPLJTVEJNriW7Eb2G6yUvJ4ktl12j9PhSkjX56L73vHBspOl
         meJlMB/P6A9OYooaESp9bN4ev096cZm9pfTQlVMnGcptxrtnvmC0vUVin+2Zm/U0mRp7
         vO/+jSqEWq1IDXEDWGQfgI106waBa81ibfFsmbtuaN0+AJ8oeUtItwXU2s3QVq4DvEKM
         6l3w==
X-Gm-Message-State: AOUpUlH+2Jq4ygBNWQCpm3b0wIPDO29F4sDU+OKRQkThYYeYsNsFI8m7
        SdPOUZPVbvPaNd9G5d5+wAtrWcoqCig=
X-Google-Smtp-Source: AA+uWPyuKyQpd+Tf27R8JXmj38PX03aLt2zTkwoACEJ9uODsWOSALFdfxktJLsRUMc393kD9AZ31sQ==
X-Received: by 2002:a1c:ec9d:: with SMTP id h29-v6mr16193872wmi.94.1534410764193;
        Thu, 16 Aug 2018 02:12:44 -0700 (PDT)
Received: from dell ([2.31.163.71])
        by smtp.gmail.com with ESMTPSA id u7-v6sm1085000wmd.46.2018.08.16.02.12.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 02:12:43 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:12:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: madera: Add register definitions for accessory
 detect
Message-ID: <20180816091241.GG10054@dell>
References: <20180807090813.15695-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180807090813.15695-1-rf@opensource.cirrus.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Aug 2018, Richard Fitzgerald wrote:

> Add some register definitions for accessory detection, used
> by the extcon driver.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  include/linux/mfd/madera/registers.h | 51 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
