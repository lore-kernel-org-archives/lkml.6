Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F30FC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203D52142A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 20:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZE0gXfVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203D52142A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754450AbeGGUdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 16:33:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:33906 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754415AbeGGUdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 16:33:42 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so4316724plo.1
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jul 2018 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7vL1LW8Rml9Y6MFtMtBcAP3e3O3Y88iKmzqZ6NxX/OM=;
        b=ZE0gXfVn2hohdqv4YPGCusMHfErcxxEdMvQIK3wVjjL6Xx63HnOhMlDdyVh82j7KRq
         05bOW7Np/D3sXoKbb4thm0PzZaBqgf8ljnZYheblO8ZiSutTfoiQg5HYfIZR3ww3YkOE
         IkKwfKtQ2CFFfRt+WljORYKm05ZDkxkW4gms9Yo2aM2bhUAB3pETLfQsiCsjszoT8ApC
         ID1vRH/wXtF4G+36kAXS91nDJ9mWr54Lg+aL4JDml82oM9f4DbHQQ+9mih1wfWx2Wi85
         +UAC+Stt6srdCTTXunruCRf3x4Ci0PVoId3hZzmyCG+/WiQ9iGbQsT4UeC/QJv7Yr7b2
         jI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7vL1LW8Rml9Y6MFtMtBcAP3e3O3Y88iKmzqZ6NxX/OM=;
        b=gAKbNbAmc1H+CRZke/g4mOc8RslWN+OMZEpuPmuLvgpBY0sz0taZHqIg4lpgmMt1+6
         SF20cf2o6RcveujoS4XEu95YxVH1Nbla6huQ9hxd/Jf74s4/U3Ww90TEtJMhPgP/9+8a
         rh1bs+u9Kx46gNUCGvsZR/tKipYmg83gw+4U+FljqA/zNM5QgO378efxqtO1a3FpB+70
         1AGfxWAgqXYlmOWPls590BlK1UczovFKAZMwMqvosNy4QfO1wLO7UEZKY6G0Z3vhSrMu
         7pGccNQ8ROwaTe2bL0p7i9AG5xcAphOtcSSpO381lewu3iQ6Tnc7atg5NMESe3GncgbW
         v6ow==
X-Gm-Message-State: APt69E3PKk2ApommVpUzTlS8TSF/50jX0iO8AGF2NdB0jX9LzfQRPvZa
        9gN9HdNz0RVpPR+MH20ljfJCxQ==
X-Google-Smtp-Source: AAOMgpdonlhtuycWq3dTCCr1iYOAQhX7TIFlowmXRwRHQHK+k4QRtdQFeG6YYLH6MYMXJroP3Ry2oA==
X-Received: by 2002:a17:902:b604:: with SMTP id b4-v6mr14889045pls.18.1530995621760;
        Sat, 07 Jul 2018 13:33:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id d141-v6sm21433862pfd.54.2018.07.07.13.33.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 13:33:40 -0700 (PDT)
Date:   Sat, 7 Jul 2018 13:33:40 -0700
From:   Joel Fernandes <joelaf@google.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Colascione <dancol@google.com>, ast@fb.com,
        linux-kernel@vger.kernel.org, timmurray@google.com,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        mathieu.desnoyers@efficios.com, fengc@google.com
Subject: Re: [RFC] Add BPF_SYNCHRONIZE bpf(2) command
Message-ID: <20180707203340.GA74719@joelaf.mtv.corp.google.com>
References: <20180707015616.25988-1-dancol@google.com>
 <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707025426.ssxipi7hsehoiuyo@ast-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:54:28PM -0700, Alexei Starovoitov wrote:
> On Fri, Jul 06, 2018 at 06:56:16PM -0700, Daniel Colascione wrote:
> > BPF_SYNCHRONIZE waits for any BPF programs active at the time of
> > BPF_SYNCHRONIZE to complete, allowing userspace to ensure atomicity of
> > RCU data structure operations with respect to active programs. For
> > example, userspace can update a map->map entry to point to a new map,
> > use BPF_SYNCHRONIZE to wait for any BPF programs using the old map to
> > complete, and then drain the old map without fear that BPF programs
> > may still be updating it.
> > 
> > Signed-off-by: Daniel Colascione <dancol@google.com>
> > ---
> >  include/uapi/linux/bpf.h |  1 +
> >  kernel/bpf/syscall.c     | 14 ++++++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index b7db3261c62d..4365c50e8055 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -98,6 +98,7 @@ enum bpf_cmd {
> >  	BPF_BTF_LOAD,
> >  	BPF_BTF_GET_FD_BY_ID,
> >  	BPF_TASK_FD_QUERY,
> > +	BPF_SYNCHRONIZE,
> >  };
> >  
> >  enum bpf_map_type {
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index d10ecd78105f..60ec7811846e 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2272,6 +2272,20 @@ SYSCALL_DEFINE3(bpf, int, cmd, union bpf_attr __user *, uattr, unsigned int, siz
> >  	if (sysctl_unprivileged_bpf_disabled && !capable(CAP_SYS_ADMIN))
> >  		return -EPERM;
> >  
> > +	if (cmd == BPF_SYNCHRONIZE) {
> > +		if (uattr != NULL || size != 0)
> > +			return -EINVAL;
> > +		err = security_bpf(cmd, NULL, 0);
> > +		if (err < 0)
> > +			return err;
> > +		/* BPF programs are run with preempt disabled, so
> > +		 * synchronize_sched is sufficient even with
> > +		 * RCU_PREEMPT.
> > +		 */
> > +		synchronize_sched();
> > +		return 0;
> 
> I don't think it's necessary. sys_membarrier() can do this already
> and some folks use it exactly for this use case.

Alexei, the use of sys_membarrier for this purpose seems kind of weird to me
though. No where does the manpage say membarrier should be implemented this
way so what happens if the implementation changes?

Further, membarrier manpage says that a memory barrier should be matched with
a matching barrier. In this use case there is no matching barrier, so it
makes it weirder.

Lastly, sys_membarrier seems will not work on nohz-full systems, so its a bit
fragile to depend on it for this?

        case MEMBARRIER_CMD_GLOBAL:
                /* MEMBARRIER_CMD_GLOBAL is not compatible with nohz_full. */
                if (tick_nohz_full_enabled())
                        return -EINVAL;
                if (num_online_cpus() > 1)
                        synchronize_sched();
                return 0;


Adding Mathieu as well who I believe is author/maintainer of membarrier.

thanks!

- Joel

