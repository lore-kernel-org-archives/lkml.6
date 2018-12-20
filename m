Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F206C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A0218FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545338810;
	bh=s5ORZNSm5WQcx8yCKaV/mQoYz757Gx07Jw1r980t5tE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E6JnkwFB5q/qUo1vfekvD1DxE34lblJHbvKwkCKCZofsqf1Y/vlpQbGRriT0awTh4
	 4OT289u2q3zlvZCwwJOQZxpqiWOEnMj9li510NV/BrdvVPxi7ysE07VxTQh6pKp/ib
	 nhCQvXaK+7B0pP0i/g3D8aZsMXNu1vNVbJmqVmD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389647AbeLTUqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:46:49 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44576 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733283AbeLTUqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:46:48 -0500
Received: by mail-oi1-f196.google.com with SMTP id m6so3006172oig.11;
        Thu, 20 Dec 2018 12:46:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wov+CbJ1zEhkMBhjV5oAvVXsgPRYwDRZ+z8zxZ0LTlU=;
        b=Zi6mHnSGlHUpUDhuPY0RcCsKXwErp049ZWu5H3n2+XjvOWmYgeF/aE+eTwPwi992t9
         Jyas8mw2G1CA0+/RpFANfLQT7Y/XdceTgwGm42fLYPawSBvKH4n+HqZKFH9JH4D1ZKKi
         N7AAo8ydgLJsFQ8U0a3B9ikQ2S8ggTwJHE4/ppWPvX0AlSZc9nTpw9PLndDOtyH6PXjI
         6obI/LkELiRpk81dOFz3XsZJISMqi7o39GxsHJhPCEcrze5BL3QnCLV5DTXDzS+ITnqc
         4rX1Y0wArAKuW7eWQyXZaTYgvb5tx+EWLMV5Y94K86Dd/cWPQP3/8mzR0QMb732tisYs
         kZOQ==
X-Gm-Message-State: AA+aEWZC6x9nadWQUTwctx/0frBNvgp8pgwIc/nzKWM2lxWVt7IhqkEq
        CGzvCBw/ydJRxy3ZPD4nEw==
X-Google-Smtp-Source: AFSGD/Ut5y2kGMhZG1pQ0gZtanJYLMJxcElMMozaWFKf1J/5YaqrLZYXAWDI7X4g/Fv1njc4BZO7eQ==
X-Received: by 2002:aca:bb04:: with SMTP id l4mr167287oif.109.1545338807431;
        Thu, 20 Dec 2018 12:46:47 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id z18sm11313530otp.41.2018.12.20.12.46.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:46:46 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:46:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dinguyen@kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, amit.kucheria@linaro.org,
        yossi@novtech.com, nazik@novtech.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: Add Novtech Vendor
 Prefix
Message-ID: <20181220204642.GA1821@bogus>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
 <20181215030152.4386-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215030152.4386-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2018 08:31:51 +0530, Manivannan Sadhasivam wrote:
> Add vendor prefix for NovTech, Inc.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
