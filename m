Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3659933-1518384956-2-11276323179193756104
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518384955; b=kO/wVW38IuxWYPzmn+yT9SWabHrHehUvpBDHETGzCcxAxAY
    8hWi5mYLXG2hgnkOwiLTCQ2U5l/p3MDYEJsDJhz8KeAfl9gIUyj42KeiYZsgD11y
    twDUsm2wKMJvmQLzjgd5ZSSO2JLy6MlKnXIEZ64fMRtDmTJWlII7ZDfkHP9ZrqMH
    obb3zJFoGRl5wvKo0YNo5HhC37NBDCKkhNLLXC8tCSha65eadhokcwx+/Mm3wSoH
    TjPRluXI1dxAULSoq3qYdGhVqluNTKctuJeJZJM27QYuVuvVJhO8zBxLKcGOez/L
    H2KOTRb34MhyyGyJHrx6yeG8mPKch6hWZSYq6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518384955; bh=Jw3OaVz6c+92pz4rFnBlNCHMeVhgxn0RxwP
    dnA+m/ig=; b=o7zComK74dmUeRHUadg8aqKLAzf0zrGZKLiVD4WoKVgtgdBKe0Q
    sV/OL5h35OkKgvf/ibSx2vxuxB78sYmdvbcTGlQx5ZwE/9SeA5/Kg0QXGF/rpl/Y
    kh8ERGl3q/FnBASi5zimZ/h98u3sYG60sOMBuW12dOKk8DHJVPxEEwUzwqAdN6iY
    G6bKXPHR8fKRnq2dxUIv9yBL+9Q4zzan+Z05JcWwtlTp0cT0DQxCpCjB0K6RTS4m
    WcZ7d1eIxRQ1NlHL33s0QP3eCQm+0P1z+cZzqYypDmtULxpw3NlEhvxXmqqsVZuu
    IyDkRk6xRNV3VKyts9cvzkfAPdM68Wf3fMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B5dDvf1Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=B5dDvf1Y x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=infradead.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753843AbeBKVfy (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 16:35:54 -0500
Received: from casper.infradead.org ([85.118.1.10]:33756 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753689AbeBKVfx (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 16:35:53 -0500
Date: Sun, 11 Feb 2018 21:35:48 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Ben Hutchings <ben@decadent.org.uk>
cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org,
        Andreas Dilger <andreas.dilger@intel.com>,
        Oleg Drokin <oleg.drokin@intel.com>,
        Peng Tao <bergwolf@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: [PATCH 3.16 002/136] staging: lustre: ptlrpc: kfree used instead
 of kvfree
In-Reply-To: <lsq.1518323471.173295807@decadent.org.uk>
Message-ID: <alpine.LFD.2.21.1802112134500.21780@casper.infradead.org>
References: <lsq.1518323471.173295807@decadent.org.uk>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180211_213548_828769_EF1CB1DC 
X-CRM114-Status: GOOD (  11.81  )
X-Remote-Spam-Score: -1.9 (-)
X-Remote-Spam-Report: SpamAssassin version 3.4.1 on casper.infradead.org summary:
 Content analysis details:   (-1.9 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
 -1.9 BAYES_00               BODY: Bayes spam probability is 0 to 1%
                             [score: 0.0000]
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> 3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

Reviewed-by: James Simmons <jsimmons@infradead.org>
 
> ------------------
> 
> From: Nadav Amit <namit@vmware.com>
> 
> commit c3eec59659cf25916647d2178c541302bb4822ad upstream.
> 
> rq_reqbuf is allocated using kvmalloc() but released in one occasion
> using kfree() instead of kvfree().
> 
> The issue was found using grep based on a similar bug.
> 
> Fixes: d7e09d0397e8 ("add Lustre file system client support")
> Fixes: ee0ec1946ec2 ("lustre: ptlrpc: Replace uses of OBD_{ALLOC,FREE}_LARGE")
> 
> Cc: Peng Tao <bergwolf@gmail.com>
> Cc: Oleg Drokin <oleg.drokin@intel.com>
> Cc: James Simmons <jsimmons@infradead.org>
> 
> Signed-off-by: Nadav Amit <namit@vmware.com>
> Signed-off-by: Andreas Dilger <andreas.dilger@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> [bwh: Backported to 3.16: use OBD_FREE_LARGE()]
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
>  drivers/staging/lustre/lustre/ptlrpc/sec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/drivers/staging/lustre/lustre/ptlrpc/sec.c
> +++ b/drivers/staging/lustre/lustre/ptlrpc/sec.c
> @@ -867,7 +867,7 @@ void sptlrpc_request_out_callback(struct
>  	if (req->rq_pool || !req->rq_reqbuf)
>  		return;
>  
> -	OBD_FREE(req->rq_reqbuf, req->rq_reqbuf_len);
> +	OBD_FREE_LARGE(req->rq_reqbuf, req->rq_reqbuf_len);
>  	req->rq_reqbuf = NULL;
>  	req->rq_reqbuf_len = 0;
>  }
> 
> 
