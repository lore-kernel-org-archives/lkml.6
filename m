Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1071429-1522071600-2-888530779849786998
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522071600; b=LJhVzW7zhgtL9Jzw1R9aAeRmCDp4wSo1Ef+gHr53yCymVUf
    qRgku1DTp3v8tXT/c/LyywMsryqoreFZEKIcTGbvcxPvFqKL+DywADugGUOKrvcB
    2Ssi2hdyW3Jsn5BAeDnAvpmA78wDNB8AAGUz6OrenjX2AlNyjiWOtlq2pzGVSIx8
    k/IFU1Spfw2syt+0Zbk226JP1vI7+wFN81za/y/9CFWqqNtyQZ3l5WpurYYGUEOJ
    60CJMtHQA6fNWxioDg6a1JtNDgfkZfMs7lYkk+8PuDp0rjFwj/O5U21a+f1MF7xS
    EIVtTjNBQ2AQDcz+20ujKzlioHnpCa+2OXEEurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:reply-to:from
    :message-id:date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522071600; bh=f34492AQsxOmYG0aTa/eD2bHuAVaUzkSIC/afVr1aB4=; b=U
    iSDDsVFZgRZG107rDfpt2COc4XjNxgZoyV4Xo/XNfPzrbLdc0qO9QJZCGn6s6wbp
    U/dhQjHzvWyvG1/fnpXwYxIaqMNp3UPvU9VsZ61M/igjVdOD9dQlMHrmQWkTsYaz
    8DIezJnG9Zgpdy6WdxXgCqFbhgYVSthrIx9VE+IoWOCSUGjqqV5l5QPzlmr3VAmc
    GBvD+Xb7altHjWD7c3as4jZZK4taVKp4PqwTh0qU7ms2KaW0B6HZuY0SuA5JacZH
    VAj9KXNFsukoyK2k6SIq43IBKNpMg3rUmCXp1W5zqlVFcsoU2xlOrfKLQQePLVyx
    DsKbPczdS4K8MaZwTkNbw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qhzPkG3+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=qhzPkG3+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCHHxkDUeNm1Igw9x/2wTGziGqgFjCislDODHDgtMCzG//RDPimtHIC+dcjkmnBVzOEn45aUcYieBTo5xGVcqE7woCxZv9DOHLN9KHZ1+VFVadtfASBF
    mLrBgkNijVqUMayge2/ycxcgqtupGY9uAQD+epveKRFkGwwyrsut3LXrS70q2cBkBiXCbRw72t550vCUCiWZXH0wVabCr4Y/uBM6HhDIrV/W6fw1aM5NCqXm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=vQBBkBfzAAAA:8 a=P1BnusSwAAAA:8 a=1PV7r5bBiXHNVB1y23IA:9
    a=gKwz8JNiChnoWoiK:21 a=shvQcO0wfR65to6K:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=NGXS0kB0m_rannUenejW:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeCZNj4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 09:39:56 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:43063 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeCZNjz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 09:39:55 -0400
Subject: Re: [PATCH] media: vsp1: Fix BRx conditional path in WPF
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
References: <1522070958-24295-1-git-send-email-kieran.bingham@ideasonboard.com>
Reply-To: kieran.bingham@ideasonboard.com
From: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Organization: Ideas on Board
Message-ID: <da2ab7ff-c236-60da-f502-f15292add028@ideasonboard.com>
Date: Mon, 26 Mar 2018 14:39:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1522070958-24295-1-git-send-email-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry,

This should have been from my +renesas to support Renesas' statistics and
filtering of course.

On 26/03/18 14:29, Kieran Bingham wrote:
> When a BRx is provided by a pipeline, the WPF must determine the master
> layer. Currently the condition to check this identifies pipe->bru ||
> pipe->num_inputs > 1.
> 
> The code then moves on to dereference pipe->bru, thus the check fails
> static analysers on the possibility that pipe->num_inputs could be
> greater than 1 without pipe->bru being set.
> 
> The reality is that the pipeline must have a BRx to support more than
> one input, thus this could never cause a fault - however it also
> identifies that the num_inputs > 1 check is redundant.
> 
> Remove the redundant check - and always configure the master layer
> appropriately when we have a BRx configured in our pipeline.
> 
> Fixes: 6134148f6098 ("v4l: vsp1: Add support for the BRS entity")
> Cc: stable@vger.kernel.org
> 
> Suggested-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

And thus:

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>


> ---
>  drivers/media/platform/vsp1/vsp1_wpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c b/drivers/media/platform/vsp1/vsp1_wpf.c
> index f7f3b4b2c2de..8bd6b2f1af15 100644
> --- a/drivers/media/platform/vsp1/vsp1_wpf.c
> +++ b/drivers/media/platform/vsp1/vsp1_wpf.c
> @@ -452,7 +452,7 @@ static void wpf_configure(struct vsp1_entity *entity,
>  			: VI6_WPF_SRCRPF_RPF_ACT_SUB(input->entity.index);
>  	}
>  
> -	if (pipe->bru || pipe->num_inputs > 1)
> +	if (pipe->bru)
>  		srcrpf |= pipe->bru->type == VSP1_ENTITY_BRU
>  			? VI6_WPF_SRCRPF_VIRACT_MST
>  			: VI6_WPF_SRCRPF_VIRACT2_MST;
> 
