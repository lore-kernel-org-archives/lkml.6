Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F13C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C28F72086D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544621537;
	bh=7cREGYjVkKAADKwdl4Jhncbo2+ngUMQzMHKwyP1G43U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lC3561ckklE9lPvX5wcUS1reTZLABiMempikKRI+Vm44BvfBJw9CsYduc+NYjCd9v
	 DZPN9JgBrT5gA0DgjBm111qxS+ebzp7v3RW+6rnL+U4DkKbEXY8Jq/gcDC0A15+ekS
	 OBTryv/OnddK6ff6YceYJc7eI1uTKaiQv1cU35Yc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C28F72086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeLLNcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:32:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeLLNcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:32:16 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76B2E2084E;
        Wed, 12 Dec 2018 13:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544621535;
        bh=7cREGYjVkKAADKwdl4Jhncbo2+ngUMQzMHKwyP1G43U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bp9j2wg50OYJyKvjL89MBPuMzdfe3iLkKdrTo5w2u9ImY3Eihj2McY552dm7BN23X
         /AMX4iBXF8w4fq7AAIOFLnLE9SEZR66JzwUTdEob1Ql9OCuLt61QK97DXMIA4VhN19
         5GE9sDUN6I86CPRfT4b8E0eHpdZA0/nG+JmJNroY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E779541B11; Wed, 12 Dec 2018 10:32:08 -0300 (-03)
Date:   Wed, 12 Dec 2018 10:32:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Link libperf-jvmti.so with LDFLAGS variable
Message-ID: <20181212133208.GC21027@kernel.org>
References: <20181212132940.840-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212132940.840-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 12, 2018 at 02:29:40PM +0100, Jiri Olsa escreveu:
> So we could propagate distro flags into libperf-jvmti.so library.

Thanks, applied.

- Arnaldo
 
> Link: http://lkml.kernel.org/n/tip-kb80gm9mmzkkcw2gkytbkkbq@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 5a90c0ef2302..6f35f4d46b0a 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -660,7 +660,7 @@ $(LIBJVMTI_IN): FORCE
>  	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
>  
>  $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
> -	$(QUIET_LINK)$(CC) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
> +	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
>  endif
>  
>  $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
> -- 
> 2.17.2

-- 

- Arnaldo
