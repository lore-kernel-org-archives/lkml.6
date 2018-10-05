Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94C9C64EB8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B85C20684
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 02:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOojo8gP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B85C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbeJEI7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 04:59:49 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45611 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbeJEI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 04:59:48 -0400
Received: by mail-pl1-f194.google.com with SMTP id y15-v6so6044041plr.12;
        Thu, 04 Oct 2018 19:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z4PN66NcGIc19BySOr8tcZB7vTozJ8u6rgclM6ReKl0=;
        b=UOojo8gPpE4+8IVMwpMsV5dkq4X8ok7Fcdu04yWVYylX9i5wVScUQCaRvAhgwtKL4s
         FjQj3uR40d2pBofXog98g/OgvcNje5T9Oe1+wpnClsQMHp0RzV8YO/3q5yPrHGUL8Vo+
         17ZJMbbWRt9KMtORHEQcVJlpTrcKzJ0aEwX8nSDNml1t0Wlxc+tWEXevgZEBNerlMGQp
         76ANAieCTdoPFq9txpSC1rin/F151v41KKA/Fubtj5S2F3m81P5AOXaoucpGEX9M6OcY
         R8nHaJx2DZ0UBYPhHBdAft6abz/9En5RuKlKm5ITdJLomuUQz5J+FeMQ2gyUsPbPc2J6
         Lb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z4PN66NcGIc19BySOr8tcZB7vTozJ8u6rgclM6ReKl0=;
        b=keh2rOX9sXZY5YNfDKk9Y5/2+se8t/bGmRYpmlY2hCXqkFqgYTbqNUrPy3muRm6utj
         6eABLsy1LGsdErQlvejMPPmsFhdcEy+Mw/gkXa++KJhuaQ+ND+9WsaTE9sp4OBOHK7pV
         QjupN4/qqqUkGaP2NIH1TvGcBWwKcYp/yNgH4UNdudlFIiuClMvMKVLVljCP4swliD75
         n1EgHQeOrDazLXpmWJcR/cOWWeTCMxIr6aWLDvQjQ4pppd6LfyDHplA7a9URCzzTlD/+
         HArb0GGf9Iyw/vqwL1elSnCjv7bK769TFunlFyEnMERGF/tfeystl6POaSQ7YJ/GpdL0
         Aw2Q==
X-Gm-Message-State: ABuFfoiJ03bKf5UwHG74Xvr8sXmwFdopeQ8JXuyCB3m1b71lBmV2dFP7
        OHIgblBpN1TNi5P0/3lX9go=
X-Google-Smtp-Source: ACcGV60flJ2gnYYKUl2wQQ0y7VBhkNgBbIjGbTdfO7ZySLJ5fO7mPbrVMSfkV1r+qBzti2llW1LzRw==
X-Received: by 2002:a17:902:7e45:: with SMTP id a5-v6mr9447545pln.151.1538705000815;
        Thu, 04 Oct 2018 19:03:20 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:c49e])
        by smtp.gmail.com with ESMTPSA id 84-v6sm13594181pfs.108.2018.10.04.19.03.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 19:03:19 -0700 (PDT)
Date:   Thu, 4 Oct 2018 19:03:18 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Howells <dhowells@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] udp: Add tracepoints to monitor skbs going in
 and out of a UDP socket
Message-ID: <20181005020316.7cqlcfkedhamwhtt@ast-mbp.dhcp.thefacebook.com>
References: <20181004171925.6neebizw4xmpjhv6@ast-mbp.dhcp.thefacebook.com>
 <f4d5ec71-b09a-84fa-599e-d0482cdb77b7@gmail.com>
 <153864184110.20296.16498481420320274305.stgit@warthog.procyon.org.uk>
 <25668.1538672073@warthog.procyon.org.uk>
 <5213.1538695482@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5213.1538695482@warthog.procyon.org.uk>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 12:24:42AM +0100, David Howells wrote:
> 
> As for kprobes: spots, plural.  Using kprobes involves installing breakpoint
> instructions and taking traps and would seem to require using printk for the
> output, which would affect the timings and potentially affect the situation,
> especially given the sheer amount of traces produced.  Note that one of these
> was in an interrupt handler, which is possibly not the best place to be taking
> an illegal instruction trap.
> 
> Using kprobes gets worse too.  In my case, the source code and the build tree
> aren't on the test machine, which I understand would be a requirement - and

there is quite a bit of misunderstanding in the above two paragraphs about kprobes.
Sounds like it influences odd design choices with tracepoints.

- kprobes at the top of the function don't use traps and they've been
optimized over the years to have very low overhead
- trace_printk is using the same mechanism as tracepoint prints
- both trace_printk and tracepoints can affect timing
- kprobes and trace_printk work well out of irq handler. They work out of NMI too
- build tree doesn't need to be present to use kprobes

perf, bcc and others tools have user friendly (arguable of course) interfaces
for kprobes.

