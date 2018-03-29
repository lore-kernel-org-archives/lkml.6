Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794503-1522358639-2-5293804863047848698
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522358638; b=O9XNRmcF0P6gn6wrjBKKS69Z12IOYa9Tay8KE6yLEfvqa25+lT
    a/+ShTMtBpcEOMpH58+4BUC9zcq1OaA9sgT1hVHlc3V/oGUopQOT4keqFyxyc/zk
    eyzUbXdD3hyEG0pRHeNBGeZ9yu+w/OPM/mX5/wzVhFVxwarN/0pRo8AU76IHRAGJ
    8HCUjR0wouOsR0B0ci3z2X6k5zfBReXY8akLyPlXkbZrBoWFn27qZvtJFrNODTQc
    NEpd4Eyb67VNR2rWG0+OLWAx/rFCwwR1iVXWQnmo7S7Kr+r/ia6Xt/fFUAjfXLRo
    Qaz9w+6nq4oVTcWJSgRBC4KaOYEHccqGz1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522358638;
    bh=SWS/Qd8krexQ7iUXbw5phD1sctA+KiL6e7+wiSztJt8=; b=Eq/PFEBMLC3e
    Dk3pBW+xP62cm1Gkg+l2zpE+0cd2Ra3SbQFZu8oZvibgX5x1XMzy8QuNWaTUuYO4
    w4xZyghmhbXzg5DClYK6EmR6NDWKA8eVKnqC+j7eWJJ3caxQLFardQagGP8aEBvr
    ZFlla9wn8Y1sQd9zBncp9jIRLTcJ2qWFLgArAPo2xMA0Uf9DYr+s0ZU1Pr1LsFWx
    jDnQuNGVan3m0RYGrQRfHtwBOIz2Hrvy/LPtXtVf7fhsj+wveFaYo/Wper99byRN
    adhIRa+0ZvR9DpLuDdfkNtshlFQeOQw+SKc9yyAu0uBC2a5VEpuguGLo8Dt1KEuS
    QsYK9V+gXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLJzNWVucVhDHIxAREatjOwMqiWexXa3WTkNcfpk0U2szJZxxovdpxXZbYIAUVSd5be28rO/bfFTKre7vTV4tRxJZlUIYROu8Num0Z8NHzcohbtCaPeG
    HfHVimhibddcTmOE2sO2tjIBeYl0nO2SU4j9KzIlnF8ANc9E2nQFC3LMsPkQJoGdZmSlT+n235R3g5sy2C3TeSIz+hTnnE5HVEVXY4P0aVwwX1DyPFkL4Y6j
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=3GLR1-XzZKwA:10
    a=v2DPQv5-lfwA:10 a=Qze4UBMhAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=EbJfy5X4qYIvP0hmrtsA:9 a=QEXdDO2ut3YA:10
    a=30qrNVoKYyQsQ_rTTfpG:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750820AbeC2VXz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 17:23:55 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:46775 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750735AbeC2VXz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 17:23:55 -0400
Message-ID: <1522358626.2654.39.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 033/134] tcp: sysctl: Fix a race to avoid unexpected
 0 window from space
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Gao Feng <fgao@ikuai8.com>, "David S. Miller" <davem@davemloft.net>
Cc: stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Date: Thu, 29 Mar 2018 22:23:46 +0100
In-Reply-To: <20180319171854.104088447@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
         <20180319171854.104088447@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:05 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Gao Feng <fgao@ikuai8.com>
> 
> 
> [ Upstream commit c48367427a39ea0b85c7cf018fe4256627abfd9e ]
> 
> Because sysctl_tcp_adv_win_scale could be changed any time, so there
> is one race in tcp_win_from_space.
> For example,
> 1.sysctl_tcp_adv_win_scale<=0 (sysctl_tcp_adv_win_scale is negative now)
> 2.space>>(-sysctl_tcp_adv_win_scale) (sysctl_tcp_adv_win_scale is postive now)
> 
> As a result, tcp_win_from_space returns 0. It is unexpected.
> 
> Certainly if the compiler put the sysctl_tcp_adv_win_scale into one
> register firstly, then use the register directly, it would be ok.
> But we could not depend on the compiler behavior.

This is true, but the compiler can also decide that this local variable
is just an alias for the global variable and still read it twice.  It
is necessary to use READ_ONCE() to prevent that.

Ben.

> Signed-off-by: Gao Feng <fgao@ikuai8.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/net/tcp.h |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1199,9 +1199,11 @@ void tcp_select_initial_window(int __spa
>  
>  static inline int tcp_win_from_space(int space)
>  {
> -	return sysctl_tcp_adv_win_scale<=0 ?
> -		(space>>(-sysctl_tcp_adv_win_scale)) :
> -		space - (space>>sysctl_tcp_adv_win_scale);
> +	int tcp_adv_win_scale = sysctl_tcp_adv_win_scale;
> +
> +	return tcp_adv_win_scale <= 0 ?
> +		(space>>(-tcp_adv_win_scale)) :
> +		space - (space>>tcp_adv_win_scale);
>  }
>  
>  /* Note: caller must be prepared to deal with negative returns */

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
