Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F0BC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBF7B2177B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547123282;
	bh=crGfDYdPOltsvWmVn0eFpUZBB/b1BDI7bkxMPXPbe+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yKUkXInOSrPYOARPYD5LO8wPSS1qhh0pTN4fAYX0VXRBbm+s03lcu6x+jjuBll3b1
	 hI+c5FGXDLWL1GEsCt2lOMcKWdSqnByh2SDBdCJzNgh3mOSDLhxxcAwoZrugS3uG92
	 OxJfvrRCqTk7ZVvmlKAqbhOBx4F6RePT4T2aX6fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfAJM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:28:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33809 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfAJM2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:28:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id u89-v6so9544672lje.1;
        Thu, 10 Jan 2019 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwAPx2ugzQ22frK+NatiM0MCS3FyveznXEHwVAedwls=;
        b=oyLYzoDQplzpmiBANRfoBJMF1YggrNImKzXJm58FbC2MomyuY3ZAIcY7FCwYYpXozq
         VeWVL5DPT42gsN7iueiuUOzE9Qri2sDazNsHy/MIIMXoGjTmhhx81pWWjhOO6scXpLns
         Y6i2gmoBfl+/piyn/P7CtxVwzg2yIJjQq3A9MddMqIB36kRTsHaPWR6BEkPgQlxnMAOk
         SmCjiWX0YfSS14oMEHOy5bOfnt72ArvnfGysXe43Hv8uptHSkSUmw5/CRPtjtCnBx3Vl
         EUgCkdhN8S89yAtNieNaOx9XcfSTpgTp+X4q/u4Bqxdp7U8NySliFAmL1ee3koORspUx
         wyEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwAPx2ugzQ22frK+NatiM0MCS3FyveznXEHwVAedwls=;
        b=g4UpbdL6LdcxOklQpUbs7zJ6HstGLOCsbCzVjQgwVKZEQL9zVU05Nl+DVDAXH7M8s7
         1dXmhWOGet6vxDh9Ka4naCb7sej2CAmaa4NWZuFXpbnolmq3LQyNOEgk95IJEjTA2VCS
         u8izCx6vlo8TYrQwlzK2JwzcUk4Air5Yrtz/9/mJ2fpnyXWfDww+FmkasoUfn/gcuqpy
         aXShzWlBfdFObckDdZ4wJgViBZ60pYMDI0ejT/u4tt0aQRQmlwvov/rHEf3xeFJFUGk+
         mQdIZPePJ1FEs0grd2D7J5L5deZFO5OcobiXX/907oAo0TQ8b4xsCtxeWbLEEUTYr5CV
         PBGg==
X-Gm-Message-State: AJcUukcEhXbh01ZbMjGPG+KJzgwMZJcWSYpTni2hwkfX++7NUxw5pw2p
        3oQWRxJkqL0M8LvfrD+F7Z4=
X-Google-Smtp-Source: ALg8bN6pZQP41bicMbMKdqSA40fcd55QFYPBFyd9a52/kjOpJmAy1Gb/8Xy9rWvXIHFloNrV0g5vPQ==
X-Received: by 2002:a2e:9e95:: with SMTP id f21-v6mr5890699ljk.128.1547123278948;
        Thu, 10 Jan 2019 04:27:58 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l3-v6sm15380166ljg.21.2019.01.10.04.27.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:27:57 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghZRF-0002pk-OC; Thu, 10 Jan 2019 13:27:57 +0100
Date:   Thu, 10 Jan 2019 13:27:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20190110122757.GB9725@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-6-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209195150.5192-6-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:51:50PM +0100, Andreas Kemnade wrote:
> Add lna-supply property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  - reordering
> Original order had a
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
>  1 file changed, 1 insertion(+)

Ah, missed this one at first.

But shouldn't this go into the generic binding since it isn't specific
for sirf-star based receivers?

Johan
