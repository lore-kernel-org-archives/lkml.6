Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052A4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98F6620870
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 13:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klV3KYmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98F6620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbeGONgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 09:36:13 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:45540 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbeGONgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 09:36:12 -0400
Received: by mail-pf0-f193.google.com with SMTP id i26-v6so13577652pfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SQLjygVzHFGjTSc8BjsDSiHpdGXVhX1Zf+PLjKfyfQ8=;
        b=klV3KYmXm1YF/AaI9C9suhUTZXc/c734NuIBFyTjz9dtMx16K8w3+hMoALGia6kaOQ
         fNWqYoLweZngIOy47IzleKL7eRZPFHfshA8dvcU3/HzMwdwTaB/3UykFvR4vk4nYFMkP
         5DnHL/WbPOMQYGL+qc2JqoTh7mA0fqvAa6Subx7wnxj27fuij0KLNU2m1vIuxFe1v5R6
         3856fPs7XsyeWtEDzBtHXWyzPxRNYQ2SSqkvc/2nuD9oKjdp3pkYfWl/B0qOXlIkWiq8
         NmMdilrhy+1moOsZp9qIQgYZcKYp3/Pd+w5lvjk3BUyBKXOCIsAqrcYoC/lzEFK87qH8
         tQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=SQLjygVzHFGjTSc8BjsDSiHpdGXVhX1Zf+PLjKfyfQ8=;
        b=BK3UJ3GQ2tj88Sfg2FW5xrCPKIxYhwpaudnDUr1UYN6b2cTrnXhZSbOEtQXVO3Zdog
         81wigve7zKCQQT3d/j/ICuFUxNyssbprNtWo/psG2i4kPYsnf39zmHNh/YlKi5+uDQqL
         DPK1d4wOMUc4t0qoxaASdC1qkx26vWfJok3aHu6RALJJ1/8/pgzyay3Mb/OR45mucThS
         P29dutz2/Jgv+9+3JTNTQvkjL138Sfgnd5kNTLb6LsYqMKksrfsrh0jC/vw2bboIqcbE
         PkXgVyRfHGHl+xVGM4OUCXA0dYo6AwyayKzPRVCfKD8mhvwzifoT7Np13xPozrPLLF9R
         nvRQ==
X-Gm-Message-State: AOUpUlE9idp78gXStSpCwxUT73+VL8A7Lkv+Vc3ajMexm0cUdCvN5mef
        LJVL4JsxCaBs4M5b6l84LuuQAQ==
X-Google-Smtp-Source: AAOMgpf54yXVlwVeVpofHBSfGdma21agn0kP4VDZBxT/9H5ezxZNdJCgXP3sUAGDbir7i7DS/VMFhw==
X-Received: by 2002:a65:450a:: with SMTP id n10-v6mr11965330pgq.392.1531660396764;
        Sun, 15 Jul 2018 06:13:16 -0700 (PDT)
Received: from danjae.aot.lge.com ([210.103.86.137])
        by smtp.gmail.com with ESMTPSA id t186-v6sm17765808pgd.77.2018.07.15.06.13.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Jul 2018 06:13:15 -0700 (PDT)
Date:   Sun, 15 Jul 2018 22:08:27 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kan Liang <kan.liang@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Lukasz Odzioba <lukasz.odzioba@intel.com>,
        Wang Nan <wangnan0@huawei.com>, kernel-team@lge.com
Subject: Re: [PATCH 1/4] perf tools: Fix struct comm_str removal crash
Message-ID: <20180715130827.GA5071@danjae.aot.lge.com>
References: <20180712142023.16915-1-jolsa@kernel.org>
 <20180712142023.16915-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180712142023.16915-2-jolsa@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Thu, Jul 12, 2018 at 04:20:20PM +0200, Jiri Olsa wrote:
> We occasionaly hit following assert failure in perf top,
> when processing the /proc info in multiple threads.
> 
>   perf: ...include/linux/refcount.h:109: refcount_inc:
>         Assertion `!(!refcount_inc_not_zero(r))' failed.
> 
> The gdb backtrace looks like this:
> 
>   [Switching to Thread 0x7ffff11ba700 (LWP 13749)]
>   0x00007ffff50839fb in raise () from /lib64/libc.so.6
>   (gdb)
>   #0  0x00007ffff50839fb in raise () from /lib64/libc.so.6
>   #1  0x00007ffff5085800 in abort () from /lib64/libc.so.6
>   #2  0x00007ffff507c0da in __assert_fail_base () from /lib64/libc.so.6
>   #3  0x00007ffff507c152 in __assert_fail () from /lib64/libc.so.6
>   #4  0x0000000000535373 in refcount_inc (r=0x7fffdc009be0)
>       at ...include/linux/refcount.h:109
>   #5  0x00000000005354f1 in comm_str__get (cs=0x7fffdc009bc0)
>       at util/comm.c:24
>   #6  0x00000000005356bd in __comm_str__findnew (str=0x7fffd000b260 ":2",
>       root=0xbed5c0 <comm_str_root>) at util/comm.c:72
>   #7  0x000000000053579e in comm_str__findnew (str=0x7fffd000b260 ":2",
>       root=0xbed5c0 <comm_str_root>) at util/comm.c:95
>   #8  0x000000000053582e in comm__new (str=0x7fffd000b260 ":2",
>       timestamp=0, exec=false) at util/comm.c:111
>   #9  0x00000000005363bc in thread__new (pid=2, tid=2) at util/thread.c:57
>   #10 0x0000000000523da0 in ____machine__findnew_thread (machine=0xbfde38,
>       threads=0xbfdf28, pid=2, tid=2, create=true) at util/machine.c:457
>   #11 0x0000000000523eb4 in __machine__findnew_thread (machine=0xbfde38,
>   ...
> 
> The failing assertion is this one:
> 
>   REFCOUNT_WARN(!refcount_inc_not_zero(r), ...
> 
> The problem is that we keep global comm_str_root list, which
> is accessed by multiple threads during the perf top startup
> and following 2 paths can race:
> 
>   thread 1:
>     ...
>     thread__new
>       comm__new
>         comm_str__findnew
>           down_write(&comm_str_lock);
>           __comm_str__findnew
>             comm_str__get
> 
>   thread 2:
>     ...
>     comm__override or comm__free
>       comm_str__put
>         refcount_dec_and_test
>           down_write(&comm_str_lock);
>           rb_erase(&cs->rb_node, &comm_str_root);
> 
> Because thread 2 first decrements the refcnt and only after then it
> removes the struct comm_str from the list, the thread 1 can find this
> object on the list with refcnt equls to 0 and hit the assert.
> 
> This patch fixes the thread 2 path, by removing the struct comm_str
> FIRST from the list and only AFTER calling comm_str__put on it. This
> way the thread 1 finds only valid objects on the list.

I'm not sure we can unconditionally remove the comm_str from the tree.
It should be removed only if refcount is going to zero IMHO.
Otherwise it could end up having multiple comm_str entry for a same
name.

Thanks,
Namhyung


> 
> We also need to ensure now, that only one caller removes the struct
> comm_str, from the list. Adding 'removed' bool to track that.
> 
> Link: http://lkml.kernel.org/n/tip-vrizt6sw1lu1ybsrl9l0wwln@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/comm.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
> index 7798a2cc8a86..7f1c6e63e3e6 100644
> --- a/tools/perf/util/comm.c
> +++ b/tools/perf/util/comm.c
> @@ -12,6 +12,7 @@ struct comm_str {
>  	char *str;
>  	struct rb_node rb_node;
>  	refcount_t refcnt;
> +	bool removed;
>  };
>  
>  /* Should perhaps be moved to struct machine */
> @@ -28,9 +29,6 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
>  static void comm_str__put(struct comm_str *cs)
>  {
>  	if (cs && refcount_dec_and_test(&cs->refcnt)) {
> -		down_write(&comm_str_lock);
> -		rb_erase(&cs->rb_node, &comm_str_root);
> -		up_write(&comm_str_lock);
>  		zfree(&cs->str);
>  		free(cs);
>  	}
> @@ -117,6 +115,28 @@ struct comm *comm__new(const char *str, u64 timestamp, bool exec)
>  	return comm;
>  }
>  
> +static void __comm_str__remove(struct comm_str *cs)
> +{
> +	down_write(&comm_str_lock);
> +	if (!cs->removed) {
> +		rb_erase(&cs->rb_node, &comm_str_root);
> +		cs->removed = true;
> +	}
> +	up_write(&comm_str_lock);
> +}
> +
> +static void comm_str__remove(struct comm_str *cs)
> +{
> +	if (!cs->removed)
> +		__comm_str__remove(cs);
> +}
> +
> +static void comm_str__exit(struct comm_str *cs)
> +{
> +	comm_str__remove(cs);
> +	comm_str__put(cs);
> +}
> +
>  int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  {
>  	struct comm_str *new, *old = comm->comm_str;
> @@ -125,7 +145,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  	if (!new)
>  		return -ENOMEM;
>  
> -	comm_str__put(old);
> +	comm_str__exit(old);
>  	comm->comm_str = new;
>  	comm->start = timestamp;
>  	if (exec)
> @@ -136,7 +156,7 @@ int comm__override(struct comm *comm, const char *str, u64 timestamp, bool exec)
>  
>  void comm__free(struct comm *comm)
>  {
> -	comm_str__put(comm->comm_str);
> +	comm_str__exit(comm->comm_str);
>  	free(comm);
>  }
>  
> -- 
> 2.17.1
> 
