Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEB1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E4C122419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="dJcvfXJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4C122419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbeKOCCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:02:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37458 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeKOCCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:02:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so11880653lfh.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c5JfBxzp9az2uxJ9RXohbPHR6RdANOh1MqdOEh7A32Q=;
        b=dJcvfXJP6d07LScZFlH/MoMzroU1CgV8GoxpK+u6qbfA/jHctXw4Gtn8irojJk1OPW
         kQKlGHujWxcmMMWDuAcgFee41tEnYX0xo2Qfg3MHc/tG6mOa3R/XFWFmRfdp5iPGsIFg
         CAW4pmAVlkW1w9ChDZi28KimJAkBPfG/1cl9uvg8tAtPYObWp9YbnrxpDAeyhNUN/l1m
         V7J7eTxlMRBoxVueB+qGhDQjlOS0Qgm1motYjNwyfMGOtV44WAX5P2kTN0npzgt74EPZ
         MsSaHolmXtAgZleFS6GanzcorqJPlwH1yzDlMx4f/M78Gd6RKEA3jBZBFVk+cDC/ShW8
         h/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c5JfBxzp9az2uxJ9RXohbPHR6RdANOh1MqdOEh7A32Q=;
        b=G8Ingl4hAutH6i6Pfpj9xIo9+38q+BTpvk2Adm4EeLwQgKsAKwh4e3Yl2VCQJ6V8EU
         n/FpwwkVtp8t/5z3CsIISIhHHQnNb4lsMxkXyu5R7KskJup4xM3qLfi7G2XhQwCEcKWs
         HeTLrON6hx3HLox3VkonussrBDEQxQXvSzCP43Jm28tmnVuHlWg01pmbQcZT88gz7ELI
         nkfG3u7xW6UJrI4B7ARaDQGkRBt2zI8xvNr169SRFerK94iQ3r8SfjPtO3MkhKntAjUx
         0jsIkW/qAlVLAYi7xPE03DW5Zl9W2aR69GzD+zoUJBFWf2n7SgppftGe7CQRUFqqbtfg
         jYVQ==
X-Gm-Message-State: AGRZ1gL939oGPhTKFvSbib2oC4n/ML7VLE3aEIpLeFIj/aWKpMHnmJj3
        VXh/F0f2paqJ04SL2Slp2JHj3w==
X-Google-Smtp-Source: AJdET5eMGZAfM3Cr5D3oSQmM6ZWn4L7XYw+oYNT9f86W3XpN32CbVhEziDXQgQkO4KrrD/3RNFLYnw==
X-Received: by 2002:a19:d04f:: with SMTP id h76mr1336693lfg.52.1542211143941;
        Wed, 14 Nov 2018 07:59:03 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.86.84])
        by smtp.gmail.com with ESMTPSA id b81-v6sm1120776ljb.7.2018.11.14.07.59.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:59:03 -0800 (PST)
Subject: Re: [PATCH 4/4] usbnet: smsc95xx: check for csum being in last four
 bytes
To:     Ben Dooks <ben.dooks@codethink.co.uk>, netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, steve.glendinning@shawell.net,
        linux-kernel@lists.codethink.co.uk
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
 <20181114115022.9584-5-ben.dooks@codethink.co.uk>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <8b5a1bc6-c762-0e50-c602-fe4a9876d246@cogentembedded.com>
Date:   Wed, 14 Nov 2018 18:59:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181114115022.9584-5-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2018 02:50 PM, Ben Dooks wrote:

> The manual states that the checksum cannot lie in the last DWORD of the
> transmission, so add a basic check for this and fall back to software
> checksumming the packet.
> 
> This only seems to trigger for ACK packets with no options or data to
> return to the other end, and the use of the tx-alignment option makes
> it more likely to happen.
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Fixes for v2:
> - Fix spelling of check at Sergei's suggestion
> - Move skb->len check into smsc95xx_can_tx_checksum()
> - Change name of smsc95xx_can_checksum to explicitly say it is tx-csum
> ---
>  drivers/net/usb/smsc95xx.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index 8f7c473f3260..cc78ef78cc93 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -1997,6 +1997,23 @@ static u32 smsc95xx_calc_csum_preamble(struct sk_buff *skb)
>  	return (high_16 << 16) | low_16;
>  }
>  
> +/* The TX CSUM won't work if the checksum lies in the last 4 bytes of the
> + * transmission. This is fairly unlikely, only seems to trigger with some
> + * short TCP ACK packets sent.
> + *
> + * Note, this calculation should probably check for the alignment of the
> + * data as well, but a straight check for csum being in the last four bytes
> + * of the packet should be ok for now.
> +*/

   Missed a space before */. 

[...]

MBR, Sergei
