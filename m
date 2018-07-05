Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC3C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 742A4205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 742A4205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754518AbeGEVNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:13:36 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:33699 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754062AbeGEVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:13:34 -0400
Received: by mail-oi0-f67.google.com with SMTP id c6-v6so19600529oiy.0;
        Thu, 05 Jul 2018 14:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YX1O5u9WFYlcuJBt2l7JdQKUDOlr1LTy8eqwWeTAuXs=;
        b=qH8xIvpq2ePXgNlrtrk2mgMp0DhaaR5h9MumSRqxvb3LsR9ls5KCL4BVHB5nwgeTAs
         TBl82djWpzGKbyCGmhPSvL8yd9pkrPVzIMAKagWjSBvPdOb2ePjylillmTunVy+FjKS5
         0TU/87HkrERk5hG36qU5eOghcCjAPcPD2oFkhn7Yauo+Q6/sUrq8aegQIJ/0/mxPJ0ju
         7CStlzE0O5n/Qmeb02LtTtgeqjuWSvpMcrjZHUyQkTT3Bhb5mmcH2VFf5KoaLc/5LgMX
         XpSKcrHt97xsYXPs8CnHZ+rNpVkixye4aIIlLvpm9PV3hizPAOEcOPnyUOTeKuDvduK9
         UnFA==
X-Gm-Message-State: APt69E1lRj4xRBh7UTQnASYz/Mb99FsD01GgY2swh8dNzUumnuHuwD5a
        IESeSd1kVqj6nSDnYgHlZQ==
X-Google-Smtp-Source: AAOMgpeLkbCXhvhWgy73j8MDyHo+A6wB3aVZvqrl9ldiGRd8px7lZDuOa+IRy7b8PPplklc+FC+eBw==
X-Received: by 2002:aca:a993:: with SMTP id s141-v6mr8945862oie.72.1530825213589;
        Thu, 05 Jul 2018 14:13:33 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id h9-v6sm5634881oic.1.2018.07.05.14.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 14:13:32 -0700 (PDT)
Date:   Thu, 5 Jul 2018 15:13:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 09/10] dt-bindings: counter: Adjust dt-bindings for
 STM32 lptimer move
Message-ID: <20180705211331.GA2404@rob-hp-laptop>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bf9f5233a46e0dc195c27be19b76687448c17ff.1529607879.git.vilhelm.gray@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 05:08:57PM -0400, William Breathitt Gray wrote:
> From: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> The STM32 LP Timer counter driver now resides under the Counter
> subsystem. This patch adjusts dt-bindings to account for the STM32
> lptimer driver move.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt | 0
>  Documentation/devicetree/bindings/mfd/stm32-lptimer.txt         | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/{iio => }/counter/stm32-lptimer-cnt.txt (100%)

Acked-by: Rob Herring <robh@kernel.org> 
