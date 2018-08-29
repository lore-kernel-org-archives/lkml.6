Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5619CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0451020847
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 12:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0451020847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeH2QpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 12:45:08 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37198 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2QpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 12:45:07 -0400
Received: by mail-oi0-f66.google.com with SMTP id p84-v6so8871682oic.4;
        Wed, 29 Aug 2018 05:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xa/jABSBkd06yK9ipKUFET/9oUGU+MNpbaBfc3VGPGA=;
        b=s/+d79+n3M87QAOKdvPhU2VOR7IyW5QCFJ1cZ4+zjjK6677SrngQcg4dSK7MAhBVaA
         Dko1ogl07znX+MGuJwyjTCOXdBWNjHj6rZy517uXrUZ+5iU4Bv9Xw6j2bk9WKFklllcj
         W5cZi3od8pba8Xw8NHyPzntgirDFCI64qm4jk9fPJ0hGS0sJ6xfwe8oZFJf3pfp8KWsh
         WTunxwkF3kyEahP9PozGs1qnOR42ZbFpa/FK5F9lmyLEYQYKAD9S4XaHzZ9PcgqrjYUQ
         wqwUYDFGtCD9IisAZx4sXDMiDkobFo6oqXo5v5fNv939AGXcVLUgCjw3lLPfrnBcozXk
         XrDw==
X-Gm-Message-State: APzg51Dj3ct1pq4snwnum+XKGbOUWe6vNTn40sloPIkXZUSwmjNMU+Fc
        Bsu3sJPQSiL3E6tyHsupZw==
X-Google-Smtp-Source: ANB0VdZ81lsfQvTu2Lk9LfHk0FrZpE2eORvsj4zqN5pur+Tqhu1KtqENNT4HfLeAAafGFjgufBnaOg==
X-Received: by 2002:aca:5e02:: with SMTP id s2-v6mr2649436oib.176.1535546900733;
        Wed, 29 Aug 2018 05:48:20 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p132-v6sm2146237oia.31.2018.08.29.05.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Aug 2018 05:48:20 -0700 (PDT)
Date:   Wed, 29 Aug 2018 07:48:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Cc:     evgreen@chromium.org, robh@kernel.org, mchehab@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, rishabhb@codeaurora.org, bp@alien8.de,
        swboyd@chromium.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH v3 4/4] dt-bindings: msm: Update documentation of
 qcom,llcc
Message-ID: <20180829124819.GA21262@bogus>
References: <1535503347-20507-1-git-send-email-vnkgutta@codeaurora.org>
 <1535503347-20507-5-git-send-email-vnkgutta@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535503347-20507-5-git-send-email-vnkgutta@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 17:42:27 -0700, Venkata Narendra Kumar Gutta wrote:
> Add reg-names and interrupts for LLCC documentation and the usage
> examples. llcc broadcast base is added in addition to llcc base,
> which is used for llcc broadcast writes.
> 
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  .../devicetree/bindings/arm/msm/qcom,llcc.txt         | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
