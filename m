Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E589EC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B00C9222C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550042238;
	bh=R62VMvcrkkw2G2KDnMnF9pyiRRqJkBh58OlxhSkcuCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rS2Tdk03iA9jncL/1/qdHFXEd7SqAeyrzJ8uxWM4ezHuA1admowd19s9TViSFVeEK
	 qrwYhNdFA1TlaaGQkNOYrBWQTfHwULv70wt4LgEnhNm3eN9xwyEPOTga7zgkVYSo7T
	 RFY2m6i1TUw2ZONmn7uOcGhici6akQrMDbBBahZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389353AbfBMHRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:17:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40474 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbfBMHRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:17:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id q21so1173157wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 23:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Iq0cmgIDwrMrikIoJnjo7xQm1OAkpZH739uIZKuVEZU=;
        b=H9r4fjRqZl+zdh/h02O4KFeuxfs1H2tY9idTKnZgY53aato3T9czbSAx2uX4x1LUUA
         dVNIWp25lUhnl1lP7/EW22K73RT5hWxpZPk8hy8yqHUmZIIuEDChF30rZ65ansbz0H/7
         ihRP/Od2l/yOqSV036uZN/z1BPS5NK43x92pua9k/On5IeEP8UCg4UBUMUVasAru6fg6
         fyaVSLfINCljP5+1cyf87kvWo5uaDZrJEczm1ON7Uk118GB0utstZuX4eJavR7W/4tuq
         7pW6InXjv2xk3jrM/i0l91fSe7tRy1U38Cor5T+OavAhNNPml5ondSMTx5EvdShaEIvR
         j34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Iq0cmgIDwrMrikIoJnjo7xQm1OAkpZH739uIZKuVEZU=;
        b=drXDXi5Xgb2MF+r6B/FJKBUylhnKezpLLfn3vGnSRdheVzBVZAS/tE8zqyIKZopgbV
         bNM288IOq16fnOzldtkY+ixVLBerZyx8IxKJhNwC0fhwgiP9XnNh/lwJO67OsQKBqKAM
         Lcn0FTODWkHXhiiNgbhaGE6blyCiLXRTcMW7wxhcFjjS/uCIZvfb6rnTWGUg4XQTxNQE
         aq1UTSWwCKVt3NWrYkLw/dga4gGfFubrlP3FJ+esg5pr/QMNdnvILEq60+QFfCj4+XET
         VsHHsdQppRD2R76N9uJNh46ooNjC7EjgOUHuJ902tpcMjGrHuFtjIThrqMxZrKHRiMQt
         H1yQ==
X-Gm-Message-State: AHQUAuZlBGYplB0fCAruDSIDEcSU/2EWyyCaA4ZfpbrqvCNN8Tj+L1i/
        QevPlP+tvwNQ9m8fItVPAEw=
X-Google-Smtp-Source: AHgI3Ia7CBHUjf6xJkbJE6zWD5E9daYVo+WOfhD5zSeOz02PprhlCehcqEPHrhux/wMQrtxZPIei/Q==
X-Received: by 2002:a1c:2787:: with SMTP id n129mr2079379wmn.128.1550042234146;
        Tue, 12 Feb 2019 23:17:14 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id z1sm9344221wrw.28.2019.02.12.23.17.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 23:17:13 -0800 (PST)
Date:   Wed, 13 Feb 2019 08:17:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>, peterz@infradead.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Righi <righi.andrea@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH -tip v3 05/10] kprobes: Search non-suffixed symbol in
 blacklist
Message-ID: <20190213071711.GB121801@gmail.com>
References: <154998785011.31052.1475728497912659748.stgit@devbox>
 <154998799234.31052.6136378903570418008.stgit@devbox>
 <20190213071316.GA121801@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190213071316.GA121801@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Newer gcc can generate some different instances of a function
> > with suffixed symbols if the function is optimized and only
> > has a part of that. (e.g. .constprop, .part etc.)
> > 
> > In this case, it is not enough to check the entry of kprobe
> > blacklist because it only records non-suffixed symbol address.
> > 
> > To fix this issue, search non-suffixed symbol in blacklist if
> > given address is within a symbol which has a suffix.
> > 
> > Note that this can cause false positive cases if a kprobe-safe
> > function is optimized to suffixed instance and has same name
> > symbol which is blacklisted.
> > But I would like to chose a fail-safe design for this issue.
> > 
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Why did you not add Steven's Reviewed-by tag?

The series looks fine otherwise, so I applied it with Steve's reviewed-by 
tag added.

Thanks,

	Ingo
