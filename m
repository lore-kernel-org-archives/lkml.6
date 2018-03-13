Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2832218-1520934963-2-9646706423130072728
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES ensk.us-asciisv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520934962; b=eV4mc8YnBzuR3DbPdacJP3IipvdCYe9eguLonvSSsX2Jq/N
    0VTsDJlG/kZmp+Sf+xt/eSN/roKwv1tML3MmJkAAhsuuBS/wBYlNUdxPLZbMUqQN
    wNX1VodeMmMK/jfJ29gZKk4jeY+YlXNbjpfwjs9yd9+Bv2QcmAY0BGk3CMYH3u0C
    EZt0mJ/yVB+RubYNsoaVQWnEPtEMBVcXr16t6pQq5W2qtUlDlii+X8x72UHiPO8y
    3y1HZtCdzOzAFTTq3y1ViunViWDqL7j9CBpIUjHS+QVIEf64GlJZXJYol23+ah1i
    v1uCXSf5kQkps4EC8GxmABW/Km7FlAGp70Oezdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1520934962; bh=owBfjJP
    9l9m5t3CUyMorogghJoRN85z1c6D1XVMVoiQ=; b=sCw+FLWBcz+p3fdnH9vxRWR
    Lksst9Lvc7TxHFSVUV24u4be82l0M1U3jxyDacvVklPCiU3LCy7pP3WEjaXJDyLu
    SZrnMgqOT6bgBfsZcXhUpI/tNdK9raF1aY6HdNAP0ykT8RTFLv8JFNOEKWKO4kNA
    3VpL5rB7Y5SKiQct0/mjDgQ3ntgDG/QLcyYfUI6Ig56JkJamqBFDtjDq9YzyuSDf
    ++VGINjDG4iuz8kpZCynOfEg/hh2NMO9tuKFx9loMGECWzTfT7bNaQlKxMjPjJSM
    kD2x1GcIHDcIYutSf9ndnyWk2cLZjE5evCIWCXnyT85w1h201Hrh3wUby9ZMlmw=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752283AbeCMJ4B (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 05:56:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46912 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeCMJ4A (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 05:56:00 -0400
Date: Tue, 13 Mar 2018 10:56:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.4 31/36] sctp: verify size of a new chunk in
 _sctp_make_chunk()
Message-ID: <20180313095600.GA5131@kroah.com>
References: <20180310001807.213987241@linuxfoundation.org>
 <20180310001809.079131255@linuxfoundation.org>
 <1520902018.23626.90.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1520902018.23626.90.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 12:46:58AM +0000, Ben Hutchings wrote:
> On Fri, 2018-03-09 at 16:18 -0800, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Alexey Kodanev <alexey.kodanev@oracle.com>
> > 
> > 
> > [ Upstream commit 07f2c7ab6f8d0a7e7c5764c4e6cc9c52951b9d9c ]
> > 
> > When SCTP makes INIT or INIT_ACK packet the total chunk length
> > can exceed SCTP_MAX_CHUNK_LEN which leads to kernel panic when
> > transmitting these packets, e.g. the crash on sending INIT_ACK:
> > 
> > [  597.804948] skbuff: skb_over_panic: text:00000000ffae06e4 len:120168
> >                put:120156 head:000000007aa47635 data:00000000d991c2de
> >                tail:0x1d640 end:0xfec0 dev:<NULL>
> > ...
> > [  597.976970] ------------[ cut here ]------------
> > [  598.033408] kernel BUG at net/core/skbuff.c:104!
> > [  600.314841] Call Trace:
> > [  600.345829]  <IRQ>
> > [  600.371639]  ? sctp_packet_transmit+0x2095/0x26d0 [sctp]
> > [  600.436934]  skb_put+0x16c/0x200
> > [  600.477295]  sctp_packet_transmit+0x2095/0x26d0 [sctp]
> > [  600.540630]  ? sctp_packet_config+0x890/0x890 [sctp]
> > [  600.601781]  ? __sctp_packet_append_chunk+0x3b4/0xd00 [sctp]
> > [  600.671356]  ? sctp_cmp_addr_exact+0x3f/0x90 [sctp]
> > [  600.731482]  sctp_outq_flush+0x663/0x30d0 [sctp]
> > [  600.788565]  ? sctp_make_init+0xbf0/0xbf0 [sctp]
> > [  600.845555]  ? sctp_check_transmitted+0x18f0/0x18f0 [sctp]
> > [  600.912945]  ? sctp_outq_tail+0x631/0x9d0 [sctp]
> > [  600.969936]  sctp_cmd_interpreter.isra.22+0x3be1/0x5cb0 [sctp]
> > [  601.041593]  ? sctp_sf_do_5_1B_init+0x85f/0xc30 [sctp]
> > [  601.104837]  ? sctp_generate_t1_cookie_event+0x20/0x20 [sctp]
> > [  601.175436]  ? sctp_eat_data+0x1710/0x1710 [sctp]
> > [  601.233575]  sctp_do_sm+0x182/0x560 [sctp]
> > [  601.284328]  ? sctp_has_association+0x70/0x70 [sctp]
> > [  601.345586]  ? sctp_rcv+0xef4/0x32f0 [sctp]
> > [  601.397478]  ? sctp6_rcv+0xa/0x20 [sctp]
> > ...
> > 
> > Here the chunk size for INIT_ACK packet becomes too big, mostly
> > because of the state cookie (INIT packet has large size with
> > many address parameters), plus additional server parameters.
> > 
> > Later this chunk causes the panic in skb_put_data():
> > 
> >   skb_packet_transmit()
> >       sctp_packet_pack()
> >           skb_put_data(nskb, chunk->skb->data, chunk->skb->len);
> > 
> > 'nskb' (head skb) was previously allocated with packet->size
> > from u16 'chunk->chunk_hdr->length'.
> > 
> > As suggested by Marcelo we should check the chunk's length in
> > _sctp_make_chunk() before trying to allocate skb for it and
> > discard a chunk if its size bigger than SCTP_MAX_CHUNK_LEN.
> > 
> > > Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> > > Acked-by: Marcelo Ricardo Leitner <marcelo.leinter@gmail.com>
> > > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> > > Signed-off-by: David S. Miller <davem@davemloft.net>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  net/sctp/sm_make_chunk.c |    8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> > 
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -1367,10 +1367,14 @@ static struct sctp_chunk *_sctp_make_chu
> >  	sctp_chunkhdr_t *chunk_hdr;
> >  	struct sk_buff *skb;
> >  	struct sock *sk;
> > +	int chunklen;
> > +
> > +	chunklen = sizeof(*chunk_hdr) + paylen;
> 
> I think this length still needs to be rounded up (with WORD_ROUND here,
> instead of SCTP_PAD4 upstream).

Ah, good point, how's this patch:


diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 4ca31e052dd8..509e9426a056 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -1369,7 +1369,7 @@ static struct sctp_chunk *_sctp_make_chunk(const struct sctp_association *asoc,
 	struct sock *sk;
 	int chunklen;
 
-	chunklen = sizeof(*chunk_hdr) + paylen;
+	chunklen = WORD_ROUND(sizeof(*chunk_hdr) + paylen);
 	if (chunklen > SCTP_MAX_CHUNK_LEN)
 		goto nodata;
 
