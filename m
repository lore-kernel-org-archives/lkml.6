Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEC8ECE562
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4E820877
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 03:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeVcYksa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E4E820877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbeISJc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 05:32:59 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43380 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbeISJc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 05:32:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id z27-v6so3660747edb.10;
        Tue, 18 Sep 2018 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cC/eaao2v7iakYXE0XNbj8XrWvKVJENxzy/dg3wlAFk=;
        b=IeVcYksaLpeTGz1aQSZhXlv8zNz46ecWBMfQBhQgk7ja4SoJe0/3ftpLQwYOxUOEwe
         l/OiHoSs4qAEX/vQK2COT90Y5Xk2dQ31vxXdFa0MDnfajAi7v6DnnGo8T7z0DOeT77+P
         EZaU/fJ7azQL89xxqLy+N/K4zqUklNPJUEa4ev7ZP6I8aqlfJBZhUNom6bbTisKHCkJM
         5/7pv9kR+D9dxaeFS8I9POWE3AkSAxjE0woJY8HHcWWoE6QDSHhWVuPDtoJmWIP9PKxB
         vVoukzWbFxOxFDbMsEhkubD+23HMMNBI/BhvNClEiyVkvZINYZbyR6qpdSAd7bj5rFs2
         pd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cC/eaao2v7iakYXE0XNbj8XrWvKVJENxzy/dg3wlAFk=;
        b=mgQttAbgm3Z5QRTHeJ7RS92pHx99QFB400nGribLk2WVV4Hklkx3nb1fLFwycU7G4A
         v0ZWeB/OCooKiNLnJmRRJZlt+/4dGaLSXwcKhNWJEGzlJziBVvuUIbYduNKaTwKpmoST
         Oc3cLeH7n61kURwJArpicYZVcZf01+dlqdSI74VnJC/+tvpzJV/ZWqG3svwapP0XRL5Q
         7aXQAh9LXWK+JtdULSyLO+d4FNYrA4lt/eVjZbuFYAq28uzUN6m2gmNBDASyRZMCUjMn
         hACkauTuKH9d7bbAVnAdW64IKq/v7WdZ79UOxoS+ggc7Tyzi3uK5cCh+S82lNR1fFN3n
         i+RQ==
X-Gm-Message-State: APzg51CUSumgZXil4QOV8RvFdUKd3/I/PwRYRlCklUo2ZQKGqukA9yOj
        BStBwGrtILbtMaYWc3ko5eQQ58lKBqFRtWw96A==
X-Google-Smtp-Source: ANB0VdaL7bbaX5nFTHMhfv2lbFclOG2hRB8WC7/trpg5AswfdB6MXFu6Jd1RYOUAmaA3auiPVmUxhF+JmHX2a76zgNg=
X-Received: by 2002:a50:8d5e:: with SMTP id t30-v6mr54327578edt.256.1537329422016;
 Tue, 18 Sep 2018 20:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <1534756717-25553-1-git-send-email-kernelfans@gmail.com>
 <1534756717-25553-2-git-send-email-kernelfans@gmail.com> <76851595.dP8mLy4DGX@aspire.rjw.lan>
In-Reply-To: <76851595.dP8mLy4DGX@aspire.rjw.lan>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 19 Sep 2018 11:56:50 +0800
Message-ID: <CAFgQCTsy-PGogprdVEApnpBuJzDkhiE42MGrYjE-UOpXDkNP_Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] drivers/base: move device_shutdown() to base/power
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2018 at 5:10 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Monday, August 20, 2018 11:18:35 AM CEST Pingfan Liu wrote:
> > Consider the shutdown as a system state transition, i.e. something like
> > suspend, hibernate, hence move it under the base/power. (This is a first
> > step to unify the duplicate code logic on devices_kset and dpm_list.)
>
> I don't really think that device_shutodwn() belongs in base/power/.
>
> Moving it to a separate file sounds like a good idea, but let that file
> reside in base/ proper.
>
> Then, I would separate the dpm_list definition, locking etc out of
> base/power/, move it to the new file containing device_shutdown() and
> make the code in base/power/ refer to it (you may want to move the list
> entry list head from dev_pm_info to struct device directly while at that
> too).
>
> Then, it should be straightforward enough to switch device_shutdown() over to
> using it.
>
Thanks for your advice. I will find a time slot to redo it.

Regards,
Pingfan
