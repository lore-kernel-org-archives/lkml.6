Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EDCC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BCB2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548874011;
	bh=9PIODHe1QNIgJUP62RcbYEoaZSOh7URJ5X5r5Ba18MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DJQmxfLTxgzR7jsdOjxcZEfncpvpoM6FK7nidtK4gS7chdJdD7ZwQXe5udG5Ww+Vx
	 jseKk44FWOTJkoMb9XtzOmGt+8I1UX6UxBXhyiH6WGaMUl6vwQl7Q0MZxWhW8EmwXN
	 q4qAR0zSrBx1blAc3zAc//UMnciHJ9IhXC89sdro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733201AbfA3Squ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:46:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33135 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733116AbfA3Squ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:46:50 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so563112otl.0;
        Wed, 30 Jan 2019 10:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zUFgm+bdpz05HgTHierrfJ+rd8bRW1Fod3fFuhlSPl0=;
        b=gXYWwMBemflepgkVaF9q5yaVKhP7fSg+uDv0w1DvgtbpDEHqWYmNGClu+18pP8/Fhw
         UEAaeub5NBPrjUOxdNnkZKJUFqvzqLlnhF5mdusLssBMDVCOGOg8VVDk54eiYPWtSOXM
         9dv6VUpM4E/E3jfJ58bijD2+Q8sgmwczV1fSbyKLkKl5/Dmru3HqSFvTkgxXybEn46ak
         RkhL9tAqX7ffdxTjpikGKnYZI8LTZIeNAGlQO2CSdElNL3FWKtiKzo62LVO02MPHrq8d
         MsJR23Th9yofB8YVCe+L9u2Tr2X8DAhX29F1hoyGygL+eX1Lumu7gwIq8V3cbifj5ifU
         GYOw==
X-Gm-Message-State: AJcUukeqcVg473R5SVBj9S6PVBn2OSaV0dTnuK/6smw4SPEQ8K1JW7w9
        Fo3Iqe+crUeftzbwdMlV0g==
X-Google-Smtp-Source: ALg8bN7FJXCJY890U4hH6beoQpoSOHVMCF45sOumbB/XomPagwJNbc8acVrBGS8F1ER3NeADvxEEXg==
X-Received: by 2002:a9d:7d10:: with SMTP id v16mr22652727otn.114.1548874009307;
        Wed, 30 Jan 2019 10:46:49 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v20sm832393otp.10.2019.01.30.10.46.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 10:46:48 -0800 (PST)
Date:   Wed, 30 Jan 2019 12:46:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Zhou Yanjie <zhouyanjie@zoho.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, paul.burton@mips.com,
        gregkh@linuxfoundation.org, jslaby@suse.com, mark.rutland@arm.com,
        syq@debian.org, jiaxun.yang@flygoat.com, 772753199@qq.com
Subject: Re: [PATCH v3 2/2] Dt-bindings: Serial: Add X1000 serial bindings.
Message-ID: <20190130184647.GA9520@bogus>
References: <1548667176-119830-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-1-git-send-email-zhouyanjie@zoho.com>
 <1548695029-11900-3-git-send-email-zhouyanjie@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548695029-11900-3-git-send-email-zhouyanjie@zoho.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2019 01:03:49 +0800, Zhou Yanjie wrote:
> Add the serial bindings for the X1000 Soc from Ingenic.
> 
> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
> ---
>  Documentation/devicetree/bindings/serial/ingenic,uart.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
