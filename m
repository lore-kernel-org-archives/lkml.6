Return-Path: <SRS0=phas=HQ=atomide.com=tony@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599407-1524855030-2-2219535570529151089
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='com',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=phas=HQ=atomide.com=tony@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524855028; b=BbcV3DQ9oUVGa2Q0rBzkeSMg+0nly3csE7Htyu7Agq5rC42R3P
    76XiGAeOqA5i1eD0HhmDUXVTzECIvzqtleLK9l9rTVUtuq/J1irzl511a7/uK4Zb
    akNKPW2/8z7BZc8uZXAjLU+orxs2T4LRUAEG0caIAPd1rGGLEOHekXeuV6Yv55q5
    IQXguA6Ob1K5/FY5NoArR4CLTgyZAZFV6MMtuxt1/BjK82EEcvhyIDBhmOc8he7g
    JfqeWz1K3JEwwjeTklTRh2ZoTBXRgJ8OgVSis14lRePFn4W0dkEqwtLm5D4YNgkI
    0i9gIlQb5z3g7p5V7egM+KOM/9RGS7Y1ggWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1524855028; bh=u1h9z5aOTO3XS2a76wYID+aJ9UPYbT+i19b6KPD9MJc=; b=a
    OFV8GixLoIv/OUh20hKIRTMNUbAZJ/n1DjS5iDmYmxucn5qC9Gr3Z5pud2RN0u21
    MH7B6vofJ+V0zfNdevWlpfWg/Q89kw4gNVWCpumMrCRfqd8Udd0VKIPpBsFRbKiH
    cNL5wi7fJmyIHGCdrs38ZnUCpdIiF2+GNSgaDvsepHeBGzU23tpdw8q3LCQjVXpv
    du73nF9Y1qrEDEJqaaRmtw2iVhhVCkJGCkV56sTe54UFLxNzqyPnSiWFoPfyPcjD
    949FXlD5BzyRkP0I3CQ97hbcPjnGzlC26VNgfNO3g4IRZIxjyASbqXckbEV9jL2U
    a6Jq+9ciQV1Ey1Tdsvi0A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=phas=HQ=atomide.com=tony@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom="SRS0=phas=HQ=atomide.com=tony@kernel.org" smtp.helo=mail.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPiiVZKNnsDP2q/hEiESJOwqXvYe8NHE+LV+G1RQNKPOthOr8JOIcHaxah4HZJGJWhlSciltt4q2WMUUwh1uW8M2RKxInpY8vO/hDzjSB9n1xGicXhMy
    mn7EBurIeYJE7oIZwYpasSz/xVRuM6ljKQK9kusGEDiQqqCXFKPPEjS50h+xtVIYdUu5GhfbdEOBgiQGsF/+ihUErCyZvr8ETX4=
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=czNdAM+YcK12vDHDihaDnQ==:117
    a=czNdAM+YcK12vDHDihaDnQ==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=AYtqSYW1AAAA:8 a=IM_xmawzFgIYGJyW4VgA:9
    a=nFncEX2JP_I1Lru0:21 a=oH4i_Lla5-OaAiDa:21 a=CjuIK1q_8ugA:10
    a=WtHkaixNIbui_3fsm1s1:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94F9C2168C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=tony@atomide.com
Date: Fri, 27 Apr 2018 11:50:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sun Peng <sun_peng@topsec.com.cn>, Jiri Slaby <jslaby@suse.com>,
	linux-kernel@vger.kernel.org, security@kernel.org,
	Lars Poeschel <poeschel@lemonage.de>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 2/4] tty: n_gsm: Prevent a potential use after free
Message-ID: <20180427185021.GD5671@atomide.com>
References: <20180420083028.7fq3hw2mjjd7nrra@mwanda>
 <20180426055321.GA15363@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426055321.GA15363@mwanda>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

* Dan Carpenter <dan.carpenter@oracle.com> [180426 05:55]:
> We're freeing the gsm->dlci[] array elements but leaving the freed
> pointers hanging around.
> 
> My concern here is if we use the ioctl to change the config, it triggers
> a restart in gsmld_config().  In that case, we would only reset the
> first ->dlci[0] element and not the others so it does look to me like a
> possible use after free.
> 
> Reported-by: Sun Peng <sun_peng@topsec.com.cn>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index cc7f68814200..1f2fd9e76fe0 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2075,9 +2075,11 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm)
>  
>  	/* Free up any link layer users */
>  	mutex_lock(&gsm->mutex);
> -	for (i = 0; i < NUM_DLCI; i++)
> +	for (i = 0; i < NUM_DLCI; i++) {
>  		if (gsm->dlci[i])
>  			gsm_dlci_release(gsm->dlci[i]);
> +		gsm->dlci[i] = NULL;
> +	}
>  	mutex_unlock(&gsm->mutex);
>  	/* Now wipe the queues */
>  	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)

This one causes the following oops for me on closing n_gsm:

Unable to handle kernel NULL pointer dereference at virtual address 0000025c
...
(refcount_sub_and_test) from [<c057e424>] (refcount_dec_and_test+0x18/0x1c)
(refcount_dec_and_test) from [<c06378b8>] (tty_port_put+0x24/0x9c)
(tty_port_put) from [<bf8c9614>] (gsmtty_cleanup+0x2c/0x48 [n_gsm])
(gsmtty_cleanup [n_gsm]) from [<c062e0d4>] (release_one_tty+0x3c/0xa0)
(release_one_tty) from [<c01622b0>] (process_one_work+0x2ac/0x858)

Regards,

Tony
