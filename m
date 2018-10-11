Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DBDC32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7DB2075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:28:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="alhO/D+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7DB2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeJKW4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:56:21 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:54147 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJKW4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:56:20 -0400
Received: by mail-it1-f194.google.com with SMTP id q70-v6so14088538itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 08:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2O3fbISqZ2mS5H6M0aEft29GcNr4kGewWd3ZG5SJSJQ=;
        b=alhO/D+FYVHwN1h4HGWW7F/A1qjpn5eJa/9CvdyGmIGqUvtUqsAkrjcYl5elsGoQiq
         2It0iSF8ltSEisReM9vO00rVtX8H29CKhFVrAzs7KmdLvFLNUfOOVrRD96w++04caivM
         kvx2ayCXF85UPmU3srkKERUeN4b2pIg5AYkrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2O3fbISqZ2mS5H6M0aEft29GcNr4kGewWd3ZG5SJSJQ=;
        b=YTV/sg3s7JeQ+xZ2lBpPQBIytXOzyNKVkjp3aRvhO0gy/jgJdeyz7fKZDc/c5UrSB+
         zg+lz0EP5i+GcJkYrqGUaQYVzlZhsZbjpfwAmgyDmvniBmCIGQ8KUSp7pJvAdVkuCm8T
         H7N9b9MiLlXb0nLQJtJm+3MlZvgFnJXUeh9uHnO2jtPQFVMaO8PodmX+nUObBx+LWicz
         3SeAy6fBnQFKtYOa9TtZtK0v4Ak7hICL2Py4svJ7YIgQLV71V0g/ZQ5YNIsjSe0Nc7lp
         HPqqlKTUJLE0QDQwPWNuWSeXLorgkYlNZpFnZCb1iZ5E78oLfre5EMzFORuT4mx4e3/Q
         uLuQ==
X-Gm-Message-State: ABuFfohFiqYomWqF5JYpAIfTU+gQWv6B9OBh4BxzDG6S/XP2K0Utvzuy
        Jgc2oPzKW9x8LVdtbLp4WZYk3fp54++uUenpSXnlHw==
X-Google-Smtp-Source: ACcGV63rtaNL7ckCjYYhVhfTthp2X65VrIB3LTzMt1feaGbMglx9qauXMiFM6AcIDzrW0Q9pcpVbfR5//3ibJ4NY9a4=
X-Received: by 2002:a24:554c:: with SMTP id e73-v6mr1739874itb.157.1539271719566;
 Thu, 11 Oct 2018 08:28:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3941:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:27:59
 -0700 (PDT)
In-Reply-To: <20181011111306.GB32752@e107155-lin>
References: <1539206455-29342-1-git-send-email-rplsssn@codeaurora.org>
 <1539206455-29342-5-git-send-email-rplsssn@codeaurora.org> <20181011111306.GB32752@e107155-lin>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 11 Oct 2018 17:27:59 +0200
Message-ID: <CAPDyKFpXJ4MbqFOmDboBuR_1sziyuDi3qgKVvhokaAnQQ+kzjA@mail.gmail.com>
Subject: Re: [PATCH RFC v1 4/8] drivers: qcom: cpu_pd: add cpu power domain
 support using genpd
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Raju P.L.S.S.S.N" <rplsssn@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-soc@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Doug Anderson <dianders@chromium.org>, mka@chromium.org,
        Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 October 2018 at 13:13, Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, Oct 11, 2018 at 02:50:51AM +0530, Raju P.L.S.S.S.N wrote:
>> RPMH based targets require that the sleep and wake state request votes
>> be sent during system low power mode entry. The votes help reduce the
>> power consumption when the AP is not using them. The votes sent by the
>> clients are cached in RPMH controller and needs to be flushed when the
>> last cpu enters low power mode. So add cpu power domain using Linux
>> generic power domain infrastructure to perform necessary tasks as part
>> of domain power down.
>>
>
> You seem to have either randomly chosen just 3 patches from Lina/Ulf's
> CPU genpd series or this series doesn't entirely depend on it ?

Yep, it not easy to follow. But I do understand what you are trying to do here.

>
> If latter, how does this work with PSCI CPU_SUSPEND operations ?
>
> And why this can be part of PSCI firmware implementation. Only PSCI
> firmware needs if RPMH votes need to be flushed or not. So, honestly
> I don't see the need for this in Linux.

I do think there is clear need for this in Linux. More precisely,
since the PSCI firmware have knowledge solely about CPUs (and clusters
of CPUs), but not about other shared resources/devices present on the
SoC.

What Raju is trying to do here, is to manage those resources which
needs special treatment, before and after the CPU (likely cluster) is
going idle and returns from idle.

One question here though, what particular idle state is relevant for
the QCOM SoC to take last-man-actions for? I assume it's only cluster
idle states, and not about cpu idle states, no? Raju, can you please
clarify?

Historically, the typical solution have been to use the
cpu_cluster_pm_enter|exit() notifiers. Those could potentially be
replaced by instead building a hierarchical topology, using
master/subdomain of genpd/"power-domains", along the lines of what
Raju is doing. However, I am not sure if that is the correct approach,
at least we need to make sure it models the HW in DT correctly.

Kind regards
Uffe
