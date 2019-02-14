Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3476C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF65222DD
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KeKFV07g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404610AbfBNQOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:14:14 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38707 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393520AbfBNQON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:14:13 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so11408865otf.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BOdALxYy+v9RjyIVHsAH5WhzSJeArR/S2Nq0EePirsI=;
        b=KeKFV07geQ0ZRrIBryd8TL+RSaNTOPuFEv4k/xygZN3yUY268CG8F2ovP8/BJ96A5f
         Q7xvBs3c5e4UFEiVNTuj7L23iSLdSriS9wpvQx61v96yjp6A5mijzJvsH8sKBQjd7k4y
         /pUCZhGrxl7Xfu4yGjDeQxMHIKh1Ow63HRghfHq+V+rQGieQdrZsm3z5yymAac+sos4W
         5PPzXMQWslYCT1iYDyxol/da6N16kXudFIvLz2rlpoNmgTNlD+GhCBbQrWD/3SRZK6Ar
         rxaBl2THcrK3ycq5wfUx3Y4ChF1+rbAL88dh5eHwd24QdZBfJoV7WjSv2UMcXyCImyxL
         OcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BOdALxYy+v9RjyIVHsAH5WhzSJeArR/S2Nq0EePirsI=;
        b=oJyXbAfje3DaA8/LgMHhk8A5cIDKAVh/uugU4lsSJOA9fCxnpWs6URrmm0LZdi8fm7
         QBvpE2iuiVtPb1sLwZKAnYobePX+EHpu/gghGTnKM0lrDCybA3CEr8umfJedQNuRPvdv
         jhd5FfVWCgbZq92Dqowec37q0SGKYx8q70raqJ0Zm8l9TetgGt/H6Y3+mNWNO8/njgMh
         wgwPYMLjAaNzCJeTiPc8EukrCpOh6g7YMzujyuBKjPXWZZOhMMRTtW5jDNWWgF1/AvIo
         RDKsrLG6fk8+LCx2D1rXrnRHtVl3CVtDEm9E4tQWu9gLTJOPyYOI7+fKMiZ2ui0XAVJc
         Us3g==
X-Gm-Message-State: AHQUAuaUt8l/WcDQbUeHcUqGfeKJV7MYEPnYtOBT6lxpi/hCarQBGQsS
        XTJ+DbzQ1u16o1WLlxOYf4ae4A==
X-Google-Smtp-Source: AHgI3IZ98GHOk6p8zUMScBoD2UZWP6KDgZkEYvXlPMlQ+yD0DhUtRJ6ktre2oCVxg6HJqROYoBkLQA==
X-Received: by 2002:aca:b104:: with SMTP id a4mr2836415oif.133.1550160852645;
        Thu, 14 Feb 2019 08:14:12 -0800 (PST)
Received: from localhost (107-207-74-175.lightspeed.austtx.sbcglobal.net. [107.207.74.175])
        by smtp.gmail.com with ESMTPSA id s66sm2041128oia.55.2019.02.14.08.14.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:14:11 -0800 (PST)
Date:   Thu, 14 Feb 2019 10:14:07 -0600
From:   Andy Gross <andy.gross@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] arm64: dts: msm8996: fix blsp2_uart1 4-pin pinconfig
Message-ID: <20190214161407.GA18332@hector.attlocal.net>
References: <20181220161750.12587-1-johan@kernel.org>
 <20190212210656.GA6642@hector.attlocal.net>
 <20190213090544.GE28278@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213090544.GE28278@localhost>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:05:44AM +0100, Johan Hovold wrote:
> That's funny, submitted six days before mine for a 2+ year old issue.

I can't tell you how many times I've seen this happen (to myself and others).


Andy
