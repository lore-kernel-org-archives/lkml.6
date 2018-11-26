Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3CDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 451C320862
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 13:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kjhFS2IS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 451C320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeKZXyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:54:50 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33470 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbeKZXyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:54:50 -0500
Received: by mail-it1-f195.google.com with SMTP id m8so6987523itk.0;
        Mon, 26 Nov 2018 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aurTFiuGcAp0aZRcwPqJiCDfSL5ycdScu5LfdN6gKNk=;
        b=kjhFS2ISx1RFdEAsDcTf73+6wKk4QpAaMdKKui3PbyIRZn3cNhRgz0HV9iO+DB7IRv
         zEKuJp3WnJYEpv0h8fbBH7hyO3uu4XCACgOYaEt+eZev6C7KfSFW0rU+o+FDYZ4eKVn8
         pACee20caNHKYkD0CTd7CXrmCCr9lNAGkJ5mAzi3o+v3eZ67dg+GvdnFkpKbsRUprX4c
         jNUv67LbySBuhXmWfCEo7FUzan5Mue3KM65zxwu0jFm+5+Ur92egw5Bzz52/tgP7pFra
         rVnAcZkfTtzP/2D2MF2GsgBBzWGM7IqTsrxB0NBMRKUkQ+cGfzv8UD9+BFHPu1O1YsiM
         7YnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aurTFiuGcAp0aZRcwPqJiCDfSL5ycdScu5LfdN6gKNk=;
        b=PGnnKW0w6Z8aKiGupK6gWC5y6VJ6ZeUXE6iO70XkhGd2UmG3KvZZKgR3e28mWV+lwS
         7JcdASdpsP40soP2VbAFAHmkr7+3SnIwCIx79XueO9ETfxvj3f7d17W4tefs/iXKOxK7
         J7ZxYbpWuuKnimzz/4qyXBUSMGNgWxq2PCWTUGr4sJYN2LMQLtL+em+ZjPxxqb0cT7E6
         +KxTXbKMMJgqbCNY8q2l8rvKlgOWcTXWCvB+hmsAKEx1w+zDh4nzWS5CSD+WHodz2dWq
         KIeJUQ4tD3keFU+powYr7OhYo8W2ZNN2ZdTFA7gnuKa8AbHvdjKg2uyDoDTb64ZcViZT
         5HJA==
X-Gm-Message-State: AA+aEWbhAEwMt2ctPP4YJOJZGILzW/DINKSAYHR6LvZHGHPMOwnR972y
        zLX3DPPIaisYlt9RyKdlCOyd+xn+eQYN9RuS46s=
X-Google-Smtp-Source: AFSGD/U71LBiXCAc+cjpmoz2Lh67bPnr/Ou4RlcyM+deVTbsfUwSyQBFNDnsoyvlbjngRPh6dlZKnal5k8vaSmvqC5g=
X-Received: by 2002:a02:5184:: with SMTP id s126mr18601064jaa.12.1543237245405;
 Mon, 26 Nov 2018 05:00:45 -0800 (PST)
MIME-Version: 1.0
References: <20181120160530.21015-1-tiny.windzz@gmail.com> <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
In-Reply-To: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 26 Nov 2018 21:00:23 +0800
Message-ID: <CAEExFWu7rt8oOHFtrvy0h=gwhMaNFXHuaaOxTnLcQfZDXsy9yw@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
To:     ego@linux.vnet.ibm.com
Cc:     rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org,
        mpe@ellerman.id.au, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 12:02 PM Viresh Kumar <viresh.kumar@linaro.org> wro=
te:
>
> On 20-11-18, 11:05, Yangtao Li wrote:
> > The of_find_node_by_path() returns a node pointer with refcount
> > incremented,but there is the lack of use of the of_node_put() when
> > done.Add the missing of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> > Changes in v2
> > -update changelog
> > ---
> >  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> --
> viresh
Hi Gautham=EF=BC=9A

Can you add your Reviewed-by here?

Thanks=EF=BC=8C
Yangtao
