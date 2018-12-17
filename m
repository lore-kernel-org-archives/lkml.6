Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22138C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FCB20874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545072576;
	bh=1LAXWjcHYZ8EvLqf9+8NBvcCE1AAWmOlR6IS1g416hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gcag8ZL7H8HAf8QJi1xOPEDJsPJhoqZQqmoYqvfjHKKfe+CpdpdZ/lcTeQmjPtWUS
	 Z2/zorY7G69wtvpLBSRYSWzAGayJfzSd12ismR0Z5ADRXQYXHrlrOgPUsPNX4ICONU
	 4dD2gl3Pb+cyjJUVIaIdUdAcx56rKiLr/sTsonds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389177AbeLQSte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:49:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36508 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733216AbeLQSte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:49:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id u4so12419063wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 10:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3f7EJWzVIGQxQ6cpNYOs/P1bT2u1rBcPQqwnZrC04Cc=;
        b=b9k64H2g3vBNikosoT4LCdq0Smg96k2IMdUWtC+Aa+6LWsJ8XEq11EGIQQA6LaEqwV
         YUyJWIjMC+IhBqfj6hUhODshbrnqSGmPblCjGLgFEU2LLW1H9xLAISMMq8DR7PUGGpG4
         gE9WzXgAUZyi2tTOZ0MNHgTY1HNMmJS25tpMKxuLE83X4hQFfEMvPatrwoG3Sx2EI9G9
         xSV3gB8AeuwfJNB9m8N/WxzBvzVgaNKQbFmbFuWHc5XOCbzQ50/VJSsrKdb8gHOGwaz4
         o1BDibfHs81EI8Fl41zq4OWbH9vtyrSFUdJjLT7QRA6shWV19quelEGHyg1MliR9HVhS
         3KqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3f7EJWzVIGQxQ6cpNYOs/P1bT2u1rBcPQqwnZrC04Cc=;
        b=dqzyxB8cIenEFGGlwYhrDuHyBUG1Ill/CJJlcdn1wSLtSEckGhf0SA77NsBKVa4u17
         wW/moWT1Av51eJDbSX1TalHD0UmsFhbBJ20Jlr6qI0pE/4UyKJLS1EcZmvm0NHnt3b28
         pN035iKtsykJN9kGqac8piAZcfAH9HkhUNwvf8QHaX/ha499KoUq3AEY3A+/zBX3Be8A
         3Vt7HkqOmy/udS7GK3s1IScdzWUvfLzRRqDsHqfAGcN1pvPVK2Nzr6/FIeESPr3F68xl
         AZkGTOnmqqlxsT3yTLTFjuH/RxTc0Z5POhmyjlP/sUhWJAnQGLTWhosKYbWk0EsxOWzR
         d4Iw==
X-Gm-Message-State: AA+aEWbfMb5fNEWVIG60SDrKn0AlVR6+ZXgx/9lqdBdjbJaA8S8Er5gw
        LFoXFaGjxdDJ0ejHXEvQaHI=
X-Google-Smtp-Source: AFSGD/W/wyBIwvY3V2mWz8ulSkpUGbtwwD63QQ5LvgnAaRMKdKghvHaACIqQ/fYgSyk0R+KMylYqrA==
X-Received: by 2002:adf:fdc2:: with SMTP id i2mr12218201wrs.117.1545072572415;
        Mon, 17 Dec 2018 10:49:32 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id r12sm1542058wrq.3.2018.12.17.10.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 10:49:31 -0800 (PST)
Date:   Mon, 17 Dec 2018 19:49:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 2/5] x86/boot: Introduce efi_get_rsdp_addr() to find
 RSDP from EFI table
Message-ID: <20181217184929.GB60403@gmail.com>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com>
 <20181214093013.13370-3-fanc.fnst@cn.fujitsu.com>
 <20181217173032.GB90818@gmail.com>
 <alpine.DEB.2.21.1812171932020.1660@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1812171932020.1660@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Thomas Gleixner <tglx@linutronix.de> wrote:

> On Mon, 17 Dec 2018, Ingo Molnar wrote:
> > * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> > > +		else if (!(efi_guidcmp(guid, ACPI_20_TABLE_GUID)))
> > > +			return (acpi_physical_address)table;
> > 
> > 'return' is not a function.
> 
> It's still a typecast :)

Yeah, see my followup from an hour ago:

  Message-ID: <20181217173605.GA14613@gmail.com>

Thanks,

	Ingo
