Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE579217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546037231;
	bh=M6A5vfCghQ8vk8uj2NtCGrxSO2vtb9x7pXUcqRnshKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ONJWEN+WWx7hOH/ryYi/ko9K6AfOHmt/0qf6ZiNLHb1LZ4yJYAZ3i39HXwTDp+y11
	 ld39RfaAoDCHTmN9b4wGCkuem19uIiGtK4JONfXNVn8wN7NzHbNmjmAWOAoQQt546H
	 3YS9vseGCb0bWhv68PqtvQhYYt+A9OfcauSFFMbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeL1WrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:47:10 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:38207 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbeL1WrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:47:09 -0500
Received: by mail-it1-f194.google.com with SMTP id h65so28522125ith.3;
        Fri, 28 Dec 2018 14:47:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=5T/qCk6IY8oKRYbMypsI8ud0TbHJ9Hyzs7hfX1OoxMM=;
        b=hEY4eZDOA+jgv+jz0e3FnMLKjtP6CDbwxZ2ewx5VNAJZhD+6lASuZrqNH+tQY8UVbF
         2BhF6ztLWpaTOdH72fgef9l9Vgavn/JrM40T13Zxey0MxAAO98nFiMOepG1BKRezLlSI
         naElfvCENRkJ/chrDeBGc0Mnig5UGzZ+2jlHYeKUEMpoYG17Dfdl9T2ukVTl2YnEJIfh
         6fUdifMF6DlZDF4K9sg5ldqwUd6w+cUQjrStBWGciTp4VduRCWgCNQ655E6SXNwy1+xH
         V8QOm95glN9eyGkE7RC1YRIr0MdqN7D2GQTC93R7+OGfER9qbdhMZqJoNt3crmvC1y7P
         wlqA==
X-Gm-Message-State: AA+aEWaLps6n/pSQ5x2v97iaQteA+0AVKiD6xn0PlWqFfEZBrOJ8nbzt
        4TwnVprS7zR2kP0f9MXY8A==
X-Google-Smtp-Source: AFSGD/XLVNduDNlWv29sKsAZCuS866n9gMjgEhFsRK71UVJXLXzsOtTdAcBAcEkex+M0zkWV0E9ZCg==
X-Received: by 2002:a24:b20e:: with SMTP id u14mr19243671ite.12.1546037228470;
        Fri, 28 Dec 2018 14:47:08 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id m37sm16184892iti.6.2018.12.28.14.47.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:47:07 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:47:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH v2 5/7] Input: dt-bindings: tm2-touchkey: Document new
 keycodes property
Message-ID: <20181228224707.GA7218@bogus>
References: <20181228154609.14846-1-pawel.mikolaj.chmiel@gmail.com>
 <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181228154609.14846-6-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2018 16:46:07 +0100, =?UTF-8?q?Pawe=C5=82=20Chmiel?= wrote:
> From: Jonathan Bakker <xc-racer2@live.ca>
> 
> Document new optional property for setting custom keycodes.
> 
> Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v1:
>   - Because key codes could be bigger than 255, use ints for keycodes
> ---
>  .../devicetree/bindings/input/cypress,tm2-touchkey.txt        | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
