Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832833-2-203443043851928390
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832833; b=liNQRwE6kaehybg6zw6tLWIxpZX8Shm4v539Q6NYYxab3Cj
    fhoFj1Svy2SkSjhWgK0nvWMMUkqoAn8yha6Xe3LOfHU8SEpMpJ/twETEFB3T/Byr
    a64BSKd98Tkfxi1YBz8pI0W/j2pSPI0oSBMXRxQS+YvhjjNtIHu+iX+ryNFS6hR2
    HPENghAe5/Z9rb1RolgmBO+O+9zDjeOLUOjE/SdyeglGJxhVkHATBJwZykHDeH6P
    EhU+Ic2DQX5vv4lxhrx97qQCaZH05peR9qUCL6X4HyC5fDrxoE1aY4ArB0dZwSx/
    rN0G+px7zM58m+BPZ9OWg/H6z4wL3x/TObkEoWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:references:date
    :in-reply-to:message-id:mime-version:content-type:sender
    :list-id; s=arctest; t=1519832833; bh=0DqD3AfyJntSZfJrkDhaspcvuO
    OGdX+mlJ0pYFzuuAQ=; b=MgIDkiKNJeuYuMidigT3q6hXt6kcOkdOTkfBswKSoP
    XrEgG8KP6V1K0zlQ/noEd8Pvus9nv10QWzlgB4ZPiRS6FZWwYfEz2e8IH9v+PEhd
    y0qqCXwmPwlUMMKjb80DyxhEv9ccQJEEKlafIkqJ7SY75c8kCe8kpbmXbWi8drr+
    Grjs5kgutmfrlscrFMRg9DoDUbRdI87kLyVT6dk5f7EnqwgjP7GeAbcgBNjZpa7d
    m/tDU9M0daiLkVAk+ooRgZ+B0OY4NslbEW0DkkXjz+R8r4wAxHo3vThr4TY5sYv7
    16InwxT0RoLgtDILZebCs0aFyvl0As2r63i7IVH7HclQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeB1PrB (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:47:01 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52098 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932668AbeB1PrA (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 28 Feb 2018 10:47:00 -0500
From: Punit Agrawal <punit.agrawal@arm.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Christoffer Dall" <christoffer.dall@linaro.org>
Subject: Re: [PATCH 4.9 09/66] KVM: arm/arm64: Check pagesize when allocating a hugepage at Stage 2
References: <20180129123839.842860149@linuxfoundation.org>
        <20180129123840.324072883@linuxfoundation.org>
        <HE1PR04MB321245D8E0ED5DB3DA6F4DA0E0C70@HE1PR04MB3212.eurprd04.prod.outlook.com>
Date: Wed, 28 Feb 2018 15:46:58 +0000
In-Reply-To: <HE1PR04MB321245D8E0ED5DB3DA6F4DA0E0C70@HE1PR04MB3212.eurprd04.prod.outlook.com>
        (Ioana Ciornei's message of "Wed, 28 Feb 2018 15:33:03 +0000")
Message-ID: <87efl515hp.fsf@e105922-lin.cambridge.arm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ioana,

Ioana Ciornei <ioana.ciornei@nxp.com> writes:

>> 4.9-stable review patch.  If anyone has any objections, please let me know.
>
> I know that my response comes late but I just found out that the version of the patch applied in 4.9-stable, the one in this email, is different than the one applied on 4.14-stable.
> This is the one applied on 4.14: https://patchwork.kernel.org/patch/10177715/
>
> As you can see, the check against PMD_SIZE which is present in 4.14 is not present in this version of the patch.
>
> Am I missing something or should I send a patch to rectify this?

You're right. The check against PMD_SIZE was lost during the rebase to
v4.9. I should've noticed this before it got sent.

Please send a patch to fix this. Alternately, I can fix this with your
reported by.

Thanks,
Punit

>
> Thanks,
> Ioana Ciornei
>
>> 
>> ------------------
>> 
>> From: Punit Agrawal <punit.agrawal@arm.com>
>> 
>> commit c507babf10ead4d5c8cca704539b170752a8ac84 upstream.
>> 
>> KVM only supports PMD hugepages at stage 2 but doesn't actually check that
>> the provided hugepage memory pagesize is PMD_SIZE before populating
>> stage 2 entries.
>> 
>> In cases where the backing hugepage size is smaller than PMD_SIZE (such as
>> when using contiguous hugepages), KVM can end up creating stage 2
>> mappings that extend beyond the supplied memory.
>> 
>> Fix this by checking for the pagesize of userspace vma before creating PMD
>> hugepage at stage 2.
>> 
>> Fixes: 66b3923a1a0f77a ("arm64: hugetlb: add support for PTE contiguous
>> bit")
>> Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> 
>> ---
>>  arch/arm/kvm/mmu.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -1284,7 +1284,7 @@ static int user_mem_abort(struct kvm_vcp
>>  		return -EFAULT;
>>  	}
>> 
>> -	if (is_vm_hugetlb_page(vma) && !logging_active) {
>> +	if (vma_kernel_pagesize(vma) && !logging_active) {
>>  		hugetlb = true;
>>  		gfn = (fault_ipa & PMD_MASK) >> PAGE_SHIFT;
>>  	} else {
>> 
>

-- 
<JHM> Being overloaded is the sign of a true Debian maintainer.
