Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF44C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 385C820693
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tzK6H40x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385C820693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754333AbeFUAeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:34:13 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41923 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754011AbeFUAeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:34:12 -0400
Received: by mail-vk0-f66.google.com with SMTP id 128-v6so836983vkf.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 17:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZBpCkL23W3kv3cyJGByxVsUCsnkF9MWwGbEV4Xivf44=;
        b=tzK6H40xgyVtW6X1a7EwMOqN8zZfJ6lnW/+XEP3Q1I4QuOa9oYlrVhxytJdKBEsIne
         yJuCXpS5r3R3YMVfDO9o2zCLmatxF+qvpzd8uKzK46kaZJdgh/pruXRynglOZ2uaslMm
         Xbx1OPgcp2/WxDhRGSMsZC4nKHdii2udPoKlfTV0EbvZYmkjHvUZuO29iEhGLVaQ8bJ1
         OuVCQOSJnZOlIcFuF5Ec6meXc0VveDxx1kRPOXxalcVDwQ2WxsZTyK7p9ZPEJ1Z/uMhD
         sVa40/q0GiC7GPY0qlkGnqXF7hx3L3gxzUQlF/fuzcl/3IGlo+FOVMIfpmp6INaRHu3B
         sE5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZBpCkL23W3kv3cyJGByxVsUCsnkF9MWwGbEV4Xivf44=;
        b=m2qI00pWZKoaIdTsgjp5yCUaklUK8iKYccElYiKXHnNeT63hAgG2Uu4vIcE451OL9w
         nS4mc6mUzvv04BS00IqaxrECkLLuv+qDhxsmgxYUZ+g4Mnu+b+GukZElefXUD2/IKHTE
         Aq1sJ+tsiTO6ogamWGTA6jOhk1U6AtDqyhlHawowbamk/DSjQ1TfrBtDOy1LrKiP9/ox
         Mq20mTZOWxWusrp5iHgEu6QwoDNzctc12CFOieXJCO2iGZx+JaGZveFJ0TQvGxcK842B
         dr1WFc4Nh7ma/a6aJerB0slCCxy+V7VBkq30GElIQJt0+js1gWbQVGBP/LpqmVX6cjwt
         bcYA==
X-Gm-Message-State: APt69E3dYYqcnxd/zXj4+w+iWE92LMlwLr4kyqXgS6TluwQFezqEUWiw
        uJw19gw+3gUwsIHmbTb7AaY5SGftNNzOLpUOXJ8=
X-Google-Smtp-Source: ADUXVKKnudeK6eh1YcURT2JLnDesIR6SSGJQ+cCgQZF+mMaSW4OADgPFpQJbD7jw2MrIykbMG5Qy7NMlmctrf9iT+WE=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr13908579vke.176.1529541251358;
 Wed, 20 Jun 2018 17:34:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 17:34:10
 -0700 (PDT)
In-Reply-To: <CAA9xbM7_vrn-f_m67eowzLzWjoJP=9Hkgyxfc=yu=aDtmk=Qvw@mail.gmail.com>
References: <1528704248-33818-1-git-send-email-jiazhouyang09@gmail.com>
 <520e80a8b8de0f532e8dd3ee15af9efbc748dd9a.camel@linux.intel.com>
 <s5hmuw1bgmd.wl-tiwai@suse.de> <CAA9xbM7_vrn-f_m67eowzLzWjoJP=9Hkgyxfc=yu=aDtmk=Qvw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Jun 2018 03:34:10 +0300
Message-ID: <CAHp75Veew3LCEKa64V+YFZZMtzvNc5dkJfXE4DGQ1noDQMhOXg@mail.gmail.com>
Subject: Re: [PATCH] ALSA: fm801: add error handling for snd_ctl_add
To:     =?UTF-8?Q?=C3=89meric_MASCHINO?= <emeric.maschino@gmail.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        BhumikaGoyal <bhumirks@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:39 PM, =C3=89meric MASCHINO
<emeric.maschino@gmail.com> wrote:
> Patch tested on my ia64 workstation. Works flawlessly.
>

Thanks, =C3=89meric!

--=20
With Best Regards,
Andy Shevchenko
