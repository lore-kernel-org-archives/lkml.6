Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C733C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581E8206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o73nGn6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfAGTGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:06:30 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39522 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfAGTGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:06:30 -0500
Received: by mail-yw1-f67.google.com with SMTP id k188so571142ywa.6;
        Mon, 07 Jan 2019 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=04pCrhV2KjxhIifXR0i5qCxX1wmwKVyNRRz4olCBkOg=;
        b=o73nGn6arm6KYWiYjy+aZuINXk61XWfeQrgy3rqwTuA62RLS2B0mW0zpfHY0z0ZUSo
         h9i1nLLeK6Ymr1AdhPOnaCixB8+VCK3oWfepQnUVL/onveWs+nIVGk8x38AqNKgnXcF+
         UkZG8Ft6IqUbWcL7B5k7CBRoYxIYHOjazoZjTFUi9pK4ODAzWkw8ZYxHWtA9/QkMSuri
         ubAeMXCmKDJAVtgLaDrfIl/lJAl3AVlJlbIn4UpgltsSIS7ioG71UZrrHAvHYjkmApSo
         VBKc5n+eKMYhCMh5OuBGaamsO4Yask1i78AlW0FW3hwi3kekgiFxioTYTmqkq6cu6ZBn
         5yAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=04pCrhV2KjxhIifXR0i5qCxX1wmwKVyNRRz4olCBkOg=;
        b=HrLijNv9jNiTCzJZdGTAyqDpn+Z9kVmrbVQTrX+c3ptmG+ZjLG4SomSXpYXqnsGJIQ
         AzbyZFZnR+uHDOTqgHsks06vTI3wQ4BsaXmByQGhG6iZbhjBbxT75fYg+iXfxpHUWpmi
         HgJZnqWcvR67yukgV/GNYkRFtZN3oICOcNK9wndLKhJe9ZRcMotMGcpQfEpLntwEUg6n
         OXk0hPH5QjrbZP8O9hBlBspbhR6h5fUFYgSH83j34xwx61vd1gvaOm0AcFQcwaXD37+i
         6cF1Xj+hvICBcACPlvd7atCVyEOYv3b7oJWmSnrgev4LLZirpxZfIuM27dJ8RfNiAMbw
         /puQ==
X-Gm-Message-State: AA+aEWbQ5mDPvoB8MR19kW2pZPwjIrb6zieEC+2j1wASeHEJ5ivdP5JD
        xGqpk3ygdGFOiaGOppoLeGzwF6xg
X-Google-Smtp-Source: AFSGD/UKbZcIFV62qEJVyOt2ylM7CHpqfGkOobhDWVxKwqPxuF++Ht9lycQvG1MUamMILdL1A3U7lw==
X-Received: by 2002:a81:e408:: with SMTP id r8mr63389040ywl.367.1546887989150;
        Mon, 07 Jan 2019 11:06:29 -0800 (PST)
Received: from [192.168.1.138] (cpe-24-160-118-96.tampabay.res.rr.com. [24.160.118.96])
        by smtp.gmail.com with ESMTPSA id o14sm34371083ywo.52.2019.01.07.11.06.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 11:06:28 -0800 (PST)
Subject: Re: Consistent capitalization of "device tree"?
To:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, corbet@lwn.net,
        linux-doc@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
References: <20190107183711.GA5671@amd>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <91bc4723-8e3a-4ed6-5104-36a614d6a6d2@gmail.com>
Date:   Mon, 7 Jan 2019 11:06:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190107183711.GA5671@amd>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+ Frank

On 1/7/19 10:37 AM, Pavel Machek wrote:
> Is it "Device Tree" or "device tree"?
>     
>  pavel@duo:/data/l/k/Documentation$ grep -r "Device Tree"  | wc -l
>  235
>  pavel@duo:/data/l/k/Documentation$ grep -r "device tree"  | wc -l
>  595
>     
> I guess it would be nice to make it consistent. I guess "device tree"
> is preffered?
> 
> Should we do something like this?
> 								Pavel
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>     
> diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
> index 725fb8d..cc5f507 100644
> --- a/Documentation/devicetree/overlay-notes.txt
> +++ b/Documentation/devicetree/overlay-notes.txt
> @@ -8,7 +8,7 @@ companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
>  How overlays work
>  -----------------
>  
> -A Device Tree's overlay purpose is to modify the kernel's live tree, and
> +A device tree's overlay purpose is to modify the kernel's live tree, and
>  have the modification affecting the state of the kernel in a way that
>  is reflecting the changes.
>  Since the kernel mainly deals with devices, any new device node that result
> 

Not a strong opinion, but I would prefer a third option of devicetree.  That
makes it much easier to search for.

-Frank
