Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC097C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B01820989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="G12lQFwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B01820989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbeLES5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:57:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32798 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbeLES5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:57:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so19369215ljd.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wZOr/mhE9Kfb0RBNcY+siwCL0pWWKCAToqOSDZBCDVw=;
        b=G12lQFwYUeVZSReZv3g4IQo+Hb3NL1xCyF+/qh+W/gC4Vc8Jn99luIlMWg/NLFKqzq
         sU2uuTaZApMHjvD0jF1UeOAVDUCabQwG+pESMGVSZ3Umd+1CKSHDXItbVklrS7NUs74l
         wb8gMxV240IJ2+57+7uCNYCNzxtjfcdd4kKCcadjFyjL8FwZJQXaZ22fpxLztc3TMpmS
         /FdXb2sE0UyEUG4P2D0gcF9YIzCjgxnxeJAMp8u/aF69kx503g5dXeoJ0ZAx3BdYbII9
         g9M3fPhMahQ4io8zgORHDhUTw5fPOLIP/27xDf50ZJeV3BwcQ/2dfBpf7koSEd/XDMdA
         wcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=wZOr/mhE9Kfb0RBNcY+siwCL0pWWKCAToqOSDZBCDVw=;
        b=Zr4O/I+tOIHNTNEpDNL8Py7aYKmc+OjXD1y9aXB2IdofAnnR5bleLlF0vaGbghrGbH
         d6/t0VMbOQ7EKmEa5gr29wR6MJT6YY4vmJmUvMZXKhWfnjdw3ejQgGacg1LcX6IQJXrl
         wdjrehGG1XiS/0Hzc02cLaSjcosJ0L+9Iu5uXYaj4njyoIMsVQ8xACd2HyiZsmZKqAf9
         ioa4ZT+YtmbbnIOqAIwsVj6iT9A/OSiY7x6ztF/y5CwZo7QP7sFdh5x2rypJDMnWrBsZ
         yyK3UIF+Z4ZZIoicBedHm1ikjJk9/5g30UxR6KY/ihtxjQTwWw1H/dmj3qX8ffbV+Gyc
         QMow==
X-Gm-Message-State: AA+aEWYNiG0g3SoWl0FFUq87Spp6OMX6yFcfg6CQuhyGnvcASFiODwrc
        RNgqa4wOumsJpko9moTphij1Yw==
X-Google-Smtp-Source: AFSGD/X58N7NxjS1I4tzou6u8avIQLvMEq5yufz1ex+ZtsfJ7AL0aEhjibP4Rm59AydnuavfNJRccw==
X-Received: by 2002:a2e:9694:: with SMTP id q20-v6mr16375808lji.173.1544036219535;
        Wed, 05 Dec 2018 10:56:59 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.81.157])
        by smtp.gmail.com with ESMTPSA id z15-v6sm4345080ljb.9.2018.12.05.10.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:56:58 -0800 (PST)
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
To:     Marek Vasut <marek.vasut@gmail.com>,
        Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
 <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8de55806-ee08-69c6-df1b-45b1eba607a6@cogentembedded.com>
Date:   Wed, 5 Dec 2018 21:56:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2018 09:19 PM, Marek Vasut wrote:

>> Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.
> 
> RPC is SPI and HF controller, it is not a pure SPI controller.
> 
> How does this deal with the HF part ? Keep in mind the bindings are ABI
> and it will be difficult to redo them later.

   Perhaps we need a "mode" prop, maybe w/vendor prefix? 

>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
[...]

MBR, Sergei
