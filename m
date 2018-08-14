Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED1BC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3FC21711
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 20:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E3FC21711
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbeHNXB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 19:01:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35905 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbeHNXB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 19:01:29 -0400
Received: by mail-pg1-f194.google.com with SMTP id h12-v6so9602718pgs.3;
        Tue, 14 Aug 2018 13:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiinAwXuf3uhYY27/5yM8sqqSy8KDbvLOYgSlbVpiD4=;
        b=QNOiQMg4IVbRK8C3vjGHH2LcMbAQCuvG9KLa9gHQDFfDOS3aNyAEUlUHnG9hKhQyJ5
         jwmc4Gde2VubykpXU+Ufvkwhj7bbzF/4tqbTPkapYhciV7v3LsSjqFxmfL3N8FEw2M6h
         15qhVrYXlzcWC9GjcYGDQmjYH9z+u7hrDuqvPVQGROJeh0gMNkdEQwzHNKZooNRoZh/Y
         UAqVYEbwdeibi5FSL5Qyt1JMvGiWLwz9K0gEYWA5jEAi11LeYJ/ybYwNEMbeYSkUK4yC
         DAYbeBLhvD+cTUXzyzI96pCF1oLVKzUVSLCMkvC1bHq6bo5/hIrgoJ30+gUBVTACBRu/
         rS9g==
X-Gm-Message-State: AOUpUlFD76uqBQpcpnuMFN15uXdaKHvtqhxNuwm4+e5KsqJmwo237rQb
        wB5/EPPppXf0UNltiXjwPmf6gYw=
X-Google-Smtp-Source: AA+uWPy9/vT8lqBQxG3JRyqm5zHQ6NrMQ3TJdA3RpB1foIm7cUXonYKIdYX5bNVbP3FzcMjyuOXIlA==
X-Received: by 2002:a62:20f:: with SMTP id 15-v6mr24999098pfc.100.1534277559584;
        Tue, 14 Aug 2018 13:12:39 -0700 (PDT)
Received: from localhost ([74.118.88.158])
        by smtp.gmail.com with ESMTPSA id d19-v6sm35794356pgi.50.2018.08.14.13.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 13:12:38 -0700 (PDT)
Date:   Tue, 14 Aug 2018 14:12:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Varadarajan Narayanan <varada@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: phy: qcom-qmp: Cleanup the 'reg'
 documentation as per review
Message-ID: <20180814201234.GA22842@rob-hp-laptop>
References: <20180807051412.126003-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180807051412.126003-1-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  6 Aug 2018 22:14:12 -0700, Douglas Anderson <dianders@chromium.org> wrote:
> After the commit 8b1087fa3a27 ("phy: qcom-qmp: Fix dts bindings to
> reflect reality") landed there was some review feedback that 'reg'
> should have been documented differently.  Fix it as per review
> feedback.
> 
> As per that feedback:
> - Subject should have been 'dt-bindings: phy:' which this patch now
>   has.
> - We should leave no ambiguity in the ordering of 'reg' ranges even if
>   'reg-names' are also specified.
> - Normally using reg-names is discouraged unless there's a strong
>   reason it's needed (like if there are optional ranges).  In this
>   case reg-names wasn't needed but the driver already landed relying
>   on reg-names so we'll just document it and move on.
> 
> Fixes: 8b1087fa3a27 ("phy: qcom-qmp: Fix dts bindings to reflect reality")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  .../devicetree/bindings/phy/qcom-qmp-phy.txt  | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
