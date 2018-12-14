Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E545C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B7720892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="M3w/SqrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B7720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbeLNM0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:26:43 -0500
Received: from sonic311-21.consmr.mail.gq1.yahoo.com ([98.137.65.202]:39828
        "EHLO sonic311-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730449AbeLNM0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:26:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1544790399; bh=MvGm0pCZ7Sf8/dnaqLdLQsFvyOHUDsKr5vHwiTYpunk=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=M3w/SqrKty00/Pab4+5RAY1HY9Qbd7GLL0FWG0zsTZwcBA9DfAYma8StIMEk7zhRMHdXeL8SIbi2QQPNKX8QrCf6JT9Cis0hC7ZWVlAUTvG56mzcCAizouucpAySk/+qwlJV7t98K12h3tCUYseiy5SQOf87yRPZ8zZwbBmoh/IG9h8UBlfWvqPcKYhjbF3bA9nSI3T3RrxyS50xk3MbA+k5ytVh+phgIFDhURRhcai+0npEUNVgcodzBxHI66yksOx7/H++Qc/9H2lUXrrdbYVRb54AawINFpIzJb6u94kBY30f1lrE8KXpngdbiGNe6H+kfyKWy5pzZYqBBSSDYA==
X-YMail-OSG: uvX2gKoVM1mdyIt.yNw190e_Ritr6zV7EosKJVQ6yY2V1q3bQ7Y8zpkBrjor1Mb
 I4R3udUooYpUu9HcGIIQe3o6cWK4Z5VIHjAy8LqL6OxTDwnYy.WlcWAvIZfdf4tLETqsvJmnLP8l
 pfhpWsJOEz_RrZmIdWcbRyXO4ergM_deHtwXZqiLYEl9.NwjQ86yyG03HJemKJTCxJ8dLpUvW8Ko
 TnDb0UvlftAn9egFkLgTbuHEB2LzSUDPoEOlHp_LLX9HHxQxp2aD8OLPuQUlOUrGkF1Fcx8_HI9w
 GVpyvbILulHXSjr_TqRTeZvQ0EWwszGwgwt8eVwPmzdU7DKnfv3lis1FuKZhFV.xFn0lGOgxuSng
 c7LLCebWhRKh6fMhrMGT4w.Npad3ct9kPX0kc3UIg4ax7xf.vyG7VzY4DKOTuGp8wxMFA542cI6u
 ncRhK5BSXLH8zbpuhPa7D5bi_yH3ug1u8QE7m.8mrt0zUjhZ9jLRFXNg3SAnlw0kouny5rs_zdvm
 rdEaAgvi28uO4AMzsA1JsUMGxbsnr4r.toud.HyQpA7W2tnyx8aJ8cw6JqPgLhQM6iIqCrG4eS_v
 whx2PctB98jcUHsYC6.joD3gFjaGk9Tc3b_j_iHibgagqjoQYVTLVx3jzs_Kxm8l15Gx0rzwN9Ex
 R_QmWV3REJJR21c7cOwW2xxdEi781KstYmK4iyaWShMbM5b1592WIyhDqzgpJjI85WII1.3Ntlug
 4kSMijOvKjU6_x7OmjQOiQ8QiXRNMa1Sq9TYe5NcsobUBc2JqGkTtn2HFjMCPKOxqNBZaLiUeeFC
 QaQ_Jz9JiONJcJ8w41Gi3XhDE5.gBHqANdNPobBLVxftHYQumHAHeakLM4lRR8KIZcRSqW7M2YYk
 GkjEYLMiAKJJ9sT5GySO21icWGSaw4McmXswWqClvNe22mx_vnfKiBubCPshLgGEcQMvJngotOQ6
 gvbcbRmuj43GWY6dxGL.25f3Ou5mAdUzJFVZIWQO38cShQTpQTfd5mHi_ScgKqV0EMCgWACGH8DK
 L4hkbr7JwYk4JB5eud5x7vIPvXlG_0pvWfdEyviZH1twUUYAbrMSkobkZgQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Dec 2018 12:26:39 +0000
Received: from 125.120.80.114 (EHLO [10.1.1.220]) ([125.120.80.114])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b2ad19ee75ed59a223f036cbcd95ca4a;
          Fri, 14 Dec 2018 12:26:37 +0000 (UTC)
Subject: Re: [PATCH] fix page_count in ->iomap_migrate_page()
To:     Richard Weinberger <richard@nod.at>
Cc:     zhangjun <openzhangj@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>, hch@lst.de,
        bfoster@redhat.com, Dave Chinner <david@fromorbit.com>,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, n-horiguchi@ah.jp.nec.com,
        mgorman@techsingularity.net, aarcange@redhat.com,
        willy@infradead.org, linux@dominikbrodowski.net,
        linux-mm@kvack.org, Gao Xiang <gaoxiang25@huawei.com>
References: <1544766961-3492-1-git-send-email-openzhangj@gmail.com>
 <1618433.IpySj692Hd@blindfold>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <2b19b3c4-2bc4-15fa-15cc-27a13e5c7af1@aol.com>
Date:   Fri, 14 Dec 2018 20:26:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1618433.IpySj692Hd@blindfold>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On 2018/12/14 19:25, Richard Weinberger wrote:
> This is the third place which needs this workaround.
> UBIFS, F2FS, and now iomap.
> 
> I agree with Dave that nobody can assume that PG_private implies an additional
> page reference.
> But page migration does that. Including parts of the write back code.

It seems that it's clearly documented in
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/mm.h#n780

 * A pagecache page contains an opaque `private' member, which belongs to the
 * page's address_space. Usually, this is the address of a circular list of
 * the page's disk buffers. PG_private must be set to tell the VM to call
 * into the filesystem to release these pages.
 *
 * A page may belong to an inode's memory mapping. In this case, page->mapping
 * is the pointer to the inode, and page->index is the file offset of the page,
 * in units of PAGE_SIZE.
 *
 * If pagecache pages are not associated with an inode, they are said to be
 * anonymous pages. These may become associated with the swapcache, and in that
 * case PG_swapcache is set, and page->private is an offset into the swapcache.
 *
 * In either case (swapcache or inode backed), the pagecache itself holds one
 * reference to the page. Setting PG_private should also increment the
 * refcount. The each user mapping also has a reference to the page.

and when I looked into that, I found
https://lore.kernel.org/lkml/3CB3CA93.D141680B@zip.com.au/


Thanks,
Gao Xiang
