Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3465232-1517865406-2-464019977435586205
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endasv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517865405; b=lHJS7VdfB1DIQhUK0SrrkDW4OCMPnCtLRmpcpyW6xhQjfdj
    ltJWZT5V9gvaOfNuJjJLq/4Z/d2cfdeRuKWzWodvt5zPiw17UhE2r1QKENBnv89s
    h3jcm1z9v7bbxHSON9qWRqfd/Ri5Ma4sJAoNZWEipiv5sk3Zge2e3gRnUYVv1XSi
    P8pOqXFiHuAUiQMbuY/TupIb8iYH4L69L2ZFLk7kMHawfaO5fAQudKrl/TUrAShI
    HCKoJUIe0mTmuXCoEXxLrGgA3I5a2LUoHnkelRLSHd9RbE3SNbqehW2Lxd8spG9p
    8VXPe7oIkoTYrOo9nL8wZhrbsgSG056mLu1GQZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517865405; bh=+9rFMH0Xvzirl6s5gupAsrDzFCBXnFOR+bh1MC6aswQ=; b=N
    dIVuLYurZpQQE7Xtc6Mo0/STyhT/Apf0YQz8MAFoviXQlx2se1EJin1Uaas4ApLJ
    kqRWNXlgnwFW7RVATMRca6jNaqtCSYMtroQ/NF+UgJ+X6oXWQHt2TiDxtaChRa+F
    00479tyajhWrfarn/8EQ7K21WSmRmtlnLlDPtsbdhrQN2w1hDMHhAS9sA+M22WHJ
    EIRAaEiZoy7MZZSO+oolsdmBoLOZUpAQoioHzR4zpCCnNj5YbUk1VqhuHrgyZ1yt
    +cu2Kzkkg1M4YTETUvnuJdPJ0iyq6BIb8MLfwneywOF9VteHxnzcxmYtBEoztjhr
    O6ZhSZJZETg8Zk72UV2gQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=synopsys.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=synopsys.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbeBEVQc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Feb 2018 16:16:32 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:42014 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751728AbeBEVQa (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Feb 2018 16:16:30 -0500
Subject: Re: [PATCH] usb: dwc2: gadget: Use true and false for boolean values
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        John Youn <John.Youn@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
References: <20180123154531.GA22359@embeddedgus>
From: John Youn <John.Youn@synopsys.com>
Message-ID: <333168e1-f8b9-87bc-c6ba-a67c9112d686@synopsys.com>
Date: Mon, 5 Feb 2018 13:12:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180123154531.GA22359@embeddedgus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.9.130.156]
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/23/2018 07:45 AM, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/usb/dwc2/gadget.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index e4c3ce0..1f684dd 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -116,10 +116,10 @@ static inline void dwc2_gadget_incr_frame_num(struct dwc2_hsotg_ep *hs_ep)
>   {
>   	hs_ep->target_frame += hs_ep->interval;
>   	if (hs_ep->target_frame > DSTS_SOFFN_LIMIT) {
> -		hs_ep->frame_overrun = 1;
> +		hs_ep->frame_overrun = true;
>   		hs_ep->target_frame &= DSTS_SOFFN_LIMIT;
>   	} else {
> -		hs_ep->frame_overrun = 0;
> +		hs_ep->frame_overrun = false;
>   	}
>   }
>   
> 

+Felipe

Acked-by: John Youn <johnyoun@synopsys.com>

Regards,
John
