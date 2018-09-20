Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C689C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15E9D21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="dphLURQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15E9D21523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731613AbeITNEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:04:33 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35698 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeITNEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 09:04:32 -0400
Received: by mail-qk1-f193.google.com with SMTP id f62-v6so4479917qke.2;
        Thu, 20 Sep 2018 00:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9HnB3Xz9tWx+W3geoEGbxF4Ybh4HxALwKnevxX/LSs=;
        b=dphLURQ2Wo2mLk7iOHtDR5wMAoVnwazkhILGtLs93KYACBjntsVbZ7wC7piqNy9ggC
         HbEYrneM9bHbmDh+7NjbV9EFMhFWh/FlQmi4SStAk+mDytjrI+wD1cpn/66hexhNOo22
         pmkKB+y7SBsGEZxne9h55+MkH44rX36bJ2dwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9HnB3Xz9tWx+W3geoEGbxF4Ybh4HxALwKnevxX/LSs=;
        b=eS6ulyn6tEgEDWaqVhzFjRLdYS4x13YlghwAhhQpBSqBSndi6cChnCRLBetJydzeM+
         keD1LicffhrIR/IxXzM3v5kkdFJ9M1ziFv4FNlBZhtXhnUn6kJjwEXhn5Q/ww2533Sie
         EyuMW92JiGBeYEp4OF3YyD3RxDa6goTaVfqB3B3EBc7Ma2c62Zrz3f7vHnzqAidLPZKn
         ZAdmRXV7SDLLKjeaSb6TRIa0/RpSvQRGOTMjsl8oWg30uWkQiI7mqHa9a7/T7tY0niXz
         hy28IN2udAjjmxmfRCGqS9i7O9lTOIEhUv8fQgqFnUTxf7C1kSZm+rDXGsi1bNliVyqp
         GWjw==
X-Gm-Message-State: APzg51Co/ty4Z3VAk7mnHwnUVqFCxaasHQIbgI4RGqwwQ9OGzRI4Jzyw
        9203PhP+oDlPABDgmhadjugB8w+Eh/o2eXyll6A=
X-Google-Smtp-Source: ANB0Vdb7nUdAyz8b5JHCrnq0eMOYg25CG0+vT8YnS8c5p5JxNnX5OU0gJYAbgL1Ty8QsYe+WVEIjgGSI3Fa/9q7566s=
X-Received: by 2002:a37:9bc9:: with SMTP id d192-v6mr27236274qke.127.1537428150079;
 Thu, 20 Sep 2018 00:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180918234110.1908926-1-vijaykhemka@fb.com>
In-Reply-To: <20180918234110.1908926-1-vijaykhemka@fb.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 20 Sep 2018 16:52:18 +0930
Message-ID: <CACPK8Xd_ZKrQa3b98Bpb=wy_P3=FDUjPDfBSHx5Wx_NHk6Y5og@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: dts: aspeed: Adding Facebook TiogaPass BMC
To:     vijaykhemka@fb.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vijay,

On Wed, 19 Sep 2018 at 09:11, Vijay Khemka <vijaykhemka@fb.com> wrote:
> Initial introduction of Facebook TiogaPass family equipped with
> Aspeed 2500 BMC SoC. TiogaPass is a x86 server development kit
> with a ASPEED ast2500 BMC manufactured by Facebook.
> Specifically, This adds the tiogapass platform device tree file
> including the flash layout used by the tiogapass BMC machines.
>
> This also adds an entry of tiogapass device tree file in Makefile
>
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

It looks like you've addressed the concerns from previous reviews. If
any comments come up please address them in follow up patches.

I made some minor whitespace fixes and applied this to the aspeed
v4.20 device tree branch.

Cheers,

Joel
