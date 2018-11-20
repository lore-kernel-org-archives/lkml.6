Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39D6C41536
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACBBF20831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 16:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXcuj7i8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACBBF20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbeKUDDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 22:03:23 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:45053 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbeKUDDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 22:03:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id k6-v6so997447ywa.11;
        Tue, 20 Nov 2018 08:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wLqi/vF2D0NhTrVanrL5/ikBNTGd8RqVHgF0CR1yK+8=;
        b=XXcuj7i8EFzOCtQ0gd1b14G9CfQjyJP2hi8itJmkJ0TlCB/q/wNk5ZGjUqhktuLRXx
         NgLQsuyfRbEKMLz88ajpLpsmt5U9dpcwsA2S0vDq7cBHeTWLG6DtsjgT49zvmK+QSyUl
         YFBbB04uny6GG4r3m8L/gJGLX6cyxh+BvKuYtrV9ST50R2ol7MatBMp7iIau97vI1rS6
         vcTUCbwL9GJJuM5NJ7cpMV227Ev9QllUOaedWNa/WfHxYHTP+SK7dPrQzLL2v9uu1sl2
         qQhOfZ1XqaUicaoVjdrLkvHWZEClrXg5tgTxk84RiueXffTMSXBVIkidKa4dYdQ4Esac
         xaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wLqi/vF2D0NhTrVanrL5/ikBNTGd8RqVHgF0CR1yK+8=;
        b=TouFEdDX/rMBSjO3R9KApzizGQq+yGi8fD9dpgCWRFv8LlLlv8xfsyd7bfCbwq7+yS
         jyUros+vpMGB//Z6RNKLZNLDniklNmJ6oXxlhvjjwwrgJQ/F42xurvP6IAHot6fUhRLJ
         7Hpxhxv+oKutgTeuhR39QnEFSJyLC+H5Qwvs3r6Vn9IntZoe7o8TAcOYEHNlcjl/sUGc
         QWXMn5z62Pz+hqQSxqjjYN5MD07yXC0mRKWlojZE/F1OkfxoLmlmJkL0IyUSAhNVBzwV
         HVBffdY3x8CAD8taaE508DP+Mq36d0BfGXEFmQoNZoar/+vHImHY7FfurZ1Darw6pAlr
         cBZA==
X-Gm-Message-State: AGRZ1gJSRxrJqbpS5jJLhIwQ/7Zp73piKmN9AyLh3lt241WSVcRXaYlZ
        TulPacamQsm9sEFvKt1ufcg=
X-Google-Smtp-Source: AJdET5e+FmwabWqyE6/U91cPDwpFU99TusXtSEpfidEC99wAtMuakMfXVNGpE8i1CLAvE393EsPGSA==
X-Received: by 2002:a81:3bc1:: with SMTP id i184-v6mr2557237ywa.455.1542731601711;
        Tue, 20 Nov 2018 08:33:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::7:4b6a])
        by smtp.gmail.com with ESMTPSA id u84sm3842541ywb.12.2018.11.20.08.33.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:33:20 -0800 (PST)
Date:   Tue, 20 Nov 2018 08:33:19 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     linux-mm@kvack.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, aarcange@redhat.com,
        aaron.lu@intel.com, akpm@linux-foundation.org,
        alex.williamson@redhat.com, bsd@redhat.com,
        darrick.wong@oracle.com, dave.hansen@linux.intel.com,
        jgg@mellanox.com, jwadams@google.com, jiangshanlai@gmail.com,
        mhocko@kernel.org, mike.kravetz@oracle.com,
        Pavel.Tatashin@microsoft.com, prasad.singamsetty@oracle.com,
        rdunlap@infradead.org, steven.sistare@oracle.com,
        tim.c.chen@intel.com, vbabka@suse.cz
Subject: Re: [RFC PATCH v4 05/13] workqueue, ktask: renice helper threads to
 prevent starvation
Message-ID: <20181120163319.GW2509588@devbig004.ftw2.facebook.com>
References: <20181105165558.11698-1-daniel.m.jordan@oracle.com>
 <20181105165558.11698-6-daniel.m.jordan@oracle.com>
 <20181113163400.GK2509588@devbig004.ftw2.facebook.com>
 <20181119164554.axobolrufu26kfah@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181119164554.axobolrufu26kfah@ca-dmjordan1.us.oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 08:45:54AM -0800, Daniel Jordan wrote:
> So instead of flush_work_at_nice, how about this?:
> 
> void renice_work_sync(work_struct *work, long nice);

Wouldn't renice_or_cancel make more sense?

Thanks.

-- 
tejun
