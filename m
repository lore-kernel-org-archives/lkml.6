Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0982EC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3B1F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="idQE5E07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B1F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbeIKTrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 15:47:18 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34033 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 15:47:18 -0400
Received: by mail-lf1-f66.google.com with SMTP id c29-v6so20606066lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 07:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a3Vyahz+VIMu+dF4LMSmK9oGOhC1B5OQP882WjBX+Ww=;
        b=idQE5E07bR4cDtSN+ZuJYE9SDJUUSS3ikdT4NID+tYYwBi8jmGjtOGo+ZFBS7euNmg
         ulYbrxoiRAn4X7/Fvz4YNjRlbD2DrHeFHvT/rp+FUgn01J9freqm1Ufzs9QYt1+E4VMM
         KGOSDa8ML5xir2BfID6Nia692rP3382WByfK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a3Vyahz+VIMu+dF4LMSmK9oGOhC1B5OQP882WjBX+Ww=;
        b=hVS4sOEDEnwOnrhVjrx1lPiszHgdHe0CYqXr/Qxd/1okrKeJf7ofGlfU6iDiLZGx1T
         iXvMiDNMeG+M57k91nkxeDoP1rWHP7b4WA/WOmhvXMTypJebMx+oVwZe6M/PI00XPxop
         LNU7InU+ZLQeaaiC9MSJVuClC/Jdb9edGzCefCD8qpKheqlIBf7eh/0UXQy7lhXHmoz4
         WQ4vjzIelRp+izmYm77ADRovGPx3Eyjp63crsUTCFC8jgoUIr4ubfniEVvnfzstfc0CB
         JhUIGmsa8bEx8eyWlQdx1RxmYV2kOks8gmg5IywniXhgaxsOF4rUSWMbmLhAbvnHziqV
         saMQ==
X-Gm-Message-State: APzg51DI0oE3zjFmNrPwQ6ddJDdedwHKCad5FJBwGRTKuFWvymXrGzgF
        dgruYC7G9b0UT7V9JajceeuIZJ1qfS3US/3XYT/Dig==
X-Google-Smtp-Source: ANB0VdYgz7OtgMn4OE7DsvEdMAM1n2RdW0uaDf4g5OJ+IdbyJAa+efscdkZHrln5QaPj2pF6RHNT7co0H2JzI3BNGX0=
X-Received: by 2002:a19:ef18:: with SMTP id n24-v6mr16484865lfh.36.1536677258055;
 Tue, 11 Sep 2018 07:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <1536655641-26192-1-git-send-email-suzuki.poulose@arm.com> <20180911103509.GA770@e107155-lin>
In-Reply-To: <20180911103509.GA770@e107155-lin>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 11 Sep 2018 08:47:27 -0600
Message-ID: <CANLsYkzaHsi=V+GZaJ+hdzDODT-BRHU42fPJ1Vu-aX726E=grA@mail.gmail.com>
Subject: Re: [PATCH] dts: juno: Enable coresight tmc scatter gather in ETR
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        coresight@lists.linaro.org, Robert Walker <robert.walker@arm.com>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018 at 04:35, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On 11/09/18 09:47, Suzuki K Poulose wrote:
> > We do not enable scatter-gather mode in the TMC-ETR by default
> > to prevent malfunctioning of systems where the ETR may not be
> > properly connected to the memory subsystem to allow for simultaneous
> > READ/WRITE transactions when used in SG mode. Instead we whitelist
> > the platforms where we know that it is safe to use the mode.
> >
> > All revisions of Juno have a proper ETR connection and hence
> > white list them.
> >
>
> Applied conditionally, this conflicts with the patch Mathieu has in his
> branch. He needs to drop that so that I can take both of them via ARM SoC.

As I communicated yesterday, I've already dropped that patch from my tree.

>
> --
> Regards,
> Sudeep
