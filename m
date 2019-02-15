Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02E0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCA221920
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfBOHl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:41:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44566 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfBOHl5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:41:57 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 69C25AB419;
        Fri, 15 Feb 2019 07:41:57 +0000 (UTC)
Received: from krava (ovpn-204-35.brq.redhat.com [10.40.204.35])
        by smtp.corp.redhat.com (Postfix) with SMTP id 403635D9C6;
        Fri, 15 Feb 2019 07:41:54 +0000 (UTC)
Date:   Fri, 15 Feb 2019 08:41:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH 5/9] perf, bpf: save bpf_prog_info in a rbtree in perf_env
Message-ID: <20190215074154.GB18997@krava>
References: <20190209011705.2160185-1-songliubraving@fb.com>
 <20190209011705.2160185-6-songliubraving@fb.com>
 <20190214123311.GA7465@krava>
 <2446DEFA-3CD3-4D3A-BE73-C29037F00C5C@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2446DEFA-3CD3-4D3A-BE73-C29037F00C5C@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 07:41:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 05:03:03PM +0000, Song Liu wrote:
> 
> 
> > On Feb 14, 2019, at 4:33 AM, Jiri Olsa <jolsa@redhat.com> wrote:
> > 
> > On Fri, Feb 08, 2019 at 05:17:01PM -0800, Song Liu wrote:
> >> bpf_prog_info contains information necessary to annotate bpf programs.
> >> This patch saves bpf_prog_info for bpf programs loaded in the system.
> >> 
> >> perf-record saves bpf_prog_info information as headers to perf.data.
> >> A new header type HEADER_BPF_PROG_INFO is introduced for this data.
> > 
> > please move those 2 changes into separate patches then
> 
> Do you mean one patch to save data in rbtree, then a separate patch 
> to save data in perf.data file?

yes

jirka
