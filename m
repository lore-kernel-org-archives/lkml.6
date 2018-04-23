Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeDWUQH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 16:16:07 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36103 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932335AbeDWUQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 16:16:04 -0400
X-Google-Smtp-Source: AIpwx4/t/HXt90n1mtWcn20Rwx8KtkRg1RiNg+yfnvEVentrm7DxBR4XJQ8XlHCgY2YOtkEV5IKsTg==
Date: Mon, 23 Apr 2018 22:16:00 +0200
From: Ahmed Abdelsalam <amsalam20@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, davem@davemloft.net,
        dav.lebrun@gmail.com, linux-kernel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: Re: [nf-next] netfilter: extend SRH match to support matching
 previous, next and last SID
Message-Id: <20180423221600.4d373f3961a1bbe91743b998@gmail.com>
In-Reply-To: <20180423200844.bq3ksj262brrifnj@breakpoint.cc>
References: <1524480503-1883-1-git-send-email-amsalam20@gmail.com>
        <1524480503-1883-2-git-send-email-amsalam20@gmail.com>
        <20180423173047.gsf2xjlmpichyvte@salvia>
        <20180423220148.03800031d0cb8e8a7a83dc31@gmail.com>
        <20180423200844.bq3ksj262brrifnj@breakpoint.cc>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.21; x86_64-apple-darwin10.8.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Apr 2018 22:08:44 +0200
Florian Westphal <fw@strlen.de> wrote:

> Ahmed Abdelsalam <amsalam20@gmail.com> wrote:
> > > > @@ -50,6 +62,12 @@ struct ip6t_srh {
> > > >  	__u8                    segs_left;
> > > >  	__u8                    last_entry;
> > > >  	__u16                   tag;
> > > > +	struct in6_addr		psid_addr;
> > > > +	struct in6_addr		nsid_addr;
> > > > +	struct in6_addr		lsid_addr;
> > > > +	struct in6_addr		psid_msk;
> > > > +	struct in6_addr		nsid_msk;
> > > > +	struct in6_addr		lsid_msk;
> > > 
> > > This is changing something exposed through UAPI, so you will need a
> > > new revision for this.
> > 
> > Could you please advice what should be done in this case? 
> 
> You need to add
> struct ip6t_srh_v1 {
> 	/* copy of struct ip6t_srh here */
> 
> 	/* new fields go here */
> };
> 
> 
> Look at xt_conntrack.c, conntrack_mt_reg[] for an example of
> multi-revision match.
> 
> You can probably re-origanise code to avoid too much duplication.
> See 5a786232eb69a1f870ddc0cfd69d5bdef241a2ea in nf.git for an example,
> it makes v0 into a v1 struct at runtime and re-uses new v1 code
> for old v0.
> 
> 

Thanks Florian!  

-- 
Ahmed Abdelsalam <amsalam20@gmail.com>
