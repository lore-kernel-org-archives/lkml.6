Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71630C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3253621CD0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3253621CD0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbeHILap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:30:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49258 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727966AbeHILap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:30:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 923EF402333A;
        Thu,  9 Aug 2018 09:06:50 +0000 (UTC)
Received: from gondolin (dhcp-192-215.str.redhat.com [10.33.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF5052026D68;
        Thu,  9 Aug 2018 09:06:47 +0000 (UTC)
Date:   Thu, 9 Aug 2018 11:06:45 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, borntraeger@de.ibm.com,
        kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com,
        pbonzini@redhat.com, alex.williamson@redhat.com,
        pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com,
        mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com,
        thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com,
        fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com,
        frankja@linux.ibm.com
Subject: Re: [PATCH v8 04/22] s390/zcrypt: Integrate ap_asm.h into
 include/asm/ap.h.
Message-ID: <20180809110645.33b20c1f.cohuck@redhat.com>
In-Reply-To: <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1533739472-7172-5-git-send-email-akrowiak@linux.vnet.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 09:06:50 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Thu, 09 Aug 2018 09:06:50 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'cohuck@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Aug 2018 10:44:14 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> From: Harald Freudenberger <freude@de.ibm.com>
> 
> Move all the inline functions from the ap bus header
> file ap_asm.h into the in-kernel api header file
> arch/s390/include/asm/ap.h so that KVM can make use
> of all the low level AP functions.
> 
> Signed-off-by: Harald Freudenberger <freude@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

You should add your own s-o-b if you are sending on patches written by
others (even if it does not matter in the end, when they are merged
through a different path anyway.)

> ---
>  arch/s390/include/asm/ap.h     |  284 ++++++++++++++++++++++++++++++++++++----
>  drivers/s390/crypto/ap_asm.h   |  261 ------------------------------------
>  drivers/s390/crypto/ap_bus.c   |   21 +---
>  drivers/s390/crypto/ap_bus.h   |    1 +
>  drivers/s390/crypto/ap_card.c  |    1 -
>  drivers/s390/crypto/ap_queue.c |    1 -
>  6 files changed, 259 insertions(+), 310 deletions(-)
>  delete mode 100644 drivers/s390/crypto/ap_asm.h
> 
> diff --git a/arch/s390/include/asm/ap.h b/arch/s390/include/asm/ap.h
> index c1bedb4..046e044 100644
> --- a/arch/s390/include/asm/ap.h
> +++ b/arch/s390/include/asm/ap.h
> @@ -47,6 +47,50 @@ struct ap_queue_status {
>  };
>  
>  /**
> + * ap_intructions_available() - Test if AP instructions are available.
> + *
> + * Returns 0 if the AP instructions are installed.

Stumbled over this when I was looking at the usage in patch 7: if I see
a function called '_available' return 0, I'd assume that whatever the
function tests for is *not* available.

Rather call this function ap_instructions_check_availability() (and
keep the return code convention), or switch this to return 0 if not
available and !0 if available?

> + */
> +static inline int ap_instructions_available(void)
> +{
> +	register unsigned long reg0 asm ("0") = AP_MKQID(0, 0);
> +	register unsigned long reg1 asm ("1") = -ENODEV;
> +	register unsigned long reg2 asm ("2");
> +
> +	asm volatile(
> +		"   .long 0xb2af0000\n"		/* PQAP(TAPQ) */
> +		"0: la    %0,0\n"
> +		"1:\n"
> +		EX_TABLE(0b, 1b)
> +		: "+d" (reg1), "=d" (reg2)
> +		: "d" (reg0)
> +		: "cc");
> +	return reg1;
> +}
