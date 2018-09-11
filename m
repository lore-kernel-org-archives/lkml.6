Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D60C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8949D206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 20:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KcOXaMOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8949D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeILB7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 21:59:24 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34565 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbeILB7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 21:59:24 -0400
Received: by mail-yb1-f196.google.com with SMTP id t10-v6so9915503ybb.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 13:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kTuy8XklDHHcbvh/JEhUxgm0szoY/mkybHB6eGIaP1w=;
        b=KcOXaMOyqkL/46gwwxIkMOMUsm8xnC8HNpcxiahQJF4LKtKtZKZ6L3bPE5M5JwtESi
         62fa7ivj3TPANvGmYgAcRS6e/4zIh7BZyGTwn9tj5M2HQz4n79UW3ZU2IwV484vjBtdX
         LpstCXGCzraCX102x4wmBF+hBDVOduGDK0JFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kTuy8XklDHHcbvh/JEhUxgm0szoY/mkybHB6eGIaP1w=;
        b=JQNSslsC0bY8uvoPniHYZEdS+ykGuRgHCb5WwHUmeVphCMzf0aPkT+ZW7Isbum7/0b
         XHnPWMZ+ANhRTgHpNxH/TNQEWTNLT8XsZ1U+eZ7PeKDxOpIbx+yG7uz4AEEJsZnD8+by
         Jk0oHcjav28xEjNvbmkxxwordkfeTyGE5BtBBHKyopxsleeZ+in5G+6xkGdgcooRXOIE
         94TRrTe1R3kYdZW5mE/2BOs75C09lSf0m8k/sH3oAuur1bvhnEtNrrYvpDBsLVYLYas/
         N+ByCgKxAYcYYEN/3zK2LGSHyQYTcm7N2dtHh+Ul3Hx8PSg6FS2QCgL8Qe2TARNzPiQ2
         LSNw==
X-Gm-Message-State: APzg51AxPpjIldXUOQsS/5eTPTJhHZ/vszH2hEoC976Sa1nz1kqx0eMO
        8uP7aZB4rkQSzBC2DkjWm98vPMy7xaXrxh1uqLg51g==
X-Google-Smtp-Source: ANB0VdZn4RrQ5BxEhGvkZb9w1dhwTgTc0+6tlgfS1bucI0IoY9F5HMDFiP5uNuKmKc4ullp+g0O038jBhaM/iKZAvf8=
X-Received: by 2002:a25:e014:: with SMTP id x20-v6mr13741321ybg.46.1536699498581;
 Tue, 11 Sep 2018 13:58:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5d0e:0:0:0:0:0 with HTTP; Tue, 11 Sep 2018 13:58:17
 -0700 (PDT)
In-Reply-To: <1536696866.3024.151.camel@codethink.co.uk>
References: <20180823074918.641878835@linuxfoundation.org> <20180823074922.442947994@linuxfoundation.org>
 <1536696866.3024.151.camel@codethink.co.uk>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Tue, 11 Sep 2018 13:58:17 -0700
Message-ID: <CACKFLinHTVrapMyU=OLcb+MS0RFxS69eHfRjirYvB2mi8Pkf0A@mail.gmail.com>
Subject: Re: [PATCH 4.4 51/79] bnxt_en: Fix for system hang if request_irq fails
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Vikas Gupta <vikas.gupta@broadcom.com>, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 1:14 PM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Vikas Gupta <vikas.gupta@broadcom.com>
>>
>> [ Upstream commit c58387ab1614f6d7fb9e244f214b61e7631421fc ]
>>
>> Fix bug in the error code path when bnxt_request_irq() returns failure.
>> bnxt_disable_napi() should not be called in this error path because
>> NAPI has not been enabled yet.
> [...]
>> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
>> @@ -4591,7 +4591,7 @@ static int __bnxt_open_nic(struct bnxt *
>>               rc = bnxt_request_irq(bp);
>>               if (rc) {
>>                       netdev_err(bp->dev, "bnxt_request_irq err: %x\n", rc);
>> -                     goto open_err;
>> +                     goto open_err_irq;
>>               }
>>       }
>>
>> @@ -4629,6 +4629,8 @@ static int __bnxt_open_nic(struct bnxt *
>>
>>  open_err:
>>       bnxt_disable_napi(bp);
>> +
>> +open_err_irq:
>>       bnxt_del_napi(bp);
>
> Shouldn't this added statement be conditional on irq_re_init?
>

Unconditional call is more correct, because when open fails, we clean
up everything, including the NAPI that was added just now or during a
previous call.

In other words, the NAPI struct is always valid here whether
irq_re_init is true or not.  And we always delete it if open fails.

Thanks.
