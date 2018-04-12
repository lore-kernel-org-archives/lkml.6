Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1582956-1523557989-2-7992694685006823302
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523557989; b=P/GjxfypICEcgLZkcoqGXQiHN6ZSUZGnAVQti1/c+NgMa9oNm5
    udk+bBpnK1lM7gCoTk57UhYk2BXujshcyhjXX7akatnlAh2q9j8/Lc9z6vwjp0uV
    58lFzgDxP9HVSl9R+tM3tt7/2u2+eKCP/r4hLNEVYbRty8OiR/TqFrg/s7zKPBPs
    krjFRIjztKaz3/9B6NDaMcMgqDw0fk8EWTPpyQqWebtaPGMO7HVQ+YXCeNEUDpkZ
    K9+slL9I0aNI6YrK1BaTc3dMvUn1I2/8T/DxSBXQeDoI48prtBKLPkLA8m9ST22h
    VyQiwgGcK+VETGrXKMGUJYSO2WRi8YDj5j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523557989;
    bh=LKqOEnzHD4kXQtxMH+/VpMR+EdH7/biUeUbh8WOollw=; b=WUsOJXyeES4E
    RSQCHhSYzPNakMKIkPzQyfzt/SlkqDDX7SDWHwqnHlCaNkFo62MgoEBA9yMSgHTD
    LVwA9rxetMVQGDavtiBtvZv1l9Jmfvn4bMJuWv6VZkcz1m89urRLDP63Rvsbcl6n
    buP9F3IqMiNIBdEtZadC/ij8jgaFvFtxdNJ3irVbmDx+WcCI0vVOwmP7Y4eW8wV9
    W/oyypcOO6DBHuS8tYBrh+8cQsxqwiltSCv14LRihBqOBfeUQ4LJuVnU/eGY5c9f
    cRPpmOuo3djp44P3v/7xabbBnZcMthei3El/0NZXwnEePXx5M6vS4oVjGzHIaDN1
    bmBuQbBRwA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nvidia.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nvidia.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEQcH9KFiI1D1QVe0Vikl9TD7SW0j805Xi3V3PodmeXmdkJ4ocTj4GPKVd/2p3Cqq9drHN2oeSe7+AolQVZAOlfB+le6zKm4heHF15BbfEXj8fQYz40U
    6b8X1Oa506mX9RW7ILp7Ee6S36wnQg40LShdYRLLjsU+Br+ojSrM/KUZZfr0e8THnP0uOCS1ie0msICiPbdUjj3Aqs3B1rgZxnHmrFcVbr69PcIh91ZJShgJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=rbY5Hf1s5mkA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=1XWaLZrsAAAA:8 a=Sg8HuZxHAAAA:8 a=VwQbUJbxAAAA:8
    a=pxlqBnYyDwo_cV-wHpAA:9 a=jJnb9CZ88NC2fvYu:21 a=_ZlHVqWTYsnFDMRu:21
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=JFlNBosjgyz61O-hmi61:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753270AbeDLSdH (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 14:33:07 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12558 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbeDLSdH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 14:33:07 -0400
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 12 Apr 2018 11:32:56 -0700
Subject: Re: [PATCH] mmap.2: MAP_FIXED is okay if the address range has been
 reserved
To: Jann Horn <jannh@google.com>, <mtk.manpages@gmail.com>,
        <linux-man@vger.kernel.org>, <mhocko@kernel.org>,
        <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>
References: <20180412153941.170849-1-jannh@google.com>
X-Nvconfidentiality: public
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <b617740b-fd07-e248-2ba0-9e99b0240594@nvidia.com>
Date: Thu, 12 Apr 2018 11:33:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180412153941.170849-1-jannh@google.com>
X-Originating-IP: [10.110.48.28]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 08:39 AM, Jann Horn wrote:
> Clarify that MAP_FIXED is appropriate if the specified address range has
> been reserved using an existing mapping, but shouldn't be used otherwise.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  man2/mmap.2 | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/man2/mmap.2 b/man2/mmap.2
> index bef8b4432..80c9ec285 100644
> --- a/man2/mmap.2
> +++ b/man2/mmap.2
> @@ -253,8 +253,9 @@ Software that aspires to be portable should use this option with care,
>  keeping in mind that the exact layout of a process's memory mappings
>  is allowed to change significantly between kernel versions,
>  C library versions, and operating system releases.
> -Furthermore, this option is extremely hazardous (when used on its own),
> -because it forcibly removes preexisting mappings,
> +This option should only be used when the specified memory region has
> +already been reserved using another mapping; otherwise, it is extremely
> +hazardous because it forcibly removes preexisting mappings,
>  making it easy for a multithreaded process to corrupt its own address space.

Yes, that's clearer and provides more information than before.

>  .IP
>  For example, suppose that thread A looks through
> @@ -284,13 +285,15 @@ and the PAM libraries
>  .UR http://www.linux-pam.org
>  .UE .
>  .IP
> -Newer kernels
> -(Linux 4.17 and later) have a
> +For cases in which the specified memory region has not been reserved using an
> +existing mapping, newer kernels (Linux 4.17 and later) provide an option
>  .B MAP_FIXED_NOREPLACE
> -option that avoids the corruption problem; if available,
> -.B MAP_FIXED_NOREPLACE
> -should be preferred over
> -.BR MAP_FIXED .
> +that should be used instead; older kernels require the caller to use
> +.I addr
> +as a hint (without
> +.BR MAP_FIXED )

Here, I got lost: the sentence suddenly jumps into explaining non-MAP_FIXED
behavior, in the MAP_FIXED section. Maybe if you break up the sentence, and
possibly omit non-MAP_FIXED discussion, it will help. 

> +and take appropriate action if the kernel places the new mapping at a
> +different address.
>  .TP
>  .BR MAP_FIXED_NOREPLACE " (since Linux 4.17)"
>  .\" commit a4ff8e8620d3f4f50ac4b41e8067b7d395056843
> 

thanks,
-- 
John Hubbard
NVIDIA
