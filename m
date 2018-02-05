Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2346552-1517831065-2-12939455385905198754
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='COM', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517831065; b=Ogm5X/PrAdBaufnccrDM7pk93oYA6I4C9Lu0bWVdhYtM9w2
    +/E4iV5xofNISW3GSYmvZZnPi+OhsbtEiqMTwfBiRHXzOWhXS9wu5F9nhHTAT+nl
    V3HCcxsHygocagqQzaczmugRsiCzuckqGb5SnN5mB2hOP9AOmGKZgO3F+zXPBwvo
    tDcQv8a++amjTxsfTWGmmrGDrtx+jMvnpjM2MirrLnZ75tkSOgKAdxDLYFpe/L+x
    DzS9AJhjfIDBw5GGOl2S+Qnc30Kyn6pSiOPqosWXGbsdHkR6DpI/THBaP8rTXMoR
    JXDpMS6poq1KGQLo2ZtpPqS8wZpb4MM+0P/QfbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517831065; bh=dyxlxo
    HENizakyuj1P/WGvjNmmbGOasUOGKnOZhmQFc=; b=fOGf8f7I+Ycl8ot15001lj
    ZMMmNrbqO8j/R6eshZpSTKYoIztgwbvkzClb5Cw8O0dgdnp+/MFmALEI866Uia6y
    aS339Ifc9Pd6Ke2FsQQBHuI6pJgj3ehkEFFRCWNQRSLm9Ris18z49wbQrdCAZ1O6
    hnL9onIdsNBqzkX869enbe8Jm7GZEALmANpuU32cyq4Uf+csFcRmOhw+WlBUvQjm
    jM2k1ri5fOHEXZPMTA//V2DqHefwBhQb8/AGKti4hOcxWdb4DAWzqqAHimos0wgh
    ekWB8m/JrCtMJjA66PPbxSadotHx33lwlzqPuwfCD9ocANBpuV5xD6YJCuyVQm7g
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aculab.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=aculab.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752738AbeBELoV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 5 Feb 2018 06:44:21 -0500
Received: from smtp-out6.electric.net ([192.162.217.192]:63413 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeBELoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Feb 2018 06:44:21 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sasha Levin' <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Xin Long <lucien.xin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: RE: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a __u16
 variable may overflow in sctp_ulpq_renege
Thread-Topic: [PATCH AUTOSEL for 4.14 019/110] sctp: fix the issue that a
 __u16 variable may overflow in sctp_ulpq_renege
Thread-Index: AQHTnRjkYeYOzvAZ1EalFmrzR8HiFaOVsB5g
Date: Mon, 5 Feb 2018 11:35:56 +0000
Message-ID: <4eedae3f4cb14e178c073c183ef134c6@AcuMS.aculab.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-19-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-19-alexander.levin@microsoft.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS: TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sasha Levin
> Sent: 03 February 2018 18:01
> [ Upstream commit 5c468674d17056148da06218d4da5d04baf22eac ]
> 
> Now when reneging events in sctp_ulpq_renege(), the variable freed
> could be increased by a __u16 value twice while freed is of __u16
> type. It means freed may overflow at the second addition.
> 
> This patch is to fix it by using __u32 type for 'freed', while at
> it, also to remove 'if (chunk)' check, as all renege commands are
> generated in sctp_eat_data and it can't be NULL.
> 
> Reported-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  net/sctp/ulpqueue.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/net/sctp/ulpqueue.c b/net/sctp/ulpqueue.c
> index a71be33f3afe..e36ec5dd64c6 100644
> --- a/net/sctp/ulpqueue.c
> +++ b/net/sctp/ulpqueue.c
> @@ -1084,29 +1084,21 @@ void sctp_ulpq_partial_delivery(struct sctp_ulpq *ulpq,
>  void sctp_ulpq_renege(struct sctp_ulpq *ulpq, struct sctp_chunk *chunk,
>  		      gfp_t gfp)
>  {
> -	struct sctp_association *asoc;
> -	__u16 needed, freed;
> -
> -	asoc = ulpq->asoc;
> +	struct sctp_association *asoc = ulpq->asoc;
> +	__u32 freed = 0;
> +	__u16 needed;
> 
> -	if (chunk) {
> -		needed = ntohs(chunk->chunk_hdr->length);
> -		needed -= sizeof(struct sctp_data_chunk);
> -	} else
> -		needed = SCTP_DEFAULT_MAXWINDOW;
> -
> -	freed = 0;
> +	needed = ntohs(chunk->chunk_hdr->length) -
> +		 sizeof(struct sctp_data_chunk);
> 
>  	if (skb_queue_empty(&asoc->base.sk->sk_receive_queue)) {
>  		freed = sctp_ulpq_renege_order(ulpq, needed);
> -		if (freed < needed) {
> +		if (freed < needed)
>  			freed += sctp_ulpq_renege_frags(ulpq, needed - freed);
> -		}
>  	}
>  	/* If able to free enough room, accept this chunk. */
> -	if (chunk && (freed >= needed)) {
> -		int retval;
> -		retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
> +	if (freed >= needed) {
> +		int retval = sctp_ulpq_tail_data(ulpq, chunk, gfp);
>  		/*
>  		 * Enter partial delivery if chunk has not been
>  		 * delivered; otherwise, drain the reassembly queue.

Hmmm...
ISTM that all the maths should be done using 'unsigned int' to avoid horrid
masking operations on many cpus....

	David
