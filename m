Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59881C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CF0213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 19:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHBsFcQD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CF0213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbeIMAsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 20:48:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36035 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbeIMAsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 20:48:53 -0400
Received: by mail-lj1-f196.google.com with SMTP id v26-v6so2652279ljj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 12:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjAnTjGg6As3Kf/lNlb6DteNOBDSgZraKD18NeUiKb4=;
        b=LHBsFcQDgUrt02L9kcnhloFfhJhUMCuJcyOu9VIFR/lDZMLZgl20RrN8Km4Wn5NFAX
         TNzi+c27gN6OGhpIYfvc6rE/MqyFWNhsosAiIpftO6LxTzFh5wkHScUPdY1j5Hd2ZnJB
         1IKmbtDR8ArzWEQIn42Gvae2Plod0ZNskEcdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjAnTjGg6As3Kf/lNlb6DteNOBDSgZraKD18NeUiKb4=;
        b=krCgz8vvz4gEBnqcQtEtMU/NjDApEaP+4VtrqzB7wrxpU4+QCm/yXc4vb5F1LSZc8e
         ESP3ZBpqAFdiyHqhKD1QZoJR2rxDZxS5goeFxWqxj4J7xPPv6DFqDYm0EJiQ1UyfbMUo
         WAwlcMEyz62anO53iKwIyr8YIEKRAl6ufmooE891nD15r/h7k/DHKBY5+jRCs9BpolgS
         wIyE9YC1Q/r8KjebSmpsWW02PLLkM9uXrW9OSW1KHQjAztg+8pTQZMv94qpkv2YZb4eJ
         BpYTNgzH63tOzJaJwyXEJvcam1CFI6C4VFVeTS2J7qIRhVcC8NjD5efG/4PqlAYyu906
         Siow==
X-Gm-Message-State: APzg51AWLUUWboKF3AQhZ4gv1VCNdk1cQAVWLolcYyN97BWLoEHYzexz
        OnDefwKT2Tp1RphNRFt76+E1FiHXGZiiQ1MgQrf8RA==
X-Google-Smtp-Source: ANB0VdbPjLEoCxhCwf7j1MLuUjKF/nAZunOlT8zPdeh7YuWxsdyutml2r7R6GtwWjKOTWuQg862zwEv7cJhPzA2SDwI=
X-Received: by 2002:a2e:9ec9:: with SMTP id h9-v6mr2101254ljk.133.1536781369227;
 Wed, 12 Sep 2018 12:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
In-Reply-To: <1536224915-31766-1-git-send-email-suzuki.poulose@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 12 Sep 2018 13:42:37 -0600
Message-ID: <CANLsYkxvF44MiX8RZtx3yU5yj=nyjbUXOYkv8oV2uYD6CbHENg@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] coresight: Implement device claim protocol
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org, Robert Walker <robert.walker@arm.com>,
        Al Grant <al.grant@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Sep 2018 at 03:08, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Coresight architecture defines CLAIM tags for a device to negotiate
> control of the components (external agent vs self-hosted). Each device
> has a pair of registers (CLAIMSET & CLAIMCLR) for managing the CLAIM
> tags. However, the protocol for the CLAIM tags is IMPLEMENTATION DEFINED.
> PSCI has recommendations for the use of the CLAIM tags to negotiate
> controls for external agent vs self-hosted use, as defined in
> ARM DEN 0022D, Section "6.8.1 Debug and Trace save and restore".
>
> This series implements the recommended protocol by PSCI.
>
> There were two options for the implementation.
>  1) Have the claim/disclaim operations performed from the coresight
>     generic driver - This doesn't work unfortunately for ETM devices
>     as the need cross-CPU calls to access the CLAIM registers. Also,
>     makes it complex for error recovery and reference counting.
>
>  2) Have the claim/disclaim operations performed from the device
>     specific drivers. The disadvantage is that the calls are sprinkled
>     in each driver, but this makes the operation much simpler.
>
> This series implements the method (2). The first part of the series
> prepares different drivers to handle errors from the lower layer
> and clean up the state. The second part of the series updates the
> existing drivers to claim/disclaim the devices as necessary.
>
> Tested with a hacked coresight driver which modifies the external
> claim tag via sysfs handle.
>
> Applies on coresight/next in Mathieu's tree.
>
> Changes since V1:
>  - Handle errors is enabling path and disable only the components
>    that were enabled in the iteration.
>  - Fix build break on arm32 (etm3x)
>  - Update commit description for "coresight: Add support for CLAIM tag protocol"
>
> Suzuki K Poulose (14):
>   coresight: Handle failures in enabling a trace path
>   coresight: tmc-etr: Refactor for handling errors
>   coresight: tmc-etr: Handle errors enabling CATU
>   coresight: tmc-etb/etf: Prepare to handle errors enabling
>   coresight: etm4x: Add support for handling errors
>   coresight: etm3: Add support for handling errors
>   coresight: etb10: Handle errors enabling the device
>   coresight: dynamic-replicator: Handle multiple connections
>   coresight: Add support for CLAIM tag protocol
>   coresight: etmx: Claim devices before use
>   coresight: funnel: Claim devices before use
>   coresight: catu: Claim device before use
>   coresight: dynamic-replicator: Claim device for use
>   coreisght: tmc: Claim device before use
>
>  drivers/hwtracing/coresight/coresight-catu.c       |   6 ++
>  .../coresight/coresight-dynamic-replicator.c       |  79 ++++++++++----
>  drivers/hwtracing/coresight/coresight-etb10.c      |  18 +++-
>  drivers/hwtracing/coresight/coresight-etm3x.c      |  56 +++++++---
>  drivers/hwtracing/coresight/coresight-etm4x.c      |  51 ++++++---
>  drivers/hwtracing/coresight/coresight-funnel.c     |  26 ++++-
>  drivers/hwtracing/coresight/coresight-priv.h       |   7 ++
>  drivers/hwtracing/coresight/coresight-tmc-etf.c    |  95 +++++++++++------
>  drivers/hwtracing/coresight/coresight-tmc-etr.c    |  80 +++++++++-----
>  drivers/hwtracing/coresight/coresight.c            | 118 +++++++++++++++++++--
>  include/linux/coresight.h                          |  20 ++++
>  11 files changed, 434 insertions(+), 122 deletions(-)

I have applied this set.

Thanks,
Mathieu

>
> --
> 2.7.4
>
