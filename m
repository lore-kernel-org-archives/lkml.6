Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1629513-1520902039-2-11871879287231900732
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520902036; b=LFfTpm6Yg72EOoiAsjSoL4cCEmCVMMEzrnv+WWxVq8UGFxV
    fNIg8zgD7UhXltV/iDiTJYf8IOV8l/4wODZ2sarNC0gjtblDIl4cc3GvUycg9hGR
    7Sz5L+aETvse2/fOsz14S+tRp+GboS1dfk6q6YHcLLe3MkztNpavMtKwV4uInjIa
    qG3RbDTmrbk15AlMBw+tEctBzvzuZ3aGSGHyOOrrbPc2ba9ZRZJjTwY1erkSXtR6
    3BfN7iHaXZghM+kIxJqyLZCqRQOCA9/A+PRF5QMkHaJgj2zGFrUF2q0YkyiHBeF9
    jeM1QO5Z3IIznMsTp53pTmaYldMBM5mDSUO2yYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520902036; bh=jaNI3eS4HID1NgabrUF485KjjY5fOox4dtC/7h9hpX0=; b=b
    W+w5/M0qAl7h7/TPsSiQvVJPVVcq+RkJb6qkSJda7hEblMSOnGl43hZ8zPFcaPEY
    LGlShfiTzGZemsS4rbwfEbGC/YtvPGKHdtB7d8ezpF3NFeyO4LO7vR5+vsyTr3pl
    KRMm822RFX6B0YFfYAO6t19OZuqBWvCRBS7WCx4LLOnDVxX/M2TLiSCj+6tyP66u
    b4nwlwCxM4O/HkuSxqTE6eMZL/FyWHwc0Pzqw94xVjg5ZLrIH5PqTbgYtqiSSOlx
    9anDO8viWyxOKYHc//O0+dbVzH9Nk8ZHl9f8aKynRDcZD4x0cwlOE7rcTQwUh3Lo
    iIQUPjrjouso86rWz6xZw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751397AbeCMArO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 20:47:14 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:56923 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeCMArN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 20:47:13 -0400
Message-ID: <1520902018.23626.90.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 31/36] sctp: verify size of a new chunk in
 _sctp_make_chunk()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Alexey Kodanev <alexey.kodanev@oracle.com>,
        Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Date: Tue, 13 Mar 2018 00:46:58 +0000
In-Reply-To: <20180310001809.079131255@linuxfoundation.org>
References: <20180310001807.213987241@linuxfoundation.org>
         <20180310001809.079131255@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Alexey Kodanev <alexey.kodanev@oracle.com>
> 
> 
> [ Upstream commit 07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c ]
> 
> When SCTP makes INIT or INIT_ACK packet the total chunk length
> can exceed SCTP_MAX_CHUNK_LEN which leads to kernel panic when
> transmitting these packets, e.g. the crash on sending INIT_ACK:
> 
> [  597.804948] skbuff: skb_over_panic: text:00000000ffae06e4 len:120168
>                put:120156 head:000000007aa47635 data:00000000d991c2de
>                tail:0x1d640 end:0xfec0 dev:<NULL>
> ...
> [  597.976970] ------------[ cut here ]------------
> [  598.033408] kernel BUG at net/core/skbuff.c:104!
> [  600.314841] Call Trace:
> [  600.345829]  <IRQ>
> [  600.371639]  ? sctp_packet_transmit+0x2095/0x26d0 [sctp]
> [  600.436934]  skb_put+0x16c/0x200
> [  600.477295]  sctp_packet_transmit+0x2095/0x26d0 [sctp]
> [  600.540630]  ? sctp_packet_config+0x890/0x890 [sctp]
> [  600.601781]  ? __sctp_packet_append_chunk+0x3b4/0xd00 [sctp]
> [  600.671356]  ? sctp_cmp_addr_exact+0x3f/0x90 [sctp]
> [  600.731482]  sctp_outq_flush+0x663/0x30d0 [sctp]
> [  600.788565]  ? sctp_make_init+0xbf0/0xbf0 [sctp]
> [  600.845555]  ? sctp_check_transmitted+0x18f0/0x18f0 [sctp]
> [  600.912945]  ? sctp_outq_tail+0x631/0x9d0 [sctp]
> [  600.969936]  sctp_cmd_interpreter.isra.22+0x3be1/0x5cb0 [sctp]
> [  601.041593]  ? sctp_sf_do_5_1B_init+0x85f/0xc30 [sctp]
> [  601.104837]  ? sctp_generate_t1_cookie_event+0x20/0x20 [sctp]
> [  601.175436]  ? sctp_eat_data+0x1710/0x1710 [sctp]
> [  601.233575]  sctp_do_sm+0x182/0x560 [sctp]
> [  601.284328]  ? sctp_has_association+0x70/0x70 [sctp]
> [  601.345586]  ? sctp_rcv+0xef4/0x32f0 [sctp]
> [  601.397478]  ? sctp6_rcv+0xa/0x20 [sctp]
> ...
> 
> Here the chunk size for INIT_ACK packet becomes too big, mostly
> because of the state cookie (INIT packet has large size with
> many address parameters), plus additional server parameters.
> 
> Later this chunk causes the panic in skb_put_data():
> 
>   skb_packet_transmit()
>       sctp_packet_pack()
>           skb_put_data(nskb, chunk->skb->data, chunk->skb->len);
> 
> 'nskb' (head skb) was previously allocated with packet->size
> from u16 'chunk->chunk_hdr->length'.
> 
> As suggested by Marcelo we should check the chunk's length in
> _sctp_make_chunk() before trying to allocate skb for it and
> discard a chunk if its size bigger than SCTP_MAX_CHUNK_LEN.
> 
> > Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> > Acked-by: Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>
> > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/sctp/sm_make_chunk.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1367,10 +1367,14 @@ static struct sctp_chunk *_sctp_make_chu
>  	sctp_chunkhdr_t *chunk_hdr;
>  	struct sk_buff *skb;
>  	struct sock *sk;
> +	int chunklen;
> +
> +	chunklen = sizeof(*chunk_hdr) + paylen;

I think this length still needs to be rounded up (with WORD_ROUND here,
instead of SCTP_PAD4 upstream).

Ben.

> +	if (chunklen > SCTP_MAX_CHUNK_LEN)
> +		goto nodata;
>  
>  	/* No need to allocate LL here, as this is only a chunk. */
> -	skb = alloc_skb(WORD_ROUND(sizeof(sctp_chunkhdr_t) + paylen),
> -			GFP_ATOMIC);
> +	skb = alloc_skb(chunklen, GFP_ATOMIC);
>  	if (!skb)
>  		goto nodata;
>  
> 
> 
> 
-- 
Ben Hutchings
Software Developer, Codethink Ltd.
