Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BCAC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E068217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeLTMYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:24:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43244 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbeLTMYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:24:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 22E24C0495B0;
        Thu, 20 Dec 2018 12:24:38 +0000 (UTC)
Received: from gondolin (dhcp-192-187.str.redhat.com [10.33.192.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E495219C65;
        Thu, 20 Dec 2018 12:24:32 +0000 (UTC)
Date:   Thu, 20 Dec 2018 13:24:30 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Michael Mueller <mimu@linux.ibm.com>
Cc:     KVM Mailing List <kvm@vger.kernel.org>,
        Linux-S390 Mailing List <linux-s390@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v5 06/15] KVM: s390: remove prefix kvm_s390_gisa_ from
 static inline functions
Message-ID: <20181220132430.7cea69d3.cohuck@redhat.com>
In-Reply-To: <20181219191756.57973-7-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
        <20181219191756.57973-7-mimu@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 20 Dec 2018 12:24:38 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Dec 2018 20:17:47 +0100
Michael Mueller <mimu@linux.ibm.com> wrote:

> This will shorten the length of code lines.
> All GISA related static inline functions are local to interrupt.c
> 
> Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 4ab20d2eb180..9b1fa39b6f90 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -224,22 +224,22 @@ static inline u8 int_word_to_isc(u32 int_word)
>   */
>  #define IPM_BIT_OFFSET (offsetof(struct kvm_s390_gisa, ipm) * BITS_PER_BYTE)
>  
> -static inline void kvm_s390_gisa_set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +static inline void set_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	set_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>  }
>  
> -static inline u8 kvm_s390_gisa_get_ipm(struct kvm_s390_gisa *gisa)
> +static inline u8 get_ipm(struct kvm_s390_gisa *gisa)
>  {
>  	return READ_ONCE(gisa->ipm);
>  }
>  
> -static inline void kvm_s390_gisa_clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +static inline void clear_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>  }
>  
> -static inline int kvm_s390_gisa_tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
> +static inline int tac_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
>  {
>  	return test_and_clear_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
>  }

I don't disagree with making them shorter, but I think the code would
be more readable if you only dropped the kvm_s390_ prefix and kept
annotating the functions as gisa_.
