Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE44C7112A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B097120853
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 08:53:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B097120853
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeJOQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 12:37:57 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36830 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeJOQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 12:37:57 -0400
Received: by mail-oi1-f194.google.com with SMTP id p125-v6so14454554oic.3;
        Mon, 15 Oct 2018 01:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV/aUmawwCkM8R1/zI5sKC2x5zU4RlvLegUUGfAZAHI=;
        b=SBYGNuwY9UfU+Ha/Qm+a5jym+SaTTxye3sePMIOERJfx6Qxsx32Bx1dbdRw1FWAGbB
         nlgGj3F1gk9iwQ9zADZi47TaykpjiaQFcSypIM9yvEiIbkJkqBNfcdTtWIa0CW2Le1GI
         AU8h2qPujHem1vLT/2Ua/zGYnOlatKLHu6DLvuNj1noIfSnjpTRgTTW5YIU1ITuGgoYV
         HthenSnF+Q73StxtAhNnIXBLkh470Zl9jHKXbhT9T12fLK9TFGuQOQpbUcJ/ErJl4wWj
         HiGdyBda4nB1zu4bf8WAwqnXXYGDhMtZ99ansg7GGDVjgRq82MWQbPz/7HJv+X11WbX9
         bb9Q==
X-Gm-Message-State: ABuFfoh6rfLJRP4XxaL2EN+eaC1Cc3HPPvDpKP+8aW1QxhgzRsWA5MAs
        QpwCDkHBm5Rro4gsAKuquvLe7PEywNl8P3ufkiQ=
X-Google-Smtp-Source: ACcGV63y3E3YyfRXVhgRzaCZtNFNuVstJ332UbVqxQzoU8TSbplvyi46okCNLWGeG5BZNEeFGXM5q0u2MBDOgxhcV/A=
X-Received: by 2002:aca:af91:: with SMTP id y139-v6mr8044089oie.322.1539593616880;
 Mon, 15 Oct 2018 01:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com> <20181012164400.3479-4-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20181012164400.3479-4-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 15 Oct 2018 10:53:25 +0200
Message-ID: <CAJZ5v0iXOtcNSqPU7NYwG=S_JCdoTFzLRD1qZocWMnFnVJ-oMQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Documentation: intel_pstate: Add base_frequency information
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>, devel@acpica.org,
        Prashanth Prakash <pprakash@codeaurora.org>,
        George Cherian <george.cherian@cavium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 6:44 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Updated documentation to explain base_frequency attribute.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index 8f1d3de449b5..14a5505e073e 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -465,6 +465,10 @@ Next, the following policy attributes have special meaning if
>         policy for the time interval between the last two invocations of the
>         driver's utilization update callback by the CPU scheduler for that CPU.
>
> +``base_frequency``
> +       When present, shows the base frequency of the CPU. Any frequency above
> +       this will be in the turbo frequency range.
> +

This isn't entirely correct, because base_frequency is not present in
the passive mode (and it is not present for the other drivers for that
matter).

>  The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
>  same as for other scaling drivers.

Instead, I would say:

"One more policy attribute is present if the `HWP feature is enabled
in the processor <Active Mode With HWP_>`_:"

here and I would add the description of the attribute below.

Thanks,
Rafael
