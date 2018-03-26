Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1535057-1522084920-2-3132581891444456862
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522084920; b=OhOoSX4jX51Wgd/ayExgcRR9GC0gAR1nuEgcsh2ERj9sGZE
    krFqUSMdN5sYDYPY75kA4Me785TKnZ3uOClP8KoX1ic9E2JLZ+0lanx04MZpgh8b
    JzFiW49OIh0aVNIXVjxUlcqwAeyYzjZyFyGRyqxvP8ESuQKxKPK+Ujt6871Ky826
    jGAylAiNF0Zfu6V8q7hWh1MbNtuYc1bbonJPjpy9C/1SiceYCxb50UQV6mqiQzAM
    o1wdZxEDDckfwEHVPzKkoiGZggIbKPUw+4OWyJZupYb8YHt1XHvlogE7fOvXCCOu
    yJuhJ5tu20+KfTqXMKOOIP3mcDpShILVZ0xpE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=arctest; t=1522084920; bh=amMa3+
    CfcHDxMVMfxJDoPZ4e7dhdPZ8g8K7qDSX4FtM=; b=aGj9HWgCw5f0ewg2gHClmP
    u1b4RsHKQiaB21elofCvj+Aeh/wnxjZvOphb5EpeXGv22kAY6Hy/gnF+J9ciD7qc
    HR5yHTBFW2RfYeDpbvfz5quL7sQDmCAq7e54DmEoKmz/6r8/b/zHkWzo/ZI3Fiyh
    GrnAT+UaILQf7lZzTojZSEJNUoGrc3t2F27TEssyYzSEHp8LgsUAlaKDPmNAXikK
    Yn/zBDFTjpYAznyGqDUorazWePyjgHzI6Gb1mpLkJ/vcvm2pYAnqvAsHue6ajiZ7
    uWbxINXJyer5cEespsH6P2XMfxexZUJ5S/7JSzaDvqo7kN9PHJLhN0Kwxglt+VPQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HX0HsQGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HX0HsQGh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ideasonboard.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ideasonboard.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNp1jDXcVgNitmcJgbFxFCohQwFO5BppVYSlcuRfigo1tjKMd06ZTbcKpUslVEZVcE6ug5TOMsaMxLqN6CharoD//dvBckcbIUe50sD6LdoTIb+Bi9A5
    ra3OQ/WrE67GXE2b8QwKhVjYXJfIXvp12zSeJbzYqjodIQiSD3X6f3S2c8e1J5CwBsDbU4GApZBv7atoqdAs4731CrjK0DwlMs5fAp4SPJDODMM+KlLrWHuk
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=VwQbUJbxAAAA:8 a=vQBBkBfzAAAA:8 a=P1BnusSwAAAA:8 a=AQcr3GvUVwXfdORfiuQA:9
    a=6efwp_RYYg-SUnx-:21 a=IzuzDNCXhkGyoJTD:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=NGXS0kB0m_rannUenejW:22 a=D0XLA9XvdZm18NrgonBM:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752131AbeCZRV4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 13:21:56 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:44549 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751964AbeCZRVz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 13:21:55 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        stable@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] media: vsp1: Fix BRx conditional path in WPF
Date: Mon, 26 Mar 2018 20:21:51 +0300
Message-ID: <3524048.Iptq6jntDe@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1522070958-24295-1-git-send-email-kieran.bingham@ideasonboard.com>
References: <1522070958-24295-1-git-send-email-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Kieran,

Thank you for the patch.

On Monday, 26 March 2018 16:29:17 EEST Kieran Bingham wrote:
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

Looking at commit 5d0beeec59e303c76160ddd67fa73dcfc5d76de0 I think your patch 
is correct.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and taken in my tree.

> ---
>  drivers/media/platform/vsp1/vsp1_wpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_wpf.c
> b/drivers/media/platform/vsp1/vsp1_wpf.c index f7f3b4b2c2de..8bd6b2f1af15
> 100644
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

-- 
Regards,

Laurent Pinchart
