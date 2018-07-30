Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB0CC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3C7F20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 22:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3C7F20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731848AbeGaAG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 20:06:28 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37272 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726966AbeGaAG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 20:06:27 -0400
Received: by mail-it0-f66.google.com with SMTP id h20-v6so1573617itf.2;
        Mon, 30 Jul 2018 15:29:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byPx5GGFkzTxhR1CUvDkN/99sqIj5R2h5wm2NEd670E=;
        b=I9FOEixEg0WbF6+PQn4UA789xfCQH+WDUGJ7rUhOqcfiN6EgPGkIQfgqb8ndYQzx6k
         0W78g5Yw8LvTw18e/7gg9xcOJ3T0QJCcR9D94cusF9Ke8TkuYivcs+QMjAQyLtls1JY2
         Vt7PJgguXeilhnLFS7ivPTZz/vTI3C8LEmS8hf9C3kG5IdYQrNxslwsHy2XB2/fFIOvx
         pbjSpVaE8/r5Y2DwCTJ7Jj27ZkB30DV3sXIvPaUUb9khC6oJ/QbXJ2kliuwDi7r4359X
         6FMvOj+P9K9Ama0zvj7c0HEkB+3T6plcj+UQD5hXErXLqMUcH8VxP0rLGRmAGTWrRgxg
         ZCUw==
X-Gm-Message-State: AOUpUlEAwldolQ9lvXiokOq4/aXmmnJ+4tJ132E2AQItCRl24USjRWuY
        SotMGg+FmWkt+YyHv3ocrA==
X-Google-Smtp-Source: AAOMgpcZ1nj6VUNZs7r18avWM6KdgKzQrdf1GkHWNppGzeXXnjYghIsoAcWs6U47taAD1f5Zac+/cw==
X-Received: by 2002:a24:c888:: with SMTP id w130-v6mr1073383itf.78.1532989760978;
        Mon, 30 Jul 2018 15:29:20 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id m131-v6sm371108itd.20.2018.07.30.15.29.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 15:29:20 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:29:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Todor Tomov <todor.tomov@linaro.org>
Cc:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 08/34] media: dt-bindings: media: qcom,camss: Unify
 the clock names
Message-ID: <20180730222919.GA9313@rob-hp-laptop>
References: <1532536723-19062-1-git-send-email-todor.tomov@linaro.org>
 <1532536723-19062-9-git-send-email-todor.tomov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532536723-19062-9-git-send-email-todor.tomov@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 07:38:17PM +0300, Todor Tomov wrote:
> Use more logical clock names - similar to the names in documentation.
> This will allow better handling of the clocks in the driver when support
> for more hardware versions is added - equivalent clocks on different
> hardware versions will have the same name.

You should note that no dts is using this yet (at least that's what I 
found).

> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Mark Rutland <mark.rutland@arm.com>
> CC: devicetree@vger.kernel.org
> Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
> ---
>  .../devicetree/bindings/media/qcom,camss.txt       | 24 +++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
