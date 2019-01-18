Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459C6C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4A820855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 05:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDrzDLgy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfARFKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 00:10:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:47000 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfARFKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 00:10:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id w7so5458268pgp.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 21:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OqwwRYEBTtVEUmI5mtBxmnkd21H2Z+IIwB9uA7XBDXo=;
        b=kDrzDLgyBTGbpwn7c8/OsBkY0PIV11UyxEAW6v2MCY9FNdlDPflF6C/GGfioOmKOvW
         +vtkIR0hi10j+5XCYUskxsuNbpgWCZPKfONwjqOj/GixqTOxYzjjfz8wd+wSgCAIPO4E
         7WnP5/8Ryd+MF9fYLA8gF3eB8tqKEuzSwHylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OqwwRYEBTtVEUmI5mtBxmnkd21H2Z+IIwB9uA7XBDXo=;
        b=QZUKPyAnX57vM3KvwNZMz9HMkMyFuA6kPH76Qaa9Am6zFigJrDyfSJnFThqVIRhx1n
         DJl1ZewJh0l76qslSYIdj/FL8yt1cil9cSpUO8hmffUpypOURxenxaKtV9CL9YUx+UyU
         5F8piOHCqmooiocgLJGcQ9P9EmjzcSDWDE2lrB9PnnBMoE8g90U0uq6tnELbwKW8OqnO
         E0DBfAHeFoU8YqH1eO4vajV////6ThZ7u1T98l7ay4vuOB8FNSUfYNFRfvoz4vAbjhKu
         yKIvFuEXd+PCaYW9B9n99uoDL3DCiHbSLeO1fW5GCd9/xhE1V4qnmdOsh9aQ+x4UYA6y
         cfjg==
X-Gm-Message-State: AJcUukdM1pQovi6HgcUhGxrYRWo/8vhohC523pg0jZxmPJR6Hd9fM8aP
        e7FxaSlmo9y0ub4e67+RaGb+FQ==
X-Google-Smtp-Source: ALg8bN7/kaVqB04oJzCi6YbeLKIS9lqCqWDET4+wiSltPBbRCcDIj2GTxtzrDoPPYFEx28z3ciGCww==
X-Received: by 2002:a63:fb4c:: with SMTP id w12mr16264319pgj.321.1547788213525;
        Thu, 17 Jan 2019 21:10:13 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 15sm6102297pfr.55.2019.01.17.21.10.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 21:10:12 -0800 (PST)
Date:   Fri, 18 Jan 2019 10:40:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        kgene@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators
 fail
Message-ID: <20190118051010.4ed2ntv2mxfeaoot@vireshk-i7>
References: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-01-19, 08:51, Krzysztof Kozlowski wrote:
> On Sun, 13 Jan 2019 at 20:58, Paweł Chmiel
> <pawel.mikolaj.chmiel@gmail.com> wrote:
> >
> > There is possibility, that when probing driver, regulators are not yet
> > initialized. In this case we should return EPROBE_DEFER and wait till
> > they're initialized, since they're required currently for cpufreq driver
> > to work. Also move regulator initialization code at beginning of probe,
> > so we can defer as fast as posibble.
> >
> > Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> > ---
> > Changes from v3:
> >   - Zero dmc_base pointers after unmapping them
> >   - If getting vddarm regulator fails just return, no need to do goto
> >     jump which would do the same
> >
> > Changes from v2:
> >   - Handle all error paths in probe
> >
> > Changes from v1:
> >   - Fix compilation error
> >   - Reorganize code so it's smaller
> 
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied, thanks.

-- 
viresh
