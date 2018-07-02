Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B25C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704BA21A53
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMt6AYLV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704BA21A53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753248AbeGBRyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 13:54:04 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35924 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752957AbeGBRyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 13:54:00 -0400
Received: by mail-pg0-f66.google.com with SMTP id m19-v6so3932378pgv.3;
        Mon, 02 Jul 2018 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ljFuLVXS3g7HboU9N3gwYtTe4kuCeA1nZKNUD6YBcGA=;
        b=UMt6AYLVpgiB5oXoQUMVId/dpWQegFKlZPfOn4+MSZGJ/qPs/qW1Rn6E0/5J/fadVN
         Lo0ABcXX2YDe3c7InusYKfcWzXD418U0gr6jI0UKiYgk41TXJttM8xNFoZBgTF/He8Pq
         W/Qf41LePIjDzsRHIa0buIEmsXYwVfoqf2GdspGb+Kc8baXCtydgRP9lFI8syv4JZsrx
         Pp17nzrIxUx+FovSlr0AOASCIWksGJXofBR5eVZIgNDpuRXkwy0LL2gnZgutL0vrtOJC
         knXkgsNhwPRQVuhGmU3aSre6oyAjEo1Q5jvqtrrtKb5eFU5mXQhnCJo3bdCc9Husm0Wi
         c24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ljFuLVXS3g7HboU9N3gwYtTe4kuCeA1nZKNUD6YBcGA=;
        b=oLBnhGY8p74jvDXzv69pZqFGJMgf3rGfKagYEi7UeWfqPNRw8j7/m4cFUn1Wc9rLAx
         M+yj4ujRcG+3WsMFIeigG3Ydy+nG1vl/iQ2p+VME80MZ2PRB6aDTARRa3T6k8Q+GDve/
         kN73FwTuVF1C4svdf/JRMqnXn0sRVI1njjAfI7pLrroA7ufimsgN2J00u2tH37zGJE2N
         ch4DJdyJSy7IgyYje5qCTuzskXUyp7GkfkuNU1uXBW2MkuLQZFEtR5QW6PQBpii10rwN
         f/cJjI6il4r1pSfR3LzbhMnAG6SOt+0xAtVcJukIMUIw5YRmUa978lsIU6uKjLhoTc/X
         ZCdQ==
X-Gm-Message-State: APt69E0v4zdvjhrIYzKVveVwto3t8JcrA51dctDF0s4ftzy7+5H5yM1H
        hv+lmwU7WrBN9Bw51pVnNxg=
X-Google-Smtp-Source: ADUXVKJ/JC86m6nleGQoFVt7qq0QSlSBY4OC52SkCwwT012Ij+MOcGflvr96QVPXTX3TYOScIQvGxw==
X-Received: by 2002:a63:8848:: with SMTP id l69-v6mr22120512pgd.377.1530554040209;
        Mon, 02 Jul 2018 10:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id z10-v6sm27304564pgo.58.2018.07.02.10.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 10:53:59 -0700 (PDT)
Date:   Mon, 2 Jul 2018 10:53:57 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, rnayak@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        smohanad@codeaurora.org, vivek.gautam@codeaurora.org,
        andy.gross@linaro.org, Kees Cook <keescook@chromium.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-soc@vger.kernel.org
Subject: Re: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Message-ID: <20180702175357.GA28713@localhost.localdomain>
References: <cover.1530533998.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1530533998.git.amit.kucheria@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 06:14:03PM +0530, Amit Kucheria wrote:
> This series is a mixed bag:
> - Some code moves to allow code sharing between various v2.x.y versions of
>   the TSENS IP,
> - new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
>   property as a fallback compatible for all v2.x.y platforms,
> - new platform support (sdm845)
> - a cleanup patch and
> - a DT change to have a common way to deal with the SROT and TM registers
>   despite slightly different features across the IP family and different
>   register offsets.
> 
> Rob mentioned offline that we should expose the full version string of the
> TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
> you were looking for.

Applied patches 1, 3, and 4. Patch 5 needs a description. Patches 2 and
6 go via your arch tree.

> 
> Regards,
> Amit
> 
> Amit Kucheria (6):
>   thermal: tsens: Get rid of unused fields in structure
>   dt: qcom: 8996: thermal: Move to DT initialisation
>   thermal: tsens: Rename tsens-8996 to tsens-v2 for reuse
>   thermal: tsens: Add support for SDM845
>   thermal: tsens: Check if we have valid data before reading
>   arm64: dts: sdm845: Add tsens nodes
> 
>  .../devicetree/bindings/thermal/qcom-tsens.txt     |  2 ++
>  arch/arm64/boot/dts/qcom/msm8996.dtsi              | 12 ++++++-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               | 16 +++++++++
>  drivers/thermal/qcom/Makefile                      |  2 +-
>  drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c}  | 39 ++++++++++++----------
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qcom/tsens.h                       |  7 ++--
>  7 files changed, 62 insertions(+), 22 deletions(-)
>  rename drivers/thermal/qcom/{tsens-8996.c => tsens-v2.c} (66%)
> 
> -- 
> 2.7.4
> 
