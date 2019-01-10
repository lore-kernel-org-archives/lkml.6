Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FEDC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C1E214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547122325;
	bh=i4iZSxZ10gxDNhXlh5D3J0I2xe7ygS2mZhYbL0uaIOk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AZpzUZYIoP4/arkXVHxdduKkijG1nFW7ztRlyYLzOLgqgo2tSDuh5xEqsGY29NUml
	 7wWYzAkU9ZJGJdkIQAYNXnu/QTKCg+H9hJrYhf6yHNV09Na83mfsU2JwraM46RSvn8
	 Ar/frWwCjzFbpoyho7pAdZH1BdcclFfBzLmGUHwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbfAJMME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 07:12:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39337 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727968AbfAJMMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 07:12:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id t9-v6so9498810ljh.6;
        Thu, 10 Jan 2019 04:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YxhrnZ5bEH6f7GA2TAG7cN5Vn3RAYe9CQ34I/qGgfZg=;
        b=A1gOcEiS4HbS333fxf0VlGkdwHWLXmgHLzZedw0mdLQ4mGRH5bIQiXDl0+gpihoSsC
         msLUZqmgqUw+MgbX21wr42U5xJj2ffXUJCbMm3w1qarEhca5KzOxWmwT0094DI2O8a0r
         8E9PmTX2P4KJyvxDtmYVuU2dktAjAXylFNLFW1Iz75ZK1PcYJVUkSCFFw3tziHaVcdc+
         aaVcBBfU7ky7zrnauWaHKPtcufmAAZGkTkDg4Ar04wW5PeYejRQv1p4edMWttDi0V3cu
         CHR2dGRcnNGfKV4XkEj3LC5OJX3YBJ2p9NqlLcj6g8H9/9GQlj00h8KC9F4V7ejuGkwf
         tLog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YxhrnZ5bEH6f7GA2TAG7cN5Vn3RAYe9CQ34I/qGgfZg=;
        b=DeUldwvNhfHiq03PKGtOmFVlt+yCxv96u9CYU4+g6XDC4xSbz0598F/KrRm/iVaoUd
         5jkCU2lpobvUmVhQDObZKk4umvJsS0wp+sQqR8x8jaNsawtXjUnRTUY8MXUEFpjqF//O
         BcOd0EFh5YUa2jUJV/STUUM5ipS8AaQLnZKaLcyIKQeD6SiojKz4hg7w8z/u7HOBh6o2
         tNGcDOI6YeukQod+GW5uzXc7YHimCz1w0qddLNCtUJAtakZ+VAX7FpufDP0er1UhPPlL
         7BNWB6MqwDXFVw/wz7rZIN+eIUHfqVTOsb0nlIxste4myRCVRh49OQqOPGyCciqNKLNd
         3ndA==
X-Gm-Message-State: AJcUukfQiz0MRCqGRBkZ3gjgTccl8+6+ZXy66ko0Fi+Z32nqui86fvdp
        nlKiTFD2Y79W0goRrTRzYeb8ADUb
X-Google-Smtp-Source: ALg8bN5lrXY5nOsVwL76hoihKbDWrveZB92TXxWzR8z4xl7C/ePrhA8NY9c9xy1/maqaL8BNeHVd7g==
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr5642019ljh.59.1547122321267;
        Thu, 10 Jan 2019 04:12:01 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id r7-v6sm15252242ljc.10.2019.01.10.04.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 04:12:00 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1ghZBo-0002jR-5S; Thu, 10 Jan 2019 13:12:00 +0100
Date:   Thu, 10 Jan 2019 13:12:00 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [PATCH v2 3/5] dt-bindings: gnss: add w2sg0004 compatible string
Message-ID: <20190110121200.GC3430@localhost>
References: <20181209195150.5192-1-andreas@kemnade.info>
 <20181209195150.5192-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209195150.5192-4-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 08:51:48PM +0100, Andreas Kemnade wrote:
> Add w2sg0004 compatible string since devices without wakeup
> pins are now supported.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
>  - reordering of entries
> With the original order there was a
> Reviewed-by: Rob Herring <robh@kernel.org>

You can keep that and add my

Reviewed-by: Johan Hovold <johan@kernel.org>

too.
