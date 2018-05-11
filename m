Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3970764-1526044399-2-17335160911751684040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526044398; b=NLw5oaoygKuvJ/iX3bTY91s5K/TOehIrRWRO0nNiGYC0XR+H/a
    od1cvedMRe+G6iqSR4LjBiK73OBwG+slzfr0TPUq/nc9mYUijOGJ9jQNMdME9aCv
    5Y93RjxzgyYQJ4v8i5NTA6WmORsNqwEuwDaWzcN30Z4oOvKWhcD+mUs3p7jmrJTP
    XoZypGlPYffT31HmqiZgHIxU1YvMfBVl9Ukx8879zFvL/8U36CCGc3hfXAJJczWh
    w4U8w2JgZRkg7ZEAr8XCaQKMuse+zIQsHAzG69udo8PuYWBHT0Pp+L/Oiyznvexi
    XOlfwjIkfHoPXA6kFJqWFxmEeitM7MYWowtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526044398;
    bh=ugY62S+tew5ErDwPUKaj1YmApnvtNbntTWbh8wCIJO4=; b=OXlEYgISaSBU
    Tq0Zk6NsXJQUs+INQkLsDmQVHlKnvB/ofyHHPmbMyIsHuzcy9yB2tCtuZ69w6Gqm
    VUejh+gFKl5ygttU8NhC+2lrdasAG9xhMmvI/ieb8aZiS7tem3rV6wfckTEur/XU
    FJL0eieEC0s7FI8vSevbZXQ0PY2S8g2VOyZnSPovLtm2REmCEFSjwF0ThKU+t8uG
    nJikj+1cB/+nW0cFAQVaiF8CUKMMkhH4lmoOFoTBFU7B3OrdOyX2L+7Ssc5YL+kS
    ZnNjEqUW6/VJAW/KdT9vfcnfx4TN9IysqZd1jwgB0bNEvdGvHKPzfojRHORRrEKL
    NkmUCKYxRg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=EVgNA5n4 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oeEv06Ug;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=EVgNA5n4 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oeEv06Ug;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAXl0xNORaAS0kSpfu+nteYOjBn8cvDLsnDeFlFG/4HxW+RcFM0OXCwnuOuSP1nxz2laGvw+ZNwzo+jK6OG7TAi1tggJI26O1kApd+8X/5C36QElEjTL
    OylNoDW+qI7d7XajissjIHp8S7jpEfYlSyhO5J9nLtz2thZvKVV4BOgXdILP/f7oGf/bttyvkrXe3pqr0boV/oRqFXmcIxZAJrFbw+I1QJmyu6Xt/Rak2Civ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=XT5P2k9a7GMA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=EZAG_AzzEmgZLEA88f8A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752578AbeEKNNQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 09:13:16 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32981 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbeEKNNO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 11 May 2018 09:13:14 -0400
X-Google-Smtp-Source: AB8JxZq9BcESG0rDZMourbzoq5Ryw/y5fPoo7m/yUSJEZ0ZU0OrAk6CibZwWQ2dtOfkKvFR15SHsFg==
Subject: Re: [PATCH 14/32] net/tcp: convert to ->poll_mask
To: Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180511110803.10910-1-hch@lst.de>
 <20180511110803.10910-15-hch@lst.de>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <96284b0e-0d4e-a944-4fd5-933d12cf53cb@gmail.com>
Date: Fri, 11 May 2018 06:13:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180511110803.10910-15-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 05/11/2018 04:07 AM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/net/tcp.h   |  4 ++--
>  net/ipv4/af_inet.c  |  3 ++-
>  net/ipv4/tcp.c      | 31 ++++++++++++++-----------------
>  net/ipv6/af_inet6.c |  3 ++-
>  4 files changed, 20 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 9c9b3768b350..d4d72ea9128d 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -388,8 +388,8 @@ bool tcp_peer_is_proven(struct request_sock *req, struct dst_entry *dst);
>  void tcp_close(struct sock *sk, long timeout);
>  void tcp_init_sock(struct sock *sk);
>  void tcp_init_transfer(struct sock *sk, int bpf_op);
> -__poll_t tcp_poll(struct file *file, struct socket *sock,
> -		      struct poll_table_struct *wait);
> +struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events);
> +__poll_t tcp_poll_mask(struct socket *sock, __poll_t events);
>  int tcp_getsockopt(struct sock *sk, int level, int optname,
>  		   char __user *optval, int __user *optlen);
>  int tcp_setsockopt(struct sock *sk, int level, int optname,
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index eaed0367e669..220b51347526 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -986,7 +986,8 @@ const struct proto_ops inet_stream_ops = {
>  	.socketpair	   = sock_no_socketpair,
>  	.accept		   = inet_accept,
>  	.getname	   = inet_getname,
> -	.poll		   = tcp_poll,
> +	.get_poll_head	   = tcp_get_poll_head,
> +	.poll_mask	   = tcp_poll_mask,
>  	.ioctl		   = inet_ioctl,
>  	.listen		   = inet_listen,
>  	.shutdown	   = inet_shutdown,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 9ce1c726185e..6ec0e7a13581 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -493,33 +493,30 @@ static inline bool tcp_stream_is_readable(const struct tcp_sock *tp,
>  		sk->sk_prot->stream_memory_read(sk) : false);
>  }
>  
> +struct wait_queue_head *tcp_get_poll_head(struct socket *sock, __poll_t events)
> +{
> +	sock_poll_busy_loop(sock, events);
> +	sock_rps_record_flow(sock->sk);

Why are you adding sock_rps_record_flow() ?



> +	return sk_sleep(sock->sk);
> +}
> +EXPORT_SYMBOL(tcp_get_poll_head);
> +
>  /*
> - *	Wait for a TCP event.
> - *
> - *	Note that we don't need to lock the socket, as the upper poll layers
> - *	take care of normal races (between the test and the event) and we don't
> - *	go look at any of the socket buffers directly.
> + * Socket is not locked. We are protected from async events by poll logic and
> + * correct handling of state changes made by other threads is impossible in
> + * any case.
>   */
> -__poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
> +__poll_t tcp_poll_mask(struct socket *sock, __poll_t events)
>  {
> -	__poll_t mask;
>  	struct sock *sk = sock->sk;
>  	const struct tcp_sock *tp = tcp_sk(sk);
> +	__poll_t mask = 0;
>  	int state;
>  
> -	sock_poll_wait(file, sk_sleep(sk), wait);
> -
>  	state = inet_sk_state_load(sk);
>  	if (state == TCP_LISTEN)
>  		return inet_csk_listen_poll(sk);
>  
> -	/* Socket is not locked. We are protected from async events
> -	 * by poll logic and correct handling of state changes
> -	 * made by other threads is impossible in any case.
> -	 */
> -
> -	mask = 0;
> -
>  	/*
>  	 * EPOLLHUP is certainly not done right. But poll() doesn't
>  	 * have a notion of HUP in just one direction, and for a
> @@ -600,7 +597,7 @@ __poll_t tcp_poll(struct file *file, struct socket *sock, poll_table *wait)
>  
>  	return mask;
>  }
> -EXPORT_SYMBOL(tcp_poll);
> +EXPORT_SYMBOL(tcp_poll_mask);
>  
>  int tcp_ioctl(struct sock *sk, int cmd, unsigned long arg)
>  {
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index 8da0b513f188..a43d967eeca5 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -571,7 +571,8 @@ const struct proto_ops inet6_stream_ops = {
>  	.socketpair	   = sock_no_socketpair,	/* a do nothing	*/
>  	.accept		   = inet_accept,		/* ok		*/
>  	.getname	   = inet6_getname,
> -	.poll		   = tcp_poll,			/* ok		*/
> +	.get_poll_head	   = tcp_get_poll_head,
> +	.poll_mask	   = tcp_poll_mask,		/* ok		*/
>  	.ioctl		   = inet6_ioctl,		/* must change  */
>  	.listen		   = inet_listen,		/* ok		*/
>  	.shutdown	   = inet_shutdown,		/* ok		*/
> 
