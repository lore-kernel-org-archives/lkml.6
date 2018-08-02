Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82786C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CD0F215E5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 23:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vCeEqKAG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tv7PNzLg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CD0F215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbeHCBjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 21:39:37 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:39866 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729790AbeHCBjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 21:39:35 -0400
Received: by mail-yb0-f194.google.com with SMTP id c4-v6so2004158ybl.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 16:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n6/zE08BHSH2F5NLsF99NGvX3CxnUK6CD0IGjh2uNAA=;
        b=vCeEqKAGOHtgtKnzieFpIn6pvKdAupaXggj7R/8sMbvAegsdbHBscPn1l8q7PrTw1g
         TqoqPAzrK+T3B2zXC26tsAmgppUUSRJ3aU91WiqvysAHQYOUP66n1q3PmZWRVHBXsKoU
         vJKSQtrMBdRRmpOtbbjzpTogoxBKXx/Im/LQTgpJETOyddEswHIMHdUILGVYuxaF8+nF
         cUaPGBHDBlotCG+Sa5QTrqafRVNfZ6Gsd5iJyfpG5DWd2cp6+tN+mLfG0BnuAMpZilx8
         5Ty9bGM8L0iKFazfwgBeZx7ujrk/MIZVCvdIWwbLmFO8GR2FrRz64so97tut4KL+nmKu
         vydg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=n6/zE08BHSH2F5NLsF99NGvX3CxnUK6CD0IGjh2uNAA=;
        b=Tv7PNzLg+vkkuX3QpeNFjEg0V+NaOzb1tYCjZ6vlGfkwiAdtiYN9WK1XIX7pbroIj1
         yxNOLE3TGWRzV32LyaN2FuZnM6z63fdUPPzjtPJmoOb+GJ7anKrM9lpuEDTA8eJ36DQp
         /FZk2eLn+ywTdRJE8sHIvxgLTt+y+cO2c3lCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=n6/zE08BHSH2F5NLsF99NGvX3CxnUK6CD0IGjh2uNAA=;
        b=k/oWwuX0rfRzojdQFyK0UuF4W0bpuhsrw7Ny2oS72KrIpOPpN8OWkn8SL/AZrbr/t5
         evZ3LqYLIUTV/uUB4x8UZgv0MmlwI6e8fis9cJ/PCN+0fhzk+gVJhZ0VpyGvQBqS5UP+
         E3CCbzR+sUilRrkE1rvCJJEuJPEr9y3TtXqOUKLKtCOnRvaxmLAjIXIIe7t5n2z1Ve+j
         YMjTTY5wB2157wUN5/1dMmEW4LTwQCrUQZTZeeGj0ew+3HmeesHsAJKG9PSgTyjNz3cN
         yPS6scBXHy8TbeNN+J88651Nw61CE0gLnhY1rLe685jHMKRmGRf1oqIKpgfviR/hs7gT
         /94A==
X-Gm-Message-State: AOUpUlEd4Uuv0k0ezwFW5yDEtRM3ZruMxlgg57sb66NYI774kqcaCzV+
        uwUAsqHu6GavSZpLcetfYxOQvBCbGozrgj2tmE3tEA==
X-Google-Smtp-Source: AAOMgpfEN2YIeo7EXbicjIBiIMVlGJxjF1JOigBIgyT26x3KaLsyk8NLzu6m8hr+XjhL8aFKchQ+GQZHSaDC/5eyQT4=
X-Received: by 2002:a5b:b44:: with SMTP id b4-v6mr914750ybr.463.1533253566262;
 Thu, 02 Aug 2018 16:46:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 16:46:05 -0700 (PDT)
In-Reply-To: <20180724164936.37477-17-keescook@chromium.org>
References: <20180724164936.37477-1-keescook@chromium.org> <20180724164936.37477-17-keescook@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 2 Aug 2018 16:46:05 -0700
X-Google-Sender-Auth: C8mFat2rDNx2X2y4vc5YC2RnLrs
Message-ID: <CAGXu5jLVNnUXkyzGdee3zvLHw5zMaDhEGm4c4YLqU=L8q9TshA@mail.gmail.com>
Subject: Re: [PATCH v6 16/18] rxrpc: Reuse SKCIPHER_REQUEST_ON_STACK buffer
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-crypto <linux-crypto@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 9:49 AM, Kees Cook <keescook@chromium.org> wrote:
> The use of SKCIPHER_REQUEST_ON_STACK() will trigger FRAME_WARN warnings
> (when less than 2048) once the VLA is no longer hidden from the check:
>
> net/rxrpc/rxkad.c:398:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> net/rxrpc/rxkad.c:242:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> This passes the initial SKCIPHER_REQUEST_ON_STACK allocation to the leaf
> functions for reuse. Two requests allocated on the stack is not needed
> when only one is used at a time.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

David (Howells), what do you think of this? Can this go via your tree
or maybe via netdev?

I'd love your Ack or Review. :)

Thanks,

-Kees

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
>                                     struct sk_buff *skb,
>                                     u32 data_size,
> -                                   void *sechdr)
> +                                   void *sechdr,
> +                                   struct skcipher_request *req)
>  {
>         struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
> -       SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>         struct rxkad_level1_hdr hdr;
>         struct rxrpc_crypt iv;
>         struct scatterlist sg;
> @@ -183,12 +183,12 @@ static int rxkad_secure_packet_auth(const struct rxrpc_call *call,
>  static int rxkad_secure_packet_encrypt(const struct rxrpc_call *call,
>                                        struct sk_buff *skb,
>                                        u32 data_size,
> -                                      void *sechdr)
> +                                      void *sechdr,
> +                                      struct skcipher_request *req)
>  {
>         const struct rxrpc_key_token *token;
>         struct rxkad_level2_hdr rxkhdr;
>         struct rxrpc_skb_priv *sp;
> -       SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>         struct rxrpc_crypt iv;
>         struct scatterlist sg[16];
>         struct sk_buff *trailer;
> @@ -296,11 +296,12 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
>                 ret = 0;
>                 break;
>         case RXRPC_SECURITY_AUTH:
> -               ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr);
> +               ret = rxkad_secure_packet_auth(call, skb, data_size, sechdr,
> +                                              req);
>                 break;
>         case RXRPC_SECURITY_ENCRYPT:
>                 ret = rxkad_secure_packet_encrypt(call, skb, data_size,
> -                                                 sechdr);
> +                                                 sechdr, req);
>                 break;
>         default:
>                 ret = -EPERM;
> @@ -316,10 +317,10 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
>   */
>  static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
>                                  unsigned int offset, unsigned int len,
> -                                rxrpc_seq_t seq)
> +                                rxrpc_seq_t seq,
> +                                struct skcipher_request *req)
>  {
>         struct rxkad_level1_hdr sechdr;
> -       SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>         struct rxrpc_crypt iv;
>         struct scatterlist sg[16];
>         struct sk_buff *trailer;
> @@ -402,11 +403,11 @@ static int rxkad_verify_packet_1(struct rxrpc_call *call, struct sk_buff *skb,
>   */
>  static int rxkad_verify_packet_2(struct rxrpc_call *call, struct sk_buff *skb,
>                                  unsigned int offset, unsigned int len,
> -                                rxrpc_seq_t seq)
> +                                rxrpc_seq_t seq,
> +                                struct skcipher_request *req)
>  {
>         const struct rxrpc_key_token *token;
>         struct rxkad_level2_hdr sechdr;
> -       SKCIPHER_REQUEST_ON_STACK(req, call->conn->cipher);
>         struct rxrpc_crypt iv;
>         struct scatterlist _sg[4], *sg;
>         struct sk_buff *trailer;
> @@ -549,9 +550,9 @@ static int rxkad_verify_packet(struct rxrpc_call *call, struct sk_buff *skb,
>         case RXRPC_SECURITY_PLAIN:
>                 return 0;
>         case RXRPC_SECURITY_AUTH:
> -               return rxkad_verify_packet_1(call, skb, offset, len, seq);
> +               return rxkad_verify_packet_1(call, skb, offset, len, seq, req);
>         case RXRPC_SECURITY_ENCRYPT:
> -               return rxkad_verify_packet_2(call, skb, offset, len, seq);
> +               return rxkad_verify_packet_2(call, skb, offset, len, seq, req);
>         default:
>                 return -ENOANO;
>         }
> --
> 2.17.1
>



-- 
Kees Cook
Pixel Security
