Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE72CC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A244204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547488955;
	bh=GF1jJwfkpV96SWQQk2Kd2rYlek5ghsTdniIzi/zlv5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O/wkBg9cSy2dxVXTlT3t4tzFRPNhetnfXVvd5h2+BEn0gWHnWW4u6oYKwY5maABjJ
	 dYu2/CXNdwvJSL4CsMf4DmJaPrpMj9HXRsc6+VtNdjSsyN8LYKg+5eK46AqRhNFT//
	 pxfOxIh+YPZpl/ZvIgUyTUAPCrdnk1sVunc5NM3E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfANSCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:02:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:37036 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726643AbfANSCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:02:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3B830AE7A;
        Mon, 14 Jan 2019 18:02:32 +0000 (UTC)
Date:   Mon, 14 Jan 2019 19:02:30 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Toshi Kani <toshi.kani@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH] mm: align anon mmap for THP
Message-ID: <20190114180230.GN21345@dhcp22.suse.cz>
References: <20190111201003.19755-1-mike.kravetz@oracle.com>
 <20190111215506.jmp2s5end2vlzhvb@black.fi.intel.com>
 <ebd57b51-117b-4a3d-21d9-fc0287f437d6@oracle.com>
 <20190114135001.w2wpql53zitellus@kshutemo-mobl1>
 <MWHPR06MB2896ACD09C21B2939959C8A8EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
 <20190114164004.GL21345@dhcp22.suse.cz>
 <MWHPR06MB289605B9E1B4234674CB87E2EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MWHPR06MB289605B9E1B4234674CB87E2EE800@MWHPR06MB2896.namprd06.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 14-01-19 16:54:02, Harrosh, Boaz wrote:
> Michal Hocko <mhocko@kernel.org> wrote:
[...]
> >> We run with our own compiled Kernel on various distros, THP is configured
> >> in but mmap against /dev/shm/ never gives me Huge pages. Does it only
> >> work with unanimous mmap ? (I think it is mount dependent which is not
> >> in the application control)
> >
> > If you are talking about THP then you have to enable huge pages for the
> > mapping AFAIR.
> 
> This is exactly what I was looking to achieve but was not able to do. Most probably
> a stupid omission on my part, but just to show that it is not that trivial and strait
> out-of-the-man-page way to do it.  (Would love a code snippet if you ever wrote one?)

Have you tried
mount -t tmpfs -o huge=always none $MNT_POINT ?

It is true that man pages are silent about this but at least Documentation/admin-guide/mm/transhuge.rst
has an information. Time to send a patch to man pages I would say.
-- 
Michal Hocko
SUSE Labs
