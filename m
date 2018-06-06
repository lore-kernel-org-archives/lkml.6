Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QoiM04ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AEDA960555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeFFLh4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 07:37:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751849AbeFFLhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 07:37:55 -0400
Date: Wed, 6 Jun 2018 20:37:52 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] selftests/ftrace: Add ppc support for kprobe args tests
Message-Id: <20180606203752.7768487691f4a85a56f82978@kernel.org>
In-Reply-To: <20180606093154.10408-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20180606093154.10408-1-naveen.n.rao@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jun 2018 15:01:54 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Add powerpc support for the recently added kprobe args tests.

Thank you for adding powerpc support!

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc  | 8 ++++++++
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc  | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index 5ba73035e1d9..a0002563e9ee 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -24,6 +24,14 @@ arm*)
>    ARG2=%r1
>    OFFS=4
>  ;;
> +ppc64*)
> +  ARG2=%r4
> +  OFFS=8
> +;;
> +ppc*)
> +  ARG2=%r4
> +  OFFS=4
> +;;
>  *)
>    echo "Please implement other architecture here"
>    exit_untested
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> index 231bcd2c4eb5..d026ff4e562f 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
> @@ -34,6 +34,13 @@ arm*)
>    GOODREG=%r0
>    BADREG=%ax
>  ;;
> +ppc*)
> +  GOODREG=%r3
> +  BADREG=%msr
> +;;
> +*)
> +  echo "Please implement other architecture here"
> +  exit_untested
>  esac
>  
>  test_goodarg() # Good-args
> -- 
> 2.17.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
