Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78C4ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB732083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 07:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="kWw4mQxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB732083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbeJYP4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 11:56:04 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36066 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbeJYP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 11:56:03 -0400
Received: by mail-pf1-f196.google.com with SMTP id l81-v6so3748411pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 00:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kEW3QRaFz8wPdxOzpYGOvSXHFYSW8YxHf/HfAlf084w=;
        b=kWw4mQxI6qzTeZHthQtOYUeuKCULroMaKoAcfko1y+Byzd4/Aw1DhW3Xm4tZW59/a5
         j/pT1kKGwaPpMs1+fI9NlFGtjUal7k9LshlgoJg1dwQeu3aXZztMGwd077VlhEOhGygH
         gkfa4EqP9KS+rtrrispYgL/azY0X6soO20pdD4Ls8ZkcV6XCaAsoMqEptWkv8auA3VRp
         79P+wzv9MwZvR0MG/hHNIikFcAwqP5LdkUaUMVeUpcm38bvl6O5VQqfNSkKoJPAuW2o0
         wu40AIHwtkBC7PJLT/jbr3q5+n0HP486XjCeXzf6Y1KBvXDmHjmcIobqwnbrKWuHP6Xr
         +UfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kEW3QRaFz8wPdxOzpYGOvSXHFYSW8YxHf/HfAlf084w=;
        b=TPNVHIPlcR9BHY8+US4qRAS0z6+ubDjLfY7b/eVyXvI23LGyyva45dTOlrXDT+QqDC
         tOl+pda46zn6GEcGRwKS6WoknG7YQuh2iYf4qnxfX0wQaaqZE1BimmZkO7dkdO/oICIY
         3zY0SzcnXDbd8y2ZaJj9wJocaoVN33g93dRrfai0+Fj6QYJGBXekuY6a1CRQK1RlXnMr
         3EOLwS1UF0gPyRejWtGak6i3u6xxU8JHgb41Myo0118NCPEY2Djfa47oujV5b7E0fs3N
         r4bozqjbTFIzWOEXbg83f8le+kSgjKgyz3rKm4WPQABByJnEqItkiD4RxenzHRLv8W5V
         kKIg==
X-Gm-Message-State: AGRZ1gLb5psJ7XX11ztZJf/h7MJGKTpyFutHo5DOZ/yvRc+ltjnWihK7
        LMyxVjYazKBMdkZrrezdI2LfQA==
X-Google-Smtp-Source: AJdET5eyfUJ5bUP50BTXzMT72EO9hWiTDotH+fCcDmWiIfd68g0wKMfcXGX4UISeTFsD7450uJOwoQ==
X-Received: by 2002:a62:5a47:: with SMTP id o68-v6mr443152pfb.31.1540452274313;
        Thu, 25 Oct 2018 00:24:34 -0700 (PDT)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id 11-v6sm9067936pfs.108.2018.10.25.00.24.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 00:24:33 -0700 (PDT)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 97D16300225; Thu, 25 Oct 2018 10:24:29 +0300 (+03)
Date:   Thu, 25 Oct 2018 10:24:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Baoquan He <bhe@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, willy@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/2] x86/mm: Move LDT remap out of KASLR region on
 5-level paging
Message-ID: <20181025072429.k54aem37sefqonqy@kshutemo-mobl1>
References: <20181024125112.55999-1-kirill.shutemov@linux.intel.com>
 <20181024125112.55999-2-kirill.shutemov@linux.intel.com>
 <20181025021809.GB2120@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025021809.GB2120@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:18:09AM +0800, Baoquan He wrote:
> > We don't touch 4 pgd slot gap just before the direct mapping reserved
> > for a hypervisor, but move direct mapping by one slot instead.
> > 
> > The LDT mapping is per-mm, so we cannot move it into P4D page table next
> > to CPU_ENTRY_AREA without complicating PGD table allocation for 5-level
> > paging.
> 
> Here as discussed in private thread, at the first place you also agreed
> to put it in p4d entry next to CPU_ENTRY_AREA, but finally you changd
> mind, there must be some reasons when you implemented and investigated
> further to find out. Could you please say more about how it will
> complicating PGD table allocation for 5-level paging? Or give an use
> case where it will complicate?

On 5-level machine all memory starting from CPU_ENTRY_AREA (and part of
KASAN memory) is in the same P4D page table. All this memory is shared
across all processes, we just copy PGD entry -- all proceses point to the
same P4D page table. (I leave out PTI from the picture for simplicity.)

LDT is per-mm. If we would place it next to CPU_ENTRY_AREA we would need
to unshare P4D page table and create a new one on each fork and copy P4D
entries.

It's considerably more complex and would affect processes that never use
modify_ldt() at all.

Other option would be to move LDT remap *to* KASLR region for both paging
modes and make KALSR code aware about it: randomize it as we do for page
offset, vmalloc, vmap. It's probably better long term, but it's more
complex and I wanted to get backportable fix.

-- 
 Kirill A. Shutemov
