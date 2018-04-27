Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3800878-1524812920-2-7969464314878161512
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812919; b=DnuGSP62FHv6AJ8vcw7G0mFs0lEOpmHcTW89HSCtwyOtTCqyH0
    xShX+PTTVajvKIKdWyGTih3726AzXzt/H+wtR12qevWq+wbsHZxeurR3QLj2gqZN
    eqdL8+vrNRgz4RVwmeh+0n2iD6CLQK5G4xfUGKxl0lZu+38p6Dg00q+5DC6523i2
    fegOwYKwdjsFPBa9nDqlkjjb51z9cQbmpJ+boBx1zL8tMOEW6D1cobGItIZHXM0h
    UuIOudrLyZuccDUvYkPDrabosWt/J+/PYvBXGWJgk6N59N/LEFvn0FTMJ0GlGpfI
    M2yEa4HzKuYSvMeRMzmfIPmBpUt008+CDmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812919; bh=YtwCHq/X7B8YwwGxAdyYwFbnGqliTs
    ho9LWgI6hzDMg=; b=Hwcm2D8douZI+gm7OewKtz0quhh+G18d8tBKmcHwfiGBD5
    oI3NYEwvL4jwPl09vhUPSXgshbEAF99p4jSnBg0ATqgPHbmtdQ4QYsMmvCWghA3f
    ztki6Pie32maAeQdfF84IeqeXxl+6RMt1ymyBe9gDknFrGEE6aunNuYtOVlV1P/s
    kIpQC61PFED75CJCy3ldOKSDRTh9VGsjb3l+OMnwk3QBWV94+Xg2KxX7wEU1QdMv
    g2dYkLVrmokYxhKTH+Gos1LEY8j/AJ8LbRKQFzVfUhxnA6F7vteJHMdoSbFy/ZK0
    iCuF9EyqqPCY7NMXmYdrqQkX55dWlFo2pi66nMvw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD8JcyPHuKMo8+6KaUMR9KU8ohha6muSFv45r6iSMBu3+3Da0ZL7Q4wtfchCXAs/bA00m2mN7OwfNl88pzskiHqt3zjB/4h6UWrTlP+1sJbf3YGJZP5Q
    Kp8MrBZhXuk/Y2In2i+KH2E9HmuB+0GhByORgQGQCNxn7zUeTAv9ywCBfZYk4iozVgK+MfR2UAY0Ixc+J6+sS1lbV1nZniSHwYRCRuFT3yCfld1n1asrsQFH
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=iox4zFpeAAAA:8 a=KpxBfPu5LOzXpxnn_V0A:9
    a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757406AbeD0HIi (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 03:08:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:36522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757367AbeD0HIh (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 03:08:37 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4DE021864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 09:08:28 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        linux-kernel@vger.kernel.org, mhocko@suse.com, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm: sections are not offlined during memory hotremove
Message-ID: <20180427070828.GC4931@kroah.com>
References: <20180426203002.3151-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426203002.3151-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 04:30:02PM -0400, Pavel Tatashin wrote:
> Memory hotplug, and hotremove operate with per-block granularity. If
> machine has large amount of memory (more than 64G), the size of memory
> block can span multiple sections. By mistake, during hotremove we set
> only the first section to offline state.
> 
> The bug was discovered because kernel selftest started to fail:
> https://lkml.kernel.org/r/20180423011247.GK5563@yexl-desktop
> 
> After commit, "mm/memory_hotplug: optimize probe routine". But, the bug is
> older than this commit. In this optimization we also added a check for
> sections to be in a proper state during hotplug operation.
> 
> Fixes: 2d070eab2e82 ("mm: consider zone which is not fully populated to have holes")
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/sparse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 62eef264a7bd..73dc2fcc0eab 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -629,7 +629,7 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
>  	unsigned long pfn;
>  
>  	for (pfn = start_pfn; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		unsigned long section_nr = pfn_to_section_nr(start_pfn);
> +		unsigned long section_nr = pfn_to_section_nr(pfn);
>  		struct mem_section *ms;
>  
>  		/*
> -- 
> 2.17.0

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
