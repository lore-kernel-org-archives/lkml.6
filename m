Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3888539-1527685487-2-6338195324675551100
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527685487; b=VzWlSqg/SUFAe3AfJuNcyW1/6HKkd8X/YAy4u7Tqs4QSUFXPyC
    IDQsthSZ0aa34ozRaekJJTZvQO1Wk0FXco3frfnxgFud4vMNY/Vz2MvOI6e1xmFh
    esoeUId3iAeat8EXCAuqr0GmQCK6yEPzBsSkpJWMTb3EFssQG3AIvLJehpQYavy/
    fPQ2y8RFzKC0HiWfx6dxdd9yoDFlaHzgNdj4sE18GzJET7kdbLfpymDx2knYOUo7
    SuFXxPClps5UIwQKC5rI42amzDFt8h4A/kKrt0XkWcpI9J89Mtl86Q+86yK/XI/m
    1PpvbPCT5HZkdCE2DOYp1Ctj0VTibGF2q0Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527685487; bh=8Iwa8s37848zixIAfOeXmPo+krk2hD
    kNzFnMyouJHic=; b=mELrRh5TVXA/qPOznJtMkrEKLGA/WHGG48h9bdP4Q7zopF
    1DHd+Hq/YRuwKRb/vFU44HVU2YpBm2Fz1oSk85iXVN8X+yj5qgMloFXfWT5kKwDW
    56fX2SsfpbcEf2SDlT/yqMF+5cpZWhK1TrYZEO7KY8WTiyRjGR141tWwRaTBSoU7
    eJHrCgJnP+c2gkHpYLctkeCc3jARH1B0ffI45/wAuWMqQwo9MECaejOU9NkhJht9
    y5pTRnYoFwXNRukdzjfuX9EuinyJaEMzXxt/7Aa4Ies7JuVqBUA/Nnpm5J7F/FQ/
    LILshMs/0QMEPNsVsYk8ZS6x27FLzLyY4XI+k7Ww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=cmpxchg.org header.i=@cmpxchg.org header.b=r8MTXIJc
    header.a=rsa-sha256 header.s=x x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=cmpxchg.org header.mx.error=NOERROR
    header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=cmpxchg.org header.i=@cmpxchg.org header.b=r8MTXIJc
      header.a=rsa-sha256 header.s=x x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=cmpxchg.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=cmpxchg.org header.mx.error=NOERROR
      header.aaaa.error=NOERROR header.result=warn header_is_org_domain=yes;
    x-vs=clean score=-50 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB2zpcLgiItfkVNUXPyShQtyp6Nw+lBC4d0xYXdsoJXHPkmfrPobhDk/tfzUOGREH+9WjGF2VkF9N8Nacj1rJHChh8g+4hMXvpXJwhE9GIavopW1uyt3
    6iReTk3Sp8hIG8MFvn0XHp25eLpKcj/H77456R+9Vd+iu1X/wjUOgwDFGjlSEeqcKyrUXwONUyJIR/r+curBtm4Ae1u147oF2+m2onolT5n3ApDmn60175So
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=TyDLVL3RFDhfg0z3Sv8A:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=i3VuKzQdj-NEYjvDI-p3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752300AbeE3NEn (ORCPT <rfc822;linux@kroah.com>);
        Wed, 30 May 2018 09:04:43 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:52740 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751771AbeE3NEl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 May 2018 09:04:41 -0400
Date: Wed, 30 May 2018 09:06:48 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: axboe@kernel.dk, kernel-team@fb.com, linux-block@vger.kernel.org,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 05/13] swap,blkcg: issue swap io with the appropriate
 context
Message-ID: <20180530130648.GA4035@cmpxchg.org>
References: <20180529211724.4531-1-josef@toxicpanda.com>
 <20180529211724.4531-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180529211724.4531-6-josef@toxicpanda.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 29, 2018 at 05:17:16PM -0400, Josef Bacik wrote:
> From: Tejun Heo <tj@kernel.org>
> 
> For backcharging we need to know who the page belongs to when swapping
> it out.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Josef Bacik <jbacik@fb.com>
> ---
>  mm/page_io.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/page_io.c b/mm/page_io.c
> index a552cb37e220..61e1268e5dbc 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -339,6 +339,16 @@ int __swap_writepage(struct page *page, struct writeback_control *wbc,
>  		goto out;
>  	}
>  	bio->bi_opf = REQ_OP_WRITE | REQ_SWAP | wbc_to_write_flags(wbc);
> +#if defined(CONFIG_MEMCG) && defined(CONFIG_BLK_CGROUP)
> +	if (page->mem_cgroup) {
> +		struct cgroup_subsys_state *blkcg_css;
> +
> +		blkcg_css = cgroup_get_e_css(page->mem_cgroup->css.cgroup,
> +					     &io_cgrp_subsys);
> +		bio_associate_blkcg(bio, blkcg_css);
> +		css_put(blkcg_css);
> +	}
> +#endif

This looks reasonable, but it probably warrants a helper function.

bio_associate_blkcg_from_page() or something?
