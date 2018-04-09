Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713199-1523268130-3-3809107909071490570
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523268130; b=nsc6OpBt9GC0FuszgM/d7CHhjLueZq7vU2TeuVjMMwYt4sLTwy
    mGffaW8XT2vy5MayqXMzpQaLAPB7YpK7fC100aLdw2iZJnzyDlkm3ym2tDT5oEF5
    H3qqoddkfyMXdUlDIpey7G7ei/HWUHj5Ndqfdb/l3xWtt56YGT0Fe+MmhZzf++jU
    45paurhRA2p5GKDjsL6mX3KgCD7LraRTq5GBY3WQWAiI/EL8HNUobRfUk2nBd+Th
    4LsOxcy0cGkujED9XQR8ivgZiuriO4hZ9bFMiDAf4/ei6Um8x1ulMDrFbJk59H2s
    ilPjC5ZdySMzgivP4AqwOtQsbTMwc5ARlz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523268130; bh=X8KEIOpNaNP1iWdfyrB1WGw7ihBsPC
    nJM0pWXFt0v3A=; b=pv5EhCC1tki0WymleuJF/a5WsnOPUbzZkFxdaY/38ODaEJ
    6ugZQPMFoNwmixRVDA9TmQWeqV8hUABN2QR8OlzsVEzN2lra82otD6d1KoeYRyC+
    o2uuGF1aXZLYx5YqXYM9YNXBRF8v46x7cvQ1r79Gd0UG7lIWhEvWG13WvR3GyjmA
    AsO8lK2XvHzokMlxy4BpihCCY4wNKItc4DRs38k0ZpF+3qXZRuQMZZfNFRiHZrY0
    bLTnms4mN1HZCoheXRfkgdomjnb9YsXDwh/BeYM1fsT5dZON2h3oDtVl212NiQjj
    Nvjo7uW75rXjj2KEBNPR/NcyQPcEXecnZapk3ydw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDuGcltc5tbJIP2JVGgw2p0rfQ7D9LDNzoAFm6jzf/35berSmS378m+KCIjYUpJTJFCjRGJtobJ0/CAaLQC58LcVe/Yvf7ejQi4SKH6/tCzPYL2Qa7Y+
    uizmiLKXe96Lag3UatY+oxcEB5fj+NCLjV//JCN9KJDozVpjMYUIstz+yIQsVrUxk079KRYV87nTllPLdg2xK0k89w6Fq2pK3dRC9AM9NXoJsnX4xCKqK8Vi
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=8M4jnuUcaReP0IsBDzQA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751969AbeDIKB5 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 06:01:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:45290 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbeDIKB4 (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 9 Apr 2018 06:01:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,426,1517904000";
   d="scan'208";a="45350649"
Date: Mon, 9 Apr 2018 13:01:53 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: fix tracepoint related build error
Message-ID: <20180409100153.GA10141@kuha.fi.intel.com>
References: <20180409075517.15362-1-tobias.regnery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409075517.15362-1-tobias.regnery@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 09:55:17AM +0200, Tobias Regnery wrote:
> The ucsi driver defines several tracepoints, but the header file with the
> tracepoint definition trace.h is only conditionally built depending on
> CONFIG_FTRACE.

You mean trace.c, right? The definitions are indeed in the header,
trace.h, so I'm a bit confused what is actually the problem?

> This leads to the following build error with CONFIG_FTRACE=n and
> CONFIG_TYPEC_UCSI=m:

That alone should not cause any problems.

> ERROR: "__tracepoint_ucsi_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_register_port" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_notify" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_reset_ppm" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_run_command" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_ack" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> ERROR: "__tracepoint_ucsi_connector_change" [drivers/usb/typec/ucsi/typec_ucsi.ko] undefined!
> 
> With CONFIG_TYPEC_UCSI=y the build fails with several link errors.
> 
> Fix this by changing the Makefile to unconditionally build trace.o.
> Tracepints are a runtime contruct and no other user of tracepoints depends
> on CONFIG_FTRACE.
> 
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> ---
>  drivers/usb/typec/ucsi/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/Makefile b/drivers/usb/typec/ucsi/Makefile
> index b57891c1fd31..971befbbc2a8 100644
> --- a/drivers/usb/typec/ucsi/Makefile
> +++ b/drivers/usb/typec/ucsi/Makefile
> @@ -3,8 +3,6 @@ CFLAGS_trace.o			:= -I$(src)
>  
>  obj-$(CONFIG_TYPEC_UCSI)	+= typec_ucsi.o
>  
> -typec_ucsi-y			:= ucsi.o
> -
> -typec_ucsi-$(CONFIG_FTRACE)	+= trace.o
> +typec_ucsi-y			:= ucsi.o trace.o
>  
>  obj-$(CONFIG_UCSI_ACPI)		+= ucsi_acpi.o

I would like to understand what is the root cause for the problem you
are seeing? CONFIG_FTRACE=n with CONFIG_TYPEC_UCSI=m alone compiles
just fine for me.

Using FTRACE as the condition here is indeed wrong, but changing that
so that we unconditionally compile trace.c is also wrong. We should
probable use CONFIG_TRACING instead of CONFIG_FTRACE. Can you check if
that works for you?


Thanks,

-- 
heikki
