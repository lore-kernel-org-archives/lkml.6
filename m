Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ACHBL8Z3GVvkKQAAmS7hNA
	; Thu, 07 Jun 2018 18:21:58 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 926C86074D; Thu,  7 Jun 2018 18:21:58 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXvzYUG1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EF71B60290;
	Thu,  7 Jun 2018 18:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EF71B60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935594AbeFGSV4 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:21:56 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:38862 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933152AbeFGSVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:21:51 -0400
Received: by mail-qk0-f195.google.com with SMTP id y4-v6so7165428qka.5;
        Thu, 07 Jun 2018 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=w/p8xIslYkmwMMIw1DYoEtNNJaXuAktmTVezFtX1zqM=;
        b=TXvzYUG1qZeT4xglclHaUc5VKKjWwp7L3pWuYyIRJSQtiqtr045YGT4w0QTH9wFB68
         85kAd7857QiqTbvU6vFh507OL1DDKkEwOoVNdvvy3D5WC/RVkWJ8WSUQUK1hURBZHHoh
         Py+z4n6nLVG96FgaQEp3czIBAkR5Okfjr0i6FDbX0St16Y98K557WjOp8nHjFRHJ0FR4
         qoix3hc0aEAeyxOSVPZXugDApblUWOhbnQegTF1Lb+cElDfPbKdcgkp1LcSemejjYgKz
         SkTX0AWsDmjogJuV7GMKitLlP+WVvETlKVKI+iaJ5sCFxzx9eskMMC/kfFtaWcAY7CaD
         ivSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w/p8xIslYkmwMMIw1DYoEtNNJaXuAktmTVezFtX1zqM=;
        b=poicCI+lRb4bDHd5Y9LoZ+FYvWMzvUeKrvwY7jC+cI/mpvtx1PgoWUvgdfNzMGzzK4
         SO+JbD1DteWxOSBUa+iSN3R+JXyl8cIsaJPPr4HgXsb5v4PZ2cCtJJ98E1MquW62NSb9
         rQbNgSHAY9X6S9OTdKpqacbbL2wthP9uJHSis0TIW5kVQ94/3NiqKe6ibj3vF1gBVmu8
         ewdIB9iQMhVbLyfsJfB4mI2LlWFAh4ILFlqBIEpDQ+Wq5b1iCPGIztUih23bmkmaQr9r
         +GveqPnnUcHPJSWVGgVxzHujx3UAqvxxLQpRNXoU4xYk9jt15MGe+DZPJj/T8iPrtDhI
         N9XA==
X-Gm-Message-State: APt69E3ZmV+NmXAMxIbb8uST3ddPlz+6dtM/xJupgzef6KWg0X4NeVTr
        BAWPaE3ergyNVVh/NCQh5dQ=
X-Google-Smtp-Source: ADUXVKLr7uPfMb9azQ+FDyphFCeMG/zTzcwvqJmvDuYZePDAGMg/QyCD8CraVyaE7Tnm12KaKkNUzw==
X-Received: by 2002:a37:2ac7:: with SMTP id q68-v6mr2474198qkq.77.1528395710583;
        Thu, 07 Jun 2018 11:21:50 -0700 (PDT)
Received: from localhost.localdomain ([138.204.24.99])
        by smtp.gmail.com with ESMTPSA id s12-v6sm32428767qkl.65.2018.06.07.11.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 11:21:49 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 15503180C41; Thu,  7 Jun 2018 15:21:47 -0300 (-03)
Date: Thu, 7 Jun 2018 15:21:47 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Xin Long <lucien.xin@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 19/92] sctp: delay the authentication for the
 duplicated cookie-echo chunk
Message-ID: <20180607182147.GD31423@localhost.localdomain>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524093200.931521036@linuxfoundation.org>
 <1528324307.2289.61.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1528324307.2289.61.camel@codethink.co.uk>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 11:31:47PM +0100, Ben Hutchings wrote:
> On Thu, 2018-05-24 at 11:37 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Xin Long <lucien.xin@gmail.com>
> > 
> > [ Upstream commit 59d8d4434f429b4fa8a346fd889058bda427a837 ]
> > 
> > Now sctp only delays the authentication for the normal cookie-echo
> > chunk by setting chunk->auth_chunk in sctp_endpoint_bh_rcv(). But
> > for the duplicated one with auth, in sctp_assoc_bh_rcv(), it does
> > authentication first based on the old asoc, which will definitely
> > fail due to the different auth info in the old asoc.
> [...]
> > --- a/net/sctp/associola.c
> > +++ b/net/sctp/associola.c
> > @@ -1000,9 +1000,10 @@ static void sctp_assoc_bh_rcv(struct wor
> >  	struct sctp_endpoint *ep;
> >  	struct sctp_chunk *chunk;
> >  	struct sctp_inq *inqueue;
> > -	int state;
> >  	sctp_subtype_t subtype;
> > +	int first_time = 1;	/* is this the first time through the loop */
> >  	int error = 0;
> > +	int state;
> >  
> >  	/* The association should be held so we should be safe. */
> >  	ep = asoc->ep;
> > @@ -1013,6 +1014,30 @@ static void sctp_assoc_bh_rcv(struct wor
> >  		state = asoc->state;
> >  		subtype = SCTP_ST_CHUNK(chunk->chunk_hdr->type);
> >  
> > +		/* If the first chunk in the packet is AUTH, do special
> > +		 * processing specified in Section 6.3 of SCTP-AUTH spec
> > +		 */
> > +		if (first_time && subtype.chunk == SCTP_CID_AUTH) {
> > +			struct sctp_chunkhdr *next_hdr;
> > +
> > +			next_hdr = sctp_inq_peek(inqueue);
> > +			if (!next_hdr)
> > +				goto normal;
> > +
> > +			/* If the next chunk is COOKIE-ECHO, skip the AUTH
> > +			 * chunk while saving a pointer to it so we can do
> > +			 * Authentication later (during cookie-echo
> > +			 * processing).
> > +			 */
> > +			if (next_hdr->type == SCTP_CID_COOKIE_ECHO) {
> > +				chunk->auth_chunk = skb_clone(chunk->skb,
> > +							      GFP_ATOMIC);
> > +				chunk->auth = 1;
> 
> Doesn't the first_time flag need to be cleared here (and before the
> other continue statement in this loop)?

Seems the description is not matching the code closely. As is,
first_time is about the first time an AUTH chunk is handled followed
by a COOKIE-ECHO chunk (which is what we wanted, in the end), and not
strictly enforcing 'first chunk in the packet', as the description
says.

We should rename this first_time into a chunk counter instead. It
may even help with debugging on crashes.

Thanks for reviewing this, btw.

  Marcelo

> 
> Ben.
> 
> > +				continue;
> > +			}
> > +		}
> > +
> > +normal:
> [...]
> 
> -- 
> Ben Hutchings, Software Developer                         Codethink Ltd
> https://www.codethink.co.uk/                 Dale House, 35 Dale Street
>                                      Manchester, M1 2HF, United Kingdom
