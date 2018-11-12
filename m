Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8399CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B461223B0
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="XY6bS+yA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B461223B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbeKMFif (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:38:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35943 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeKMFif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:38:35 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so14983851itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 11:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+KxY+S0jycbW7OSNzNygypb+pb2oM12h8IJb6Ejoiw=;
        b=XY6bS+yAdXv10NHFCXkutbnLwoIGztEDe4bLXYdV2XXOI2lMKNvIIvMD50b71xDDPz
         6EqbHr1Ko5Zij+5p0YvHlivbNDQ4a/bA/8LnGs/dAQNBVhtz4Z3R3hSo3ZqGCJ1276hb
         qZfAsrfAxCERqj9UNIPjqF1J3Mqkwg7274emzK4iRRuGrDvQf+D962P282Hq3H3qtaLK
         LMTutigTSIsjy9VM45T/bkrVKR4T24xpkMTsjozDOSsyws3ScnvYRT6wtlZVTUQnmH/S
         eCE1kP+NaUeL2MAcvJ3QMfQ/ewsY7OI4IGRo8VV6cLrkmkG8So+HCGqlhLYTLcJyExR2
         EqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+KxY+S0jycbW7OSNzNygypb+pb2oM12h8IJb6Ejoiw=;
        b=JrLR4ewDD/XPMJJkUNPMcSwi0btRyn+d1POQosTiZZGkB6lrX4dMRkivHwCTKLq6oP
         5YQ5gIWCWoIVoPQg2lstOFlFp3TeFsHfoHmYITLJEibtb3HR5ueZtfD+Z8rmsCB24j0I
         B+rIb5R+ZPkZhvP/m106j2KYobw90eqDjfKyq15Ycom0tPwvldFhgH3659r/K1tTPQvR
         t+NVTeteHc7GVaKCMkQB8wA34jMEwlB4eMjIlHUqsskPJXV8NYjWX4DacmL++7nHos9D
         fwi7bp8RsZbp2pYfJAGteoZufmXcwZSnymkfiKcdvhcNjobDZH9ZmwdyZ9ND+9klUbgX
         V8mg==
X-Gm-Message-State: AGRZ1gLAOSvJu2gzEp+ZJcNW8b05XKZxpRMvsyAoHhflVC7fNge+MiIk
        NwaYp2CeUg2nEqgVWSTOkbJt+A==
X-Google-Smtp-Source: AJdET5dUUOS0ZTg05VyI1vUtQ9GCdsUR943rw/TcYGdYKz1Zm4WIr3w89QB/UqwDkFJTMJJEwM7fTQ==
X-Received: by 2002:a24:52ce:: with SMTP id d197-v6mr995851itb.151.1542051834549;
        Mon, 12 Nov 2018 11:43:54 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 201-v6sm5397831itm.2.2018.11.12.11.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 11:43:53 -0800 (PST)
Subject: Re: [PATCH RESEND] Blacklist SAMSUNG MZ7TD256HAFV-000L9 SSD
To:     Greg KH <gregkh@linuxfoundation.org>,
        Diego Viola <diego.viola@gmail.com>
Cc:     hdegoede@redhat.com, tj@kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20181112192252.3911-1-diego.viola@gmail.com>
 <20181112194201.GA2849@kroah.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da949e5a-f951-2a5a-4fa4-ab09181d5341@kernel.dk>
Date:   Mon, 12 Nov 2018 12:43:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181112194201.GA2849@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 12:42 PM, Greg KH wrote:
> On Mon, Nov 12, 2018 at 05:22:52PM -0200, Diego Viola wrote:
>> med_power_with_dipm still causes freezes after updating the firmware to
>> the latest version (DXT04L5Q).
>>
>> Set model_rev to NULL and blacklist the device.
>>
>> Signed-off-by: Diego Viola <diego.viola@gmail.com>
>> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/ata/libata-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>

Marking it stable here.

-- 
Jens Axboe

