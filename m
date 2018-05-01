Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2842537-1525166171-2-9937690135084242952
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_EXCESS_BASE64 0.979,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', to='utf-8', cc='utf-8', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525166170; b=SxQLVK1e9jRn1WpXDE0VqqLZkzf63R5uI9Di2NZvqEcWi5Ofde
    iRhmYwN7jy3z1wQJ7B4fF8nRij0jGNKc8TB2sncPPFpvymzDaEq55trYEsyrkDIm
    lWuj5nMSq7qZYkwq0IceX3MeS+ke4WTX/uJcCm4KFTLeJje8k4aFEMYmcIBKw3aT
    arNZ1mCJVBH0+xHg7C5TkAJUKaaoVBU+sNZB15zD0uTHc0X1SVQRalwGYsCPgwpq
    3bzKEii3NLywv16R+BKdZaZK0UsD9fR4zHqMd62qeIsHNAjIOv9N7tf39tnqxqWz
    xMG72nnAU7sKRcM6B0XV9LgcRq68F9VNbcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525166170; bh=AN9zcnUluVH
    VYp7O5jqMlyaZ1YtPzSKjnIJtaR1hmrw=; b=Tq/0UbigYtnp3qylOOiGIrYwjxe
    WtwvgfoUfDcC937OY6r0glqg/SipHpg600DA5JvO/at2wENy67SoNAy5qRfyztd1
    7nkFXfEoUU4macm8/uLEC+IDclmjLoNe8dw1VPnLacD+MXI1/BydUEo2w37DmEJ+
    0GniKnnGoEh31NhLPlqb8mWwSrzVNuvcjitkNKzNx32Ncx3ow6G6vA9pve8zi6YA
    EMSsmld40aHf+CKLQaBOB0QbdMTbWQgJ3azsMdNr2aH2oPb1sRYH+lNnPvMHne4T
    dyalgYI3HTtsNkWomZMFR0vDGNKe1tVh8/4ylF3Ai4doqobKgxMu+3YduXg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-35 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=citrix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-35 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMoQgGXfS5EFF64X1IxxOx3ontxZsi5bG7ADSRD19diLRpsr0t6wXvR5rvWvbOghovBErpu/FsKtG/OTQNtAR7Eo5IbHCLNVzyoa8hJQR+fBkJf03ERw
    Fhkih36vRtdN6r8EirqF/nHc1uH8sNVE61bmi5JA689Bwqe4qC9P07Mu2CKBO7CLa2ETG//6SE5QkOYFIuZzu5QFNwHJetwaDdSeCumQHUWtxwRLAOp22uf5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=KxUqhg8yU9m4zpCWrgEA:9 a=wPNLvfGTeEIA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755421AbeEAJP4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 05:15:56 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:27513 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754550AbeEAJPw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 05:15:52 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520899200";
   d="scan'208";a="72420768"
Date: Tue, 1 May 2018 10:15:26 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
CC: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        open list <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH 6/6] xen-blkfront: prepare request locally,
 only then put it on the shared ring
Message-ID: <20180501091526.6b6j6h6rh62646fx@MacBook-Pro-de-Roger.local>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
 <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 09:22:31AM +0100, Roger Pau Monné wrote:
> On Mon, Apr 30, 2018 at 11:01:50PM +0200, Marek Marczykowski-Górecki wrote:
> >  					    struct request *req,
> > -					    struct blkif_request **ring_req)
> > +					    struct blkif_request *ring_req)
> >  {
> >  	unsigned long id;
> >  
> > -	*ring_req = RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt);
> > -	rinfo->ring.req_prod_pvt++;
> > -
> >  	id = get_id_from_freelist(rinfo);
> >  	rinfo->shadow[id].request = req;
> >  	rinfo->shadow[id].status = REQ_WAITING;
> >  	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
> >  
> > -	(*ring_req)->u.rw.id = id;
> > +	ring_req->u.rw.id = id;
> >  
> >  	return id;
> >  }
> > @@ -545,23 +542,28 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
> >  static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
> >  {
> >  	struct blkfront_info *info = rinfo->dev_info;
> > -	struct blkif_request *ring_req;
> > +	struct blkif_request ring_req = { 0 };
> >  	unsigned long id;
> >  
> >  	/* Fill out a communications ring structure. */
> >  	id = blkif_ring_get_request(rinfo, req, &ring_req);
> 
> Maybe I'm missing something obvious here, but you are adding a struct
> allocated on the stack to the shadow ring copy, isn't this dangerous?

The above comment is wrong, you are storing a pointer to 'req' in the
shadow ring copy, which is fine and is not the ring request.

Roger.
