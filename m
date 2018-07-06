Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 406CBC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE87122AE3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 20:57:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mvista-com.20150623.gappssmtp.com header.i=@mvista-com.20150623.gappssmtp.com header.b="mmF91Ew9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE87122AE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mvista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934492AbeGFU5y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 16:57:54 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:41120 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933982AbeGFU5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 16:57:52 -0400
Received: by mail-pf0-f193.google.com with SMTP id c21-v6so4700448pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 13:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Un01gk2Hny7DhiKbRjcAvlZZIcMfK0c/ZmkQOm+vsNc=;
        b=mmF91Ew9On3pi0wIXJXV2k6vexj9po+yL98n+Be0WLv+lVbgMzV/67BuabHkc2t3Bp
         dgJ1cZzjNAk8bG9rXbH0cvROaOV2LCYPncCjmLr83WsRSAH0kffKWYJVOtjD71Dx2/4H
         nmgW7IWLze43d6l2LSizzEmtVJQKoaH1Spj5WeQlfMNo58kY3IOyvJvJ9za6J4vTpvfp
         Mi8NWqcnebPva6GNq0/lSu3G2ZVfgt9lh0knf6PUtTON1Cnp+dFt3PuhaPzcjA0s0CNh
         IlLflP9U15N0pkM0C6oItP1UzFOSEyjuNHT55MnbusjKQ4DyL2YB6yU9D3FANmNDCY96
         lgBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Un01gk2Hny7DhiKbRjcAvlZZIcMfK0c/ZmkQOm+vsNc=;
        b=NHdzFOmySWhz/1zy6m3wnXDoiWQf8fDfKjb6P6N0P5kwByzjknGw891cfFp1qWNwDR
         w29WacVvxRwpyuczZGKdjc/R5yT+xeLoFvmN8vTsdok6josYeQV3V5ttbI6vTsH+sYXU
         wf//o+3kt1uNXid+sycOL0vwM8jQnqKUc6aoB17NjCPb3Lj//dY2g79wIVU8Xpxpn5YQ
         wgvUf2gu8F4Iy9LPNrwbfE13XpbR/O0qRpeJvGRekfmmxhPdeRFZOW+LC1kEPAd8YBuZ
         d266GRtE3N5nqiiZerZQxQGhiKm0l0tHZEbht22mZmW6VHidFWLjHwuG0cQGrYwmJAo+
         vCpQ==
X-Gm-Message-State: APt69E03Bm7pUF/MNj3WYqmdXNkWKyueACotrmgTyTCLQWMTjZV8feN/
        paq7MSiLkEi9KJtLtoTp/1g8KrcN124=
X-Google-Smtp-Source: AAOMgpdwUnVgKf1P+2x8fBeNECXEPdTKPnedB4Szu1T1TG+Xi6lrwaQvUqphaDokOoALw6SnzutU/Q==
X-Received: by 2002:a62:1894:: with SMTP id 142-v6mr11405021pfy.49.1530895925230;
        Fri, 06 Jul 2018 09:52:05 -0700 (PDT)
Received: from [192.168.27.3] ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id y14-v6sm15142143pgo.22.2018.07.06.09.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 09:52:04 -0700 (PDT)
Subject: Re: [PATCH] ipmi: update ssif max_xmit_msg_size limit for multi-part
 messages
To:     Kamlakant Patel <kamlakant.patel@cavium.com>
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1530784849-3376-1-git-send-email-kamlakant.patel@cavium.com>
From:   Corey Minyard <cminyard@mvista.com>
Message-ID: <c457c4c4-7ed4-e465-54b6-68151ea04f0b@mvista.com>
Date:   Fri, 6 Jul 2018 11:52:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530784849-3376-1-git-send-email-kamlakant.patel@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2018 05:00 AM, Kamlakant Patel wrote:
> There is an issue with Host name Write command with payload size of 132 bytes.
> Currently ipmi driver limits max_xmit_msg_size to 63 bytes. Due to this
> all IPMI commands with request size more than 63 bytes will not work.
> This is seen with AMI OEM Host Name write command: payload 132 bytes.
> When a DNS host name set is tried from host through SSIF interface, the name
> gets truncated due to ipmi_ssif driver limiting the length to 63 bytes
>
> As per IPMI Spec v2.0 section 12.3:
> The maximum message size returned by the Get SSIF Interface Capabilities command
> is 255 bytes.
>
> This patch updates the max_xmit_msg_size to 255 in case SSIF_MULTI_n_PART.

Umm, did you read that monstrous comment just above that code?  It's 
there for a reason.

The specification is very strange here.  If you read it carefully, you 
will be confused.

In the 3rd paragraph of section 12.3, it says:

    The combination of a Start transaction followed by an End
    transaction can transfer up
    to 63 bytes of IPMI message.  The Middle transaction is available
    when there is a need
    to transfer an IPMI message of greater than 63 bytes.

If you read on, in a multi-part message, the first part must carry 32 
bytes.  All
intermediate ("middle") parts must carry 32 bytes.  It says the end part
can carry 1-32 bytes, but not zero bytes.  This is a typo, though. You 
will discover
that the end part can be 1-31 bytes, not 32 bytes, because the end
part is marked by the length being less than 32 bytes (even though it
doesn't explicitly say this any place).  If you look at Table 12-3 "BMC 
Multi-part Write
Middle" and Table 12-4 "BMC Multi-part Write End" they are exactly the same
except that the length in 12-4 is not =20h.  Thus the 63 bytes maximum for
two parts.

That means that you *cannot* send a 64-byte message.  If you have to 
have a middle
transaction to carry >63 bytes of data, and the first and middle must be 
32 bytes, and
the end cannot be zero bytes or 32 bytes, you are stuck.

Then at the end it mockingly says:

    Software that uses the Middle transaction should take care to
    correctly handle the
    cases where the number of IPMI message bytes is an exact multiple of 32.

It then gives no clue about what to do in this case.

So I cannot take this change unless I know what should really be done 
here.  I'm
pretty sure the middle part handling code is broken if you allow >63 
byte messages,
too, so it will take more than just this change.  I believe the current 
code will send
a zero-byte end message in that case.

-corey

>
> Signee-off-by: Kamlakant Patel <kamlakant.patel@cavium.com>
> ---
>   drivers/char/ipmi/ipmi_ssif.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 18e4650..2bf6f07 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -88,6 +88,8 @@
>   #define SSIF_MSG_JIFFIES	((SSIF_MSG_USEC * 1000) / TICK_NSEC)
>   #define SSIF_MSG_PART_JIFFIES	((SSIF_MSG_PART_USEC * 1000) / TICK_NSEC)
>   
> +#define SSIF_MAX_MSG_LENGTH	255
> +
>   enum ssif_intf_state {
>   	SSIF_NORMAL,
>   	SSIF_GETTING_FLAGS,
> @@ -1500,8 +1502,8 @@ static int ssif_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   			 * to be 1-31 bytes in length.  Not ideal, but
>   			 * it should work.
>   			 */
> -			if (ssif_info->max_xmit_msg_size > 63)
> -				ssif_info->max_xmit_msg_size = 63;
> +			if (ssif_info->max_xmit_msg_size > SSIF_MAX_MSG_LENGTH)
> +				ssif_info->max_xmit_msg_size = SSIF_MAX_MSG_LENGTH;
>   			break;
>   
>   		default:


