Return-Path: <acme@kernel.org>
X-Google-Smtp-Source: AIpwx4+6F3LWxc5Ldn93bmEmcl42ii7I7xpsXfO+YKc32zVtQmeSPePKnPzfoxMCuBxZBmiqDOLJ
ARC-Seal: i=1; a=rsa-sha256; t=1524071993; cv=none;
        d=google.com; s=arc-20160816;
        b=Z8tiyR3oFKNUovTob315J11iHexmGvyAu1APtcUCW0gIbWnu7p89GySXJVQiADoVYQ
         tDfldBWNtzLt0eetqKkg54omXK6Z/PUdkNkF7TCVX6bBQoNiHrMknnuUts/8VdnlRPcL
         0J0rhmod00JAjdi8qHNEyngqWiGHgzw31H/ZXicAjcAnW4cIK1j4ANLP56xe5GmSVD2i
         eMFPD40B9Lhkm8i+Ee5nkpqQDF7+XwXI2X3Rd2KlEOUTCFf0ydhVM3pBI0gWTF/U2h3x
         WTS5RS7oB13PLIkjtWj0YEnhOftDcF+JyUV9vF43V9vSsv+JSkq7ijCPDqIo5/ppup+A
         5MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dmarc-filter
         :arc-authentication-results;
        bh=U+qKbDbrhA8twgjYGmhxR/qGSQ73Bz6g/yfSBk6r4SA=;
        b=vokMLdrR1sJc1PcyoSgpUqsQr81ceYRwHNZRkzXX99hqq/+/PBazPsmrpDFQO5YJUV
         9fYrtiAVC6u9oQlaI+qxtccqdssRydcR0OygYS6y0vne34bhzWSJgUHD7xZBfS/yHNDu
         UImdg5Wdo6J4ysFj9h19QgEaz/I/5KGoehsY46qjgteVyu8O84mU35WEOjJO8jEl0yw+
         7Y2FdCwerFptNQVtAGglD777+dQrQaRttoM0ZrwlN1pe4NIdiufuGl6ZNElcEhVC6VbJ
         AKsipVGLQtwH1oNa9Jm6zgGDVaVP9QpHQ1U3Jp0Y1bunxH3TnVItyqT/UA3SMX7OkmqQ
         5jzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of acme@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=acme@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D384217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 18 Apr 2018 14:19:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: peterz@infradead.org, mingo@redhat.com, jolsa@redhat.com,
	alexander.shishkin@linux.intel.com, namhyung@kernel.org,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf tools: coresight: Moving to SPDX identifier
Message-ID: <20180418171950.GA22762@kernel.org>
References: <1523912013-29331-1-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523912013-29331-1-git-send-email-mathieu.poirier@linaro.org>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597937566509126674?=
X-GMAIL-MSGID: =?utf-8?q?1598105315102889226?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Mon, Apr 16, 2018 at 02:53:33PM -0600, Mathieu Poirier escreveu:
> Moving perf tools CoreSight support to the SPDX identifier.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/include/linux/coresight-pmu.h             | 13 +------------
>  tools/perf/arch/arm/util/auxtrace.c             | 13 +------------
>  tools/perf/arch/arm/util/cs-etm.c               | 13 +------------
>  tools/perf/arch/arm/util/cs-etm.h               | 13 +------------
>  tools/perf/arch/arm/util/pmu.c                  | 13 +------------
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  3 +--
>  tools/perf/util/cs-etm.c                        |  3 +--
>  tools/perf/util/cs-etm.h                        | 13 +------------
>  8 files changed, 8 insertions(+), 76 deletions(-)

So now I get:

[acme@jouet perf]$ make -C tools/perf
make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/include/linux/coresight-pmu.h' differs from latest version at 'include/linux/coresight-pmu.h'
  INSTALL  GTK UI
  INSTALL  trace_plugin
<SNIP>

You should either send the patch to both files or first send it to the
kernel, then to tools/, I just checked and this SPDX using
coresight-pmu.h file hasn't hit upstream, so we're in the future here,
i.e. tools/include has a _copy_ of what is in include/ :-)

I'm dropping this patch from my tree till this gets resolved.

- Arnaldo
