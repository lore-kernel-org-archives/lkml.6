Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3247637-1521477268-2-1804800909489371695
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521477267; b=Ll93csFaTEKh9rBnCF7ViIQP/0Yo90zfHUN0t7xtzcamOcO
    1rMQ7See/IOKlMqs60rkGXKZIl0fGYRJaq7t6ch3LPAbQwMScfNDpzzJgEdrkT9g
    jGTBzhCV/gxtooPOOgu1OcWkBr9h5zwaGKL0xt+ojoum9kzEHUiZ6DWjk9hU4bgn
    0uqkfCw2+skOqnh+SqB31RcMCwCyG4ZbhZu1xopjJ9xupBIRIyG/6y9dCy8LniYM
    L+tBI7Mm8GS9tpcHmfzJu1U7ieL50d26dLVODTiMgzshm5FC1spZtbCPbPlPaoD9
    fhv13OJNpuidn7mrM5/myYu/aY2cbKwOfvGOb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521477267; bh=GFt/vk0sblYgSFYTshU+nlfDyy
    XwLvGuzcf3Ku2O2J0=; b=NghgqLwG+K8s4BTc6euugKVU2AX+YMRbFkdXubkTMG
    E7wV2zLtjl+fadaVczSjdbJ1zPnBsarf31gB7ZCGjO5lLtJiSrWoBDklj5GKpnWp
    obExItehzaj1Y3oQ5pZFYycjg5VLkKF5sgjkxzYO0PQKxgldg+vpb37HMPqPCugR
    LL+xCTqjC3jf2l+6DETiFjcSRfCKJhocTr3YlzAb5Ea4j71w8HH/+GvZiJHtV4Pl
    hJkDRyy3qAHRMUeQOpjsZXyz7j28aarOx5iDHzIqa94TQKN29UqSn4YMSqL0aSv2
    RCaKY98g5G3tZ+iGt+4qp1mDSuacPyFBmy24sCsLHDjA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ucDr3Yad x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeeuihhnucfnihhuuceosgdqlhhiuhesthhirdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudehjedrudejtddrudejtddruddttdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeelieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=ucDr3Yad x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttdertddtredvnecuhfhrohhmpeeuihhnucfnihhuuceosgdqlhhiuhesthhirdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpudehjedrudejtddrudejtddruddttdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidquhhssgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepfeelieeinecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966912AbeCSQ0z (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:26:55 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:50330 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965769AbeCSQ0x (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Mar 2018 12:26:53 -0400
Date: Mon, 19 Mar 2018 11:26:49 -0500
From: Bin Liu <b-liu@ti.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: musb: gadget: misplaced out of bounds check
Message-ID: <20180319162649.GT14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180319071228.11051-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180319071228.11051-1-xypron.glpk@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, Mar 19, 2018 at 08:12:28AM +0100, Heinrich Schuchardt wrote:
> musb->endpoints[] has array size MUSB_C_NUM_EPS.
> We must check array bounds before accessing the array and not afterwards.
> 
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  drivers/usb/musb/musb_gadget_ep0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_gadget_ep0.c b/drivers/usb/musb/musb_gadget_ep0.c
> index 18da4873e52e..482e7c2f8dc7 100644
> --- a/drivers/usb/musb/musb_gadget_ep0.c
> +++ b/drivers/usb/musb/musb_gadget_ep0.c
> @@ -88,6 +88,11 @@ static int service_tx_status_request(
>  			break;
>  		}
>  
> +		if (epnum >= MUSB_C_NUM_EPS) {

only the LSB 4 bits are the EP number, bit7 is the direction flag. So
you can only compare the LSB 4 bits here.

Regards,
-Bin.
