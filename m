Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932405AbeD0R4O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 13:56:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38168 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751753AbeD0R4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 13:56:12 -0400
Date: Fri, 27 Apr 2018 10:55:46 -0700
From: Martin KaFai Lau <kafai@fb.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH 2/2] bpf: btf: remove a couple conditions
Message-ID: <20180427175544.vydqf4iufopcyv6d@kafai-mbp>
References: <20180427140459.GB19583@mwanda>
 <20180427172023.6japncdd3nbqauzn@kafai-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180427172023.6japncdd3nbqauzn@kafai-mbp>
User-Agent: NeoMutt/20171208
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 10:20:25AM -0700, Martin KaFai Lau wrote:
> On Fri, Apr 27, 2018 at 05:04:59PM +0300, Dan Carpenter wrote:
> > We know "err" is zero so we can remove these and pull the code in one
> > indent level.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Thanks for the simplification!
> 
> Acked-by: Martin KaFai Lau <kafai@fb.com>
btw, it should be for bpf-next.  Please tag the subject with bpf-next when
you respin. Thanks!

> 
> > ---
> > This applies to the BPF tree (linux-next)
> > 
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index e631b6fd60d3..7cb0905f37c2 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -1973,16 +1973,14 @@ static struct btf *btf_parse(void __user *btf_data, u32 btf_data_size,
> >  	if (err)
> >  		goto errout;
> >  
> > -	if (!err && log->level && bpf_verifier_log_full(log)) {
> > +	if (log->level && bpf_verifier_log_full(log)) {
> >  		err = -ENOSPC;
> >  		goto errout;
> >  	}
> >  
> > -	if (!err) {
> > -		btf_verifier_env_free(env);
> > -		btf_get(btf);
> > -		return btf;
> > -	}
> > +	btf_verifier_env_free(env);
> > +	btf_get(btf);
> > +	return btf;
> >  
> >  errout:
> >  	btf_verifier_env_free(env);
