Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AEEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F26526816
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 06:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByuQAzA+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F26526816
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeF0GTd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 02:19:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:56164 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeF0GTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 02:19:31 -0400
Received: by mail-it0-f65.google.com with SMTP id 16-v6so5830367itl.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 23:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uA2Pb/30EqiDSghX6pdSdb/uURjYSTOOFfuufwsoc40=;
        b=ByuQAzA+9pjXvvlprA9DxPKdjYNeZybGoICjpsGynJbFyR2m7xRZlLrfjnGJ4i71wG
         W5XxVmbkHnsbPcnf1QIDtFLQhiYwkPpqGgLzTFPP+xI7O2UnJ+caR8ntwzqMeGflSb0t
         gmqDenvrd4ksj6bo095TBEO/SXf6FfLFVc0OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uA2Pb/30EqiDSghX6pdSdb/uURjYSTOOFfuufwsoc40=;
        b=hREKuktnsu1HTgtpnBubAc1wFh7F0elB8UDhWShzLbvb6sEBQYkgx1ECepGOepybwj
         ZeQI+3b1vcn1/EtS3oEGNhPd7UIeNGOhNxrJt1GWixpc44h5ce9jooDAGinztpC6jIV0
         krp7t6z0IsHZ5HCL3w7OCkerCGInp/n5WhRmyAKcnP5i/JICUIUz35947j5EUHyNXMPF
         0Aov0/RQeIEXRm+lXA+wU+2qrBIddAKktvkJn/wX5F1v2o2mKUOXnN3RUMg0NFSgPECz
         cL106YuWONi2EqVuaNoJ4hFr4YeQiavxbGw+cEgoVx9xuu4o45NFOmNlkJRVPKYAOnNW
         9vCA==
X-Gm-Message-State: APt69E0KKBqCTTyqOVF94UUyCQFGSR2OohRNTFnXJHCxj5trSuqHeXT4
        X5WJR7GCjbsOBgXvhQu6S+l2yP/4izV/bDpXkmLktw==
X-Google-Smtp-Source: AAOMgpdlPdJ6udtLV4Ij0+241w3OwoQgPXnAxIiBBcV37u18j9wHqT3rRvcFSMrGIoNUgAbCbp8bepLnnqKuIqbNBzc=
X-Received: by 2002:a02:4e46:: with SMTP id r67-v6mr3810146jaa.101.1530080371128;
 Tue, 26 Jun 2018 23:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180620121141.15403-1-georgi.djakov@linaro.org> <20180620121141.15403-2-georgi.djakov@linaro.org>
In-Reply-To: <20180620121141.15403-2-georgi.djakov@linaro.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 27 Jun 2018 08:19:20 +0200
Message-ID: <CAKfTPtBApjf9rhJm3paeXdgbVG50ALeun=zMUddc-f+RnrvkqQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] interconnect: Add generic on-chip interconnect API
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     "open list:THERMAL" <linux-pm@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>,
        mturquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        daidavid1@codeaurora.org, Evan Green <evgreen@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        abailon@baylibre.com, linux-kernel <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Georgi

On Wed, 20 Jun 2018 at 14:11, Georgi Djakov <georgi.djakov@linaro.org> wrote:

[snip]

> +
> +static struct icc_path *path_allocate(struct icc_node *dst, ssize_t num_nodes)
> +{
> +       struct icc_node *node = dst;
> +       struct icc_path *path;
> +       size_t i;
> +
> +       path = kzalloc(sizeof(*path) + num_nodes * sizeof(*path->reqs),

Should be (num_nodes -1) * sizeof(*path->reqs) as there is already 1
icc_req in icc_path struct

> +                      GFP_KERNEL);
> +       if (!path)
> +               return ERR_PTR(-ENOMEM);
> +
> +       path->num_nodes = num_nodes;
> +
> +       for (i = 0; i < num_nodes; i++) {
> +               hlist_add_head(&path->reqs[i].req_node, &node->req_list);
> +
> +               path->reqs[i].node = node;
> +               /* reference to previous node was saved during path traversal */
> +               node = node->reverse;
> +       }
> +
> +       return path;
> +}
> +

[snip]
