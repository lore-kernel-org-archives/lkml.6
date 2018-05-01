Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2838156-1525162962-2-17594883169041026524
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FROM_EXCESS_BASE64 0.979,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='utf-8', to='utf-8', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525162961; b=TuD1nC+fbUTgislQxpQ8jk7eZQ4gPayhp8BYoiVPMRW7AREyek
    Uqe/f6d8TZFTDUM9Od9CbG1/x+QQ12FZFU9er1bmo6bsD4FQVqBKhUEyk5Khw6YW
    Eamb42ZNI6VAyHwR3eZzF9a/B9Ee5nMhAhRJ8XGTfhApVwluLrebCTAROpIz8mSv
    yoyE02sjb0eEuqKRjw+FVXVIK5MZGKB55T4aBuyBAio0R8ocJVkeJyIdtC9S8kQs
    TkYMevpL446fJeoLabU5XKOOkYbDncB0Ihz6/GyaEg+3LqPZ8Zn1Z9HSHScu0bDx
    c+LSULbGmNvQm9JgXvy3LSrM8c8Zzv7UjCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525162961; bh=UCBbzDwMNEL
    CEEhaFXGAmwR7h8boAJuhP7pd8aeL2JE=; b=GmLUBQbsQshyCWtOkmzlh8cjfcD
    +4NkyizKAiRACL+P56YChIBkG5UzcxSE3eWFPayIFc73s7AQe4nK6CRtl4dwSTsg
    mNbc5hGmZc22jp89ypY89Gh5x42D/DKQlAn8yAtBLNwG1GspChCAI6P8FaXHiRGc
    1dUKCWSwhqJaRQVg0k8CiBFmCar9PeOBI2OfNd81SRee8rA5KlxojTkZ5rY7zrwV
    OnyPPY2kIR7UTb6mKisa8ur23pAVRBEggLoXCgWMduE90h/45hzw/dcVx0cTNF9r
    MwUB2b9+FWMF0K9Pz84Dl44FwkzgORH2NXaH9WD8aicxIgJIswAwb5wJ6qQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
    x-vs=clean score=-50 state=0
Authentication-Results: mx3.messagingengine.com;
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
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO1/ByeuXBZ0m19aIb8UYotEWDa+ouqLSedRzXq4VuKtxO0G5Mrg5dx+UF7/DBCujCjCeqVEj96tKcUYzT0fTtsWKwc74Lwa0bTLnfzUGn14SXpa0EGa
    99nfgh/x4Y2dOB0H6anZd6+wghuThSjDLvGnWhlJzXAlzOkbz1UBhjyTTOIeETiNmKo55ra3yTuPeFpm9c2fKal6Ba1/8UY9i9J4z0/QYkdYEpVCiLxwWCoB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=vkfgAjWNAAAA:8 a=CM0MTxwrMBVTQAxnb44A:9 a=wPNLvfGTeEIA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=s88AYcEWOXMFsoP9cgP2:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeEAIWk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 04:22:40 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:10593 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751081AbeEAIWi (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 May 2018 04:22:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,350,1520899200";
   d="scan'208";a="72418771"
Date: Tue, 1 May 2018 09:22:31 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?=
        <marmarek@invisiblethingslab.com>
CC: <xen-devel@lists.xenproject.org>, <stable@vger.kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/6] xen-blkfront: prepare request locally, only then put
 it on the shared ring
Message-ID: <20180501082231.dzdbcghtwvlbkoys@MacBook-Pro-de-Roger.local>
References: <cover.7ee732ab822b728ec486a3118ec12e9c06f0f325.1525122026.git-series.marmarek@invisiblethingslab.com>
 <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <951a221b0e655b3077d1f96ac365194320bc8809.1525122026.git-series.marmarek@invisiblethingslab.com>
User-Agent: NeoMutt/20180323
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 11:01:50PM +0200, Marek Marczykowski-Górecki wrote:
> Do not reuse data which theoretically might be already modified by the
> backend. This is mostly about private copy of the request
> (info->shadow[id].req) - make sure the request saved there is really the
> one just filled.
>
> This is complementary to XSA155.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
> ---
>  drivers/block/xen-blkfront.c | 76 +++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
> index 3926811..b100b55 100644
> --- a/drivers/block/xen-blkfront.c
> +++ b/drivers/block/xen-blkfront.c
> @@ -525,19 +525,16 @@ static int blkif_ioctl(struct block_device *bdev, fmode_t mode,
>  
>  static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,

The name of this function should be changed IMO, since you are no
longer getting a request from the ring, but just initializing a
request struct.

>  					    struct request *req,
> -					    struct blkif_request **ring_req)
> +					    struct blkif_request *ring_req)
>  {
>  	unsigned long id;
>  
> -	*ring_req = RING_GET_REQUEST(&rinfo->ring, rinfo->ring.req_prod_pvt);
> -	rinfo->ring.req_prod_pvt++;
> -
>  	id = get_id_from_freelist(rinfo);
>  	rinfo->shadow[id].request = req;
>  	rinfo->shadow[id].status = REQ_WAITING;
>  	rinfo->shadow[id].associated_id = NO_ASSOCIATED_ID;
>  
> -	(*ring_req)->u.rw.id = id;
> +	ring_req->u.rw.id = id;
>  
>  	return id;
>  }
> @@ -545,23 +542,28 @@ static unsigned long blkif_ring_get_request(struct blkfront_ring_info *rinfo,
>  static int blkif_queue_discard_req(struct request *req, struct blkfront_ring_info *rinfo)
>  {
>  	struct blkfront_info *info = rinfo->dev_info;
> -	struct blkif_request *ring_req;
> +	struct blkif_request ring_req = { 0 };
>  	unsigned long id;
>  
>  	/* Fill out a communications ring structure. */
>  	id = blkif_ring_get_request(rinfo, req, &ring_req);

Maybe I'm missing something obvious here, but you are adding a struct
allocated on the stack to the shadow ring copy, isn't this dangerous?

The pointer stored in the shadow ring copy is going to be invalid
after returning from this function.

The same comment applies to the other calls to blkif_ring_get_request
below that pass a ring_reg allocated on the stack.

Thanks, Roger.
