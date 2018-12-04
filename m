Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527D2C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198032082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 22:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 198032082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLDW7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 17:59:40 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45226 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeLDW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 17:59:39 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so16822719ota.12;
        Tue, 04 Dec 2018 14:59:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PcDnk+dmp4CDvgWb4QZlGd4nPBk8brW+78dwKCifZI8=;
        b=Ye4UUdx0Nb0GoNmNEAadIBn9o5ASyw3d5DaqFoA2Iuc4JuNZq0bfpZH55vm3GtKqqK
         H0kSfxwxTzd5dAoT1KG10eLlJWCwOAtqdlUrfKsJFdbGnloU6mEWOullqs9pJn3FVbMF
         ZF9E1hRckVqL6Uj6UoIpihbDDWNZ1tzGrV+yzDUTQoDpGwdcQviH0mnlCQf0OjanqJ0d
         7Vp60Ex67+ofHMS91BjUfrwOlp2cua2/lb6TNn7OnDWw3swAB9YcfMW4MOgT0qyHb/Xd
         0rBndJiD1x8T4ep1LdfB1xY8y+VMqStaW05IqmMwCsUfTwEtSCvh6FvSYNduMgjWXxWh
         vDcA==
X-Gm-Message-State: AA+aEWYm804PwTgvE/rqKYTfY/RV4tHyAV/WxiNX82RFBSB+LX3Hi4qX
        31Jfhk0uP8Kc9wUsTW957DSFpXY=
X-Google-Smtp-Source: AFSGD/Xr3xPO55eeDS0BF7uJUiItUjEvYWbsIZ0RFhzSkYh9m8NF8r9FbDwsJXeuMCFvRL+ZYiAvNw==
X-Received: by 2002:a05:6830:cd:: with SMTP id x13mr13195682oto.13.1543964378838;
        Tue, 04 Dec 2018 14:59:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f34sm7664094otb.25.2018.12.04.14.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 14:59:37 -0800 (PST)
Date:   Tue, 4 Dec 2018 16:59:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     johan@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [PATCH RFC 5/5] dt-bindings: gnss: add lna-supply property
Message-ID: <20181204225937.GA25800@bogus>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <20181118215801.12280-6-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181118215801.12280-6-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2018 22:58:01 +0100, Andreas Kemnade wrote:
> Add lna-supply property.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  Documentation/devicetree/bindings/gnss/sirfstar.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
