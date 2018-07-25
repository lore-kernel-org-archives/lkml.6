Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA721C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8949020852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 14:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OFS9E3pW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8949020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbeGYPuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 11:50:20 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41112 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeGYPuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 11:50:20 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so7427952edr.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 07:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hiPquA11utZhlW/Hpq4rxMlOXRyUT2VscSPmkPn06/g=;
        b=OFS9E3pWLcaWlk5h2X1NoY4w0pVVxBnv91TJmiqf4KPggc+FK9ZO+jpMy5+rdPi4WW
         Wq+AIIIw5m/On+nbCzquu2E06xRsfhSGjdKOdVCDeXtw7QTl/bUEKiLIh9N6mLhZyZQ5
         lb0rXUKI3XJCtpAo0KZyROMIfuwReDdx/E+z0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hiPquA11utZhlW/Hpq4rxMlOXRyUT2VscSPmkPn06/g=;
        b=rqtDrNVTg/3pxyD/23hA0ZKt/owL0A509rqgqesqQuPySsndnmHvTptlM49tkdxQXX
         IPgjOYvqfV1fIrAiBusmvvFqBFSRjzsUpXX2B6KfHOhRmDRmDnv/9xvW+axno6vezx4q
         USyLNglT8nUaq+zZzdIOCSrD76lHPqnY5Fezylj33Q0k7Hr6my9khz1D7M0WEodj1rWi
         DfcSrT/xD5z971ZumN3ZN3y6rduwof3zYe5n5y9g5QzgGfHytkMiMG1LFFmZI1ZFqEe/
         mtUBoiu7Pky1tmnlkWjSy2zZRw83zhQqx3ez7aMXLnxqJ8+/AbAvJ1kdyTBHYuEqRJOu
         SxTg==
X-Gm-Message-State: AOUpUlFLU3xorEdTlIEJKcgQ8KOCQ7dCqAFTM1i96dMwe2CXZKX90O4k
        4kbfhlfp/6oIJM7FoPPCaVrM3LfqgsaYBguChSLzL2bK
X-Google-Smtp-Source: AAOMgpcZyLvh3YnlCoXo3+b1XQeczxfVHqez7XXmXy9LvMwEE9VzZZEo09b7X2ssV3ULogK938MKRsaLSqzfpxX629Y=
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr24026068edk.12.1532529499621;
 Wed, 25 Jul 2018 07:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com> <20180724213031.GA22451@xps15>
 <CANLsYkwDTM2pT0JCCnLdetKoYe6xsmj48Gyb5OJFxJMmRLrZ_g@mail.gmail.com> <ea1a6672-0cbb-86b7-c8cd-0759edb94f85@arm.com>
In-Reply-To: <ea1a6672-0cbb-86b7-c8cd-0759edb94f85@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 25 Jul 2018 08:38:09 -0600
Message-ID: <CANLsYkxcTPWbM75wHgiy8tC6FNhELsMcK=fu2TfvXG-3rM=hCA@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] coresight: platform: Refactor graph endpoint parsing
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matt Sealey <matt.sealey@arm.com>,
        Charles Garcia-Tobin <charles.garcia-tobin@arm.com>,
        coresight@lists.linaro.org, John Horley <john.horley@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Jul 2018 at 03:01, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 07/24/2018 10:34 PM, Mathieu Poirier wrote:
> > On Tue, 24 Jul 2018 at 15:30, Mathieu Poirier
> > <mathieu.poirier@linaro.org> wrote:
> >>
> >> Good afternoon,
> >>
> >> On Thu, Jul 19, 2018 at 11:55:06AM +0100, Suzuki K Poulose wrote:
> >>> Refactor the of graph endpoint parsing code, to make the error
> >>> handling easier.
> >>>
> >>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >>> ---
> >>> Changes since v1:
> >>>   - Splitted from the of_node refcounting fix, part1
> >>> ---
> >>>   drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
> >>>   1 file changed, 75 insertions(+), 54 deletions(-)
> >>>
> >>> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> >>> index 6880bee..68faaf8 100644
> >>> --- a/drivers/hwtracing/coresight/of_coresight.c
> >>> +++ b/drivers/hwtracing/coresight/of_coresight.c
> >>> @@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
> >>>   }
> >>>   EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> >>>
> >>> +/*
> >>> + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> >>> + * and fill the connection information in @pdata[*@i].
> >>> + *
> >>> + * Parses the local port, remote device name and the remote port. Also
> >>> + * updates *@i to point to the next index, when an entry is added.
> >>> + *
> >>> + * Returns :
> >>> + *    0      - If the parsing completed without any fatal errors.
> >>> + *   -Errno  - Fatal error, abort the scanning.
> >>> + */
> >>> +static int of_coresight_parse_endpoint(struct device *dev,
> >>> +                                    struct device_node *ep,
> >>> +                                    struct coresight_platform_data *pdata,
> >>> +                                    int *i)
> >>> +{
> >>> +     int ret = 0;
> >>> +     struct of_endpoint endpoint, rendpoint;
> >>> +     struct device_node *rparent = NULL;
> >>> +     struct device_node *rport = NULL;
> >>> +     struct device *rdev = NULL;
> >>> +
> >>> +     do {
> >>> +             /* Parse the local port details */
> >>> +             if (of_graph_parse_endpoint(ep, &endpoint))
> >>> +                     break;
> >>> +             /*
> >>> +              * Get a handle on the remote port and parent
> >>> +              * attached to it.
> >>> +              */
> >>> +             rparent = of_graph_get_remote_port_parent(ep);
> >>> +             if (!rparent)
> >>> +                     break;
> >>> +             rport = of_graph_get_remote_port(ep);
> >>> +             if (!rport)
> >>> +                     break;
> >>> +             if (of_graph_parse_endpoint(rport, &rendpoint))
> >>> +                     break;
> >>> +
> >>> +             /* If the remote device is not available, defer probing */
> >>> +             rdev = of_coresight_get_endpoint_device(rparent);
> >>> +             if (!rdev) {
> >>> +                     ret = -EPROBE_DEFER;
> >>> +                     break;
> >>> +             }
> >>> +
> >>> +             pdata->outports[*i] = endpoint.port;
> >>> +             pdata->child_names[*i] = dev_name(rdev);
> >>> +             pdata->child_ports[*i] = rendpoint.id;
> >>> +             /* Move the index */
> >>> +             (*i)++;
> >>
> >> Not a big fan, makes the code needlessly complex.  Incrementation of the index
> >> can be done in the while loop of of_get_coresight_platform_data().  See below.
>
> Me neither..
>
> >
> > Void that - it properly deals with the first of_parse_endpoint().
>
> Or may be we could do something with the return value :
>
>           1 - Successfully parsed and populated a connection entry
>           0 - No errors in parsing
>         < 0 - Errors in parsing

Right, that is another solution.  I usually try to avoid those but I
think it is better than what we currently have.

>
> >>> @@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,
>
>
> >>> +     while ((ep = of_graph_get_next_endpoint(node, ep))) {
> >>> +             /*
> >>> +              * No need to deal with input ports, processing for as
> >>> +              * processing for output ports will deal with them.
> >>> +              */
> >>
> >> This comment has been broken for a while... It should read:
> >>
> >>                  /*
> >>                   * No need to deal with input ports, as processing
> >>                   * for output ports will deal with them.
> >>                   */
>
> Sure, will fix it.

Thanks,
Mathieu

>
>
> Suzuki
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
