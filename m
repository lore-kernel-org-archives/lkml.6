Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D953C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545210910;
	bh=cLhbY7dBkzlVk9Y9KKA90Cj8vYejMn1pKRfxHVlQWg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oHxwE4pT/mqWedJx3iSkPVtld8Vzl9ftHYgS24yvXpOr0jgoXBHVuOk2OZt5auIhJ
	 oLUCmkdJsoWaR6ul44wkYqjUkV0C+XxpG8ZNPNpwQuvbnG9hdGM5NHAkqXkuUseDmd
	 Cj1jRuQBLxu/Uf9PzT18yDf2OgzZKf329L9l2eM0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728676AbeLSJPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:15:09 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34972 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeLSJPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:15:09 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so9182532pgs.2;
        Wed, 19 Dec 2018 01:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9lbCxpplthykvomAmhnVmBNdcm6t59QNi2ehRvzQnW0=;
        b=ZKCZhqv8Nr6ZSHAcysuFwqDhWFlEwgHxFYEk65JE+61u4a9rTtyMQM8vO6ftRCIvdQ
         Ud4RQh/PHddky8q6OGypU/+Y9bmVUEcYsQjF9CKxnU1ac+ElrO0/Sap6p7wZysJFY0qB
         Q+D3ud41RtV+z7c153oYJO+sOrlmsHw9HkAP3k1GdZkE/HtneVbilAehlO7PwKTnHdhs
         VmFzHHVCKk3HaEXiWqd5N6sHODr26xvATJ8whJqy8dBSmVKIP4b2T/QuuP31/DXGnTSN
         jgkNwoBNxDfDvs+w6ctfkg4ai69ely8jjigOwxDCWwHPEfmk+2NQFl+KwAPrz2ZehXIs
         udrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9lbCxpplthykvomAmhnVmBNdcm6t59QNi2ehRvzQnW0=;
        b=AEVkl7sK2ASCtZVnR9+rmrEWk0okI+0KUrHAxB4sHBh9lnPxZElMLa6E6GaBb/goWR
         cFhAGXqkc9shdv8YxNWsdUY+sGDegkYnoPfNiPD38U2JO+wLy4tChV+c60xJ+y0YeuMB
         BuZ/VaqTnaUAa/FIjY1ooyWmy7/N1x7gMHzHgh7YhCHeAiipVf3F6EMgD5JiAFODDnuh
         NL9fefMPUtQXV4BcsrH2KCLG/XRrrpFswvV84lg1ru3L+3/c5LluaLZUKGaIN5Txdyc1
         CNm2Z/4DluYcZBVmxdbRCoyv4EkKMlHphcZb8epUZK1zEXOrsoHayNS9vM0Jij+BiAFg
         MsYw==
X-Gm-Message-State: AA+aEWbUyqMjiYOQrs65cf0H8Gqlu9A4eCdGqFHqyQq4l5kdXfk+Bp9b
        fi6zsVyWR7krx3Y0ulN9D8Z6hIvd
X-Google-Smtp-Source: AFSGD/XIZ12qh1D6G0PRt/+d73+ShP3gmoYyC4Mq4Eb6yS2Lt0HA9XsDF+EUK6/RYLwC7iA2WCifnA==
X-Received: by 2002:a63:d949:: with SMTP id e9mr18835228pgj.24.1545210908227;
        Wed, 19 Dec 2018 01:15:08 -0800 (PST)
Received: from danjae.aot.lge.com ([182.210.106.196])
        by smtp.gmail.com with ESMTPSA id 125sm27183490pfx.159.2018.12.19.01.15.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Dec 2018 01:15:06 -0800 (PST)
Date:   Wed, 19 Dec 2018 18:15:00 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?Q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Wang Nan <wangnan0@huawei.com>,
        kernel-team@lge.com
Subject: Re: [PATCH 57/63] perf beauty mmap: Print PROT_READ before PROT_EXEC
 to match strace output
Message-ID: <20181219091500.GB18068@danjae.aot.lge.com>
References: <20181218220733.15839-1-acme@kernel.org>
 <20181218220733.15839-58-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181218220733.15839-58-acme@kernel.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:07:27PM -0300, Arnaldo Carvalho de Melo wrote:
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Helps with comparing 'strace' and 'perf trace' output, for mutual
> regression testing.
> 
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Wang Nan <wangnan0@huawei.com>
> Link: https://lkml.kernel.org/n/tip-va0qe95xbhep5hy52aq5qe0v@git.kernel.org
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/trace/beauty/mmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
> index 138f36a47fb1..eb31089790e3 100644
> --- a/tools/perf/trace/beauty/mmap.c
> +++ b/tools/perf/trace/beauty/mmap.c
> @@ -17,8 +17,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
>  		prot &= ~PROT_##n; \
>  	}
>  
> -	P_MMAP_PROT(EXEC);
>  	P_MMAP_PROT(READ);
> +	P_MMAP_PROT(EXEC);
>  	P_MMAP_PROT(WRITE);

EXEC should be printed after WRITE..

  $ cat mmap.c
  #include <sys/mman.h>
  
  int main(void)
  {
    mmap(0, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
    return 0;
  }
  
  $ strace -e mmap ./a.out
  ...
  mmap(NULL, 4096, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f4c643ec000
  +++ exited with 0 +++

Thanks,
Namhyung



>  	P_MMAP_PROT(SEM);
>  	P_MMAP_PROT(GROWSDOWN);
> -- 
> 2.19.2
> 
