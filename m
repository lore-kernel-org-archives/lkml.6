Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519751415-2-11877194199208891007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519751414; b=V7tQomKX54v0Vv4wzofHauvyUcRx0paOlWpFDiiWBMw3nS+
    4QUvI06kBzY48gXVu2lHarGdaAYj/ITq1eK8T+cmttDtoMoRodyvwe1LreXUwdCK
    AoWonVUgxGXJXiq07RHGGDs0jL+MzXygAXAhcfnLptIneJzpJr4nsGfPKT/nB3cv
    zI0noLUZeiyMrkUU9p55sjCUMtB8rm3CZ6GoaRgfk389EpHj/vLucN58nYuFbSY6
    DtYlAidoQjaY0FQVZqXXJe5PGNMXmbGjbpzuhLWNJmUkb9No8zqfHntYIEITZoTe
    ruT00v8lStO8YZHgmWitTWrS7x4XMJobUeo/kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519751414; bh=K/JYK8Z
    3Ot+ueJZipXXylJksodOwoUEYSYbzEcjzBp8=; b=GFZlB2Xptdp15C6BzjzMu7I
    I9v2w6RApexFMHr3Rozf4UR6xkfXbOT2BX9v0zFTy58lm8/5LxZErNwbSKE2UY4B
    Szt6w6+3ursKFoPP05JaQT9akuojAYF3o0JzXAY/ffGywQ7tjlPXxRXAFc7mgAM8
    w6WixgmQjobqFNiawGqt8gH3BWIw9tBH+ZagbHpSo6cN2l8KRPzl0CT5phcCT/NF
    2rHAL7xVkF/APZfUZhy38jhlVgiCOHBoieceNKznRASmaKujO8pGQgFIYobBbodP
    dceiBGHSG8g8icdbv1nuJOKBH9cG4stXPHif8h6hydjEv4ejLsxg05OglZA5+Ag=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeB0RKL (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:10:11 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:4724 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750938AbeB0RKL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 12:10:11 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="68707722"
Date: Tue, 27 Feb 2018 17:07:40 +0000
From: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To: Amit Shah <aams@amazon.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Eduardo Valentin <eduval@amazon.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Liu Shuo <shuo.a.liu@intel.com>,
        Anoob Soman <anoob.soman@citrix.com>
Subject: Re: [PATCH v2 2/2] xen: events: free irqs in error condition
Message-ID: <20180227170740.jcaxsvpepsn6eot2@MacBook-Pro-de-Roger.local>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
 <1519746958-52077-3-git-send-email-aams@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519746958-52077-3-git-send-email-aams@amazon.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:55:58PM +0000, Amit Shah wrote:
> In case of errors in irq setup for MSI, free up the allocated irqs.
> 
> Fixes: 4892c9b4ada9f9 ("xen: add support for MSI message groups")
> Reported-by: Hooman Mirhadi <mirhadih@amazon.com>
> CC: <stable@vger.kernel.org>
> CC: Roger Pau Monné <roger.pau@citrix.com>
> CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> CC: Eduardo Valentin <eduval@amazon.com>
> CC: Juergen Gross <jgross@suse.com>
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: "K. Y. Srinivasan" <kys@microsoft.com>
> CC: Liu Shuo <shuo.a.liu@intel.com>
> CC: Anoob Soman <anoob.soman@citrix.com>
> Signed-off-by: Amit Shah <aams@amazon.com>
> ---
>  drivers/xen/events/events_base.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index c86d10e..a299586 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -750,11 +750,14 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  
>  	ret = irq_set_msi_desc(irq, msidesc);
>  	if (ret < 0)
> -		goto error_irq;
> +		goto error_desc;
>  out:
>  	mutex_unlock(&irq_mapping_update_lock);
>  	return irq;
>  error_irq:
> +	while (--nvec >= i)
> +		xen_free_irq(irq + nvec);
> +error_desc:
>  	while (i > 0) {
>  		i--;
>  		__unbind_from_irq(irq + i);

It seems pointless to introduce another label and another loop to fix
something that can be fixed with a single label and a single loop,
this just makes the code more complex for no reason.

IMHO the way to solve this issue is:

while (nvec--) {
	if (nvec >= i)
		xen_free_irq(irq + nvec);
	else
		__unbind_from_irq(irq + nvec);
}

Roger.
