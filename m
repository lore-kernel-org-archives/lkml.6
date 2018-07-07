Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF29C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB881208A6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 22:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwIw9Ikb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB881208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754473AbeGGWfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 18:35:39 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44867 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754249AbeGGWfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 18:35:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so4379436pls.11;
        Sat, 07 Jul 2018 15:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QjTyw2B8cHVI5crUeTk3jFCxEqKXgm+18QY+mQKcFtM=;
        b=kwIw9Ikb3dgKulwE/3pDJu5SQirqdrGTxWGrHsRDze1qqzyOCGTFm0XWxctAjXteKL
         4inFoi4yBH4WodQjdbSmQJRJcm0fSpjo1fEwdfKEoKxnXcVlh+/L5EcEXdP5IRz+g5Hi
         9xetohMTYFa8R3Xmvu86ZwgegvxgjUvDq0F4dun/13BF0bm7bNub8XqJngBoBtEzDK8E
         17XjciGOUXTX6S/9Oysjtfg6EauocOUCz3UkkirsUKYK5MKKfK5pJJBxghlgxdJZd6vO
         9fbBeH3wCfFxjea5sqjOSl3JujBvcD0si9KdPSx7EOkAHXWA2P6DvxRQsKWMsCxZ3Q+I
         3Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QjTyw2B8cHVI5crUeTk3jFCxEqKXgm+18QY+mQKcFtM=;
        b=pPlb+f+0drXIsB4HntiPUMVsiM5bDDDc9jz/gRk+JLNh3A227Uncx+WDhh8V8GRt7k
         eK+VzpgZ2jnBxEG6mXLaZ22/LB8uOfFDq7elbyNcHTt8Nf2TVNa/Cb5KhZpMlY7t+SWb
         ogFKMnS16uwsSS7jFPAliXHX3Jb+xFJV6GjFtFHqpt3GKjp2L6S+NRRhdvcWraR291Gw
         ohnxHpvHyP6n63yHH/Ejy7TmopZQHdGF94DIaMUIibrbvf67X96taRMHdqIunYMJOYTv
         SLXtWy2XbVMnGDQgDSgnFkryJumqkHEpsEbINFZvRNwl4s5J0k0Y3NRBVH/uYuHmDCdb
         Sulw==
X-Gm-Message-State: APt69E2ECqaeYY62B4wW+1W5GWMOY7rxzNMMk56mo2M5BBAQjsYgEGhK
        PjR4LzjodCCtgupAzvOgVBmg13Hp
X-Google-Smtp-Source: AAOMgpcLGMz/42baNtOSBHwIr6a5tnDj/ROZbbQpkRsXkXGfLCtwwXxlxeSnhGqpmnYvTYKv3ooRMA==
X-Received: by 2002:a17:902:7043:: with SMTP id h3-v6mr15185872plt.269.1531002937182;
        Sat, 07 Jul 2018 15:35:37 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:fbf2])
        by smtp.gmail.com with ESMTPSA id z4-v6sm19629369pfb.108.2018.07.07.15.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Jul 2018 15:35:36 -0700 (PDT)
Date:   Sat, 7 Jul 2018 15:35:34 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Roman Gushchin <guro@fb.com>
Cc:     netdev@vger.kernel.org, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com, tj@kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sean Young <sean@mess.org>
Subject: Re: [PATCH v2 bpf-next 02/14] bpf: introduce cgroup storage maps
Message-ID: <20180707223532.k5i4h5xp4lj2pf77@ast-mbp.dhcp.thefacebook.com>
References: <20180705205139.3462-3-guro@fb.com>
 <201807062214.O8pQxWve%fengguang.wu@intel.com>
 <20180706215229.GA27634@castle.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706215229.GA27634@castle.DHCP.thefacebook.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 02:52:32PM -0700, Roman Gushchin wrote:
> On Fri, Jul 06, 2018 at 10:42:39PM +0800, kbuild test robot wrote:
> > Hi Roman,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on bpf-next/master]
> > 
> > url:    https://github.com/0day-ci/linux/commits/Roman-Gushchin/bpf-cgroup-local-storage/20180706-055938
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> > config: s390-performance_defconfig (attached as .config)
> > compiler: s390x-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> > reproduce:
> >         wget https://urldefense.proofpoint.com/v2/url?u=https-3A__raw.githubusercontent.com_intel_lkp-2Dtests_master_sbin_make.cross&d=DwIBAg&c=5VD0RTtNlTh3ycd41b3MUw&r=jJYgtDM7QT-W-Fz_d29HYQ&m=ImwiAAR6DVyf5JEcIc5VLF9xY4lfFxVuk8_4BN6I03g&s=r0S7gFQPOZVZagshsK0pL3eU8_GRpD1ywrvYfXJ4yBQ&e= -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # save the attached .config to linux build tree
> >         GCC_VERSION=7.2.0 make.cross ARCH=s390 
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    In file included from kernel//bpf/local_storage.c:2:0:
> >    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_attach':
> > >> include/linux/bpf-cgroup.h:237:10: error: 'EINVAL' undeclared (first use in this function)
> >      return -EINVAL;
> >              ^~~~~~
> >    include/linux/bpf-cgroup.h:237:10: note: each undeclared identifier is reported only once for each function it appears in
> >    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_detach':
> >    include/linux/bpf-cgroup.h:243:10: error: 'EINVAL' undeclared (first use in this function)
> >      return -EINVAL;
> >              ^~~~~~
> >    include/linux/bpf-cgroup.h: In function 'cgroup_bpf_prog_query':
> >    include/linux/bpf-cgroup.h:249:10: error: 'EINVAL' undeclared (first use in this function)
> >      return -EINVAL;
> >              ^~~~~~
> > 
> > vim +/EINVAL +237 include/linux/bpf-cgroup.h
> > 
> > 30070984 Daniel Mack 2016-11-23  232  
> > fdb5c453 Sean Young  2018-06-19  233  static inline int cgroup_bpf_prog_attach(const union bpf_attr *attr,
> > fdb5c453 Sean Young  2018-06-19  234  					 enum bpf_prog_type ptype,
> > fdb5c453 Sean Young  2018-06-19  235  					 struct bpf_prog *prog)
> > fdb5c453 Sean Young  2018-06-19  236  {
> > fdb5c453 Sean Young  2018-06-19 @237  	return -EINVAL;
> > fdb5c453 Sean Young  2018-06-19  238  }
> > fdb5c453 Sean Young  2018-06-19  239  
> > 
> > :::::: The code at line 237 was first introduced by commit
> > :::::: fdb5c4531c1e0e50e609df83f736b6f3a02896e2 bpf: fix attach type BPF_LIRC_MODE2 dependency wrt CONFIG_CGROUP_BPF
> > 
> > :::::: TO: Sean Young <sean@mess.org>
> > :::::: CC: Daniel Borkmann <daniel@iogearbox.net>
> 
> These errors have nothing to do with the cgroup local storage patchset.
> They do exist in the current bpf-next tree.
> Here is the fix.
> 
> Thanks!
> 
> --
> 
> From c0cd59b969e060765514224e31595763213e40f9 Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Fri, 6 Jul 2018 14:34:29 -0700
> Subject: [PATCH bpf-next] bpf: include errno.h from bpf-cgroup.h
> 
> Commit fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
> wrt CONFIG_CGROUP_BPF") caused some build issues, detected by 0-DAY
> kernel test infrastructure.
> 
> The problem is that cgroup_bpf_prog_attach/detach/query() functions
> can return -EINVAL error code, which is not defined. Fix this adding
> errno.h to includes.
> 
> Fixes: fdb5c4531c1e ("bpf: fix attach type BPF_LIRC_MODE2 dependency
> wrt CONFIG_CGROUP_BPF")
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Cc: Sean Young <sean@mess.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/bpf-cgroup.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
> index 79795c5fa7c3..d50c2f0a655a 100644
> --- a/include/linux/bpf-cgroup.h
> +++ b/include/linux/bpf-cgroup.h
> @@ -2,6 +2,7 @@
>  #ifndef _BPF_CGROUP_H
>  #define _BPF_CGROUP_H
>  
> +#include <linux/errno.h>
>  #include <linux/jump_label.h>
>  #include <uapi/linux/bpf.h>

good catch, but please resend it as a proper patch,
since patchwork didn't pick it up.
Also the subj should say 'bpf' instead of 'bpf-next', right?

