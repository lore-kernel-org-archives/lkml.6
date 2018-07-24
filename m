Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9A7C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AD2A20856
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 21:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q6LnZA9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD2A20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388795AbeGXWmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 18:42:46 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43850 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388541AbeGXWmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 18:42:45 -0400
Received: by mail-ed1-f66.google.com with SMTP id b20-v6so5334484edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 14:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=51eg8JJOpJaJ40fKjOgjOsef8+4tyOTlI9vjBrpuLZk=;
        b=Q6LnZA9kM+/2a+g8nF8FY2ha64NgJmHqJNwAERBMSTLc+V2mwz7vEKLCl3Ko38N/K1
         dBTKXHZJg3oXgXGH99GLnGyOWVZPLrBl2aPLeeuikwVibFwukIunSNZMRd2TRGigka8I
         n63q0vWpn5+Kw5ZC4OSMvCHElGG9H4sWaZtXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=51eg8JJOpJaJ40fKjOgjOsef8+4tyOTlI9vjBrpuLZk=;
        b=GA59K5G9qx20KP5cN5ruedqDZJyCwL6i72ehAp2jSimgCxSplS3OJDq0hdvV3Kahnh
         TwFElK8VRzhWAa+gfJMbqBZM6nadnRk2HezFd+ho7X6RMyxbWBoi2fEJZOGMKm8ti3jA
         POV0YLA466UbS+1NdaoK0OSAwDq99EZm+Mfwy+CXuITNULcXzPIfYCuw8J78T9jUhQrF
         BJ/5DNZVKKRFBthGFzTfj8FK+mVvoZkZLM1QsWtHKjq8YPQV3VjB1UkQ8iAuVxWM7PmS
         WU/myLhOUFRPFRS/xZ2THY3bY4SRzWwBBPmWq8CBR1hxUQw0tGlh3x08FKXvIqT83p0p
         i+gg==
X-Gm-Message-State: AOUpUlHfz8Wcwjpc8aM/Fi94GDhF1Yod87Qt05dXHE5KW10nEc/VsE4v
        u7T4C933rn+yyTKX/7iA/1s9088Ept4vbo8AS7An0w==
X-Google-Smtp-Source: AAOMgpfgnjky0rty4XM24L4DOfvyHiY+gOx5O3lDF3eDStL30BgwgOy+AoVEuSb7FUyZQX49gfcBZupDrwpcLVGiZvs=
X-Received: by 2002:a50:8ea1:: with SMTP id w30-v6mr20267897edw.295.1532468058490;
 Tue, 24 Jul 2018 14:34:18 -0700 (PDT)
MIME-Version: 1.0
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-3-git-send-email-suzuki.poulose@arm.com> <20180724213031.GA22451@xps15>
In-Reply-To: <20180724213031.GA22451@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 24 Jul 2018 15:34:07 -0600
Message-ID: <CANLsYkwDTM2pT0JCCnLdetKoYe6xsmj48Gyb5OJFxJMmRLrZ_g@mail.gmail.com>
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

On Tue, 24 Jul 2018 at 15:30, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good afternoon,
>
> On Thu, Jul 19, 2018 at 11:55:06AM +0100, Suzuki K Poulose wrote:
> > Refactor the of graph endpoint parsing code, to make the error
> > handling easier.
> >
> > Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > ---
> > Changes since v1:
> >  - Splitted from the of_node refcounting fix, part1
> > ---
> >  drivers/hwtracing/coresight/of_coresight.c | 129 +++++++++++++++++------------
> >  1 file changed, 75 insertions(+), 54 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> > index 6880bee..68faaf8 100644
> > --- a/drivers/hwtracing/coresight/of_coresight.c
> > +++ b/drivers/hwtracing/coresight/of_coresight.c
> > @@ -114,17 +114,69 @@ int of_coresight_get_cpu(const struct device_node *node)
> >  }
> >  EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
> >
> > +/*
> > + * of_coresight_parse_endpoint : Parse the given output endpoint @ep
> > + * and fill the connection information in @pdata[*@i].
> > + *
> > + * Parses the local port, remote device name and the remote port. Also
> > + * updates *@i to point to the next index, when an entry is added.
> > + *
> > + * Returns :
> > + *    0      - If the parsing completed without any fatal errors.
> > + *   -Errno  - Fatal error, abort the scanning.
> > + */
> > +static int of_coresight_parse_endpoint(struct device *dev,
> > +                                    struct device_node *ep,
> > +                                    struct coresight_platform_data *pdata,
> > +                                    int *i)
> > +{
> > +     int ret = 0;
> > +     struct of_endpoint endpoint, rendpoint;
> > +     struct device_node *rparent = NULL;
> > +     struct device_node *rport = NULL;
> > +     struct device *rdev = NULL;
> > +
> > +     do {
> > +             /* Parse the local port details */
> > +             if (of_graph_parse_endpoint(ep, &endpoint))
> > +                     break;
> > +             /*
> > +              * Get a handle on the remote port and parent
> > +              * attached to it.
> > +              */
> > +             rparent = of_graph_get_remote_port_parent(ep);
> > +             if (!rparent)
> > +                     break;
> > +             rport = of_graph_get_remote_port(ep);
> > +             if (!rport)
> > +                     break;
> > +             if (of_graph_parse_endpoint(rport, &rendpoint))
> > +                     break;
> > +
> > +             /* If the remote device is not available, defer probing */
> > +             rdev = of_coresight_get_endpoint_device(rparent);
> > +             if (!rdev) {
> > +                     ret = -EPROBE_DEFER;
> > +                     break;
> > +             }
> > +
> > +             pdata->outports[*i] = endpoint.port;
> > +             pdata->child_names[*i] = dev_name(rdev);
> > +             pdata->child_ports[*i] = rendpoint.id;
> > +             /* Move the index */
> > +             (*i)++;
>
> Not a big fan, makes the code needlessly complex.  Incrementation of the index
> can be done in the while loop of of_get_coresight_platform_data().  See below.

Void that - it properly deals with the first of_parse_endpoint().

>
> > +     } while (0);
> > +
> > +     return ret;
> > +}
> > +
> >  struct coresight_platform_data *
> >  of_get_coresight_platform_data(struct device *dev,
> >                              const struct device_node *node)
> >  {
> >       int i = 0, ret = 0;
> >       struct coresight_platform_data *pdata;
> > -     struct of_endpoint endpoint, rendpoint;
> > -     struct device *rdev;
> >       struct device_node *ep = NULL;
> > -     struct device_node *rparent = NULL;
> > -     struct device_node *rport = NULL;
> >
> >       pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> >       if (!pdata)
> > @@ -132,64 +184,33 @@ of_get_coresight_platform_data(struct device *dev,
> >
> >       /* Use device name as sysfs handle */
> >       pdata->name = dev_name(dev);
> > +     pdata->cpu = of_coresight_get_cpu(node);
> >
> >       /* Get the number of input and output port for this component */
> >       of_coresight_get_ports(node, &pdata->nr_inport, &pdata->nr_outport);
> >
> > -     if (pdata->nr_outport) {
> > -             ret = of_coresight_alloc_memory(dev, pdata);
> > +     /* If there are no output connections, we are done */
> > +     if (!pdata->nr_outport)
> > +             return pdata;
> > +
> > +     ret = of_coresight_alloc_memory(dev, pdata);
> > +     if (ret)
> > +             return ERR_PTR(ret);
> > +
> > +     /* Iterate through each port to discover topology */
> > +     while ((ep = of_graph_get_next_endpoint(node, ep))) {
> > +             /*
> > +              * No need to deal with input ports, processing for as
> > +              * processing for output ports will deal with them.
> > +              */
>
> This comment has been broken for a while... It should read:
>
>                 /*
>                  * No need to deal with input ports, as processing
>                  * for output ports will deal with them.
>                  */
>
> > +             if (of_find_property(ep, "slave-mode", NULL))
> > +                     continue;
> > +
> > +             ret = of_coresight_parse_endpoint(dev, ep, pdata, &i);
> >               if (ret)
> >                       return ERR_PTR(ret);
>
>                 i++;
>
> > -
> > -             /* Iterate through each port to discover topology */
> > -             do {
> > -                     /* Get a handle on a port */
> > -                     ep = of_graph_get_next_endpoint(node, ep);
> > -                     if (!ep)
> > -                             break;
> > -
> > -                     /*
> > -                      * No need to deal with input ports, processing for as
> > -                      * processing for output ports will deal with them.
> > -                      */
> > -                     if (of_find_property(ep, "slave-mode", NULL))
> > -                             continue;
> > -
> > -                     /* Get a handle on the local endpoint */
> > -                     ret = of_graph_parse_endpoint(ep, &endpoint);
> > -
> > -                     if (ret)
> > -                             continue;
> > -
> > -                     /* The local out port number */
> > -                     pdata->outports[i] = endpoint.port;
> > -
> > -                     /*
> > -                      * Get a handle on the remote port and parent
> > -                      * attached to it.
> > -                      */
> > -                     rparent = of_graph_get_remote_port_parent(ep);
> > -                     rport = of_graph_get_remote_port(ep);
> > -
> > -                     if (!rparent || !rport)
> > -                             continue;
> > -
> > -                     if (of_graph_parse_endpoint(rport, &rendpoint))
> > -                             continue;
> > -
> > -                     rdev = of_coresight_get_endpoint_device(rparent);
> > -                     if (!rdev)
> > -                             return ERR_PTR(-EPROBE_DEFER);
> > -
> > -                     pdata->child_names[i] = dev_name(rdev);
> > -                     pdata->child_ports[i] = rendpoint.id;
> > -
> > -                     i++;
> > -             } while (ep);
> >       }
> >
> > -     pdata->cpu = of_coresight_get_cpu(node);
> > -
> >       return pdata;
> >  }
> >  EXPORT_SYMBOL_GPL(of_get_coresight_platform_data);
> > --
> > 2.7.4
> >
