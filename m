Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E92DC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377E0206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbfAPWDJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:03:09 -0500
Received: from ms.lwn.net ([45.79.88.28]:52652 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbfAPWDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:03:08 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 26BA5300;
        Wed, 16 Jan 2019 22:03:08 +0000 (UTC)
Date:   Wed, 16 Jan 2019 15:03:07 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Otto Sabart <ottosabart@seberm.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/3] doc: networking: prepare scaling document for
 conversion into RST
Message-ID: <20190116150307.67eb2201@lwn.net>
In-Reply-To: <9a37aecf3f7e5b0df579f4c72885b0716f5abd6c.1547063330.git.ottosabart@seberm.com>
References: <cover.1547063330.git.ottosabart@seberm.com>
        <9a37aecf3f7e5b0df579f4c72885b0716f5abd6c.1547063330.git.ottosabart@seberm.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2019 20:57:22 +0100
Otto Sabart <ottosabart@seberm.com> wrote:

> Add markups which are necessary for successful conversion into
> reStructuredText.
> 
> There are no semantic changes.
> 
> Signed-off-by: Otto Sabart <ottosabart@seberm.com>

This seems generally good, except:

>  Documentation/networking/scaling.txt | 131 +++++++++++++++++----------
>  1 file changed, 85 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/networking/scaling.txt b/Documentation/networking/scaling.txt
> index b7056a8a0540..0ce13ed103bd 100644
> --- a/Documentation/networking/scaling.txt
> +++ b/Documentation/networking/scaling.txt
> @@ -1,4 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
>  Scaling in the Linux Networking Stack
> +=====================================
>  
>  
>  Introduction
> @@ -10,11 +14,11 @@ multi-processor systems.
>  
>  The following technologies are described:
>  
> -  RSS: Receive Side Scaling
> -  RPS: Receive Packet Steering
> -  RFS: Receive Flow Steering
> -  Accelerated Receive Flow Steering
> -  XPS: Transmit Packet Steering
> +- RSS: Receive Side Scaling
> +- RPS: Receive Packet Steering
> +- RFS: Receive Flow Steering
> +- Accelerated Receive Flow Steering
> +- XPS: Transmit Packet Steering
>  
>  
>  RSS: Receive Side Scaling
> @@ -45,7 +49,9 @@ programmable filters. For example, webserver bound TCP port 80 packets
>  can be directed to their own receive queue. Such “n-tuple” filters can
>  be configured from ethtool (--config-ntuple).
>  
> -==== RSS Configuration
> +
> +RSS Configuration
> +`````````````````

The use of the heading levels is kind of strange; I'm not really sure why
you did it that way?  I'd rather this adhered to our normal hierarchy, so
it should be:

   RSS Configuration
   -----------------

All of the other bottom-level headings should be as well.

Fix that up, please, and I can take these.  The whole series can also be
squashed into a single patch (though I don't feel really strongly about
that either way).

Thanks,

jon
