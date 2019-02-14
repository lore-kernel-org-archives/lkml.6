Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0399C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4DD222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 19:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjMe/8Uu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439873AbfBNTto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 14:49:44 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46771 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbfBNTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 14:49:44 -0500
Received: by mail-lj1-f194.google.com with SMTP id v16so6300946ljg.13;
        Thu, 14 Feb 2019 11:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9mizv2u1bnhIcxX/vcld3ggF1yKDboB9WACUavwBk6k=;
        b=EjMe/8UuZVL9JR+gTHIxhMryuWg0SBkqnCM85DvEoQFf8YOYP/tjBg5tZBeRkajh7u
         jKERvS1b3vQYlo7GVRIFlLMzoXNrwmO5jl3rYP9YmmFxY4WVAqJ3h1LOzqh1BP+UISKx
         7g+JKG2b8BKePerOWOZ2zrg62oxWO5iIEEQBI/+AwLUjQ92aI3T5mKp9NaIeaDo2YhaR
         JR1adsR6YxwTE4fSFm6flkgTnpjuU8hB8r4iTDATRq0BVS+hXdApiq6lPGkDplL8flhV
         Cn3/oqWgZYw0G44+g349LRb37JCZ1Jx5nOIxvTMLIuQSN9O/eY4pWyOffCnybJ2o1sMS
         Mz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9mizv2u1bnhIcxX/vcld3ggF1yKDboB9WACUavwBk6k=;
        b=L9E12zw9exUMFuSI+7vInepA95f+jp0/zLszh6u7eTNIwQrhSdCsaiMStwqccRVbcD
         sFeIkSIatS+qQanvKaGLFezKXzvr0c7tuWJyK6fXISKZ/o1vCu6O3sHHtWtSnY+Mx5yx
         vE1chqcGmSLAD0ary/awKD5UNiIP1L1OFqchVT56Y/joDwWOeWlnGgxTXipdj5mMStMk
         iwI1plA4vL/IQpiqED0RLalmW5+9PIuDreOwRoHxdZjmDDKb0gwkyOf9Oys/ZRcNuWiT
         vNofVO7N8ZZCqte6By1BU8eBZvZG3YcyL9TEnmjeaD6UsaTfR10eU+z85qsgpzAxlPU+
         BwUw==
X-Gm-Message-State: AHQUAuZN2XFUAVfvkupxSz9OlpFs2uLT+tryhfTNPmxUZCEt9mvdjHfA
        ZHodZP4KQ5NXRRRIPgcuc335sjNcYa0=
X-Google-Smtp-Source: AHgI3IbbZT9iYS34Bvy8KdD3t3ZnKQVcD8k1VXNKlDKKhr/92fU6+LgkstLix75w2sn1HCSFXjr8lA==
X-Received: by 2002:a2e:918d:: with SMTP id f13mr3731204ljg.151.1550173781915;
        Thu, 14 Feb 2019 11:49:41 -0800 (PST)
Received: from im-mac (pool-109-191-226-91.is74.ru. [109.191.226.91])
        by smtp.gmail.com with ESMTPSA id v24-v6sm616115ljj.65.2019.02.14.11.49.39
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 14 Feb 2019 11:49:41 -0800 (PST)
Message-ID: <ea2674fa03e861f72bf7f4f65a049243527948c7.camel@gmail.com>
Subject: Re: [RFC PATCH 1/4] watchdog: hpwdt: Don't disable watchdog on NMI
From:   Ivan Mironov <mironov.ivan@gmail.com>
To:     Jerry.Hoemann@hpe.com
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Date:   Fri, 15 Feb 2019 00:49:38 +0500
In-Reply-To: <20190208012658.GF28168@anatevka>
References: <20190114023617.10656-1-mironov.ivan@gmail.com>
         <20190114023617.10656-2-mironov.ivan@gmail.com>
         <20190116022731.GD18342@anatevka>
         <84950aa0d194f28389f3bb209154ddc26e96c6de.camel@gmail.com>
         <20190208012658.GF28168@anatevka>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-07 at 18:26 -0700, Jerry Hoemann wrote:
> The name is not the best given its current use, but I'm not sure a
> name change would be allowed.
> 
> However, I will send a patch to update the documentation in Kconfig.
> 
> 

Thanks!

