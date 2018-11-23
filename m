Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63D8C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0CB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 13:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0CB206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439838AbeKXAb0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 19:31:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:45160 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390880AbeKXAb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 19:31:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E3C44AF93;
        Fri, 23 Nov 2018 13:47:07 +0000 (UTC)
Subject: Re: [RFC PATCH 1/3] mm, proc: be more verbose about unstable VMA
 flags in /proc/<pid>/smaps
To:     Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        David Rientjes <rientjes@google.com>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-2-mhocko@kernel.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSFWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmNvbT7CwZcEEwEKAEECGwMFCwkIBwMFFQoJCAsFFgIDAQAC
 HgECF4ACGQEWIQSpQNQ0mSwujpkQPVAiT6fnzIKmZAUCWi/zTwUJBbOLuQAKCRAiT6fnzIKm
 ZIpED/4jRN/6LKZZIT4R2xoou0nJkBGVA3nfb+mUMgi3uwn/zC+o6jjc3ShmP0LQ0cdeuSt/
 t2ytstnuARTFVqZT4/IYzZgBsLM8ODFY5vGfPw00tsZMIfFuVPQX3xs0XgLEHw7/1ZCVyJVr
 mTzYmV3JruwhMdUvIzwoZ/LXjPiEx1MRdUQYHAWwUfsl8lUZeu2QShL3KubR1eH6lUWN2M7t
 VcokLsnGg4LTajZzZfq2NqCKEQMY3JkAmOu/ooPTrfHCJYMF/5dpi8YF1CkQF/PVbnYbPUuh
 dRM0m3NzPtn5DdyfFltJ7fobGR039+zoCo6dFF9fPltwcyLlt1gaItfX5yNbOjX3aJSHY2Vc
 A5T+XAVC2sCwj0lHvgGDz/dTsMM9Ob/6rRJANlJPRWGYk3WVWnbgW8UejCWtn1FkiY/L/4qJ
 UsqkId8NkkVdVAenCcHQmOGjRQYTpe6Cf4aQ4HGNDeWEm3H8Uq9vmHhXXcPLkxBLRbGDSHyq
 vUBVaK+dAwAsXn/5PlGxw1cWtur1ep7RDgG3vVQDhIOpAXAg6HULjcbWpBEFaoH720oyGmO5
 kV+yHciYO3nPzz/CZJzP5Ki7Q1zqBb/U6gib2at5Ycvews+vTueYO+rOb9sfD8BFTK386LUK
 uce7E38owtgo/V2GV4LMWqVOy1xtCB6OAUfnGDU2EM7ATQRbGTU1AQgAn0H6UrFiWcovkh6E
 XVcl+SeqyO6JHOPm+e9Wu0Vw+VIUvXZVUVVQLa1PQDUi6j00ChlcR66g9/V0sPIcSutacPKf
 dKYOBvzd4rlhL8rfrdEsQw5ApZxrA8kYZVMhFmBRKAa6wos25moTlMKpCWzTH84+WO5+ziCT
 sTUZASAToz3RdunTD+vQcHj0GqNTPAHK63sfbAB2I0BslZkXkY1RLb/YhuA6E7JyEd2pilZO
 rIuBGl/5q2qSakgnAVFWFBR/DO27JuAksYnq+aH8vI0xGvwn75KqSk4UzAkDzWSmO4ZHuahK
 tQgZNsMYV+PGayRBX9b9zbldzopoLBdqHc4njQARAQABwsF8BBgBCgAmFiEEqUDUNJksLo6Z
 ED1QIk+n58yCpmQFAlsZNTUCGwwFCQPCZwAACgkQIk+n58yCpmQ83g/9Frg1sRMdGPn98zV+
 O2eC3h0p5f/oxxQ8MhG5znwHoW4JDG2TuxfcQuz7X7Dd5JWscjlw4VFJ2DD+IrDAGLHwPhCr
 RyfKalnrbYokvbClM9EuU1oUuh7k+Sg5ECNXEsamW9AiWGCaKWNDdHre3Lf4xl+RJWxghOVW
 RiUdpLA/a3yDvJNVr6rxkDHQ1P24ZZz/VKDyP+6g8aty2aWEU0YFNjI+rqYZb2OppDx6fdma
 YnLDcIfDFnkVlDmpznnGCyEqLLyMS3GH52AH13zMT9L9QYgT303+r6QQpKBIxAwn8Jg8dAlV
 OLhgeHXKr+pOQdFf6iu2sXlUR4MkO/5KWM1K0jFR2ug8Pb3aKOhowVMBT64G0TXhQ/kX4tZ2
 ZF0QZLUCHU3Cigvbu4AWWVMNDEOGD/4sn9OoHxm6J04jLUHFUpFKDcjab4NRNWoHLsuLGjve
 Gdbr2RKO2oJ5qZj81K7os0/5vTAA4qHDP2EETAQcunTn6aPlkUnJ8aw6I1Rwyg7/XsU7gQHF
 IM/cUMuWWm7OUUPtJeR8loxZiZciU7SMvN1/B9ycPMFs/A6EEzyG+2zKryWry8k7G/pcPrFx
 O2PkDPy3YmN1RfpIX2HEmnCEFTTCsKgYORangFu/qOcXvM83N+2viXxG4mjLAMiIml1o2lKV
 cqmP8roqufIAj+Ohhzs=
Message-ID: <28689fcd-fd57-6a1a-6ae1-a860c77842f8@suse.cz>
Date:   Fri, 23 Nov 2018 14:47:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181120103515.25280-2-mhocko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/20/18 11:35 AM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> Even though vma flags exported via /proc/<pid>/smaps are explicitly
> documented to be not guaranteed for future compatibility the warning
> doesn't go far enough because it doesn't mention semantic changes to
> those flags. And they are important as well because these flags are
> a deep implementation internal to the MM code and the semantic might
> change at any time.
> 
> Let's consider two recent examples:
> http://lkml.kernel.org/r/20181002100531.GC4135@quack2.suse.cz
> : commit e1fb4a086495 "dax: remove VM_MIXEDMAP for fsdax and device dax" has
> : removed VM_MIXEDMAP flag from DAX VMAs. Now our testing shows that in the
> : mean time certain customer of ours started poking into /proc/<pid>/smaps
> : and looks at VMA flags there and if VM_MIXEDMAP is missing among the VMA
> : flags, the application just fails to start complaining that DAX support is
> : missing in the kernel.
> 
> http://lkml.kernel.org/r/alpine.DEB.2.21.1809241054050.224429@chino.kir.corp.google.com
> : Commit 1860033237d4 ("mm: make PR_SET_THP_DISABLE immediately active")
> : introduced a regression in that userspace cannot always determine the set
> : of vmas where thp is ineligible.
> : Userspace relies on the "nh" flag being emitted as part of /proc/pid/smaps
> : to determine if a vma is eligible to be backed by hugepages.
> : Previous to this commit, prctl(PR_SET_THP_DISABLE, 1) would cause thp to
> : be disabled and emit "nh" as a flag for the corresponding vmas as part of
> : /proc/pid/smaps.  After the commit, thp is disabled by means of an mm
> : flag and "nh" is not emitted.
> : This causes smaps parsing libraries to assume a vma is eligible for thp
> : and ends up puzzling the user on why its memory is not backed by thp.
> 
> In both cases userspace was relying on a semantic of a specific VMA
> flag. The primary reason why that happened is a lack of a proper
> internface. While this has been worked on and it will be fixed properly,
> it seems that our wording could see some refinement and be more vocal
> about semantic aspect of these flags as well.
> 
> Cc: Jan Kara <jack@suse.cz>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Agreed, although no amount of docs will override the
do-not-break-userspace rule I'm afraid :)

Acked-by: Vlastimil Babka <vbabka@suse.cz>

On top of typos reported by Mike:

> ---
>  Documentation/filesystems/proc.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 12a5e6e693b6..b1fda309f067 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -496,7 +496,9 @@ flags associated with the particular virtual memory area in two letter encoded
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
>  be present in all further kernel releases. Things get changed, the flags may
> -be vanished or the reverse -- new added.
> +be vanished or the reverse -- new added. Interpretatation of their meaning

                                            ^ interpretation

> +might change in future as well. So each consumnent of these flags have to
> +follow each specific kernel version for the exact semantic.
>  
>  This file is only present if the CONFIG_MMU kernel configuration option is
>  enabled.
> 

