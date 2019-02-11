Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3F6C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E853222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmExmgQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391658AbfBKPQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:16:00 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35415 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391346AbfBKPH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:07:29 -0500
Received: by mail-it1-f194.google.com with SMTP id v72so2054560itc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 07:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQqZlYHAY6HjAeSYpVOSflml6k7zg9teSdrJm8leEUk=;
        b=HmExmgQNH5IAGNs2+AgmsD+/8/vrqIeob15MBtVs/D3GSqX9h+b4Fyu8CZTUvGCPW6
         9LdgclqoNgCNZgXqtpceGLrp76mk467FWtUyG59VEEkeS95SFmFm5F/KRwLbrG1Vu5DI
         vKcYi0M0ThTTT1KnPRF8l+L67yvAx/JaI0yKeljZVgrU70IiYHP0r9Z3SVQatMowOlK6
         W9aPZQrw1EKMZcHDKUqYZ3SjYQs/o35gQ96cInVB/JB2xpL12M89H2p3ttcJTUjByjnJ
         VAEUhhTKd0dBi3Hulxq7nsq3ZzsLXtnLTnniyzgIB6k7gkkUnsJrrU963Jn9WKiC401r
         lgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQqZlYHAY6HjAeSYpVOSflml6k7zg9teSdrJm8leEUk=;
        b=H8su8ei+r9/U0GEHdrjzopzkDGQ1ai8eJq8EUknpr43kRIL0jgCzH3ZMjimBkpAXrx
         cILiokLi+FJ9svnEyPc+P/HHApjBy7RdqFxrDb1KeeMj5+0PD/0bFJLBK8vUDUZG8f2y
         OXd8S2nKREngnhUE9eNapsEp7okaU4Ya5UCrpj9oLi7+YTVuY1dEIb2rbNrJezM30JUH
         oRjnkSoQJIdsiu8AmVQpaGa8dWqwWujgOz6uzNDl908O6scBgZv8HF0AivpNqiZV2S+x
         nvQO9jnyBG5qwc0c2+SwqbKqveiGkZPJIu9LkNTeLRYv6fxGvbvxfQdFXaCXmlyGK2pA
         TtxQ==
X-Gm-Message-State: AHQUAuY3NhjvpCkRYRdNQi6jeDftBgF94/FLmtF8l9NPf0Io+y0nGLyq
        y10g1XqLlACMhdd40X5R81E=
X-Google-Smtp-Source: AHgI3IZmq0Wcl4jw3ZGGwMalNA0I8DLN1B3MVKmlOJ0rQRedSwiLS415yoRt58VHhhp8O1qD0/WEjQ==
X-Received: by 2002:a24:4653:: with SMTP id j80mr5381444itb.177.1549897648834;
        Mon, 11 Feb 2019 07:07:28 -0800 (PST)
Received: from ubu-Virtual-Machine (66-188-57-61.dhcp.bycy.mi.charter.com. [66.188.57.61])
        by smtp.gmail.com with ESMTPSA id y190sm4322446itb.26.2019.02.11.07.07.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 07:07:28 -0800 (PST)
Date:   Mon, 11 Feb 2019 02:01:18 -0500
From:   Kimberly Brown <kimbrownkd@gmail.com>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, devel@linuxdriverproject.org,
        Haiyang Zhang <haiyangz@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Display nothing in sysfs if
 monitor_allocated not set
Message-ID: <20190211070118.GA2977@ubu-Virtual-Machine>
References: <cover.1549619051.git.kimbrownkd@gmail.com>
 <52d58fe5805f2ba2405c9091b4c86033d434d2b9.1549619051.git.kimbrownkd@gmail.com>
 <20190208143148.052c8d9c@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208143148.052c8d9c@hermes.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 02:32:09PM -0800, Stephen Hemminger wrote:
> On Fri, 8 Feb 2019 05:01:12 -0500
> Kimberly Brown <kimbrownkd@gmail.com> wrote:
> 
> You are right, the current behavior is broken.
> It would be good to add a description of under what conditions
> monitor is not used. Is this some part of a project emulating
> Hyper-V?
> 

I'm not sure which conditions determine whether the monitor mechanism is
used. I've searched the Hypervisor TLFS, and I couldn't find any
information. If you have any suggestions for where I can find this
information, please let me know.

No, I'm not working on a project emulating Hyper-V.


> 
> > +
> > +	if (!hv_dev->channel->offermsg.monitor_allocated)
> > +		return sprintf(buf, "\n");
> 
> If monitor is not used, why not return an error instead of empty
> data. Any program (or user) would have to handle that already.

I think that returning an error instead is fine. I'll make this change
in the next version of the patch.
