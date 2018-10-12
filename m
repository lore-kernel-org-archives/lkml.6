Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA6BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D86420868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 11:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D86420868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbeJLTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 15:09:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36716 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbeJLTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 15:09:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id x4so10666524otg.3;
        Fri, 12 Oct 2018 04:37:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E2yXTOUVdgOXwXqQa9GXtyLg6PjKzTY0nLRute9vB04=;
        b=coZPnrLP2NQwA7GuciSZe8YuiBX9FhXvmLk2vFHR5+jqe/ad1IcMHh9WlnF/oUGQGj
         sFlvvV8IVh10GR8lNvkT+GV1mu95UUjyRY+bV5FUD4+hHyLujQ/K7TGElT0aNRojQCkl
         CtmXs8TN1sAwraFb+cX15ShRw2WssxyTHcuYyAMFrbkb/LzMVPUioN8HY/XWS8icq//S
         ePRnhmXOwb8NKfXXW+Xg9sHFZnYOkpWoyHSepOgmsmrzmQI5TeYGAR9Yf5fSZ7OCP6vF
         EdCO0SzXV9qNFI3eQsvmWg00FSa4wK4G1Jmp0+OuuFJGU8AB/qPwwYXQcnKk87b45QtS
         I3hw==
X-Gm-Message-State: ABuFfohj02YWaKOpk415B0teJ89EXQn1riF/l8BQCLJsWB2e0bfqrt7c
        W8JfvyenFsaGTORjoAulOg==
X-Google-Smtp-Source: ACcGV63+z953V1Q/Lm8atAU4kViSqlkyqAwpYoQQSqZ4j/OOjTitDKkdxPe63Jzgls0X1rBM2QJ+YQ==
X-Received: by 2002:a9d:41e9:: with SMTP id v38mr3880967oti.16.1539344276778;
        Fri, 12 Oct 2018 04:37:56 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 37sm232249ots.39.2018.10.12.04.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 04:37:56 -0700 (PDT)
Date:   Fri, 12 Oct 2018 06:37:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        preid@electromag.com.au, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: Re: [PATCH v4 2/3] iio: magnetometer: Add DT support for PNI RM3100
Message-ID: <20181012113755.GA24893@bogus>
References: <20181002143812.3661-1-songqiang1304521@gmail.com>
 <20181012073536.20339-1-songqiang1304521@gmail.com>
 <20181012073536.20339-3-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012073536.20339-3-songqiang1304521@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 15:35:35 +0800, Song Qiang wrote:
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
>  .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
