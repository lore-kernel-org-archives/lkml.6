Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C004CECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890AD21477
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 19:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V7WRtZDp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890AD21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbeJRD4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 23:56:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41134 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJRD4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 23:56:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id m77-v6so13704461pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=H0DKsXihlM0NQPPht+/+FHBCldKDkLh+uDzGgPdMPT0=;
        b=V7WRtZDpd4EU2gIK0BzBthgQMurHyIcS4cS691sQ1PWN+0A/hznQmfqvBJol8eGXRX
         oIR/+nthMGR783jaq24ToF2CUF4WDFsXhTdmK6GwyX9Cm397IarTzQDUmvvrbWp8ye5+
         ZEQZAHbRc5u4PZI6A7oGD0IXIN6RwTbRDsZq8EushVf52doaMpGB7K85BX3+KmCjWjbw
         LmpldJgXXMN5JPABZm45laTyz2vs15HBh4x3g3K21VFQN4MM9MtZPSFodHwkNO9pnUPX
         3kIRHqxpFEolZCY2Dr20V6dY6D98pPfguTbzPw1/e6KSy31EIfdeKHkFDLZ6zoaYRH33
         2r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=H0DKsXihlM0NQPPht+/+FHBCldKDkLh+uDzGgPdMPT0=;
        b=Guwp1V7523TG8AZZXO9tQELo/e04xYZzPD+seFu6lW+HDnkOs/2B2AMwAZUSAaKhMY
         KZ28G2kGrtqAp2qy4stJvY7QrdJKRx4RFWWRIx09BdF9P3OR7j1UYM8k4zvSybUuvo64
         eB7aQDtzgg9FzbNxUN7aJgtX6LRJfyxHpqvaQmbA02NmNakEfsv+uIEezRc3a22NRc0R
         XkbQpizyE6EbqsmnqqbJ/0LipF9/jzCBYx2HHibKvm9jH1Z8m2dd3GexdY8I1t4dek7A
         kHfZOqflsDrp1c5O/jbOoldDkUTYWNXfWpvEJ4S+3cw3k/K0pQeX6Atre3K8R3ty8X2N
         wt6g==
X-Gm-Message-State: ABuFfoiepC9WNu0rY/sY1p7PJvn01Q56TBia3mqWyi2lMlSV+Jtpw9Lt
        3+PXO7g8aRGurREjqs2tF6g36A==
X-Google-Smtp-Source: ACcGV63JYNM0//S8IIty4/QpIjVAzmioCYj1HlU1/q7buwakg5Ee88yoQ8R0qNSHDwLqiQVjKTcBEQ==
X-Received: by 2002:a63:dd58:: with SMTP id g24-v6mr25148262pgj.86.1539806360186;
        Wed, 17 Oct 2018 12:59:20 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d2-v6sm20892491pfn.118.2018.10.17.12.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 12:59:19 -0700 (PDT)
Date:   Wed, 17 Oct 2018 12:59:18 -0700 (PDT)
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
In-Reply-To: <20181017070531.GC18839@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.1810171256330.60837@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.1810031547150.202532@chino.kir.corp.google.com> <20181004055842.GA22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810040209130.113459@chino.kir.corp.google.com> <20181004094637.GG22173@dhcp22.suse.cz> <alpine.DEB.2.21.1810041130380.12951@chino.kir.corp.google.com>
 <20181009083326.GG8528@dhcp22.suse.cz> <20181015150325.GN18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810151519250.247641@chino.kir.corp.google.com> <20181016104855.GQ18839@dhcp22.suse.cz> <alpine.DEB.2.21.1810161416540.83080@chino.kir.corp.google.com>
 <20181017070531.GC18839@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018, Michal Hocko wrote:

> Do you know of any other userspace except your usecase? Is there
> anything fundamental that would prevent a proper API adoption for you?
> 

Yes, it would require us to go back in time and build patched binaries. 
