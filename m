Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401F2C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FA8216FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsUF5dD5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4FA8216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbeHNQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 12:31:11 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44362 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732699AbeHNQbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 12:31:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so9255443pff.11;
        Tue, 14 Aug 2018 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0GJAVV0LQoLLb/xORuLGfWOqsJy3SJXg82euTrhQiNE=;
        b=VsUF5dD5d7hJrxs6cr9fA2BtMm41R9AxyzWXaS3IDShhgVsIXwfFsWOibX99DnGMqK
         HT948eEjeFT4u1OGosKLOMpuhQP0LHylrZUKjYK0O3JcBbOSRrgYhAZr8ezhyKTFNuUt
         nzIQL0fMBwV2DDn6E79YAQN3dowkD5buf23Fc+qQDvzainKI+K3LSibQ4YRna+jcGGIE
         xVhXc/k/T29+BT1UyI3D7slfaet9DN1+gEJb8VV+jRfPl/Uw8Vzyl2Tq+05C+5VXpczL
         T496e0fOzPE4DUZ0STF4MlqhSfpbNM2lOkj2oHmI8kSyEfQEb2rq6MgPiLdvNhQXB5kY
         UxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GJAVV0LQoLLb/xORuLGfWOqsJy3SJXg82euTrhQiNE=;
        b=s7s90ro4KoSMBYjlrrphb0dyss3+9Jeh/CABj+vLXv4wl+hR1gn3UFWv0zB/uJu8wt
         ACq6QZcZLcablszEqFOKlSnhC2aWvZDRCxm0s2/xgImgNeFfiUqvNToBRoGkylwfCxeI
         hIhcqWkwoVlKbRZ/5yRdrP89E+JbtQEVdYVR+i6taQ6QoenIWEyt2Tq5kKlJUak1dh/A
         mhx7euGiPOjM3sRDiqORiUVzn9Kxo6Y27Hcq2Lx1P7jaayr5/b/QYdhBg7xfbQW9/XVH
         7wwiFR8FeTb1uN02/stM0k4xeJ7Q8RG9p2NebjO4Vl8507w2ce+GYHNJ1OVMG65MVQNB
         t2ow==
X-Gm-Message-State: AOUpUlHpJBupa7B/8/5o+2gPeaGCXlMgbWzCZnMQthZWuGDeBDf1xn96
        HdUntFNZUGAMzaYnVmVMj6ZNbY9S
X-Google-Smtp-Source: AA+uWPwP9U9nn4+gvJNIl1+WEEvm+nsTU4IDTYOYJOK2Y03JNIeW+aX24hEiAteGQZcWjUV6/W6fOA==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr20633373pgv.273.1534254236860;
        Tue, 14 Aug 2018 06:43:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l27-v6sm43560437pfi.180.2018.08.14.06.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 06:43:56 -0700 (PDT)
Date:   Tue, 14 Aug 2018 06:43:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     michael.hennerich@analog.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: hwmon: pmbus: ltc2978: Add support for LTM4686
 uModule
Message-ID: <20180814134355.GA15658@roeck-us.net>
References: <1534249108-29765-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1534249108-29765-1-git-send-email-michael.hennerich@analog.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 02:18:28PM +0200, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds support for LTM4686 Ultrathin Dual 10A or
> Single 20A uModule Regulator with Digital Power System Management.
> 
> Datasheet: http://www.analog.com/ltm4686
> 
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>

Applied to hwmon-next.

Thanks,
Guenter
