Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id izcBKa3MGlveawAAmS7hNA
	; Fri, 08 Jun 2018 18:36:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 831AC607E7; Fri,  8 Jun 2018 18:36:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWkBfi5M"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DAEFC605A2;
	Fri,  8 Jun 2018 18:36:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAEFC605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753023AbeFHSg0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:36:26 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:45448 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752697AbeFHSgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:36:25 -0400
Received: by mail-pf0-f196.google.com with SMTP id a22-v6so7044426pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 11:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Dr4lhiBmjjffIm8LJAJh7TUgIqFJ/g+ZOjphROYkJ64=;
        b=HWkBfi5MI3xaAuh3iMJbQ0O8wGt/ZHYhJ4a9We5eOi1WU1e+GU6mwhbSjY3DcH73qt
         /ttmgN81O6jjN4xn0RZmO7yW5kk07PzlM/W0cGhlaQgLeYbLXqHd6Fs/1VLHEaz5UtK8
         jAhfePFmycxvumbMc0wTnCIcDYWSQROqjqQ76ygUKFoZMDqmAO0TOcqNZqiiBulo0zbC
         jAs81Cccz/HfGOwH+QQZc245UWJ/HIvAs3IBW5fprsS3bLzdNoB9Incm4QzoF77DvhNM
         fFjkyW8cqgwWgmzqeJm/ww+z46/dOMYQqhyFm4tlMN1r8LbJ145Zlnb2F1feIohI4eSo
         gSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dr4lhiBmjjffIm8LJAJh7TUgIqFJ/g+ZOjphROYkJ64=;
        b=JG0MLXCjE3eMVC2XqkJ99ioDWIJNTJO+Swo8HxgrCL1eynaO4H3KZo2ALFV5bw3Fq+
         gkoT8Nj/wypYOgVKQBP3n0/t2rs2vtbeAqmCK0Ulqz6DWtmHj8W5pUBG/jLlaJDHv3Dk
         LBjxoBnmQe/KtGLNGBGS4we1Lab3oDtd56V7GwBuz0Bz3rpMJw6k6Zq/l0M1gUYWPybI
         QJjnBzttCsJhGL8WG10Puz3VycwrhlWTINdGUQ/wTbkZgPI4hiWlz6LUvXhjdwMdkHNs
         KsHYfoOo76sBSgxATRhmAXNZq42mcxnqy+qMErvCxdzdR7/pNabUy7+420VRBkeg3M3J
         yCzQ==
X-Gm-Message-State: APt69E22OZ9YX7NwW1dm3svyfmo4D9SvPmCCeE4WqysvmwcGh0d49rnJ
        yQD2kPtLSHS4sj3cZ8HTBT+McRpfBfI=
X-Google-Smtp-Source: ADUXVKLg5Vfsm0JZCcDuR2qjgcjxWBcSRk/UXZEHGRE89tlpMm3u5ia3vl08vajhoJ0aEoOTBBSJXA==
X-Received: by 2002:a62:1013:: with SMTP id y19-v6mr7119126pfi.166.1528482984616;
        Fri, 08 Jun 2018 11:36:24 -0700 (PDT)
Received: from jchowdhary0.mtv.corp.google.com ([2620:0:1000:1612:de71:f59c:9968:92ba])
        by smtp.gmail.com with ESMTPSA id o65-v6sm5884219pga.75.2018.06.08.11.36.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 11:36:23 -0700 (PDT)
Subject: Re: [PATCH] uapi: Make generic uapi headers compile standalone.
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, kernel-team@android.com,
        linux-kbuild@vger.kernel.org
References: <20180606231602.231326-1-jchowdhary@google.com>
 <b6b6dd56-c948-54e8-df95-3d170a3c1e7d@infradead.org>
From: Jayant Chowdhary <jchowdhary@google.com>
Message-ID: <fe1d69e1-1a0f-a3ea-e45f-994698d53dbd@google.com>
Date: Fri, 8 Jun 2018 11:36:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b6b6dd56-c948-54e8-df95-3d170a3c1e7d@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On 06/07/2018 05:07 PM, Randy Dunlap wrote:
> On 06/06/2018 04:16 PM, Jayant Chowdhary wrote:
>> In order for static analysis tools to analyze each of the uapi headers,
>> we need to enable them to compile stand-alone. Some uapi headers were
>> missing dependencies which would not make them compile stand-alone in
>> user-land. This patch adds those dependencies.
> 
> Hi,
> 
> Thanks for getting started on this.  I see that the kbuild robot and I were
> still not able to do successful builds even after this patch is applied.
> We were building different targets though.  robot was doing kernel builds
> and I was doing a large "all-uapi" build.
> 
> I started on my all-uapi work about 1 week ago but haven't posted anything yet,
> but it's posted (attached) below.  It's not yet up to kernel quality yet (for a
> Makefile), and I have made very little progress toward a successful userspace build.
> 
> If anyone is interested, just put these 3 files in <kernel_tree>/tools/build
> and then run:
> 
> make ARCH=$some_arch O=build_dir headers_check
> so that the headers will be cleaned up and installed in build_dir/usr/.
> 
> Then run 'make -f all-uapi.mk'
> and the userspace program with all header files found in build_dir/usr/include
> will be built -- i.e., attempted (not successfully).
> 
> (note: chmod +x hdr-fix-lines.pl)
> 
> 

Thank you for this. This is surely a more formal way of finding out and
verifying problems w.r.t the uapi headers, being compiled from user-land. I do
have one concern with this approach though: the make target 'all-uapi.o' depends
on all-uapi.h, which includes all the uapi headers installed in <build-dir>. So
this does make sure that when all the uapi headers are included, a user-land
program will be able to compile fine, without adding any additional
dependencies. However, this could be masking some cases of dependency exclusion.
An example can be seen as follows:

Header dependency chain:
A.h->B.h, however A.h doesn't actually include B.h
C.h->B.h, C.h does include B.h

all-uapi.h
#include<C.h>
#include<A.h>

all-uapi.h will compile fine, since the inclusion of C.h before A.h satisfies
A.h's dependency on B.h. However, if a user-land program includes just A.h, it
will not compile without adding B.h. So the target being built successfully
masked an issue with the uapi header, no?

I guess it might be better to just have a Makefile which produces a target for
each header in the set produced by 'make headers_install' and compile those,
with a -I flag as <build-dir>/usr/include ?

Also, do you think it might be better to do this work in phases ? I'm guessing
we'll be seeing many headers to fix (especially arch specific ones). Fixing
these separately: first the generic ones, followed by the ones for the arches,
might be easier ?

Thanks,
Jayant
