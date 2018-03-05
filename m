Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2968864-1520294230-2-2056647472098864661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520294225; b=H/4obDvmPDtSFmup7WMwNphVNvHed/9fDVeYfmUp184iAqO
    dSFRVVlloRzLjaSDO8Ui7nSAk3rINGKqr+259C5vLgRH4E/xN2oAqYFb2FxSKShA
    bK0gYhw8gXnsnzng2WpSmkfiiIVhUVLZflIpgHreB+5wTzBTHN0lht/8FM8t393U
    xyCdlwFZ5Tt6KSl1q/eXs5Vo2zdi+SszScH2CTpVO9Ir9KezlQ2A5Mi5ZUfdOqMD
    9/85KC97cEK4Nnfy24l+8iJadQ58Lcb9LbsEQU0KBc2dSh+5egg5tr9QSmluYetb
    PmbZ6qnNTspo7+jTVyiuafsS6nRaKHefm9Cm6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520294225; bh=3KEyPeo97mCP21ZIFddGL5HYa1wFxwn66nK1RlNLC9U=; b=i
    hkgZZlNS5TYV7qPWC/dT3k/huhDzvbBGt9dn74NspIYeibRIP7wCJhrO9EcYey2E
    crdmlu0V00YNmlpmd01oe7nKTIePlSuV5LkvUs6uUnsJ4heh6dCLIE+eoMaXN5Ld
    6zHa2TDOYLZgPrrZQKtuI1wZ+ZGROcbxMD+wc67uhoVGe8nC0C4N/GcECS+ZtiVd
    lMm0C4c871R8FWhIEwItV95IRa0EXutFg7ly59kVw4+e/JVk3RtAXxNeO83uxnQf
    7yVkE3uoDNr+PWmxCY6/PidRMVcDumIY3P1q2Ze2s/QlHdOZbYwNGclQu/3CTg6j
    bJtjwmgq8FxGopSaOoL5Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=iogearbox.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=iogearbox.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=iogearbox.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=iogearbox.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932406AbeCEX5D (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 18:57:03 -0500
Received: from www62.your-server.de ([213.133.104.62]:46804 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932084AbeCEX5C (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 18:57:02 -0500
Subject: Re: [PATCH bpf-next 3/5] bpf: introduce BPF_RAW_TRACEPOINT
To: Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc: torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
References: <20180301041957.399230-1-ast@kernel.org>
 <20180301041957.399230-4-ast@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <56cd9ef9-41b0-dc89-fa49-92a459796515@iogearbox.net>
Date: Tue, 6 Mar 2018 00:56:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180301041957.399230-4-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/01/2018 05:19 AM, Alexei Starovoitov wrote:
> Introduce BPF_PROG_TYPE_RAW_TRACEPOINT bpf program type to access
> kernel internal arguments of the tracepoints in their raw form.
> 
> From bpf program point of view the access to the arguments look like:
> struct bpf_raw_tracepoint_args {
>        __u64 args[0];
> };
> 
> int bpf_prog(struct bpf_raw_tracepoint_args *ctx)
> {
>   // program can read args[N] where N depends on tracepoint
>   // and statically verified at program load+attach time
> }
> 
> kprobe+bpf infrastructure allows programs access function arguments.
> This feature allows programs access raw tracepoint arguments.
> 
> Similar to proposed 'dynamic ftrace events' there are no abi guarantees
> to what the tracepoints arguments are and what their meaning is.
> The program needs to type cast args properly and use bpf_probe_read()
> helper to access struct fields when argument is a pointer.
> 
> For every tracepoint __bpf_trace_##call function is prepared.
> In assembler it looks like:
> (gdb) disassemble __bpf_trace_xdp_exception
> Dump of assembler code for function __bpf_trace_xdp_exception:
>    0xffffffff81132080 <+0>:     mov    %ecx,%ecx
>    0xffffffff81132082 <+2>:     jmpq   0xffffffff811231f0 <bpf_trace_run3>
> 
> where
> 
> TRACE_EVENT(xdp_exception,
>         TP_PROTO(const struct net_device *dev,
>                  const struct bpf_prog *xdp, u32 act),
> 
> The above assembler snippet is casting 32-bit 'act' field into 'u64'
> to pass into bpf_trace_run3(), while 'dev' and 'xdp' args are passed as-is.
> All of ~500 of __bpf_trace_*() functions are only 5-10 byte long
> and in total this approach adds 7k bytes to .text and 8k bytes
> to .rodata since the probe funcs need to appear in kallsyms.
> The alternative of having __bpf_trace_##call being global in kallsyms
> could have been to keep them static and add another pointer to these
> static functions to 'struct trace_event_class' and 'struct trace_event_call',
> but keeping them global simplifies implementation and keeps it indepedent
> from the tracing side.
> 
> Also such approach gives the lowest possible overhead
> while calling trace_xdp_exception() from kernel C code and
> transitioning into bpf land.

Awesome work! Just a few comments below.

> Since tracepoint+bpf are used at speeds of 1M+ events per second
> this is very valuable optimization.
> 
> Since ftrace and perf side are not involved the new
> BPF_RAW_TRACEPOINT_OPEN sys_bpf command is introduced
> that returns anon_inode FD of 'bpf-raw-tracepoint' object.
> 
> The user space looks like:
> // load bpf prog with BPF_PROG_TYPE_RAW_TRACEPOINT type
> prog_fd = bpf_prog_load(...);
> // receive anon_inode fd for given bpf_raw_tracepoint
> raw_tp_fd = bpf_raw_tracepoint_open("xdp_exception");
> // attach bpf program to given tracepoint
> bpf_prog_attach(prog_fd, raw_tp_fd, BPF_RAW_TRACEPOINT);
> 
> Ctrl-C of tracing daemon or cmdline tool that uses this feature
> will automatically detach bpf program, unload it and
> unregister tracepoint probe.
> 
> On the kernel side for_each_kernel_tracepoint() is used
> to find a tracepoint with "xdp_exception" name
> (that would be __tracepoint_xdp_exception record)
> 
> Then kallsyms_lookup_name() is used to find the addr
> of __bpf_trace_xdp_exception() probe function.
> 
> And finally tracepoint_probe_register() is used to connect probe
> with tracepoint.
> 
> Addition of bpf_raw_tracepoint doesn't interfere with ftrace and perf
> tracepoint mechanisms. perf_event_open() can be used in parallel
> on the same tracepoint.
> Also multiple bpf_raw_tracepoint_open("foo") are permitted.
> Each raw_tp_fd allows to attach one bpf program, so multiple
> user space processes can open their own raw_tp_fd with their own
> bpf program. The kernel will execute all tracepoint probes
> and all attached bpf programs.
> 
> In the future bpf_raw_tracepoints can be extended with
> query/introspection logic.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf_types.h    |   1 +
>  include/linux/trace_events.h |  57 ++++++++++++
>  include/trace/bpf_probe.h    |  87 ++++++++++++++++++
>  include/trace/define_trace.h |   1 +
>  include/uapi/linux/bpf.h     |  11 +++
>  kernel/bpf/syscall.c         | 108 ++++++++++++++++++++++
>  kernel/trace/bpf_trace.c     | 211 +++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 476 insertions(+)
>  create mode 100644 include/trace/bpf_probe.h
> 
[...]
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e24aa3241387..b5c33dda1a1c 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1311,6 +1311,109 @@ static int bpf_obj_get(const union bpf_attr *attr)
>  				attr->file_flags);
>  }
>  
> +struct bpf_raw_tracepoint {
> +	struct tracepoint *tp;
> +	struct bpf_prog *prog;
> +};
> +
> +static int bpf_raw_tracepoint_release(struct inode *inode, struct file *filp)
> +{
> +	struct bpf_raw_tracepoint *raw_tp = filp->private_data;
> +
> +	if (raw_tp->prog) {
> +		bpf_probe_unregister(raw_tp->tp, raw_tp->prog);
> +		bpf_prog_put(raw_tp->prog);
> +	}
> +	kfree(raw_tp);
> +	return 0;
> +}
> +
> +static const struct file_operations bpf_raw_tp_fops = {
> +	.release	= bpf_raw_tracepoint_release,
> +	.read		= bpf_dummy_read,
> +	.write		= bpf_dummy_write,
> +};
> +
> +static struct bpf_raw_tracepoint *__bpf_raw_tracepoint_get(struct fd f)
> +{
> +	if (!f.file)
> +		return ERR_PTR(-EBADF);
> +	if (f.file->f_op != &bpf_raw_tp_fops) {
> +		fdput(f);
> +		return ERR_PTR(-EINVAL);
> +	}
> +	return f.file->private_data;
> +}
> +
> +static void *__find_tp(struct tracepoint *tp, void *priv)
> +{
> +	char *name = priv;
> +
> +	if (!strcmp(tp->name, name))
> +		return tp;
> +	return NULL;
> +}
> +
> +#define BPF_RAW_TRACEPOINT_OPEN_LAST_FIELD raw_tracepoint.name
> +
> +static int bpf_raw_tracepoint_open(const union bpf_attr *attr)
> +{
> +	struct bpf_raw_tracepoint *raw_tp;
> +	struct tracepoint *tp;
> +	char tp_name[128];
> +
> +	if (strncpy_from_user(tp_name, u64_to_user_ptr(attr->raw_tracepoint.name),
> +			      sizeof(tp_name) - 1) < 0)
> +		return -EFAULT;
> +	tp_name[sizeof(tp_name) - 1] = 0;
> +
> +	tp = for_each_kernel_tracepoint(__find_tp, tp_name);
> +	if (!tp)
> +		return -ENOENT;
> +
> +	raw_tp = kmalloc(sizeof(*raw_tp), GFP_USER | __GFP_ZERO);
> +	if (!raw_tp)
> +		return -ENOMEM;
> +	raw_tp->tp = tp;
> +
> +	return anon_inode_getfd("bpf-raw-tracepoint", &bpf_raw_tp_fops, raw_tp,
> +				O_CLOEXEC);

When anon_inode_getfd() fails to get you an fd, then you leak raw_tp here.

> +}
> +
> +static int attach_raw_tp(const union bpf_attr *attr)
> +{
> +	struct bpf_raw_tracepoint *raw_tp;
> +	struct bpf_prog *prog;
> +	struct fd f;
> +	int err = -EEXIST;
> +
> +	if (attr->attach_flags)
> +		return -EINVAL;
> +
> +	f = fdget(attr->target_fd);
> +	raw_tp = __bpf_raw_tracepoint_get(f);
> +	if (IS_ERR(raw_tp))
> +		return PTR_ERR(raw_tp);
> +
> +	if (raw_tp->prog)
> +		goto out;
> +
> +	prog = bpf_prog_get_type(attr->attach_bpf_fd,
> +				 BPF_PROG_TYPE_RAW_TRACEPOINT);
> +	if (IS_ERR(prog)) {
> +		err = PTR_ERR(prog);
> +		goto out;
> +	}
> +	err = bpf_probe_register(raw_tp->tp, prog);
> +	if (err)
> +		bpf_prog_put(prog);
> +	else
> +		raw_tp->prog = prog;

I think this would race here with the above test on concurrent attach
attempts, so you could still register via bpf_probe_register() multiple
times before you hit the earlier raw_tp->prog test to bail out before
doing so.

> +out:
> +	fdput(f);
> +	return err;
> +}
> +
>  #ifdef CONFIG_CGROUP_BPF
>  
>  #define BPF_PROG_ATTACH_LAST_FIELD attach_flags
> @@ -1385,6 +1488,8 @@ static int bpf_prog_attach(const union bpf_attr *attr)
>  	case BPF_SK_SKB_STREAM_PARSER:
>  	case BPF_SK_SKB_STREAM_VERDICT:
>  		return sockmap_get_from_fd(attr, true);
> +	case BPF_RAW_TRACEPOINT:
> +		return attach_raw_tp(attr);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1917,6 +2022,9 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
>  	case BPF_OBJ_GET_INFO_BY_FD:
>  		err = bpf_obj_get_info_by_fd(&attr, uattr);
>  		break;
> +	case BPF_RAW_TRACEPOINT_OPEN:
> +		err = bpf_raw_tracepoint_open(&attr);

With regards to above attach_raw_tp() comment, why not having single
BPF_RAW_TRACEPOINT_OPEN command already passing BPF fd along with the
tp name? Is there a concrete reason/use-case why it's split that way?

> +		break;
>  	default:
>  		err = -EINVAL;
>  		break;
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c0a9e310d715..e59b62875d1e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -723,6 +723,14 @@ const struct bpf_verifier_ops tracepoint_verifier_ops = {
>  const struct bpf_prog_ops tracepoint_prog_ops = {
>  };
>  
