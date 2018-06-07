Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +NiRN73GGFusVgAAmS7hNA
	; Thu, 07 Jun 2018 05:46:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C3B4F608BA; Thu,  7 Jun 2018 05:46:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aXJ1Toll"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 4D82A607E7;
	Thu,  7 Jun 2018 05:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4D82A607E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752669AbeFGFqf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 01:46:35 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33687 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752573AbeFGFqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 01:46:32 -0400
Received: by mail-pf0-f194.google.com with SMTP id b17-v6so4323894pfi.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 22:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKa0IiHiKPjnsmOsfad2hFNE3mMnAg0LjmtKnPL2UIE=;
        b=aXJ1TollBN+7ZgZAKVaZDKePYi7DRLivMu9KN4q6nI77vLfMyov/ZPUWPm+mAEZcLp
         bRwoh3otl0F3oRQyhHwKR5Ss4PrRbZvGOmwxLKlGNeHESoxb8dMo6qrxgk+4OeIEM45B
         iULuH3IsRBnTSvfCttYYgayo5ZO9VOU6aOE5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKa0IiHiKPjnsmOsfad2hFNE3mMnAg0LjmtKnPL2UIE=;
        b=p2sjJ9EskWQhM582h7w6MsLK99If4vzi0X+GiXK9kZD5La1DWBWuYOI4P7hBM8tEQ4
         QnP/ZJaYqBK5TOOrv39mlF5FNzRL44oaLbXtu5rma4Y0NZ60jmI4Xx7xbzraqO2nsjYD
         tUnBHnMmpla/cRfEB9L9IJgUvVq3wNbDufDII+fRMCNP5qT5YBip2UEq0VhKCAS1T/wa
         G02HqO9X3DiLH/myH4gIGXZLwE8hpU+AGVTl5IDOoA4TTkpz0qYVEPcKqbFYs/Ca0xsj
         prXuKr368AOZtAS9jyFA02dH5Kr4Tqlao9CJjd58wrSvH4VznbvnMMV0uLPRyh2m5lrq
         S/tA==
X-Gm-Message-State: APt69E0K0PjPKUBqL3g+tRGTOjwZ2unxnyReJ0uEbMgAoLJblr4JqhYO
        eD12Z3+TXe9uVMnMX8d6H221nA==
X-Google-Smtp-Source: ADUXVKKiw3cP+bLAfBu2bW/FVFU51g9cZ6k5WlgXG59NKA82X51BpByZUICSvs4Z4PIDMFIgCeUOIA==
X-Received: by 2002:a63:304:: with SMTP id 4-v6mr420951pgd.290.1528350392133;
        Wed, 06 Jun 2018 22:46:32 -0700 (PDT)
Received: from tuxbook-pro (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id p20-v6sm18862385pff.90.2018.06.06.22.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 22:46:31 -0700 (PDT)
Date: Wed, 6 Jun 2018 22:48:38 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Sricharan R <sricharan@codeaurora.org>
Cc: Vinod <vkoul@kernel.org>, ohad@wizery.com, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        sibis@codeaurora.org
Subject: Re: [PATCH] remoteproc: qcom: Introduce Hexagon V5 based WCSS driver
Message-ID: <20180607054838.GM510@tuxbook-pro>
References: <1528177361-8883-1-git-send-email-sricharan@codeaurora.org>
 <20180605061919.GQ16230@vkoul-mobl>
 <3a4c102b-7228-153a-c588-b1bf00291fa8@codeaurora.org>
 <20180606161733.GE510@tuxbook-pro>
 <20180607041134.GF16230@vkoul-mobl>
 <20180607042443.GK510@tuxbook-pro>
 <d01d6819-3f95-0b65-1251-aead88fe86cc@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d01d6819-3f95-0b65-1251-aead88fe86cc@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Jun 22:29 PDT 2018, Sricharan R wrote:

> Hi Bjorn,
> 
> On 6/7/2018 9:54 AM, Bjorn Andersson wrote:
> > On Wed 06 Jun 21:11 PDT 2018, Vinod wrote:
> > 
> >> On 06-06-18, 09:17, Bjorn Andersson wrote:
> >>> On Tue 05 Jun 05:56 PDT 2018, Sricharan R wrote:
> >>>
> >>>> Hi Vinod,
> >>>>
> >>>> On 6/5/2018 11:49 AM, Vinod wrote:
> >>>>> On 05-06-18, 11:12, Sricharan R wrote:
[..]
> > If we ignore SMD for a while we have the following combinations:
> > 
> > glink/wcss
> > y     y - valid
> > y     m - valid
> > y     n - valid
> > m     y - link failure (invalid)
> > m     m - valid
> > m     n - valid
> > n     y - valid (platform uses wcss, but not glink)
> > n     m - valid (-----"-----)
> > n     n - valid
> > 
> > So to distill this we have the two valid cases:
> > module/no if RPMSG_QCOM_GLINK_SMEM=m
> > yes/module/no if RPMSG_QCOM_GLINK_SMEM=y
> > 
> > and the way you express that in Kconfig is the somewhat awkward
> > 
> >   depends on RPMSG_QCOM_GLINK_SMEM || RPMSG_QCOM_GLINK_SMEM=n
> > 
> 
>  ok, Having "depends on RPMSG_QCOM_GLINK_SMEM" takes care of the
>  first 6 cases in the above list.
> 
>  But just was thinking that by allowing the last three combinations,
>  there is a chance that some config that really needs GLINK_SMEM and WCSS,
>  but selects only Q6V5_WCSS and misses to select GLINK_SMEM,
>  would still built and make it non-functional, right ?
> 

It would allow you to compile a kernel with GLINk disabled that in
runtime loads a firmware that depends on GLINK being there.

As it would be convenient to thereby state that "WCSS always depends on
GLINK" we can make the analog to 410 where "MSS always depends on SMD",
which isn't true when the same driver is reused on e.g. 845 - which
uses GLINK.


So my recommendation is that we stick with Kconfig options that
describes the build time dependencies of this particular driver, rather
than its runtime dependencies in a particular platform.

Regards,
Bjorn
