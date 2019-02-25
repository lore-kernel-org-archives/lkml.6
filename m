Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13EDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8183E20842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 13:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7Mf8a4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbfBYNtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 08:49:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39051 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfBYNtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 08:49:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so5280744qki.6;
        Mon, 25 Feb 2019 05:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zTiCMhkCXh3F8qxsPXKduCvZBchsPR7PvpcqdOf8rJg=;
        b=N7Mf8a4GSjmN8Kjk/wV0dkkdBODJkAER6qF/fPUTRy+XMnV9mMmbFhrXWW+uXcZQZM
         jg0hHVGZWcSQWGotU2eDaLVYrGXxPqSZ1D+QnLI4IPO6xYrDtrD/xXnbN5o6qlJ/143P
         PCz+xVEfqJSHDAA6vX4RKEN0e0r3zpdpZQa8t+5k2ojnuVTpPSO2tkl02FBQ3RJ6YM1K
         bDJ+R/VSeWmgpaKn4ra+t8WsW4qRQD9gsSX04HjMZuFLfC7n4xs4kcyJR1fQKAVd6Zud
         ZQAMNzRVpLfln6+UUJuWMg3OJq6DTOOmgT3oHW5TZuz5KnMFrCIQZ/BFIZRm7PkH0PC6
         7+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zTiCMhkCXh3F8qxsPXKduCvZBchsPR7PvpcqdOf8rJg=;
        b=rPL2oFBgtp3joIihDpLksN9ijiDzP3gcxZzChPofl440YHgNUcF0BcN7nZAgqufQlk
         g2/gQ7oJ8zlX7IXKju+/c6zJ0vfcTkgk4vClcKGCWsRRmU025nusmbaDs3q+U62/xEN2
         J8on0wii4U7wwUz7KCTNr+vHZsUejBJm+EVkw65Pj8k4QmOSPSm6orVpGFsY4dJDndrS
         cICulQoPxU2TFQvpKZWf8FXcr1tZ4D5C0T6Nhg/Qlw7I+DQ2KHBzt4040qxqCcxrda9b
         mVN7/t0hxzknyDReeoNkd7FpMDJBuZcoEg9jn84Q3KFEe9YyTE2+77gcXA7Lf/XFvFIS
         qtXQ==
X-Gm-Message-State: AHQUAuaWxCQLqOSXmohRSPGnjhgcSPdhNbudUB5yThC6NuHT53SQGfR1
        klqkxil2xVh6l8Y2RA/Bxqo=
X-Google-Smtp-Source: AHgI3IbQ+tAjiuCfM4zUnrYJt2QxfTLb/idiVsjnvcMS0eJkEF++7tq5v6xF7d3SZGLk2Rib6NBrKg==
X-Received: by 2002:a37:7b01:: with SMTP id w1mr12996644qkc.122.1551102548866;
        Mon, 25 Feb 2019 05:49:08 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id 81sm5311069qkg.75.2019.02.25.05.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 05:49:07 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6954A4039C; Mon, 25 Feb 2019 10:49:05 -0300 (-03)
Date:   Mon, 25 Feb 2019 10:49:05 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 01/11] perf tools script: Handle missing fields with -F
 +..
Message-ID: <20190225134905.GB31136@kernel.org>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-2-andi@firstfloor.org>
 <20190225125642.GM19795@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225125642.GM19795@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 25, 2019 at 01:56:42PM +0100, Jiri Olsa escreveu:
> On Sun, Feb 24, 2019 at 07:37:12AM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > When using -F + syntax to add a field the existing defaults
> > are currently all marked user_set. This can cause errors when
> > some field is missing in the perf.data
> > 
> > This patch tracks the actually user set fields separately,
> > so that we don't error out in this case.
> > 
> > Before:
> > 
> > % perf record true
> > % perf script -F +metric
> > Samples for 'cycles:ppp' event do not have CPU attribute set. Cannot print 'cpu' field.
> > %
> > 
> > After
> > 
> > 5 perf record true
> > % perf script -F +metric
> >             perf 28936 278636.237688:          1 cycles:ppp:  ffffffff8117da99 perf_event_exec+0x59 (/lib/modules/4.20.0-odilo/build/vmlinux)
> > ...
> > %
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> 
> nice, that one was annoying
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Applied.

- Arnaldo
