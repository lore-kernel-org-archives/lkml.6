Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F21C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A7E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pj4Fk0jD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A7E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730492AbeGZPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:21:47 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46680 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729877AbeGZPVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:21:47 -0400
Received: by mail-ua0-f194.google.com with SMTP id r18-v6so1135120ual.13;
        Thu, 26 Jul 2018 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WWbbh2qvNFM7bSl2x7J6re4mTHa6Mav16SIeH4UQWeM=;
        b=pj4Fk0jDoOvD3is0yM4Fj30gMzVgecxAaqTExSLdapfkLLYHOy1NrIX2ECK4CQbMos
         ZDlyhov7yJOfj6QBUEoY/EgJ3EHHRzeuxp0C+WxleYjv+3Suo4cXc2Msd0FIpzneOG02
         kjYt+A7ozhYx2ncfKMawdASZ5XQNnsElu6TinUT4b/ij6cL74xUrGX4Kwd/wygMMWOPJ
         dNWKiACuSXBTAeE826Pv7BbevMjxjS/DBqvi1/QVSJSbBFhVkCV7KDEe3rBk13iuN9gA
         QmZ7KdP/vc0swGhkGQxipw4RvXgPPZG97AIyLBm4BK10W+Si+9HcP62HZeOs9ovQ1v7u
         uD0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WWbbh2qvNFM7bSl2x7J6re4mTHa6Mav16SIeH4UQWeM=;
        b=r77+K1Xq6l6iD9Fr06ov21x7/lENnnJyFcrPjQl9McG1mbVxetHivjxMotlETOriQg
         nVTlGQxyEdBQBEAthLSXtqYZQT4K/ebBHniSELDsAYquuYU8PMjp2Dw+MtDvqGz/D2yw
         5q6JndPRA49L8/xyTVcx9fEo5hN7tD+eNv1oNEuzC4qhG5A38UmLzGpFSJ1T5p+t4JhR
         yZGrQnJzfYhEkZRp1Ecc9OIPJqvV87E+Z2epc+S+ViaYzl9WKANCS6+aN32vP2fShsUU
         qGulTDPNlK/2zxbadgRaIHfus6069tGFUVKqdvjYDrucWFYZASf7e9mCC/oNv28YgIzX
         HWLw==
X-Gm-Message-State: AOUpUlFrL6xZ4UY2+Z7KckX6YmBf5uBcG6eDsgkkmIGGtzO6bL1HYYbx
        NlFR48J1Zqs7F8Bs7w9Yxs6crntCSjjGX0Lp2tk=
X-Google-Smtp-Source: AAOMgpdz3bSyys6w1ECF2E9QqoC4eZNrg05aeZ5MpsNxcACXj9Qy0+gkwK657ZemBOCFmiQVfMLYGmgdXhr9bH7116o=
X-Received: by 2002:ab0:6037:: with SMTP id n23-v6mr1474815ual.28.1532613886003;
 Thu, 26 Jul 2018 07:04:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 07:04:45
 -0700 (PDT)
In-Reply-To: <20180726093620.3876-1-hu1.chen@intel.com>
References: <CAHp75Ve7i0QsrjshtMMp0cb44Mtet-SHDN+XuQHF-EHH_KuZEQ@mail.gmail.com>
 <20180726093620.3876-1-hu1.chen@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 26 Jul 2018 17:04:45 +0300
Message-ID: <CAHp75VeuCQ+R-rK+sYbZM_ED4R5aXSXy_QiAOPd4wE7FmBxX2Q@mail.gmail.com>
Subject: Re: [PATCH] serial: core: stop passing NULL in uart_resume_port
To:     Chen Hu <hu1.chen@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 12:36 PM, Chen Hu <hu1.chen@intel.com> wrote:
> Is it better to modify the DesignWare 8250 driver directly? Or do you think is this really an issue?

I have checked all of the users of do_termios in 8250 and only DW
bails out on old == NULL.

So, send a patch against 8250_dw with detailed explanation why it's
wrong (use case, examples of wrong output, etc) and how you fix it.
Describe any potential side effects (b/c it's a new behaviour).


-- 
With Best Regards,
Andy Shevchenko
