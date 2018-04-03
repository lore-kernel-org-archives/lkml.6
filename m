Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1674080-1522765042-2-8244948609954051533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522765041; b=HLHCJBKQnMbmpc+3qfuV146ywHGO6Lp+dkJ4W5wCK8H8YWJwLP
    E/92bmrdbdD1oui6YMIxzEXrrDTLQoTkDNu6ZsW3dH14ZjI28hdrg6OLMHV4j1Lb
    +ujNH89tZcGPQWY4NJCqXfXArFpqV2/8NKJNHbe2lVXoWJCu1lO4/kdK+6NB+iSK
    Vazm4vige4dycRUNcuIyVpRZ49pO9/5IIWWRaiSv5ypRZgSnCTSZQxxZdMc6J3+Q
    WCEuKlnsdaEIw3Ar0PCluh+gflUiDvMYT63McFaKHPdbqAIHIemBdJZotgiuCava
    g2B0DjikagdIwUiEPKKteFsHdYae6O0s3fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522765041;
    bh=i4oG3/e+b5AkvZdvzcSjtjXBeD+h+s4mlxER4B+qeRA=; b=t+NuHgj7pcyY
    XUnmCHj0emgruIH/OhUfbrtgQD70ZNGKv1zgqGT/qFTOl11C+CiD24zQWxJtEC0v
    rpac7vuA/D4ubzme8/zR8+bv+ysPcJhxUWuxcQa1fXZTjo32NKFShEAagCyoI19T
    v6AudEzD/Jg2eedAOLgfp4+0Y/MoYJwoE7FBl814NanV2NMvYn6kW4gyXhiOyL9T
    lzofcl16TWnQmUivnC86+FbediMysOO3O8ZaOgo1l5oDfDq1AJqTLBD3liAC+R+8
    YV7gMbd925hfkLgns2ugl4UhD7zaHyATh1z7eeqLHTKkcLOTNqDOWF1YZLhsUwvt
    CKpITgjQsg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC2kZHuKPKzm4mRaiJf2YS7GXBjOpBszMV1kZpZTjJ1fy2wPDX0xl3WdrGblHxWBprTLoZKqwWSbo2EtX4wu5TRDhWSfs9lA7997ZkggXLS5GLcw+CrK
    AI6qsibjXULagcBt0nCW9athkF+uYqmkZtbKNCmEUL6nI/AUCQpizL6tN92OsygnAAFay+tNoyHwJbDg6Lp1bXwECdEwzpM/oH8sF0i+G5z9vVZmENhOzqWP
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=FRsr_42YyUxe5CN--kcA:9 a=QEXdDO2ut3YA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751283AbeDCORU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 10:17:20 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:55454 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDCORT (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 10:17:19 -0400
Message-ID: <1522765036.2654.99.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 15/97] genirq: Use irqd_get_trigger_type to compare
 the trigger type for shared IRQs
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 15:17:16 +0100
In-Reply-To: <20180323094158.346866234@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094158.346866234@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Hans de Goede <hdegoede@redhat.com>
> 
> 
> [ Upstream commit 382bd4de61827dbaaf5fb4fb7b1f4be4a86505e7 ]
> 
> When requesting a shared irq with IRQF_TRIGGER_NONE then the irqaction
> flags get filled with the trigger type from the irq_data:
> 
>         if (!(new->flags & IRQF_TRIGGER_MASK))
>                 new->flags |= irqd_get_trigger_type(&desc->irq_data);

The code above was added to __setup_irq() in 4.8, so I don't think this
fix is needed in 3.18 or 4.4; and I suspect it might cause a regression
there.

Ben.

> On the first setup_irq() the trigger type in irq_data is NONE when the
> above code executes, then the irq is started up for the first time and
> then the actual trigger type gets established, but that's too late to fix
> up new->flags.
> 
> When then a second user of the irq requests the irq with IRQF_TRIGGER_NONE
> its irqaction's triggertype gets set to the actual trigger type and the
> following check fails:
> 
>         if (!((old->flags ^ new->flags) & IRQF_TRIGGER_MASK))
> 
> Resulting in the request_irq failing with -EBUSY even though both
> users requested the irq with IRQF_SHARED | IRQF_TRIGGER_NONE
> 
> Fix this by comparing the new irqaction's trigger type to the trigger type
> stored in the irq_data which correctly reflects the actual trigger type
> being used for the irq.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
> Link: http://lkml.kernel.org/r/20170415100831.17073-1-hdegoede@redhat.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  kernel/irq/manage.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1189,8 +1189,10 @@ __setup_irq(unsigned int irq, struct irq
>  		 * set the trigger type must match. Also all must
>  		 * agree on ONESHOT.
>  		 */
> +		unsigned int oldtype = irqd_get_trigger_type(&desc->irq_data);
> +
>  		if (!((old->flags & new->flags) & IRQF_SHARED) ||
> -		    ((old->flags ^ new->flags) & IRQF_TRIGGER_MASK) ||
> +		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
>  		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
>  			goto mismatch;
>  

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
