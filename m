Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED59C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3403218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548323347;
	bh=q45l6LGW18Im4quv8V2oj8aPXILNr9EeFCB+Isnh9/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tpHoodk6EsyrikRo/6AHjDoC3J3pIG+/nMuyr7t3JwJVn3QEUUZ/Ow2ynlJZaiFX3
	 OKzeNVs8utQy8zTlMydgKadCnz0l5E4Yp/ZXsVUve0CmfPl9ERfZ/9ULOCUGoRZI02
	 52swZbqh6iLRntffBsdCpyiouocRhrkX3wvfUJo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbfAXJtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbfAXJtF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:49:05 -0500
Received: from quaco.ghostprotocols.net (ovpn-brq.redhat.com [213.175.37.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECC42085A;
        Thu, 24 Jan 2019 09:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548323344;
        bh=q45l6LGW18Im4quv8V2oj8aPXILNr9EeFCB+Isnh9/s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zOpmYRf5MWVKuTW5IyTW4dsWPQaH2AEyOVAXn3gyvKPacZxp9geAHuW4IgyE2RB5y
         EUj5CaJHdiVa7SS/Bg9K/FCwfJEBUQG6+jFJ0/ukknq6rL182jryWlkqReqyWaewb5
         0HVlL4se96PaVc0Svihx/tXo92Jb7y+pbrksDFrU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5D7B340355; Thu, 24 Jan 2019 10:49:02 +0100 (CET)
Date:   Thu, 24 Jan 2019 10:49:02 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v11 perf, bpf-next 7/9] perf tools: synthesize
 PERF_RECORD_* for loaded BPF programs
Message-ID: <20190124094902.GJ14973@kernel.org>
References: <20190117161521.1341602-8-songliubraving@fb.com>
 <20190118144655.GM5823@kernel.org>
 <20190122141320.GF14973@kernel.org>
 <20190122143117.GG14973@kernel.org>
 <20190122145119.GF27625@krava>
 <20190122145805.GI14973@kernel.org>
 <20190122152145.GG27625@krava>
 <101BF88D-2DA4-4B54-A710-D0641C427136@fb.com>
 <20190122191555.GH27625@krava>
 <CF447261-1B9C-423B-9508-60B32EAC4A5C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CF447261-1B9C-423B-9508-60B32EAC4A5C@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 22, 2019 at 07:24:43PM +0000, Song Liu escreveu:
> +#include "machine.h"
>  #include "bpf-event.h"
>  #include "debug.h"
>  #include "symbol.h"
> @@ -187,7 +188,7 @@ static int perf_event__synthesize_one_bpf_prog(struct perf_tool *tool,
>                 *bpf_event = (struct bpf_event){
>                         .header = {
>                                 .type = PERF_RECORD_BPF_EVENT,
> -                               .size = sizeof(struct bpf_event),
> +                               .size = sizeof(struct bpf_event) + machine->id_hdr_size,
>                         },
>                         .type = PERF_BPF_EVENT_PROG_LOAD,
>                         .flags = 0,
> 
> Would you send the official patch? Or would you prefer me sending it?

Nevermind, I'll fix this, its just that I'm now travelling.

- Arnaldo
