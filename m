Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-208113-1526278607-2-7381543756792242635
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526278607; b=mjd0RDidG8+I8jhWXkdqhHdR3B53EJLYSBN1iG/eWSDENuQNbZ
    MmzAzwME1oyw51O3CuL+5fMm/GgSrHQcsfN5QDl8ufS2nrPIJT5XF/CVAIZpnuHY
    JSVXh74uIVwNBXb4w7xygWtLyo0pdHudzR+AMY5vwHX6Qub6Vw4/XcwyO5qOfqeg
    UUUoWYz0+RN43/U7PIIqvqtk87WL9cDPWYyFMYMZyM4bwWtHiTZY0NAajIn+pkEf
    rIPLKiDWn+NkpsLGw7ZDbpScsv5rtB+Hs9iEiNvsoHHI2U/heJq4c8MLIQOAA/vX
    lL/YxjZPURTeYMjO14DvtSVwXcGrsYUit65w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526278607; bh=ExAXhVKTUnh5b2/yR+PXUfoTilyv2p
    l90svOSxdXtd4=; b=WbXOuip9OgkjTYbhsmG7SW49pKohi7db0bdhl60Eoc9M8R
    MkVVcy6hgbarYAVR/nLC7kjFEsZJEg6PRK6JTCl2mr9gfKZwrgAho9wA0c9B61hP
    Y8zKqO/iaUondF+v+TdXqHlkEFy+5Jrb4vYqW35jzjjbaUPq4MwlOwYLs+dQAKHE
    uS7+sxuLwV+CcsJvvaqrDeqCJZF+nYPYzRoIk9qG8fxlErGztFVusIjiESsF8D7q
    1LC/olXGDTlN6gNf0XUBJG14sb++gUB7sHs1FQCa2UGicvZpFMJWKclCyfWamcpS
    8+6TiGExjt4fVOO8Lt9pvSbPIUbH7mS0jpRd7fMw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Y+29txeW x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Y+29txeW x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMW3Hn+m9A/EiaNaPlKcmK2XmghUz4W8Ghejmf15v1DdBIeJimyPJK9+AiYLU9VcVPj6CRSTU+iy3YbEZn1DXPET/V24DncQ05EsLTJJL72GJAkoeJfl
    qHW1TX3XAfR3jEuNzRElNQIqEFW9iOlTjvOECOcHMQI81S7o6pZl5rNHRU3aKVrLYaB++LQUxkd95NDlwvPSGBqxQM+gY9wx71IXBysaF/aiz3UEE3FBqCz7
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=eZ2p5blU9TiBVwGvglEA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=jGH_LyMDp9YhSvY-UuyI:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeENGQd (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 02:16:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751690AbeENGQc (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 14 May 2018 02:16:32 -0400
Date: Mon, 14 May 2018 08:16:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Elaine Zhang <zhangqing@rock-chips.com>
Cc: heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, rjw@rjwysocki.net, khilman@kernel.org,
        ulf.hansson@linaro.org, stable@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        wxt@rock-chips.com, xxx@rock-chips.com, xf@rock-chips.com,
        huangtao@rock-chips.com, Finley Xiao <finley.xiao@rock-chips.com>
Subject: Re: [PATCH v2 04/13] soc: rockchip: power-domain: Fix wrong value
 when power up pd
Message-ID: <20180514061616.GA9153@kroah.com>
References: <1526268455-9133-1-git-send-email-zhangqing@rock-chips.com>
 <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526268578-9361-1-git-send-email-zhangqing@rock-chips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 11:29:38AM +0800, Elaine Zhang wrote:
> From: Finley Xiao <finley.xiao@rock-chips.com>
> 
> Solve the pd could only ever turn off but never turn them on again,
> If the pd registers have the writemask bits.
> 
> Fix up the code error for commit:
> 	commit 79bb17ce8edb3141339b5882e372d0ec7346217c
> 	Author: Elaine Zhang <zhangqing@rock-chips.com>
> 	Date:   Fri Dec 23 11:47:52 2016 +0800
> 
> 	soc: rockchip: power-domain: Support domain control in hiword-registers
> 
> 	New Rockchips SoCs may have their power-domain control in registers
> 	using a writemask-based access scheme (upper 16bit being the write
> 	mask). So add a DOMAIN_M type and handle this case accordingly.
> 	Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> 	Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/soc/rockchip/pm_domains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
