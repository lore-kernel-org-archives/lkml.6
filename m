Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5299C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2124CAF
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uF92bh4J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BD2124CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753264AbeGCMHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:07:24 -0400
Received: from mail-pf0-f178.google.com ([209.85.192.178]:46727 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbeGCMHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:07:23 -0400
Received: by mail-pf0-f178.google.com with SMTP id l123-v6so920493pfl.13;
        Tue, 03 Jul 2018 05:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DHZHPl+Flxzdn5h3HGD3iDrUgdBkCiqlsFFOBU5oAso=;
        b=uF92bh4JMrm9STN7qAzW73HgtNuckVqBHtEwNfhTP2IOCbEddFHh7g12MkDUtfhi+b
         2C0bilcsDcyp4WEkCdfB2DJtT3ICYglnZYYPv3fviUJEcRCcGXoVvXQfi7WPvQQ+C6Sd
         Nmm54exZ0lONfAdFIX5KlM74YZLE0DAyJxyugwXKJdKl99x9Rpuvuj2sFqltKrAOqpaS
         So2QhCV0pF14v7jE4ED/7PtRqvcZUg39TEfxMpe+VTNwVGgQtxUmJmUE1wsxw0mt1/Oj
         8O1ysFZxbo5imsdnlHyRiDrMEq5KQAdPwvnUToNj4hdy1pP/IqC+MW3INekfqbXlJBpD
         Zpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DHZHPl+Flxzdn5h3HGD3iDrUgdBkCiqlsFFOBU5oAso=;
        b=l+QQW8PU/PGQ1exhLPpSg2fbPfWuJ1hZ9tZJJhfqaKGMqsn/fIuV2JY+zdkaPiqYDo
         xiAqpeP89iIWEOQzLMe+sXfYCJokWEILF5AhFT5CURocFQs5mbohGjadTkYTAI4LvObU
         6y8HZYcp+00zdEeluhrnG6Ye7+fJoL1m8d33lUQMopXBOGxM0JXjGOQL3WqcZ8GlSSiF
         19cgDMl1d7p/aDLHhu8AK84VJP5ZzQf2X1+dnB4hsSNev9lG8c78EX741I4lOtMzD+G4
         6T83PfOy/DjIj1IqxxYxss7qP5DuiEpt6znjKcRu3R/HLFyAR+3fOWo6A85tbSQW3T7l
         aIJQ==
X-Gm-Message-State: APt69E14bvJF6eFAavklaykTD4fu3RzmlOx3rMuZZqx0ga2i3/XRa6A2
        XIOXr1c9KCHxqskHuvr9iTDPYg==
X-Google-Smtp-Source: AAOMgpckhSEbfPUzoI6KEOyq0Xwy/VTnNo2y7DbfReptPvlz4V91xaiNDy/Ik2BkjbGUHo09axxwRA==
X-Received: by 2002:a62:9d14:: with SMTP id i20-v6mr2160736pfd.3.1530619641460;
        Tue, 03 Jul 2018 05:07:21 -0700 (PDT)
Received: from [192.168.3.4] (softbank219203027033.bbtec.net. [219.203.27.33])
        by smtp.gmail.com with ESMTPSA id d65-v6sm2503234pfj.20.2018.07.03.05.07.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 05:07:20 -0700 (PDT)
Subject: Re: media: dvb-usb-v2/gl861: ensure USB message buffers DMA'able
To:     Colin Ian King <colin.king@canonical.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-media@vger.kernel.org, Antti Palosaari <crope@iki.fi>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <8308d9f0-2257-101c-69e3-8fe165de9348@canonical.com>
From:   Akihiro TSUKADA <tskd08@gmail.com>
Message-ID: <d2465376-4b3e-7d3d-86d2-0cd8d7543520@gmail.com>
Date:   Tue, 3 Jul 2018 21:07:07 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8308d9f0-2257-101c-69e3-8fe165de9348@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
thanks for the report.

>  47        buf = NULL;
> 
> Condition rlen > 0, taking false branch.
> 
>  48        if (rlen > 0) {
>  49                buf = kmalloc(rlen, GFP_KERNEL);
>  50                if (!buf)
>  51                        return -ENOMEM;
>  52        }
> 
>  53        usleep_range(1000, 2000); /* avoid I2C errors */
>  54
>    CID 1470241 (#1 of 1): Explicit null dereferenced (FORWARD_NULL).
> var_deref_model: Passing null pointer buf to usb_control_msg, which
> dereferences it.
> 
>  55        ret = usb_control_msg(d->udev, usb_rcvctrlpipe(d->udev, 0),
> req, type,
>  56                              value, index, buf, rlen, 2000);
> 
> 
> The assignment of buf = NULL means a null buffer is passed down the usb
> control message stack until it eventually gets dereferenced. This only
> occurs when rlen <= 0.   I was unsure how to fix this for the case when
> rlen <= 0, so I am flagging this up as an issue that needs fixing.
> 

Since rlen is an u16, null pointer is passed only when rlen == 0,
so I think it is not a problem,
but I am OK to add a guard in order to make scan result clean.

regards,
Akihiro
