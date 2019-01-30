Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C46C169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A975C21848
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 03:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Iy2a5V9M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfA3D1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 22:27:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39806 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbfA3D1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 22:27:37 -0500
Received: by mail-qk1-f194.google.com with SMTP id c21so12909736qkl.6;
        Tue, 29 Jan 2019 19:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0b2GDl2yieLIyx2pFYrqOUiHxYeTYtmKw6/wCfFz+T4=;
        b=Iy2a5V9MHKAxrlKsnJ9rvNj4qf16/5BykO68Vm7RZa7LecX/MGwVbwNi7xKfBVOtT5
         k8Q5Q5jLXd0GA3BlUfmybllg9sTRLNHMUFzFwBbuCAtT3aGCnHizLffXYtk9vV3wac01
         iDO2opyMPNA4+IjQD82rEXt18DZys6H7bUErg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0b2GDl2yieLIyx2pFYrqOUiHxYeTYtmKw6/wCfFz+T4=;
        b=HKW/zABQH8S4Kqq5EhAwV1pzmG7vcvkq0UNTECcFNXuIpnDLUUaZjK4F0ZUsMkEGAS
         2GpQuUiCv7UXNguL/wuX/fw0BsFVnK1L0tRmvuj/oNZw00IWqMSMYKZGiydkh2Vmlghy
         eyH2lZBwkBOX1MYd8p9uzxb56w6FYjjoB664ho8QVH2CXxyQWUtu+jS2fBv7YF23W6B3
         mT+pePQH3pa7uD54jki8DR2YpuA63Phig7wKT+TBa9PANX206pE/DEwVzsONHDJTLrjH
         ZiErPCNJMY/y6kMMMOpBgJPBGoDHF+1rVj/w3eQvx3r4K1D7oOoQxw5z3l5EblmdS53n
         X+DA==
X-Gm-Message-State: AJcUukcLFODEJIaMseAgUpzZtOcPPgZ3LrVMfD6uLppvbyAACBtQjfkM
        YRxmhlHgNBDCSjvGTOFBZrx3+Cxa+IAFiKOvmfzIKQ==
X-Google-Smtp-Source: ALg8bN5KS647Oz897o2Lp4q/4anxz45TJI1E5O6Dbhj26ozy8v2BKx5KAQFns7kWbyI/ya5kUEmqLguF66sAaUDJLWM=
X-Received: by 2002:a37:781:: with SMTP id 123mr26025466qkh.231.1548818856336;
 Tue, 29 Jan 2019 19:27:36 -0800 (PST)
MIME-Version: 1.0
References: <20190123230733.1821501-1-vijaykhemka@fb.com> <20190123230733.1821501-2-vijaykhemka@fb.com>
In-Reply-To: <20190123230733.1821501-2-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 30 Jan 2019 14:27:24 +1100
Message-ID: <CACPK8Xc-abT8Y9f60qt=v3TQ-=fQ3k7YzJGS5Y2MN0MDfRY+tA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: dts: aspeed: Add uarts for SoL in Facebook
To:     Vijay Khemka <vijaykhemka@fb.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "openbmc @ lists . ozlabs . org" <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2019 at 10:07, Vijay Khemka <vijaykhemka@fb.com> wrote:
>
> Added uart2 and uart3 in Facebook Tiogapass for routing serial input
> from Host to BMC for SoL via LPC.
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied for 5.1.

Cheers,

Joel
