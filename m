Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284D4C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6BB22086E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 06:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M91yGIZt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BB22086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJKOFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 10:05:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40447 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbeJKOFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 10:05:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id r83-v6so7142460ljr.7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xAq3G/WOP98XSdOvHrnhfLRJqC5LZ6aJD5T0CJKf6Nw=;
        b=M91yGIZtXQou1PO657igXWrv82p/L79UBuEpVi1pbDwUUONY/bjH0SJpRui5QAxfpf
         66ipKgDWP32NTSPhn/B1m/y7IO6FB1P4jfRA/blzII++TqVMxR+Dt+VL2KrEYund1Cnv
         YvOAvxSfQrgLjeQYm3ZmwtUk7K31yeQj+Es/uQSJlK0Xa4vCjefQssbFIDCkqNlrgGhC
         3X7j7UyfhTz9qDTmgR2r3eED5WkxbYGymxJ0mZoBmEym8cK+hJLKLD7Ee1N0XDjyzW5N
         mXEgmVA53hf5ulnrCkMTV7H+40W+0Jnr8cX1YX5Nf/7UsQUwEkR8gSmjU8wEfvGy1dAc
         ajmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=xAq3G/WOP98XSdOvHrnhfLRJqC5LZ6aJD5T0CJKf6Nw=;
        b=QNUnn/SolFYjyyLO+ZErtd/TWNwV1phB5NDKopFZ0FrOyfl3dvnOjwjSknYfQkSwjk
         OCDe5fW6nGTKh5TQC1vEGXj4U4B3sexE/baDHJk/C1MpkaJM5p1SXILaszio7PdmOWvP
         BRItnIVrrlEUZ1Nyi6/a7hHMQyCttXD1FoErk5eU4LNi0ISHAe8oizEs3hrI3MrGkcPk
         CHc+gaIqb8+hy9R6RYqF8rgDmvkxXz7S5HFuqPxVSaY1Wb5qIM/nyG+bOG97p3/7YxPt
         JfyOf/+C5ciqyB6XWLrNPpBEMt2YeNiCIm07eLvYlOHdMdDLXWPR7tlRGIUF4fhW5zli
         qkFQ==
X-Gm-Message-State: ABuFfoi8oaMH9ga3y37y0B1FlIpQWAIbONjyQNODI2Mdcg9hnreXbl2y
        7AIrF4nL3Zd87qWpGL1PU3WZL/sM
X-Google-Smtp-Source: ACcGV628Za4ZXJBvFDh9IFGMb5WzghBFthrjjjO0L+PwINAiw8TX7fJYLN40ig3mkwL/5Qwh8fQfkA==
X-Received: by 2002:a2e:638d:: with SMTP id s13-v6mr219097lje.117.1539239988747;
        Wed, 10 Oct 2018 23:39:48 -0700 (PDT)
Received: from [192.168.1.111] (91-157-235-206.elisa-laajakaista.fi. [91.157.235.206])
        by smtp.googlemail.com with ESMTPSA id 71-v6sm6052094lja.90.2018.10.10.23.39.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 23:39:46 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] code of conduct fixes
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        ksummit-discuss@lists.linuxfoundation.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
References: <1539202053.12644.8.camel@HansenPartnership.com>
From:   Tomi Valkeinen <tomi.valkeinen@iki.fi>
Openpgp: preference=signencrypt
Autocrypt: addr=tomi.valkeinen@iki.fi; prefer-encrypt=mutual; keydata=
 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
 QChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
Message-ID: <6b0d5ad6-c76b-8dbf-bd74-de352280e780@iki.fi>
Date:   Thu, 11 Oct 2018 09:39:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1539202053.12644.8.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 23:07, James Bottomley wrote:
> Resend to show accumulated tags and also to add a third patch listing
> the TAB as the reporting point as a few people seem to want.  If it
> gets the same level of support, I'll send it in with the other two.
> 
> ---
> 
> Previous cover letter:
> 
> 
> We've had several threads discussing potential changes to the code of
> conduct but Mauro is the only person to have proposed an actual patch. 
> In order to move the debate on, I'm presenting two patches, one to fix
> the email problem Mauro identified and the other to strip the
> enforcement section pending community discussion as Shuah suggested.
> 
> I'll take responsibility for collecting any tags people want to add
> (review/ack/sign off, etc) and sending the patch in as a signed pull
> request before 4.19 final if they get enough community support.
> 
> Note, I've sent both patches in as a series to facilitate review and
> discussion, but they are separable if one is looked on with less favour
> than the other.
> 
> It was also a bit unclear which list to send this to, but I finally
> settled on linux-kernel as the catch all and ksummit-discuss since
> that's where most of the current discussion is.  I can add other lists
> as people suggest them.
> 
> James
> 
> ---
> 
> James Bottomley (3):
>   code-of-conduct: Fix the ambiguity about collecting email addresses
>   code-of-conduct: Strip the enforcement paragraph pending community
>     discussion
>   code-of-conduct: Add back the TAB as the central reporting point
> 
>  Documentation/process/code-of-conduct.rst | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 

For the three patches (preferably with Alan's "except where required by
law"):

Acked-by: Tomi Valkeinen <tomi.valkeinen@iki.fi>

Although I think reverting 8a104f8b5867c682 is the best option.

 Tomi
