Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id w0MgB8yGGFvdWQAAmS7hNA
	; Thu, 07 Jun 2018 01:13:48 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id EAB696089E; Thu,  7 Jun 2018 01:13:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AkFbiFl3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6FFE1607E4;
	Thu,  7 Jun 2018 01:13:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6FFE1607E4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752729AbeFGBNp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 21:13:45 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:35377 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbeFGBNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 21:13:44 -0400
Received: by mail-ot0-f193.google.com with SMTP id q17-v6so9565702otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFjXnjGjtbsJFts1Lm8+qwzAxVpOsPLU+KcTzhoWHPo=;
        b=AkFbiFl3LP+96wFCojgk9UKWRLHN75qrUzmtSn+dpY/gxfEVBT1DV9gLuh8qy4HumZ
         WZwaao1LJGVljQVIe7Y2iN2NIS0AQVMqXBcISWZQli2AXe962sViHWnNfslcFfPeqx1u
         v66vX0dTMzTaB7Q/xiHcrLPSwKe4YLdQBBl/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFjXnjGjtbsJFts1Lm8+qwzAxVpOsPLU+KcTzhoWHPo=;
        b=r75Hm3UruxSAhWs2fhHW/KBeb/olzY64D6hqm+P6/DGN+xDI8QY7JQZJ7AJQBzOGtl
         tcZEww8ZbSNNI/RfocGLF41WBDmIlp2+w3CgyOR8yzIWEBtoxmv0wjtGITf1T1U7KxM2
         8rh1+RUR4DLktEmGs7Tr49TsanqmH39lx2zelYFp8rDE2RybsYc1jO/73eVi/dkgKoZy
         0Ze/U2p6QfL77IFBPfCmayxxi/vU2n1jewpmdhheiU/eNUsJmLuMsm/xUNQe86Lz4NhF
         QKsSwDnaBuji9AkKcRO/zYGvxm529IxEPsUsSAa1aT0ZQ5qgKuMgEScqxh+pbiUtFjA/
         lNWQ==
X-Gm-Message-State: APt69E1EL6RssD+Ct/4bkbPBKWy+oI44x6fNGy6oJ/d024kS2iXgc/+1
        rr3NFHtpehMC00h9NVTX7ctzUEyy8k0=
X-Google-Smtp-Source: ADUXVKJsmOM8eolAQL/hY2lnq+kQBMUnitOI1zN7WLvio/YKy/839/tGKLrf5lHWoBpP4k1GKvnZnw==
X-Received: by 2002:a9d:fe5:: with SMTP id m34-v6mr3249124otd.372.1528334023554;
        Wed, 06 Jun 2018 18:13:43 -0700 (PDT)
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com. [74.125.82.169])
        by smtp.gmail.com with ESMTPSA id 97-v6sm4232832oth.15.2018.06.06.18.13.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 18:13:43 -0700 (PDT)
Received: by mail-ot0-f169.google.com with SMTP id q17-v6so9565667otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 18:13:43 -0700 (PDT)
X-Received: by 2002:a9d:fba:: with SMTP id d55-v6mr3539656otd.53.1528333605582;
 Wed, 06 Jun 2018 18:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <20180309210958.16672-1-georgi.djakov@linaro.org>
 <20180309210958.16672-2-georgi.djakov@linaro.org> <CAE=gft76VpU1mXgNPK9-XTj6WoLHj-_SxAGuV-bUSNYVpfSn6w@mail.gmail.com>
 <43fedb5b-f4a5-8362-d0a2-534b85473bc1@linaro.org> <c98d2ee2-c4fa-eb35-e6ae-f6d9c91ffe6c@linaro.org>
In-Reply-To: <c98d2ee2-c4fa-eb35-e6ae-f6d9c91ffe6c@linaro.org>
From: Evan Green <evgreen@chromium.org>
Date: Wed, 6 Jun 2018 18:06:05 -0700
X-Gmail-Original-Message-ID: <CAE=gft71Y+0dcYtJmq6nxG99--yRGUXf+B9_+GWPTTrin+TBjA@mail.gmail.com>
Message-ID: <CAE=gft71Y+0dcYtJmq6nxG99--yRGUXf+B9_+GWPTTrin+TBjA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] interconnect: Add generic on-chip interconnect API
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org,
        rjw@rjwysocki.net, robh+dt@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>,
        Saravana Kannan <skannan@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, seansw@qti.qualcomm.com,
        davidai@quicinc.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 11:09 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Hi Evan,
>
> On 06/06/2018 05:59 PM, Georgi Djakov wrote:
> >>> +
> >>> +/**
> >>> + * icc_node_create() - create a node
> >>> + * @id: node id
> >>> + *
> >>> + * Return: icc_node pointer on success, or ERR_PTR() on error
> >>> + */
> >>> +struct icc_node *icc_node_create(int id)
> >>> +{
> >>> +       struct icc_node *node;
> >>> +
> >>> +       /* check if node already exists */
> >>> +       node = node_find(id);
> >>> +       if (node)
> >>> +               return node;
> >>
> >> This is probably going to do more harm than good once icc_node_delete comes
> >> in, since it almost certainly indicates a programmer error or ID collision,
> >> and will likely result in a double free. We should probably fail with
> >> EEXIST instead.
> >
> > In the current approach we create the nodes one by one, and the linked
> > nodes are created when they are referenced. The other way around would
> > be to create first all the nodes and then populate the links to avoid
> > the "chicken and egg" problem.
> >
>
> Just to elaborate a bit more on that: We can't actually register all the
> nodes in advance, as we might have multiple interconnect providers
> probing in different order. Each provider may have nodes linking to
> nodes belonging to other providers (not probed yet). That's why we
> create the nodes on the first reference and then, when the actual
> provider driver is probed, the rest of the node data is filled.
>

Ah ok, the extra explanation helped a lot. This makes sense to me. Thanks.
-Evan
