Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65120C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D489262B9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PUf5ehQh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D489262B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeFYXay (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:30:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:35462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754586AbeFYXax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:30:53 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27B08262B9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 23:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529969453;
        bh=DkAaudqMaICWlyvx+eL3GnoFibBH1UjXD7UotZ6/dDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PUf5ehQh3g3HLxYZ6xXbaTIpW30Qo+oo6GPMYsEYaZ/WKieRDlnZaufJGD+7LK1zi
         h0tJLqv6XUjw7ea77KdVxA/gjRsw/6Hi6xEnZcL7+IiE+rKG+4+LsYQQ5rcqAFEFUY
         Z7TrJ58xWZx5AxynbT+oH5WV40sZGQcUbh1YlNew=
Received: by mail-wm0-f49.google.com with SMTP id l15-v6so13747587wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 16:30:53 -0700 (PDT)
X-Gm-Message-State: APt69E05h/I15xiss3NUqScpZpYYfUfEdZCxZ+EA0bgquMVwVNWPqVwx
        d7O1H5EoR/2c0XXgok/+eKjLgiK3mfigfoqm1n/m4w==
X-Google-Smtp-Source: AAOMgpfEXrZN0nYtseFyF+3E6n6cUyHLsYjo6IOF7/aDDwJ/dY4kDBS4kLMMu1gWNGYiYmYssU14RgVi63ltjEfXJ1c=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr2430463wma.21.1529969451689;
 Mon, 25 Jun 2018 16:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com> <20180622055659.GA255098@joelaf.mtv.corp.google.com>
 <20180622132843.GN3593@linux.vnet.ibm.com> <20180622181916.GA13628@joelaf.mtv.corp.google.com>
 <20180622143247.781028b1@gandalf.local.home> <20180622200548.GA114655@joelaf.mtv.corp.google.com>
 <20180625082824.GB21377@X58A-UD3R> <20180625163951.GA52646@joelaf.mtv.corp.google.com>
 <20180625162557.7140664c@gandalf.local.home> <20180625204708.GS3593@linux.vnet.ibm.com>
 <CALCETrVD6CxY0gDcfNfy8rNK74UZKnVvBJfiK7pLbZLiqgEbOg@mail.gmail.com> <20180625181638.7fb84df6@gandalf.local.home>
In-Reply-To: <20180625181638.7fb84df6@gandalf.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Jun 2018 16:30:39 -0700
X-Gmail-Original-Message-ID: <CALCETrX3KOOhNP14CcZ60W9ys3F6hC+oH2xyF9a2OPOO_Lqv3Q@mail.gmail.com>
Message-ID: <CALCETrX3KOOhNP14CcZ60W9ys3F6hC+oH2xyF9a2OPOO_Lqv3Q@mail.gmail.com>
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        joel@joelfernandes.org, Byungchul Park <byungchul.park@lge.com>,
        byungchul park <max.byungchul.park@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 3:16 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon, 25 Jun 2018 13:47:45 -0700
> Andy Lutomirski <luto@kernel.org> wrote:
>
> >
> > As a straightforward example, NMI and MCE can nest inside each other.
>
> But I'm not sure how stable the machine becomes when MCE's start
> interrupting NMIs. Also, can MCE callbacks use RCU?
>
> > IIRC we treat #DB somewhat NMI-ish-ly as well.
>
> And #DB is something I think we finally said shouldn't be done in NMIs,
> IIRC.
>

No one ever applied the patch to make it so, so we still support it.
