Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAFCC3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 779402089D
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IOpXnpFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 779402089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932942AbeGHX0Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:26:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33748 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932692AbeGHX0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:26:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so12283105pfi.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 16:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=g4LdTou2xjzbz1FOdIgWBZ5I2BT8UENCb/4CjY6knaw=;
        b=IOpXnpFuCGNRlX1OT7/9wyvYNnF3LZw9fVPAJ1Gp/cL6l66EWQIP9zCUBez7BIhlxJ
         ySpjSKC/uwEpBkhMmIsfEfBBW9PqL2y6kFhvYLiAqNJ9SMstZ6aSSy6ISFNva7HjanZE
         NQXmXblWxv1cMQcZiPysuRw0ai0Wo5fTRUm3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g4LdTou2xjzbz1FOdIgWBZ5I2BT8UENCb/4CjY6knaw=;
        b=d+UKrF77asPvNCMhSRbjk54yd2JzM+LDrsZhFvJA91/v3qmyoownUi7NqvMKUrhvQD
         drBhuZ20FBMpe2tHNES60gKznXC0zD4Uf9n8PDzifAx6pEiNgPZuaHYNZ1EsNVB15ZJ9
         aL+aqZaWRns0srg3LpFMBo222Vld5zE34lbpfwEedHyM3XT/Zh0+pQcgvHkPTJcOzQhh
         JSgr8Z5DWvUR1125LRYjwJ0+cb6J8X5ukiSBHGhhjlQPpD9mwAmz5CfQmMF/muQfs0u8
         +/weN+03brrvzcsvkG3Vut8NO14nClXDDhTRbQOWmi7t6sBZslpM2a3eZ4F9pRogerGm
         mn/g==
X-Gm-Message-State: APt69E0DM8qB64SESQTjveK0c3hTvOQwpyDNv7aZuPRdpTvg7Nlmb4KC
        8UXpfjbuP4WKBVMlXSeZ2cLHeQ==
X-Google-Smtp-Source: AAOMgpd7vguALethbfQ9rw9BtuBbGeOUtQu5csQ1LG8nraot8qfn1nZuQOa2Dl8WQqL0pDeqCJsdIA==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr10683555pgl.13.1531092383820;
        Sun, 08 Jul 2018 16:26:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1192-169.members.linode.com. [45.79.93.169])
        by smtp.gmail.com with ESMTPSA id v5-v6sm22027657pfm.14.2018.07.08.16.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Jul 2018 16:26:22 -0700 (PDT)
Date:   Mon, 9 Jul 2018 07:26:17 +0800
From:   leo.yan@linaro.org
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, xuwei5@hisilicon.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: hikey960: update idle-states
Message-ID: <20180708232617.GA21469@leoy-ThinkPad-X240s>
References: <1530860246-29072-1-git-send-email-vincent.guittot@linaro.org>
 <20180708140157.GA28878@leoy-ThinkPad-X240s>
 <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <948f033f-aef2-4d6c-170d-a1ff2113f258@linaro.org>
User-Agent: Mutt/1.10+31 (9cdd884) (2018-06-19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 11:15:22PM +0200, Daniel Lezcano wrote:
> Hi Leo,
> 
> 
> On 08/07/2018 16:01, leo.yan@linaro.org wrote:
> 
> [ ... ]
> 
> >> A simple test with a task waking up every 11,111ms shows improvement:
> > 
> > Should s/11,111ms/11.111ms ?
> 
> Actually the French notation is ',' for decimal :)
> 
> English and French are inverted.
> 
> For example one million is noted:
> 
> French  : 1.000.000 (or 1 000 000)
> English : 1,000,000
> 
> And one milli is noted:
> 
> French  : 0,001
> English : 0.001
> 
> :)

Ah, interesting.  Thanks for explaination, Daniel. :)

Thanks,
Leo Yan
