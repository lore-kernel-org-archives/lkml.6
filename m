Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE57C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EEF20821
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 09:24:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FbHE1f6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbfAIJYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 04:24:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44787 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbfAIJYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 04:24:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so3310733plt.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dY2fCWGedJlYccsX3VNSSa4+uvQYYUehpvw6IRKQmHo=;
        b=FbHE1f6nvGc2f7pCi/EQ00kDcAaKC+5F1Q5cQ9sq+spif/fKBY5AcqR8pTT6iKcFQo
         vPYT668R6O6ZKzO+48fLfFdoFMY/DhTEOb60Neafhzfh12YVlB64Iq8Wktuve9CrpXQc
         J8Np0kJFUOApnSD+f0kFk40vdQRZ0U3Lxo/aQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dY2fCWGedJlYccsX3VNSSa4+uvQYYUehpvw6IRKQmHo=;
        b=jfTRGchzrE0CO73/ygDSIjHOFnSgaW0ZYDw9QHlDkoVk/ZzJW82/NlZqhj4vpO/gML
         nvfqsNg3sTUS1O6w7Hat6D0q+x5ltm2urSX024aKEywgoPcm8TFvX0G9N8KLHkbimzAv
         wB7dLUDWNkzyh0X5tOoRTuUAtcNxwvUpjizVRm5dxvN7nuXEixteUIsxJtzTI5Xbep09
         7wKd8ZLKBhaiXI69ssJ6nhFqdhe1qzmPzVz+UJnCH3PqNWjKwdhjS7Q2jRHz51FKRPwI
         45Pu3lGLL2UueUoqEBujc9hdF/9bRBy6Ix2MGlSvVO+w+cxD/mBgSR10LYlA+/4sGzIj
         6lUQ==
X-Gm-Message-State: AJcUukd//Bv5ZSCbsKy5EK5rhYH3tahZAEMDY9YkQJIOzyRvOpS2B1kb
        f3213eQkAGZaPPNg47f7CYXdYg==
X-Google-Smtp-Source: ALg8bN5hzWFSo7jhyanjXL8BWMH0FlHG2rw0sA9yKOmQkbdBwNEJo20qYeOKZmib3vSgB5Ampud3YA==
X-Received: by 2002:a17:902:6b87:: with SMTP id p7mr5369854plk.282.1547025848722;
        Wed, 09 Jan 2019 01:24:08 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id 85sm112691625pfw.17.2019.01.09.01.24.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 01:24:08 -0800 (PST)
Date:   Wed, 9 Jan 2019 14:54:06 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     andy.gross@linaro.org, robh@kernel.org, sboyd@kernel.org,
        ulf.hansson@linaro.org, collinsd@codeaurora.org, mka@chromium.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, henryc.chen@mediatek.com
Subject: Re: [PATCH v10 1/9] dt-bindings: opp: Introduce opp-level bindings
Message-ID: <20190109092406.clpx57gmmtrj2vf4@vireshk-i7>
References: <20190109090420.8100-1-rnayak@codeaurora.org>
 <20190109090420.8100-2-rnayak@codeaurora.org>
 <20190109090912.ciq4uzo5sjghyms2@vireshk-i7>
 <d48db4fd-0b6b-8963-048d-3304b850e28c@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d48db4fd-0b6b-8963-048d-3304b850e28c@codeaurora.org>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-01-19, 14:50, Rajendra Nayak wrote:
> Sure, does this seem fine?
> 
> - opp-level: A value representing the performance level of the device,
>   expressed as a 32-bit big-endian integer.

Not sure if you need to specify endian-ness here.

> I assume the changelog mentioning the motivation behind adding this is fine?

Yeah, that would be fine. Just mention that one of the users of such a
property is qcom/mtk ......

-- 
viresh
