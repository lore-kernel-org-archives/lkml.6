Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F1C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDF6208A6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 10:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDF6208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932869AbeGHKzT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 06:55:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932757AbeGHKzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 06:55:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2FB877C809;
        Sun,  8 Jul 2018 10:55:18 +0000 (UTC)
Received: from krava (ovpn-204-62.brq.redhat.com [10.40.204.62])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4FB30111DCE6;
        Sun,  8 Jul 2018 10:55:16 +0000 (UTC)
Date:   Sun, 8 Jul 2018 12:55:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Laura Abbott <labbott@redhat.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robin Jarry <robin.jarry@6wind.com>
Subject: Re: [PATCH 2/7] tools: build: Use HOSTLDFLAGS with fixdep
Message-ID: <20180708105515.GA29861@krava>
References: <20180707010709.16648-1-labbott@redhat.com>
 <20180707010709.16648-3-labbott@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707010709.16648-3-labbott@redhat.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 08 Jul 2018 10:55:18 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Sun, 08 Jul 2018 10:55:18 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 06:07:04PM -0700, Laura Abbott wrote:
> The final link of fixdep uses LDFLAGS but not the existing HOSTLDFLAGS.
> Fix this.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> This was another one where I couldn't tell of the use of LDFLAGS was a
> typo or intentional, hence keeping both.

I think the replacement (using just HOSTLDFLAGS) should
be the correct fix, moreover fixdep doesn't have any special
link requirements

thanks,
jirka


> ---
>  tools/build/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/build/Makefile b/tools/build/Makefile
> index 5eb4b5ad79cb..cd0fd2cd165b 100644
> --- a/tools/build/Makefile
> +++ b/tools/build/Makefile
> @@ -43,7 +43,7 @@ $(OUTPUT)fixdep-in.o: FORCE
>  	$(Q)$(MAKE) $(build)=fixdep
>  
>  $(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
> -	$(QUIET_LINK)$(HOSTCC) $(LDFLAGS) -o $@ $<
> +	$(QUIET_LINK)$(HOSTCC) $(HOSTLDFLAGS) $(LDFLAGS) -o $@ $<
>  
>  FORCE:
>  
> -- 
> 2.17.1
> 
