Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-623030-1524063971-2-1616835965786096893
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524063971; b=b7ESR6mXo/MkCB/VJOfTBgRnJbNHgPZvG4JdoPNq3sHBl32fyg
    mER8xWXcTzbSKoSl9BWG8hrkvXTw1dDZ0rquREJo/c89pV5bnZK32RcMrdc4EHmC
    yeJ+cvE+eTLe1KddXFQRJ40u/tx2hd/RA+Edrw0GZjBORxY9OWi4YNpe/9DUH8ur
    z60Zb+c83esZqsOfQOlsiQfgPHZ10NmgV7YSiFshwx7i9INri1oU7UTuxNiDGT6l
    DCAXH9fCb2fT0n3q8hvWNIHs6B7WGq6JSNJRagWsYkXQeVZyIwAExYrUVncI6DUZ
    NBxXOXfNN8GhLkFkFOhngxaiDeFpY+mODTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524063971; bh=g2tUBzjIg3ldyNFzcEaSDjD/wF3aIf
    d/3jMWhjU5TnQ=; b=rGlefG/jMAEjZaZPfpe9WDx1I3qQhs3Q5sT0EokDEVe/Wn
    sOqUn+MHa6F0PlNlL9uSXP4dTmuFRp+ah5DKiqozvwc9RRfb83bL16sH49UpsqbS
    FVQJL2jnvViv81ZknFGiDWtbs21qKczbekAA2bjRHhkJJII+KSrBIbWnxNC4aBB2
    7E81oozzizJg8zZ/NfwOsLiXEkFkUXnRTlfY/YRK1vWslhXw5WnDwFWHokPUd69Z
    HFCnzkLtLGcdPpZkwctyGPcJU50B4uk4L+kX8oc3n74hQmxNcrgvlfpqrvyX2IQo
    2IO2YCmsNR4e42/IZhoNddnjzR1YiYB1hwbJYngA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=hallyn.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=hallyn.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCEXWH9gO4V8oe3nktgNoVVax5g/OPf4xfu75vIxAxThmyllkT7GXn5v1qBV92YoflNxFKWfF3pjFiNJ+qYqVQ6ESy+x8kLWJqV9bwh6bf1fJKUnNzj0
    cMESgaLyjWqdZ724NWjPnz91ZEgWQIcvjEC/eDWUUVqlFVTxDX1G+xBalVjVlnee69jk2p+3jyJ1UWUH5vabDDuSYoslwQAPOR9GthJzG5MBFCbUT1DI+P4o
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=DfNHnWVPAAAA:8 a=danhDmx_AAAA:8 a=VwQbUJbxAAAA:8
    a=hBqU3vQJAAAA:8 a=wEO7SVL8iM3TIgd1UdoA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=rjTVMONInIDnV1a_A2c_:22 a=P4VdviVPEcjfz_PVVggX:22
    a=AjGcO6oz07-iQ99wixmX:22 a=WLjMIN4s_96MqnBbPenP:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeDRPFx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 11:05:53 -0400
Received: from h2.hallyn.com ([78.46.35.8]:38208 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753153AbeDRPFw (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 18 Apr 2018 11:05:52 -0400
Date: Wed, 18 Apr 2018 10:05:51 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH 4.16 55/68] apparmor: fix display of .ns_name for
 containers
Message-ID: <20180418150551.GB15395@mail.hallyn.com>
References: <20180417155749.341779147@linuxfoundation.org>
 <20180417155751.583001796@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417155751.583001796@linuxfoundation.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Greg Kroah-Hartman (gregkh@linuxfoundation.org):
> 4.16-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: John Johansen <john.johansen@canonical.com>
> 
> commit 040d9e2bce0a5b321c402b79ee43a8e8d2fd3b06 upstream.
> 
> The .ns_name should not be virtualized by the current ns view. It
> needs to report the ns base name as that is being used during startup
> as part of determining apparmor policy namespace support.
> 
> BugLink: http://bugs.launchpad.net/bugs/1746463
> Fixes: d9f02d9c237aa ("apparmor: fix display of ns name")
> Cc: Stable <stable@vger.kernel.org>
> Reported-by: Serge Hallyn <serge@hallyn.com>

Excellent, thank you - this has been a pretty invasive bug for
nested container usage.

> Tested-by: Serge Hallyn <serge@hallyn.com>
> Signed-off-by: John Johansen <john.johansen@canonical.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  security/apparmor/apparmorfs.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> --- a/security/apparmor/apparmorfs.c
> +++ b/security/apparmor/apparmorfs.c
> @@ -1189,9 +1189,7 @@ static int seq_ns_level_show(struct seq_
>  static int seq_ns_name_show(struct seq_file *seq, void *v)
>  {
>  	struct aa_label *label = begin_current_label_crit_section();
> -
> -	seq_printf(seq, "%s\n", aa_ns_name(labels_ns(label),
> -					   labels_ns(label), true));
> +	seq_printf(seq, "%s\n", labels_ns(label)->base.name);
>  	end_current_label_crit_section(label);
>  
>  	return 0;
> 
