Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78ACC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996102080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544782716;
	bh=6h6X6GXHnbFH+2UbAv08vvsLldRnMgatmWpu3adbFBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hb4c1ae9C+CJQZ9Co+JdhOdoINcu/3m0uAXX5z+0ihSvK9075I04wUw8KFFpYIkXa
	 1aG1BkT9oPtHbcqpPIvhRZTm2vIH7ngy23fCKKZC0U/4lV140IsU2wa66zBiGcOk7M
	 uY/Z0cLXHq71j3xFDQhYix6wuI/+pj8x2n66eEyg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 996102080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeLNKSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:18:35 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41867 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:18:35 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so4883436otk.8;
        Fri, 14 Dec 2018 02:18:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h6X6GXHnbFH+2UbAv08vvsLldRnMgatmWpu3adbFBQ=;
        b=baJ5NSS1Hbr0bwhhWhpRPTdFRw7jVmtGmU4PgV9BYcvOuehJ6HqDXRzGmjxjqPPg0u
         wAWCSolgcK7SRuHFPVAgToKvLruodCdpk89Wep2fJKC3/0HSq1u2vgow2EYtAw7Qipsc
         SysXUxnMQz27huYDzrIynGrBCu9GltLRPzORS6vMMCGW1tTuEkmG7RcZ9r88lTJgpPMX
         mDJYLuruye9FlC8wzesHxujbmsJZ4TnikrlClcMXIRcDVMKH/RTGJ8kEUbeHBigfRPDM
         eQgkjmVlScv6Rgv5naKpQNJnxiXrZhrNuK4YEoAcXyN9Kerhn1vW8ggmbdtbFEFCSCt/
         S7Mg==
X-Gm-Message-State: AA+aEWaNVGcrF2zb74i9H7lpl9UCQMXB6e+j8kY+FXid98z15Y5sAQGD
        DLMvedAmokZhxzdCzs5I0K8WAXwSVaxJGEn1G2M=
X-Google-Smtp-Source: AFSGD/WSFvDeBerZR3F7nzAx0rtwgHo+3CPUuE33wY3jwLCiUXxgPH31iUlG9Nlf5x7jDKSL8lJT2ykvC5s12k4cKdk=
X-Received: by 2002:a9d:5f06:: with SMTP id f6mr1711447oti.258.1544782714487;
 Fri, 14 Dec 2018 02:18:34 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544782279.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1544782279.git.viresh.kumar@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Dec 2018 11:18:23 +0100
Message-ID: <CAJZ5v0h9WCmBNB2K5pd6Z9VnFK4tcT5uVxmP36wHxqM5SkdXYA@mail.gmail.com>
Subject: Re: [PATCH V4 0/7] PM / Domains: Allow performance state propagation
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Nishanth Menon <nm@ti.com>,
        Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Nayak, Rajendra" <rnayak@codeaurora.org>,
        niklas.cassel@linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 11:15 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Hi,
>
> This series adds performance state propagation support in genpd core.
> The propagation happens from the sub-domains to their masters. More
> details can be found in the individual commit logs.
>
> This is tested on hikey960 by faking power domains in such a way that
> the CPU devices have two power domains and both of them have the same
> master domain. The CPU device, as well as its power domains have
> "required-opps" property set and the performance requirement from the
> CPU eventually configures all the domains (2 sub-domains and 1 master).
>
> Based on opp/linux-next branch (which is 4.20-rc1 +
> multiple-power-domain-support-in-opp-core + some OPP fixes).
>
> Rajendra has already tested the previous version of this series and so I
> have included his Tested-by for all patches.

I'm assuming that this set will go in via the OPP tree.

Cheers,
Rafael
