Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1993284-1519750791-6-5158953338983563319
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
    t=1519750790; b=GdF9x/k3M86F25yxmq3Ql2nZM7NmMwXRyAiyhAMY81URbWd
    3ySETkJSE5Esk+fRhBzowiX/OfLDy2Qq1S1VAiejNDK6tv65sxxDVMlCnEzyD41o
    LXjKcezBk/XZdJ6li3pP5FGLAjVTBgh26EstKY/qoo5vmhXSMx9lKfIbE7Ezf4GB
    o2n9wNaEeWHguqtdbuLsVVn770MQt8mriBhO+xEzDLjnDE8n6AQXIujUDLB8Y+R4
    QXQoABIffmlZpumJmE8kKp5x7RFyUzNCgPxyPk43kWYi0lgqAkluk53QtBy/vzpT
    Kqa4dPBij1pfcu1zTBjxJ+SXBPHKoqjdKbp4YXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519750790; bh=1vEiT9m
    kI1478jvuUbC5vfmoD2scKXoqpTuXB+71qUc=; b=fs0VCBVJ8r4HBxcglYA7G/Z
    36ogGCqcZXXZ5HRZqN6WrKhozVgS665ubq9OqbHrngnaOgupBVeJITJ+G6uQcsXe
    VmwQgBQKNhSSJgHAraSP5WQetk7AgXhhBQR4eYDgZG0lpnNwfBjpJRBcciLZ3DP/
    lZhx84lUvGIHTW+TgrTEiVm9Bbr1hCvlsYemHHiPfLmkYPA3irKG7ea3+NVWnrFc
    AQnCTZeX+xxC9nTyb1tJVXjM1IhuoZGDs4yC/nbi6aYWyGgSS+M0IKjwrbetsD2o
    Y/xdhyG6xIlxlyE5w86o7XI7xGI+d3lXCHS7WxX7/v4qyXrtSYfXbyG/1X+q+PQ=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=citrix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=citrix.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeB0Q7r (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 11:59:47 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:51722 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752036AbeB0Q7r (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 11:59:47 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515456000";
   d="scan'208";a="68706682"
Date: Tue, 27 Feb 2018 16:58:10 +0000
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
Subject: Re: [PATCH v2 1/2] xen: fix out-of-bounds irq unbind for MSI message
 groups
Message-ID: <20180227165607.wrqp5tb7fmhqglea@MacBook-Pro-de-Roger.local>
References: <1519746958-52077-1-git-send-email-aams@amazon.com>
 <1519746958-52077-2-git-send-email-aams@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1519746958-52077-2-git-send-email-aams@amazon.com>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:55:57PM +0000, Amit Shah wrote:
> When an MSI descriptor was not available, the error path would try to
> unbind an irq that was never acquired - potentially unbinding an
> unrelated irq.

Those IRQs have been allocated in the xen_allocate_irqs_dynamic call,
so I think the "potentially unbinding an unrelated irq" part is wrong.
The unbind call would be performed against an unbound IRQ, which is
harmless AFAICT.

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
>  drivers/xen/events/events_base.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
> index 1ab4bd1..c86d10e 100644
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -755,8 +755,10 @@ int xen_bind_pirq_msi_to_irq(struct pci_dev *dev, struct msi_desc *msidesc,
>  	mutex_unlock(&irq_mapping_update_lock);
>  	return irq;
>  error_irq:
> -	for (; i >= 0; i--)
> +	while (i > 0) {

while (i--)
	__unbind_from_irq(irq + i);

Although please see reply to patch 2.

Roger.
