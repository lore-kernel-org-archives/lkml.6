Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF17C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7489620831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 09:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7489620831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbeJ3SUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 14:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39946 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbeJ3SUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 14:20:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7056F7F6CE;
        Tue, 30 Oct 2018 09:27:32 +0000 (UTC)
Received: from krava (unknown [10.43.17.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id 495CB2A2D5;
        Tue, 30 Oct 2018 09:27:29 +0000 (UTC)
Date:   Tue, 30 Oct 2018 10:27:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Herton R. Krzesinski" <herton@redhat.com>
Subject: Re: [PATCH 08/10] tools power turbostat: Override CFLAGS assignments
 and add LDFLAGS to build command
Message-ID: <20181030092727.GD19259@krava>
References: <20181016150614.21260-1-jolsa@kernel.org>
 <20181016150614.21260-9-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016150614.21260-9-jolsa@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 30 Oct 2018 09:27:32 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping

thanks,
jirka

On Tue, Oct 16, 2018 at 05:06:13PM +0200, Jiri Olsa wrote:
> So user could specify outside CFLAGS/LDFLAGS values.
> 
> Cc: Len Brown <len.brown@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/power/x86/turbostat/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/Makefile b/tools/power/x86/turbostat/Makefile
> index 2ab25aa38263..1598b4fa0b11 100644
> --- a/tools/power/x86/turbostat/Makefile
> +++ b/tools/power/x86/turbostat/Makefile
> @@ -9,13 +9,13 @@ ifeq ("$(origin O)", "command line")
>  endif
>  
>  turbostat : turbostat.c
> -CFLAGS +=	-Wall
> -CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
> -CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
> +override CFLAGS +=	-Wall
> +override CFLAGS +=	-DMSRHEADER='"../../../../arch/x86/include/asm/msr-index.h"'
> +override CFLAGS +=	-DINTEL_FAMILY_HEADER='"../../../../arch/x86/include/asm/intel-family.h"'
>  
>  %: %.c
>  	@mkdir -p $(BUILD_OUTPUT)
> -	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@
> +	$(CC) $(CFLAGS) $< -o $(BUILD_OUTPUT)/$@ $(LDFLAGS)
>  
>  .PHONY : clean
>  clean :
> -- 
> 2.17.2
> 
