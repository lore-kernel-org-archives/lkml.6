Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2958128-1525996507-2-2696405356338202677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525996507; b=dwMaoCqMnTjgq0WLtkuvVY5Wr8RbicaxUS+y8c7/Bl4kUyz2fP
    /wXQo0LFsZgVBrauwuN5Xzp6S8LGiFJH7ilrOZaAEJQk0tcsUTa2LjOB6/WN26xP
    sQ7tbI5SL0o/UDZMWwq9oRGL5Dx9TNG0GtbNIdl/p739lkPoUnQl0dbuF1D1t+H3
    hvRnXWA6w4jToAGUviNlbp4tB2R35Z3u4kNieU5Hnx89o+SBMho1MhFuXap+46Nr
    9Seb0KIvgFWxHofK7zYtiVYa3MxadQMXMmrDEg8KQd2NPbN3N/yslhoxjfjk6FHf
    cRXuV2fH2IXmGO3ci0VMMwvdDTLKf6HGcgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525996507;
    bh=LdGLLdUsWqybEfYmUa25B5F9LSlRkoBIa1ayZ01SrGA=; b=mBw5qCTnqunA
    VWG2l/O2DU2/UkfThTzJk7IA5iEaMA4RMI90EPFygePtCo09/Bh1GqkNTpqfCEth
    BRQkwXwJGbGZqY4lrH7IdOwHCQIF58H9taF7OfcZwkO41xI+/R1xRCyVDuRS7QOP
    +tVxeyKtPvSlaPoII0EANZEmbT6N0dMWlu6QjctdeZG4trdm0YBe9SneeGHLKx0H
    4VyWgWYojVe3wtETwcbFqGJoD54+R3JEVOR7oEusCj1m8ff1Zb+DY02mvSLtjVaP
    WUPL3CTheUN5FnLApxDSE4t0GY8Z2C3q78iOL5MrMCmxDIcWjB1qej/SraVQpzm+
    jqI3bfAJ1A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GPIGu9ei x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=I65kUZxH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GPIGu9ei x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=I65kUZxH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCDIO99vkEgyLqI9hb05q0SniUxnnGspRMCgOSyI4/VsxZL9A9kBOhdbKwgQtK7E1RSQiEQY5WYOuCe6iXUNlHpNrM2IBmoHwTotTBCJe0tEuYiCYCCw
    MPGbiyr437eWKAvGPBKIcaN+5FONH2JmdGE/Cpvefc/PbwANmf5eWnupccCYZJS9Ds4PVWDzcnYZliC4ucIcDckF/poDaNIOwDJ8fgwBF/pBo5naVIUsD3PO
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hSkVLCK3AAAA:8 a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=zn3KHpepHgQkCt9puiUA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=zvYvwCWiE4KgVXXeO06c:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750806AbeEJXyw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 19:54:52 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34866 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeEJXyt (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 10 May 2018 19:54:49 -0400
X-Google-Smtp-Source: AB8JxZpS42GYU39HDM56UqXqUdf9A+TEDis+mD/yz540qFLgjWyEPyVIcToGAzCBKFHapx/r3zQXlg==
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
To: Roman Kagan <rkagan@virtuozzo.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Cc: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        x86@kernel.org, Cathy Avery <cavery@redhat.com>,
        stable <stable@vger.kernel.org>
References: <20180510191634.18796-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <52bd5b0b-a4bb-5426-3c92-edd7085faea3@redhat.com>
Date: Fri, 11 May 2018 01:54:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510191634.18796-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 10/05/2018 21:16, Roman Kagan wrote:
> If an IDR contains a single entry at index==0, the underlying radix tree
> has a single item in its root node, in which case
> __radix_tree_lookup(index!=0) doesn't set its *@nodep argument (in
> addition to returning NULL).
> 
> However, the tree itself is not empty, i.e. the tree root doesn't have
> IDR_FREE tag.
> 
> As a result, on an attempt to remove an index!=0 entry from such an IDR,
> radix_tree_delete_item doesn't return early and calls
> __radix_tree_delete with invalid parameters which are then dereferenced.
> 
> Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  lib/radix-tree.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/radix-tree.c b/lib/radix-tree.c
> index da9e10c827df..10ff1bfae952 100644
> --- a/lib/radix-tree.c
> +++ b/lib/radix-tree.c
> @@ -2040,8 +2040,9 @@ void *radix_tree_delete_item(struct radix_tree_root *root,
>  	void *entry;
>  
>  	entry = __radix_tree_lookup(root, index, &node, &slot);
> -	if (!entry && (!is_idr(root) || node_tag_get(root, node, IDR_FREE,
> -						get_slot_offset(node, slot))))
> +	if (!entry && (!is_idr(root) || !node ||
> +		       node_tag_get(root, node, IDR_FREE,
> +				    get_slot_offset(node, slot))))
>  		return NULL;
>  
>  	if (item && entry != item)
> 

I cannot really vouch for the patch, but if it is correct it's
definitely stuff for stable.  The KVM testcase is only for 4.17-rc but
this is a really nasty bug in a core data structure.

Cc: stable@vger.kernel.org

Should radix-tree be compilable in userspace, so that we can add unit
tests for it?...

Paolo
