Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1388873-1523287692-2-12297960077477710303
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523287691; b=bh1nWBB/zAKSphA3m7vjoS6xiR2JfXrEKkcZgCYHa8Xv+OmZDl
    xVwf8JrAT3PIkdJuo/tT+0zYO+4rvkyiti4tivv4pCvgW7bup58uzuzyIYZx/0DM
    AE0fsBz8BurXGxtC+9b7BzNaFqLJLhG8ug6MspgaED3hMSiaqtjCwUmK7yBAs/xu
    cAu/61VsVCI8fMiI/aL8n8q/zEFIH3hr8Lb3kzv9+wnHdJcLWHTTlJ9hg1DyuQgj
    kCZ9FDXeXJespHttNnZFQsOgPhDgvou6gn2Vbaqxo3/pxL1BcXbzTb1qKStM9kFr
    H342LxCt0ERmdXl1hBvH90UclyDk24dvg36Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523287691; bh=xexnANilyITp1BezSAKVBJe7ZcsbVg
    86ctbwfoBdMcg=; b=St97ENSraWikIFDUgi9t3pynFAxs0ytZ5iIXKBhfyYyOAx
    smGKDRy76PirsK7x1a0okhcd1L8ZJ/vDgRUJnG1yJjJE3ZZzJ26fFfPk/X1I80EW
    gkxf0lW+/aSQRRbVC1KOcz1GNo5iyZuOcMVayC365fB8Tsv+UZtyDacTYH2yjsQ6
    w7Sy9BCG60+XoEsDPicLcBC8wuAKLMFBnljd6f0hYN6REPNWIL9KI+33JEhkk8ft
    /kjloUK6qedEtskH9A6VSXy4gs6f3UfPm+aQL51Qe5iHznjWhIjhjsfOMobGUuFm
    IcZv9KUpvaJw9REiagcgpQvNTo+AjMF665ufJnYw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF49eXuopnUB7rltygWDgtf830UbRvhB/9mh/l15saXEJwzO2/2A9prG+TwwD3ZwRl2HkYi9cQ0enx7QcF07LlWf+azM+IQjzslj4hAQSkMH05RfGc5i
    53/GyTUdVnLkMD14FOc9uvPG3tgpCW5wSIxSZOJUrIiSFejA0pzbRG5wtHd660mlIkxmSJERMGeDSCP/nvqR0baL7BQMz5TOha5P8n6ETjT4WGe552Nnwu8r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=omOdbC7AAAAA:8 a=yMhMjlubAAAA:8 a=7OckoMRCZg84XcCdkoEA:9
    a=CjuIK1q_8ugA:10 a=baC4JDFNLZpnPwus_NF9:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753063AbeDIP2K (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 11:28:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43710 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752961AbeDIP2J (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 9 Apr 2018 11:28:09 -0400
Date: Mon, 9 Apr 2018 11:27:47 -0400
From: "J. Bruce Fields" <bfields@redhat.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.15 168/189] nfsd: return RESOURCE not
 GARBAGE_ARGS on too many ops
Message-ID: <20180409152746.GA25317@parsley.fieldses.org>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-168-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409001637.162453-168-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

What's your default on these patches on these AUTOSEL patches if you
don't get an ACK or NACK?  Do you apply them anyway?

(I'd skip this one as it doesn't meet the "It must fix a real bug that
bothers people" criterion.  But I don't recall it *causing* any bugs
either, so the stakes are low, I'm mainly just curious.)

--b.

On Mon, Apr 09, 2018 at 12:19:02AM +0000, Sasha Levin wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> [ Upstream commit 0078117c6d9160031b866cfa1853514d4f6865d2 ]
> 
> A client that sends more than a hundred ops in a single compound
> currently gets an rpc-level GARBAGE_ARGS error.
> 
> It would be more helpful to return NFS4ERR_RESOURCE, since that gives
> the client a better idea how to recover (for example by splitting up the
> compound into smaller compounds).
> 
> This is all a bit academic since we've never actually seen a reason for
> clients to send such long compounds, but we may as well fix it.
> 
> While we're there, just use NFSD4_MAX_OPS_PER_COMPOUND == 16, the
> constant we already use in the 4.1 case, instead of hard-coding 100.
> Chances anyone actually uses even 16 ops per compound are small enough
> that I think there's a neglible risk or any regression.
> 
> This fixes pynfs test COMP6.
> 
> Reported-by: "Lu, Xinyu" <luxy.fnst@cn.fujitsu.com>
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  fs/nfsd/nfs4proc.c | 3 +++
>  fs/nfsd/nfs4xdr.c  | 9 +++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index effeeb4f556f..a0bed2b2004d 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -1703,6 +1703,9 @@ nfsd4_proc_compound(struct svc_rqst *rqstp)
>  	status = nfserr_minor_vers_mismatch;
>  	if (nfsd_minorversion(args->minorversion, NFSD_TEST) <= 0)
>  		goto out;
> +	status = nfserr_resource;
> +	if (args->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
> +		goto out;
>  
>  	status = nfs41_check_op_ordering(args);
>  	if (status) {
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 2c61c6b8ae09..5dcd7cb45b2d 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -1918,8 +1918,13 @@ nfsd4_decode_compound(struct nfsd4_compoundargs *argp)
>  
>  	if (argp->taglen > NFSD4_MAX_TAGLEN)
>  		goto xdr_error;
> -	if (argp->opcnt > 100)
> -		goto xdr_error;
> +	/*
> +	 * NFS4ERR_RESOURCE is a more helpful error than GARBAGE_ARGS
> +	 * here, so we return success at the xdr level so that
> +	 * nfsd4_proc can handle this is an NFS-level error.
> +	 */
> +	if (argp->opcnt > NFSD_MAX_OPS_PER_COMPOUND)
> +		return 0;
>  
>  	if (argp->opcnt > ARRAY_SIZE(argp->iops)) {
>  		argp->ops = kzalloc(argp->opcnt * sizeof(*argp->ops), GFP_KERNEL);
> -- 
> 2.15.1
