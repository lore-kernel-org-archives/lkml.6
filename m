Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB059C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DEC52083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 18:08:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DEC52083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389078AbeGZT0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:26:33 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:39259 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbeGZT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:26:32 -0400
Received: by mail-qk0-f170.google.com with SMTP id b5-v6so1603908qkg.6;
        Thu, 26 Jul 2018 11:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SsQlA7dHHw7awPTUchlblMxo2mcaFUZpeWyOITE4/zc=;
        b=QBZjYxYA721UaAfHDpztJXvt/Zzi8xeclKQMwthGeIqsrYb/ulk5wVo4JatqubU841
         OFXASFuHIeHjIsmjvpqWngIwnfF5vFzVbsCdDXe57n9CQrCqbkTYG+KzM4k0RcMVGW/U
         svjqI7wOgZIr6ENUOn+8APAGcY5W7dU4O+iH5xRB0B733H6ysfjyfi/X1B8nVwkt/35e
         kDdGwY0kfLzi1Fn/+K91AyqRwQvwbx0VxJdmPcMdE8mzFDebvZNZZjDXhVg0aFtm8scv
         6KCbyqNxEn0QxbrpwdmEi78vMPWJfmcowWBvNYIM1bMbbHgI/8JtCQuLiZdqCbc1Ss5o
         J4cg==
X-Gm-Message-State: AOUpUlFn3wfyBe4B81nt/y68BX3jAyh9keNZ23+hE6fm5DF1pHUaoNzR
        UnegA/cHL3AFnhonAsbrPYxYca890Wxcs0hPq08=
X-Google-Smtp-Source: AAOMgpfUccbrvGTlGsfH/p6t4MruL5mjbbvRtJc80Rx7xtFI/mwl364EBS4ZWcSkI71Gg0TRCSV1odt4gyjBHU0FgDg=
X-Received: by 2002:a37:5d02:: with SMTP id r2-v6mr2834073qkb.22.1532628516102;
 Thu, 26 Jul 2018 11:08:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
In-Reply-To: <20180718222656.11795-1-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 26 Jul 2018 14:08:25 -0400
Message-ID: <CAJvTdKkEiMLM5V39mNPrT06Lp5rY+A9LN5StGj7T=oi31S-nRw@mail.gmail.com>
Subject: Re: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL,
 CPUID) (Resend)
To:     calvin.walton@kepstin.ca
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> (I wasn't sure who to send this to initially - maybe the
> MAINTAINERS file should be updated so get_maintainer.pl gives better
> results).

turbostat was added to MAINTAINERS in 4.18-rc1
