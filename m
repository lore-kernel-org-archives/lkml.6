Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59944C004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A013214FE
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 16:00:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A013214FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIZWOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:14:20 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41739 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbeIZWOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:14:19 -0400
Received: by mail-oi1-f195.google.com with SMTP id l197-v6so4051755oib.8;
        Wed, 26 Sep 2018 09:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QTwwZYMd8pL8Sva8pFylogmXWYk1rgXnmSYIj45ZH/Y=;
        b=BNSINlFni+fWeunB+CDXNfXoxya+xwnrTJr5+pEIuKiHGzUTKa0KQWnAYHQqlhqIds
         Vyn4LwUtTBuGneVdJk6UKC0KNTMYnaF+nyhgEb1TAPpzTJ+hTrzjxDRi0nqjA/ZvJxUj
         wJjc1KLIOK5TCowDtTxFFXbHAOyY8u995vtTLpCe+E9QFjZRJLcGFXXoszZclUA2yI+F
         exfliQz96ndYgkjrzDMXwtvNXe79n++sQzrnhg8nrChzHMchoJfU+GvL63XW6M030yV4
         9vVFxsgD6JCLU0JeFGwWfwmKHgJjd/M6IsO6jN42+5h+7AjiinkQn8NU0iYmatZIJ07d
         vG8Q==
X-Gm-Message-State: ABuFfogjB6V+6pMOwNYMfO8NE3s+VfhwCP2wB1uRD0fF4tvrfNsSWpyn
        3w4rxh5+wjs0fyKIZS2UdQ4XtW8+nA==
X-Google-Smtp-Source: ACcGV61yCg2/saKcOVXuYBXczfLumguiAh/9VztM+A4afs5hDXhIM4wjxGPRC9helwIK7a0+0xOrjQ==
X-Received: by 2002:aca:bdc4:: with SMTP id n187-v6mr1032624oif.3.1537977642763;
        Wed, 26 Sep 2018 09:00:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h9-v6sm1833675otl.59.2018.09.26.09.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 09:00:42 -0700 (PDT)
Date:   Wed, 26 Sep 2018 11:00:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rohit kumar <rohitkr@codeaurora.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, bgoswami@codeaurora.org,
        rohkumar@qti.qualcomm.com, Rohit kumar <rohitkr@codeaurora.org>
Subject: Re: [PATCH v4] dt-binding: remoteproc: Add QTI ADSP PIL bindings
Message-ID: <20180926160041.GA9880@bogus>
References: <1536638041-11033-1-git-send-email-rohitkr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536638041-11033-1-git-send-email-rohitkr@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 09:24:01 +0530, Rohit kumar wrote:
> Add devicetree bindings documentation file for Qualcomm
> Technolgies Inc ADSP Peripheral Image Loader.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
> Changes since v3:
> Addressed comments given by Rob
> 
>  .../bindings/remoteproc/qcom,adsp-pil.txt          | 126 +++++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,adsp-pil.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
