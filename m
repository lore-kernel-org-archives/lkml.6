Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25A7C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 575B120843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 575B120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbeGYQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 12:48:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728360AbeGYQsK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 12:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D9FA140241C0;
        Wed, 25 Jul 2018 15:35:58 +0000 (UTC)
Received: from treble (ovpn-120-113.rdu2.redhat.com [10.10.120.113])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DD002156897;
        Wed, 25 Jul 2018 15:35:58 +0000 (UTC)
Date:   Wed, 25 Jul 2018 10:35:57 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Artem Savkov <asavkov@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/kprobes: Fix trace_probe flags on
 enable_trace_kprobe() failure
Message-ID: <20180725150226.5jdhtj4j7bdp4ddu@treble>
References: <20180725142038.4765-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180725142038.4765-1-asavkov@redhat.com>
User-Agent: NeoMutt/20180323
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 15:35:58 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Wed, 25 Jul 2018 15:35:58 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 04:20:38PM +0200, Artem Savkov wrote:
> If enable_trace_kprobe fails to enable the probe in enable_k(ret)probe
> it returns an error, but does not unset the tp flags it set previously.
> This results in a probe being considered enabled and failures like being
> unable to remove the probe through kprobe_events file since probes_open()
> expects every probe to be disabled.
> 
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
