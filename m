Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D29AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBFC218FE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545339449;
	bh=qPCLY35/vEBQ2nb85EICVbzSm+O/eFCrX2Ap35slKBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xaxyScwGHfWQjfncYoP4D2Q8FKu7CAfHeJMlh310XWM8qFZxdqQnU0G9qU7KcZOUn
	 0kyP9TIL5Ni5WZqTe6P+aQoXS6F2Iq7gt8VIh4xlMeILF8RZzLLWcTh/pNy8g2XyJY
	 hqLYqmA5E3KjJa3iPnVTNZUL4OEEPfmIBB4gN5pg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730653AbeLTU52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:57:28 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55925 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729578AbeLTU50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:57:26 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so4010788ith.5;
        Thu, 20 Dec 2018 12:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rTeIc8r8cSutS4ORvHntsXYGF2soEDoZph4eBu+yZLs=;
        b=JpdzxY2E5Yj/Iy82zDrVg3GjfLdK4KJ1PTidApqGqkobpgdsN5gkhPePQVby/asEuS
         H2iPihuUjoh7qcGZTxeoEY/HI4p2I1BPY4B8co5kUCglDZuubBr6ubm+EIsG5J/Bv1Sq
         i9NtgKmQCv8FhGbcCcAINl+y8b46lrt1YztCal840E72ynFGFsWHrwLPjgsBubsgfrGc
         1YYunf+1YfOo4uwjSlko0CJ0eagrquur6HjMC4+5XdtGLsd1YLJugy0PDnCnrO332LHc
         dzarfOj+kI9MDedwf+hMMDb1WY85uE4eTpiYKY6tOfngVq6rhUuBJYi4q57Q4TtCe6D+
         tDFg==
X-Gm-Message-State: AA+aEWYRl/3PISz1VR3X6nS246PLq4PEwmfGF04qNm2MIpaMYWN6dyN+
        zq/fzhTCFoR4Tf6kBtmt7hAosG4=
X-Google-Smtp-Source: AFSGD/XEcTZXNDZLfJRKCiFlEbVfvwKOHvZTmRUYOzNkiUr7EvBJQYN7XCipwj85eRYdUO+lSGyodg==
X-Received: by 2002:a05:660c:6cc:: with SMTP id z12mr201724itk.65.1545339445033;
        Thu, 20 Dec 2018 12:57:25 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id k2sm5242586itk.35.2018.12.20.12.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:57:24 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:57:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, devicetree@vger.kernel.org,
        Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/7] dt-bindings: riscv: sifive: add documentation for
 the SiFive FU540
Message-ID: <20181220205722.GA2072@bogus>
References: <20181215052154.24347-1-paul.walmsley@sifive.com>
 <20181215052154.24347-3-paul.walmsley@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181215052154.24347-3-paul.walmsley@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 09:21:49PM -0800, Paul Walmsley wrote:
> Add DT binding documentation for the SiFive FU540 SoC.  This
> SoC is documented at:
> 
> https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> 
> This file is originally based on
> Documentation/devicetree/bindings/arm/ti/k3.txt.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: devicetree@vger.kernel.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  .../devicetree/bindings/riscv/sifive/fu540.txt     | 14 ++++++++++++++
>  MAINTAINERS                                        |  9 +++++++++
>  2 files changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/riscv/sifive/fu540.txt

Reviewed-by: Rob Herring <robh@kernel.org>

However, with 4.21 we're starting to use json-schema and top-level 
SoC/board bindings. Not requiring it yet, but feel free to convert to 
that if you want. Then we don't have to do it later.

Rob
