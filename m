Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63078C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 304B4218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 04:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYOI4xQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbfBREPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 23:15:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41486 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728497AbfBREPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 23:15:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id b7so7861132pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 20:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rCBtixOAlRrBLd9IV7bCItMVBYm9rP9pmV8AxVhu9bA=;
        b=jYOI4xQiRUUAQWcOm5RSDqwonEyRsmBOrQN1/pqQ4l1MF1cix+Wv13QPfQq4/aTkMK
         mMfBRAV4rPiieCFgH02zSMTZynxi84JyqjgNjzwNRN5fRlLRErgfjvdM/q9ckXPgilIA
         0PYYsqO/MNQK67v+gIK++VNzgWiKDhtVYBI0G/ybQEVPjzqCU2CMDXQaHdnqUJSfV9v3
         IyUjVGvwLIXp9emS6WzsvjzcQDya/RfJddyqiGGavtxiUEbCKdpbDOF6g2YUtEmwvU3C
         rRmPTuzMCIy07aRlShSRmsXpfIKmFuyM7WtrIh+ZShX+qO9jLgV6mAoHSfuNZI6Ze6zt
         +HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rCBtixOAlRrBLd9IV7bCItMVBYm9rP9pmV8AxVhu9bA=;
        b=Pg3sl0RXx5MSRlN0KKmB4O5qwgcguMU1yOt9swdOl0ohMbvfWDFwvLi0QKa9QglO9u
         N1IfKoZKcYmyojW924MzagPbdpAVKwMnGq2kG6CvHlZ40GYzKnalRozG6AORMKKQxmPS
         IeGtILAt64zHZGX7vNuWq+gf30XzdgE+sGjv2jvypDANr3xqtz7tkrlVyRVq09co39Nm
         Je2FPAKqy2Jc8BAXoFJlJvneOequS3YJa+dEu4Wh0M9Uy21RBusOb4Xw1OMkq1FZzE0w
         75QNTX2tCviSrsPtmvESlbiTaJxRf5xkBP0s2vZXezcss5gqpzoqhCs5mjHLUMsaQ2C/
         5dOA==
X-Gm-Message-State: AHQUAua5FGL8GePM8t6lZGB8rgukd3nz9W2FxmH81ih6nPsUL8s3HSIJ
        6j+qmtbMpnvwDeY+0O9Q7SRS4g==
X-Google-Smtp-Source: AHgI3Ibuutk24r+4p+neRIhK6MyfBVX5vlFOxzGHTf9asMCN9Gu9bTCDKA9mBuV/y788Rmps4mZJEA==
X-Received: by 2002:a62:7086:: with SMTP id l128mr22181952pfc.68.1550463318349;
        Sun, 17 Feb 2019 20:15:18 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id 20sm2030889pgr.80.2019.02.17.20.15.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 20:15:16 -0800 (PST)
Date:   Mon, 18 Feb 2019 09:45:14 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-pm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Kevin Hilman <khilman@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Domains: Mark "name" const in
 genpd_dev_pm_attach_by_name()
Message-ID: <20190218041514.yn76qm65k77etedr@vireshk-i7>
References: <20190214181249.2749-1-dianders@chromium.org>
 <20190215030205.g6ntaiec3kscsaoi@vireshk-i7>
 <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=WH9zg62ME5Atk2NDXX8rLn0qMY3-P1U8jqDr4Th_BX_Q@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-19, 07:47, Doug Anderson wrote:
> Hi,
> On Thu, Feb 14, 2019 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-02-19, 10:12, Douglas Anderson wrote:
> > > The genpd_dev_pm_attach_by_name() simply takes the name and passes it
> > > to of_property_match_string() where the argument is "const char *".
> > > Adding a const here allows a later patch to add a const to
> > > dev_pm_domain_attach_by_name() which allows drivers to pass in a name
> > > that was declared "const" in a driver.
> > >
> > > Fixes: 5d6be70add65 ("PM / Domains: Introduce option to attach a device by name to genpd")
> >
> > Not sure if this should be counted as a fix.
> 
> I'm OK if the "Fixes" is stripped when applying or if someone tells me
> to re-post without the Fixes--just let me know.  In general I do a lot
> of cherry-picks from upstream and I appreciate the Fixes tag helping
> to link patches together.  In this case if I picked the original patch
> I'd definitely want this one too.  Certainly, though, CCing stable
> would make no sense in this case.  ;-)

I am not sure if this is being done right now or not, but I read/heard
somewhere that stable has started picking "Fixes" patches directly as
well even if they aren't cc'd to stable.

-- 
viresh
