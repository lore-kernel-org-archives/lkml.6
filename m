Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4168DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E2F2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 02:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3wCoVWt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E2F2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbeK2N5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 08:57:21 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32814 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbeK2N5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 08:57:21 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so266155plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 18:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFU1lUq2SC/xP0cpSKqjgisCKeyMbH4QUfp+Cb3/n8U=;
        b=P3wCoVWtmXhJ4fU+eLVU/+9a57UfgLrhXK4PikAPuSTvRmt+s35kZ+coY69V0Ci1Qe
         zz1DRjUpel8kaNRR9QJXHLkaxoscDDZe6OWV6H8nkf8fWMYMz+Ti/Tkpgg46GXq009mE
         uTZJUeaRd5fWGgT0Hg4vQbGGf0zxq3IWPXQ190K5IRLKneHNSgZ71htbKzOFpbGFj+5U
         JUDIWYjc3f8V2Us0o3mvWtYGxbzVfMzvgKvkT6SqmSAIIO+YQ7uDO1wFgw/JCLpnVoVn
         0pM4Hq3kL7rpCMNDZsWrP14fdKSh4GAqGfFo5QrOmeDh6mYkEMVUiMPjgl7qXG6ou5y2
         cmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFU1lUq2SC/xP0cpSKqjgisCKeyMbH4QUfp+Cb3/n8U=;
        b=sD5fphym2PzD6jNSG2sIg6FwpTwtIh66tFf/XGmxwB1f8OOIxvfzt9xQ41TucahGO6
         o+0koGA1KwNVtXFTOW3MKfRJPYOO8fWr7Sgh1KYc/z986oVZW7u/rheQk92txsKGl5XE
         SW4KWWEIWvhp+c47x0t7/mkxUQM9pPVemHeImVwA/jqg+aiC103pxfIhawpgGNvMa5VS
         PSmCLtxuB5oBHhMKiuWdjBktlPg0HrwOowcomgReBhNpPdYz5RrS1Ig0idJvpJp3qxxr
         AJGmiy5UYT6awkVP6XEAQzs8KMzdQ3O0ybtKwI+fV2Rn9rl9kj0MrBYXOlvSOnHwNi+J
         EPnw==
X-Gm-Message-State: AA+aEWaxCZPSAUAXL3KfpsBAlwv7JOzq5waRjG94ph6NBQ21MqW0JaGu
        srall3Zy7b3VbUPn/GJFPaU=
X-Google-Smtp-Source: AFSGD/VGI8yJQ0EiiVwSOeYW/71KrrHgGQgDluQ1zJJ46DuauovrpHg8UWI+riiBKivjtUz+TVCVeQ==
X-Received: by 2002:a17:902:33c1:: with SMTP id b59mr4499985plc.220.1543460012702;
        Wed, 28 Nov 2018 18:53:32 -0800 (PST)
Received: from localhost ([175.223.15.27])
        by smtp.gmail.com with ESMTPSA id 78sm419704pft.184.2018.11.28.18.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Nov 2018 18:53:31 -0800 (PST)
Date:   Thu, 29 Nov 2018 11:53:28 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Rafael David Tinoco <rafael.tinoco@linaro.org>
Cc:     linux@armlinux.org.uk, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Subject: Re: [PATCH v2] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Message-ID: <20181129025328.GE6379@jagdpanzerIV>
References: <20181025134344.GZ30658@n2100.armlinux.org.uk>
 <20181121001150.405-1-rafael.tinoco@linaro.org>
 <91776bf8-0d12-1cc4-1ffb-ca3c486aeb0b@linaro.org>
 <93b0cce5-4ceb-14ab-5987-af54f15958f2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b0cce5-4ceb-14ab-5987-af54f15958f2@linaro.org>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/27/18 18:33), Rafael David Tinoco wrote:
> On 11/20/18 10:18 PM, Rafael David Tinoco wrote:
> > 
> > Russell,
> > 
> > I have tried to place MAX_POSSIBLE_PHYSMEM_BITS in the best available
> > header for each architecture, considering different paging levels, PAE
> > existence, and existing similar definitions. Also, I have only
> > considered those architectures already having "sparsemem.h" header.
> > 
> > Would you mind reviewing it ?
> 
> Should I re-send the this v2 (as v3) with complete list of
> get_maintainer.pl ? I was in doubt because I'm touching headers from
> several archs and I'm not sure who, if it is accepted, would merge it.

Yes, resending and Cc-ing archs' maintainers if the right thing to do.
It's also possible that they will ask to split the patch and do a
per-arch change.

	-ss
