Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D69FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4DA20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3yQWT5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4DA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbeGPSKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:10:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42562 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727811AbeGPSKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:10:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id l9-v6so15001738pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 10:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ka6tAyjB4U0AXj6g1IdDWDcNjCgK1ubkeXIXwmrs3UI=;
        b=h3yQWT5KqsKIVSb432htQWOV7DByZxDyIWcy6QROzV7iKfhsSn2v0QJ61lj0So7fTP
         PfTf9Uol91xqBcmRATYps2XCkIYj+MLpv+wI4/Z/D6T4kc4kTFL/1sMQke0aSitfQsrI
         SU0vROERVwex7Vfu17PdAUfwZn7OxudasXdFWspojX12TtErTyhny+FBoKr8MS2ZFS6Z
         cJK1Dc26dZ/SyI4ddvQ2leGyMwrzoNIU3mAWl0hu6sRbUqMob7TU3XOZegYi3CFXPegu
         4It1WPDv+XRyBvEe1c7bfQBJCImrny7HsLCdD2c4RzSNMWez25HoN1Q02G/K8zQNg3xJ
         kLYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ka6tAyjB4U0AXj6g1IdDWDcNjCgK1ubkeXIXwmrs3UI=;
        b=lQHBY03xULI8Ae1/UhlTJtnUd9dJk1wgdvT20yGA1FOltN8bths+iktavIvLi2C4+H
         Re7AN6CX4kH2G4wM6u5aowbY2ARSJPxCQwRbsLe2yiXEyyz5stb0jjAhIL5sFu1pZv8x
         cY2PE8U3Xc6slhptKMj+FpgGZvXAtpTQXHesUZrPSNAwBlOOv+ejJ3A5f+0vogwGDtpY
         xlAAQmR8IA/G/eN705+OXpcbm/SyH2ZVQ0Xpq5SI6qBY2WbP/smBIbahPWPbyXvs8o/Y
         RnQtNn3zfdI+fxQoEk+s74RrYdCK0HkJdrOgReYFrFdIVHUSc+bNHN55oXKqWl4maFDw
         hcgQ==
X-Gm-Message-State: AOUpUlGE65WWlsMHlj0EKYzEH1SqErAAnsR7roGApsouqLaQxuYUZ2mv
        CVK0/+XqpXBEH6VjM/0XNdVpOQ==
X-Google-Smtp-Source: AAOMgpePHQ5eB8bfXeEWTVqOtl6wtGQNQ/2UQW3n1hPYUCO8MckQDO/7rosyYYy9GcRiRrsfr32Bog==
X-Received: by 2002:a62:3a9d:: with SMTP id v29-v6mr18934480pfj.215.1531762945836;
        Mon, 16 Jul 2018 10:42:25 -0700 (PDT)
Received: from google.com ([2620:15c:17:3:dc28:5c82:b905:e8a8])
        by smtp.gmail.com with ESMTPSA id q21-v6sm24281985pfl.156.2018.07.16.10.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 10:42:25 -0700 (PDT)
Date:   Mon, 16 Jul 2018 10:42:23 -0700
From:   Eric Biggers <ebiggers@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
Message-ID: <20180716174223.GE77258@google.com>
References: <20180716034947.GA32022@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716034947.GA32022@beast>
User-Agent: Mutt/1.10+35 (c786a508) (2018-06-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 08:49:47PM -0700, Kees Cook wrote:
> The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
> (when less than 2048) once the VLA is no longer hidden from the check:
> 
> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
> functions for reuse. Two requests allocated on the stack are not needed
> when only one is used at a time.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  net/rxrpc/rxkad.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
> index 278ac0807a60..6393391fac86 100644
> --- a/net/rxrpc/rxkad.c
> +++ b/net/rxrpc/rxkad.c
> @@ -146,10 +146,10 @@ static int rxkad_prime_packet_security(struct rxrpc_connection *conn)
>  static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
>  				    struct sk_buff *skb,
>  				    u32 data_size,
> -				    void *sechdr)
> +				    void *sechdr,
> +				    struct skcipher_request *req)
>  {
>  	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> -	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>  	struct rxkad_level1_hdr hdr;
>  	struct rxrpc_crypt iv;
>  	struct scatterlist sg;
> @@ -183,12 +183,12 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
>  static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
>  				       struct sk_buff *skb,
>  				       u32 data_size,
> -				       void *sechdr)
> +				       void *sechdr,
> +				       struct skcipher_request *req)
>  {
>  	const struct rxrpc_key_token *token;
>  	struct rxkad_level2_hdr rxkhdr;
>  	struct rxrpc_skb_priv *sp;
> -	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>  	struct rxrpc_crypt iv;
>  	struct scatterlist sg[16];
>  	struct sk_buff *trailer;
> @@ -296,11 +296,12 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
>  		ret = 0;
>  		break;
>  	case RXRPC_SECURITY_AUTH:
> -		ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr);
> +		ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr,
> +					       req);
>  		break;
>  	case RXRPC_SECURITY_ENCRYPT:
>  		ret = rxkad_secure_packet_encrypt(call, skb, data_size,
> -						  sechdr);
> +						  sechdr, req);
>  		break;
>  	default:
>  		ret = -EPERM;
> @@ -316,10 +317,10 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
>   */
>  static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
>  				 unsigned int offset, unsigned int len,
> -				 rxrpc_seq_t seq)
> +				 rxrpc_seq_t seq,
> +				 struct skcipher_request *req)
>  {
>  	struct rxkad_level1_hdr sechdr;
> -	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>  	struct rxrpc_crypt iv;
>  	struct scatterlist sg[16];
>  	struct sk_buff *trailer;
> @@ -402,11 +403,11 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
>   */
>  static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
>  				 unsigned int offset, unsigned int len,
> -				 rxrpc_seq_t seq)
> +				 rxrpc_seq_t seq,
> +				 struct skcipher_request *req)
>  {
>  	const struct rxrpc_key_token *token;
>  	struct rxkad_level2_hdr sechdr;
> -	SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>  	struct rxrpc_crypt iv;
>  	struct scatterlist _sg[4], *sg;
>  	struct sk_buff *trailer;
> @@ -549,9 +550,9 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb,
>  	case RXRPC_SECURITY_PLAIN:
>  		return 0;
>  	case RXRPC_SECURITY_AUTH:
> -		return rxkad_verify_packet_1(call, skb, offset, len, seq);
> +		return rxkad_verify_packet_1(call, skb, offset, len, seq, req);
>  	case RXRPC_SECURITY_ENCRYPT:
> -		return rxkad_verify_packet_2(call, skb, offset, len, seq);
> +		return rxkad_verify_packet_2(call, skb, offset, len, seq, req);
>  	default:
>  		return -ENOANO;
>  	}
> -- 
> 2.17.1

How about doing the 'skcipher_request_set_tfm(req, call->conn->cipher)' and
'skcipher_request_zero(req);' just once, in the top-level function
rxkad_verify_packet(), instead of before/after every time the request is used?

- Eric
