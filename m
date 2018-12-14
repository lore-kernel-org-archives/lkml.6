Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F55120811
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544809577;
	bh=PUD9WQCP8s1l7G3dhRROEuwEXKvA+VuOZmaG62FMnS0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NyUsi/gEUyXbY9F4WZApxpROR6qRlZMzaENgLq0aKPFvHfQcNpm+6hZF8gmJIUbEE
	 HvuhoEKAI3ijj2eLaS+0/rQ2GuFJvqcIeTsgAVzJN+gIH8N0sFV9+QjuYOH68gNv0K
	 J5sk+d3vi2MwUUKcTnoWDkYxDa5pAqlCXYhJB3+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbeLNRqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:46:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:48792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbeLNRqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:46:14 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0BD206BA;
        Fri, 14 Dec 2018 17:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544809575;
        bh=PUD9WQCP8s1l7G3dhRROEuwEXKvA+VuOZmaG62FMnS0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IBD6YTby/nlmYJNiiboQlzEJ9r7D7y1wVc1McCWV+48igW4JxZR+hJkhfftyYQplT
         LxLjvaTWJlGx3auKPD6Scxu308vaUimLwtm+xaPPooqCPgTG4mcH1YRlbwfq4RFp56
         JqNtGFd4jOgE7EtyBNJsJNv9/NRm9YRRuP94qepw=
Received: by mail-qt1-f176.google.com with SMTP id y20so7053473qtm.13;
        Fri, 14 Dec 2018 09:46:13 -0800 (PST)
X-Gm-Message-State: AA+aEWZOQFAz2BLv/h1L6Pl3lBW5oB18l8nQKNa1UUm3OvAegOs1Hfiz
        c3hG7snhz8HHnFBxUR5XJK7uSaYLS9djYXBmDg==
X-Google-Smtp-Source: AFSGD/VZ3ixoqhZC16GRfItol+dMpWfXxWQ9riM3srypdETaJTipM0JC82oeXg6685o+kr/crpHIJLUQpiNbObFxYjw=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr3701840qtd.257.1544809573229;
 Fri, 14 Dec 2018 09:46:13 -0800 (PST)
MIME-Version: 1.0
References: <20181211131451.52832-1-heikki.krogerus@linux.intel.com>
 <20181211131451.52832-4-heikki.krogerus@linux.intel.com> <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0hvGL8DnxFAtp3NiuT7ubTBuoKbTzbD9UaZYNpgZLiWaQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 14 Dec 2018 11:46:02 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
Message-ID: <CAL_JsqLn3dbt-8Hjoja5AJip7FxLoWLAh0Cuk1eqE3Z8RiaO1A@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] of/property: Add of_fwnode_name()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 3:36 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Dec 11, 2018 at 2:15 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > This implements get_name fwnode op for DT.
> >
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> Rob, any objections here?

Yes, what I said in v5.

At one point this series had a user which was finding a matching node
by name. Now there is no user, so I can't really say whether this API
makes sense or not.

There's generally only 2 uses for 'name' at least for DT. The first is
node matching by name. ICYMI, every case of that in the tree is now
replaced with of_node_name_eq(). Now the details of matching by node
name are contained within the DT API. The 2nd use of node names is
just informational purposes or to fill some other structure's name
string (e.g. struct resource). In these cases, device_node.full_name
can be used. The only difference is full_name includes the unit
address ('@1234' part) if there is one. For these uses, the kernel
shouldn't generally care what the name actually is, but that's not
really enforceable.

Rob
