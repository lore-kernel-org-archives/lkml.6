Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9E0C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7213D20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMk4DEJY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7213D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbeLCUjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 15:39:37 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43218 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeLCUjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 15:39:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id v28so6238002pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 12:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QOQGNXmWwBfLmQecrK1pXi7DjtkunKaw9mj2GLJuEGI=;
        b=pMk4DEJYttV+dALHqlAHCSmFwOuuUzTcV/DVapqjiUxUUMN62bz0/W0ZVVTjjDpr/f
         ixEIFdkWEqs7xRATE8E4KL7aEiMqD89J849M3i7IaN94F9bdup548eXpas3I1O0WCEyq
         FdytHw/IEH59dCdHb5WuHv70ZdgV+XsB34bpWsgsUwWD2glsrC3IUO8EIVWhbbVnbiN2
         3abSiF3A2CjJq+Au6MxclOqpgF0kU9ny2EJuKBaSDmUsKERPZCYX5y/YW4OOjXF2NmR0
         Q9dPpezgSexvvM8zWoIOSUbtkcHqK+Te6Yf4G2pdTay03GkeXCvA8iKIUIoVq4uPoj0K
         vhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QOQGNXmWwBfLmQecrK1pXi7DjtkunKaw9mj2GLJuEGI=;
        b=ES22vUoaVezzX6WTJzqJbNm/EeHl4QdmAQjj4Q32DRV+6kO3jq7UgFp5TiTjfqghgp
         bRdlpfvtEFIoaql1dPsOuXXUyYX/d8nOznekV10qHOXH1qtSUHv94uaSSiBFehOUo+MQ
         kYWBhPpI6/DjBkBm7zC+7eXfw/fpNlT1p1bUK647/jRbxdosKAZaGU28YRfgzlwaitkx
         oT/9Idq3x06znfHkThzg+cny71lO1bsbEyAmxgGfkfd2G6I0cYckP9EijVWbS7nqv9im
         YSEIHTcoSIB2FsS7BlrL1C0txVYPozGrso9wv1NXjxKMlc5dA/GR3MqpOjwVoEMfGp7C
         ch2g==
X-Gm-Message-State: AA+aEWbWVHoD2leiV6LodAssu1g738+j5cu3yjNftlxUP6oH/yudB186
        SxqmJb0MQqxQnqK10qrUWu5Yig==
X-Google-Smtp-Source: AFSGD/UJKlaWApbB/RV36eghbeC6WP/Qcmn0Og1ETUTgpcGHJTSlyFVRpn+iouvpjUns/ELGXY3OIA==
X-Received: by 2002:a65:484c:: with SMTP id i12mr14405887pgs.309.1543869575663;
        Mon, 03 Dec 2018 12:39:35 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id u123sm15987810pfb.1.2018.12.03.12.39.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 12:39:34 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:39:34 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ying.huang@intel.com, Andrea Arcangeli <aarcange@redhat.com>,
        s.priebe@profihost.ag, mgorman@techsingularity.net,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        alex.williamson@redhat.com, lkp@01.org, kirill@shutemov.name,
        Andrew Morton <akpm@linux-foundation.org>,
        zi.yan@cs.rutgers.edu, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [LKP] [mm] ac5b2c1891: vm-scalability.throughput -61.3%
 regression
In-Reply-To: <20181203185954.GM31738@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1812031237340.192288@chino.kir.corp.google.com>
References: <20181127062503.GH6163@shao2-debian> <CAHk-=wiq9eTzenOPh9srdB=Y8NcP6NJxh7o8Y5SfSjfqZ20-RA@mail.gmail.com> <20181127205737.GI16136@redhat.com> <87tvk1yjkp.fsf@yhuang-dev.intel.com> <CAHk-=wjgRO-=NPaU9EmrdC3it3o7kvf4u7sewv3crtNLkE13Hg@mail.gmail.com>
 <CAHk-=wjgpWOA7zQ9H5=Zj6KQijm5CBXZc7J=it6C5gdEV0hb5Q@mail.gmail.com> <20181203181456.GK31738@dhcp22.suse.cz> <CAHk-=whrfDw4yV4h2ijbX3vpXf5m4hzJ5pGX7_v6pU31RGib-g@mail.gmail.com> <20181203183050.GL31738@dhcp22.suse.cz> <CAHk-=wgVL_sxXSbjYTiGhxp6+9wLQ9ZmSN+0R5PCF6_a9pQgWw@mail.gmail.com>
 <20181203185954.GM31738@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Dec 2018, Michal Hocko wrote:

> I have merely said that a better THP locality needs more work and during
> the review discussion I have even volunteered to work on that. There
> are other reclaim related fixes under work right now. All I am saying
> is that MADV_TRANSHUGE having numa locality implications cannot satisfy
> all the usecases and it is particurarly KVM that suffers from it.

I think extending functionality so thp can be allocated remotely if truly 
desired is worthwhile just so long as it does not cause regressions for 
other users.  I think that is separate from the swap storm regression that 
Andrea is reporting, however, since that would also exist even if we 
allowed remote thp allocations when the host is fully fragmented rather 
than only locally fragmented.
