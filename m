Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF473C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8339920851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oaSQYNQE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8339920851
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbeKTIbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:31:20 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33804 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730469AbeKTIbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:31:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id h3so8955854pfg.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=L0ZlTV3enHxCpq4llUtEhjs+hZ9waqlhfC58LgbVFkg=;
        b=oaSQYNQELdQ7xxWt5PSi3UmGcPSBE25FONuWrsGV7DFSzUfzw9xO6jbaPDnn6XfoGU
         wgONSXLeqZlWyxdOpbT6YFTeDqhXrd01DUa4TKIk1WLMhtxmLfOuht7vgLF8dCv6CfTQ
         A0/KZx16FzBfUEBSZ/fOOxcPMsdolAKM28NghaTUZlzpaQLp5Lmg7NO8FN61RwNmOueJ
         jXofbHYe5jnHcQAxgEr7EsE3Oc0uRHFSZywcp4+EegAL0P0LnxJPz282oYcMUncqIHvF
         lfeaET0y2cwD/GcyvI4hCU/+E6rkbYy5IOCsEFKI3YEw8AgrL1oODNHxChuacVF0sY7n
         dlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=L0ZlTV3enHxCpq4llUtEhjs+hZ9waqlhfC58LgbVFkg=;
        b=sdFsb1WpA4GrO+S+B5vQAMdrvf1C5RbqNRx22bVMz0pB+mrJv7k9RCjPgYeuHyww0g
         iWSPzY/iyZdqo+i4ihTt/zZnKza1eRWsGME3TqP2qqaaMPW+exwYDcr+MSjlI1JrDjSJ
         NINuHelZhTs6T3RpCO9Yya0Ix/m3v92smqI5XvZvgyL/KS9yFUKi9BZ+OJbwajMCjadX
         1lZ5rBHALsQdyeVnsUhIwiewdwZTKjrnBTdpMuYEpXQfqsp1493tnJNjPvfjhlXwJ+bo
         FoLA+X+IXxhRP4WYNoHul/rJsS6TbYqv38E1/h++pCwLxNIhMM3F9cyeygrl4NJDMW/R
         V0/w==
X-Gm-Message-State: AGRZ1gJsRYpN/lir75ps3dFAxBgN/Mlvz9GvMZc4MLSt/eK/UKVhICaS
        MPtB4QSLk09vfcv+YW3AQAUEEYFSV4s=
X-Google-Smtp-Source: AJdET5eBcOqyoo0vkC4aTuiCySwWH0arYBgvInpEnIYh+OBYm4fQ0XNTUjwdzOCzLz5H+dLIL4BU7Q==
X-Received: by 2002:a63:2d82:: with SMTP id t124mr21604293pgt.260.1542665136395;
        Mon, 19 Nov 2018 14:05:36 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f22-v6sm43154636pfn.177.2018.11.19.14.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 14:05:35 -0800 (PST)
Date:   Mon, 19 Nov 2018 14:05:34 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org
Subject: Re: [RFC PATCH] mm, proc: report PR_SET_THP_DISABLE in proc
In-Reply-To: <20181115090242.GH23831@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1811191404030.150313@chino.kir.corp.google.com>
References: <20181009083326.GG8528@dhcp22.suse.cz> <20181015150325.GN18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com> <20181016104855.GQ18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
 <20181017070531.GC18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810171256330.60837@chino.kir.corp.google.com> <20181018070031.GW18839@dhcp22.suse.cz> <20181114132306.GX23419@dhcp22.suse.cz> <alpine.DEB.2.21.1811141336010.200345@chino.kir.corp.google.com>
 <20181115090242.GH23831@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2018, Michal Hocko wrote:

> > The userspace had a single way to determine if thp had been disabled for a 
> > specific vma and that was broken with your commit.  We have since fixed 
> > it.  Modifying our software stack to start looking for some field 
> > somewhere else will not help anybody else that this has affected or will 
> > affect.  I'm interested in not breaking userspace, not trying a wait and 
> > see approach to see if anybody else complains once we start looking for 
> > some other field.  The risk outweighs the reward, it already broke us, and 
> > I'd prefer not to even open the possibility of breaking anybody else.
> 
> I very much agree on "do not break userspace" part but this is kind of
> gray area. VMA flags are a deep internal implementation detail and
> nobody should really depend on it for anything important. The original
> motivation for introducing it was CRIU where it is kind of
> understandable. I would argue they should find a different way but it is
> just too late for them.
> 
> For this particular case there was no other bug report except for yours
> and if it is possible to fix it on your end then I would really love to
> make the a sensible user interface to query the status. If we are going
> to change the semantic of the exported flag again then we risk yet
> another breakage.
> 
> Therefore I am asking whether changing your particular usecase to a new
> interface is possible because that would allow to have a longerm
> sensible user interface rather than another kludge which still doesn't
> cover all the usecases (e.g. there is no way to reliably query the
> madvise status after your patch).
> 

Providing another interface is great, I have no objection other than 
emitting another line for every vma on the system for smaps is probably 
overkill for something as rare as PR_SET_THP_DISABLE.

That said, I think the current handling of the "nh" flag being emitted in 
smaps is logical and ensures no further userspace breakage.  If that is to 
be removed, I consider it an unnecessary risk.  That would raised in code 
review.
