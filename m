Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45747C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E721B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O92FxP4/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E721B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388750AbeGXVk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:40:58 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbeGXVk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:40:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id p23-v6so3659644pgv.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=hcGAbBYmyCZyUfzw0f+h27Ed22V61cPcCUFQwW7rzdI=;
        b=O92FxP4/oerhKZ0WjTlpvCcaQ0HuZTXfjyeu4Blq2uAi42KMswzRF+vmwB4eKgOt9x
         sLAXadVaCEpQkjaeT4A2FTmE0T2HmvZxpScD1Rnz8W+EL0CfYN5oj/01tL9nvZEeU+Yi
         y77zvO+vN+KZilC8e4rgUbYA1NOR3h21RxyQVLkxtsDWAojGjZ1sjQYuCPb+uFfmeWuP
         ufiQIKWFMmFsv0AgntxQXWiCGCuJPWaMhMIbfZAYuRa2SuvBm6eSt5NcW0NchGu4MmjA
         c1oXopeRIUUX45KSUv2UKaHz5+6G0MnZyL5+YjwWDcOyopDztPYP1vOHoKf7ST+123+T
         Oqkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=hcGAbBYmyCZyUfzw0f+h27Ed22V61cPcCUFQwW7rzdI=;
        b=Ivj1apbB1BPpIFizCH2BwonmjlXdZBh7Tn0iX07UDLiY89qoUCXJiy8Ex7Qmeo14TG
         WLa8AW+ANCEd70EvfixlquDh5/RX4gxQ5lukroAzxybi8/Fv09v3Xtmci3Dg2PJen9dG
         y6LwvmF0aawfHf3qANCYaCMtGi23rGs9Fxn3erFsg9iIF2aaf4HzBV776GO6iX2t+Nra
         PA8lUbxouTXm81R42BkkSIY8DdKPUfn7ykFBr/U3WL829zOV/raNbLlqtKuCE0UTVQyv
         3lpO9wfI69HC9NqApdrAqaNKqBtzpJ2bSC76/umD0gXdp1CzauwMkkg3QGRHCAN4JrqR
         aM5g==
X-Gm-Message-State: AOUpUlE091XWlfmVpu0xD/xqN5qmNGQUE7V0cPil3vrkNUxD9rDDqPP8
        oGFZhKhx8IxznJrdqh7roODiQw==
X-Google-Smtp-Source: AAOMgpcnd28iRAH4oMJGCRhma7vTKHFbPcUgdvuP1JIrlgG6kxjHMQFV1xuooqoe8fiih+a6fcmrKA==
X-Received: by 2002:a63:941a:: with SMTP id m26-v6mr17345656pge.82.1532464366395;
        Tue, 24 Jul 2018 13:32:46 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a191-v6sm28701157pge.45.2018.07.24.13.32.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:32:45 -0700 (PDT)
Date:   Tue, 24 Jul 2018 13:32:44 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
cc:     Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        aaron.lu@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: remove use_zero_page sysfs knob
In-Reply-To: <20180724090800.g43mmfnuuqwczzb2@kshutemo-mobl1>
Message-ID: <alpine.DEB.2.21.1807241331540.185034@chino.kir.corp.google.com>
References: <1532110430-115278-1-git-send-email-yang.shi@linux.alibaba.com> <20180720123243.6dfc95ba061cd06e05c0262e@linux-foundation.org> <alpine.DEB.2.21.1807201300290.224013@chino.kir.corp.google.com> <3238b5d2-fd89-a6be-0382-027a24a4d3ad@linux.alibaba.com>
 <alpine.DEB.2.21.1807201401390.231119@chino.kir.corp.google.com> <20180722035156.GA12125@bombadil.infradead.org> <alpine.DEB.2.21.1807231323460.105582@chino.kir.corp.google.com> <alpine.DEB.2.21.1807231427550.103523@chino.kir.corp.google.com>
 <20180724090800.g43mmfnuuqwczzb2@kshutemo-mobl1>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018, Kirill A. Shutemov wrote:

> > use_zero_page is currently a simple thp flag, meaning it rejects writes 
> > where val != !!val, so perhaps it would be best to overload it with 
> > additional options?  I can imagine 0x2 defining persistent allocation so 
> > that the hzp is not freed when the refcount goes to 0 and 0x4 defining if 
> > the hzp should be per node.  Implementing persistent allocation fixes our 
> > concern with it, so I'd like to start there.  Comments?
> 
> Why not a separate files?
> 

That works as well.  I'll write a patch for persistent allocation first to 
address our most immediate need.
