Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-333182-1521122909-2-2641764827183275964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='gbk'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521122909; b=YwrXOYHlgltPcdfeZzmO1KWrwBbod8SmpwDO3vp84Ih5key
    nUdXcSS19rV2k+aBAazoU3iHo3l+q5Bwq0HJfRf4vwXdIrIuzYs65XoH81RMa4We
    AMHYYPT5k4yNDFfjHoOZkVQWyg45f8wPYWU4M/399avP3DfXSF0VHRr7gQFF7SKU
    zK5UwyUXiXlqV/MZlH7jrzjtA817EKDu/ccXEKtRzez7tUQ9UUdjvruo1dzCuLZG
    5HQuyBIsalnnunRS6lVZy06g1W24PeItqMsfjYs0edHPeX79F9QlRLlWmmwIJC5X
    Gu1dO5JdUxATnAoFajmvyleNdIXfqruxJNj6Rfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521122909; bh=jPPoUOCZHkGZ2ofFqZZzXJjYdJPCD9SyCuH/Rybxvyw=; b=D
    73/CvbsBMvKDUggR68sr4mZCx5uJe4+nZyljaqsCHw4548ZTFv/UMfbjrGec75/9
    dJqhfZul0/Mjsd7a3dtfVwrmlHGnDyLyfkX5oNiyjmVJWcAeeksHbV617jz9Dv0L
    IuaqmKclkcYZnMYssbs8aB+ZV9w6h/F98Tw3Gwt/qGhYq3uBRQ3tjbwV2a0G6Lri
    km4gbD1V8Yw/ll2xIMp0AzvxIRS8hzMAPfFiGPggUqlEtS2wv1TkC0JosG96+Od/
    3u5fO3JKo90sZG1VBEtBhb9yM4NrFI9n0+ZloJ05v4A/c4C3ZtvcDGn09sTHLgsI
    KXzw/lJYqHjJ7ZZxf94iQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fyfKeWBR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J8mpc11M;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fyfKeWBR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=J8mpc11M;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCOOI0 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 10:08:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41570 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeCOOIZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 10:08:25 -0400
X-Google-Smtp-Source: AG47ELsPS7s4H3ArKYgkl12rg7k1+YOl5iLx7UjINmd9Kbu1exqRd2J1sevEz4eX1QpWkKXW9KS9pg==
Subject: Re: [PATCH] mm/page_alloc: fix boot hang in memmap_init_zone
To: Daniel Vacek <neelx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, stable@vger.kernel.org,
        ard.biesheuvel@linaro.org
References: <20180313224240.25295-1-neelx@redhat.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <049a38e2-c446-85f4-656c-91d4e5bb1c0d@gmail.com>
Date: Thu, 15 Mar 2018 22:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313224240.25295-1-neelx@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel


On 3/14/2018 6:42 AM, Daniel Vacek Wrote:
> On some architectures (reported on arm64) commit 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> causes a boot hang. This patch fixes the hang making sure the alignment
> never steps back.
>
> Link: http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
> Fixes: 864b75f9d6b01 ("mm/page_alloc: fix memmap_init_zone pageblock alignment")
> Signed-off-by: Daniel Vacek <neelx@redhat.com>
> Tested-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Paul Burton <paul.burton@imgtec.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: <stable@vger.kernel.org>
> ---
>   mm/page_alloc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3d974cb2a1a1..e033a6895c6f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5364,9 +5364,14 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>   			 * is not. move_freepages_block() can shift ahead of
>   			 * the valid region but still depends on correct page
>   			 * metadata.
> +			 * Also make sure we never step back.
>   			 */
> -			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
> +			unsigned long next_pfn;
> +
> +			next_pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
>   					~(pageblock_nr_pages-1)) - 1;
> +			if (next_pfn > pfn)
> +				pfn = next_pfn;
It didn't resolve the booting hang issue in my arm64 server.
what if memblock_next_valid_pfn(pfn, end_pfn) is 32 and 
pageblock_nr_pages is 8196?
Thus, next_pfn will be (unsigned long)-1 and be larger than pfn.
So still there is an infinite loop here.

Cheers,
Jia He
>   #endif
>   			continue;
>   		}

-- 
Cheers,
Jia
