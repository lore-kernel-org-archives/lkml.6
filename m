Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3029665-1521605680-2-975972140467741271
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521605679; b=doRrz+DUNDhCztgUfDFufZg47Uc4n7DZgfIkxSzOZ7Q0nLq
    4ppQScXhZT3D5sJunt+d4UC3jYv0rWCANB1b6vOl23yQn7f+3dqpBmOqfcFBL52m
    Gs0Qg+sE4gVXB2T1mQ7vXAEoQgKsChRRWXRf+rJzZ1IoRAwrilcpkrTUTTde40aX
    wBSizjVlKpZjn+jGfg3+7XPKCgTdhVuW+HbtuYo7/m/vF+YIeKhuh6MbFLhKzbvo
    cF44DGPwlRTvuobGTdndObAbt51wpn1cDbjRsgMGJTIC3p/eGprOMdFWTXHCkPVL
    WMVVMty6UPCll7FPb/vu5/gGWNIfGvFNUjSOHOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521605679; bh=5s9NX2rrg4R8k+oQAiiAh/H+lKIoZb4OwBXMiHf3pMY=; b=c
    X9O7aR5Rqge18UgRcoB5VS9vGs4r2ZcP/gT5ScxzA1Az/eVg5RwKz5d+x24KNL35
    JGftyoYprFre3+du6fcPMuyzL5fyb5rj4xQlhTSHUX001uwrPYbjFSkcpP/J09j4
    LwDmobJHjdLaAn2Xr5eYhLpHk1wiDM4i+ZhKNs+tB6LuOMrb05kpPFHdTH7qzBzF
    73grwhIrJ/MYhvsFzvgM9WvnKQekLaMp2RzVNbPQlLoDXHNhSA8aVN+1IzyR/RPI
    LTDGDx9SUPegTLxmeJj6V37clGgEDqiirE44qbzU2+oIQd45FV8VTeQqhLpdYdzG
    gROs7crtDZ3BHnn9ND7AA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751040AbeCUEOg convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 21 Mar 2018 00:14:36 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11273 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeCUEOf (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 00:14:35 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 20 Mar 2018 21:14:30 -0700
Subject: Re: [PATCH 03/15] mm/hmm: HMM should have a callback before MM is
 destroyed v2
To: <jglisse@redhat.com>, <linux-mm@kvack.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        <stable@vger.kernel.org>, Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-4-jglisse@redhat.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <d89e417d-c939-4d18-72f5-08b22dc6cff0@nvidia.com>
Date: Tue, 20 Mar 2018 21:14:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180320020038.3360-4-jglisse@redhat.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> The hmm_mirror_register() function registers a callback for when
> the CPU pagetable is modified. Normally, the device driver will
> call hmm_mirror_unregister() when the process using the device is
> finished. However, if the process exits uncleanly, the struct_mm
> can be destroyed with no warning to the device driver.
> 
> Changed since v1:
>   - dropped VM_BUG_ON()
>   - cc stable
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> Cc: stable@vger.kernel.org
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/hmm.h | 10 ++++++++++
>  mm/hmm.c            | 18 +++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index 36dd21fe5caf..fa7b51f65905 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -218,6 +218,16 @@ enum hmm_update_type {
>   * @update: callback to update range on a device
>   */
>  struct hmm_mirror_ops {
> +	/* release() - release hmm_mirror
> +	 *
> +	 * @mirror: pointer to struct hmm_mirror
> +	 *
> +	 * This is called when the mm_struct is being released.
> +	 * The callback should make sure no references to the mirror occur
> +	 * after the callback returns.
> +	 */
> +	void (*release)(struct hmm_mirror *mirror);
> +
>  	/* sync_cpu_device_pagetables() - synchronize page tables
>  	 *
>  	 * @mirror: pointer to struct hmm_mirror
> diff --git a/mm/hmm.c b/mm/hmm.c
> index 320545b98ff5..6088fa6ed137 100644
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -160,6 +160,21 @@ static void hmm_invalidate_range(struct hmm *hmm,
>  	up_read(&hmm->mirrors_sem);
>  }
>  
> +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> +{
> +	struct hmm *hmm = mm->hmm;
> +	struct hmm_mirror *mirror;
> +	struct hmm_mirror *mirror_next;
> +
> +	down_write(&hmm->mirrors_sem);
> +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
> +		list_del_init(&mirror->list);
> +		if (mirror->ops->release)
> +			mirror->ops->release(mirror);

Hi Jerome,

This presents a deadlock problem (details below). As for solution ideas, 
Mark Hairgrove points out that the MMU notifiers had to solve the
same sort of problem, and part of the solution involves "avoid
holding locks when issuing these callbacks". That's not an entire 
solution description, of course, but it seems like a good start.

Anyway, for the deadlock problem:

Each of these ->release callbacks potentially has to wait for the 
hmm_invalidate_range() callbacks to finish. That is not shown in any
code directly, but it's because: when a device driver is processing 
the above ->release callback, it has to allow any in-progress operations 
to finish up (as specified clearly in your comment documentation above). 

Some of those operations will invariably need to do things that result 
in page invalidations, thus triggering the hmm_invalidate_range() callback.
Then, the hmm_invalidate_range() callback tries to acquire the same 
hmm->mirrors_sem lock, thus leading to deadlock:

hmm_invalidate_range():
// ...
	down_read(&hmm->mirrors_sem);
	list_for_each_entry(mirror, &hmm->mirrors, list)
		mirror->ops->sync_cpu_device_pagetables(mirror, action,
							start, end);
	up_read(&hmm->mirrors_sem);

thanks,
--
John Hubbard
NVIDIA
