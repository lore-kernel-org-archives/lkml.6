Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E25C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5D020862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 21:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vd3t2/5F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5D020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbeKGGoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 01:44:37 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35426 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388314AbeKGGog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 01:44:36 -0500
Received: by mail-pf1-f196.google.com with SMTP id v9-v6so4390692pff.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 13:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vi1IQ7D8ZktlzlH2Ka7ftUfVGmJd+tbtL15+KmkRdHo=;
        b=vd3t2/5FJholrF+bsR+22oTqlARysREbJ3xhWFPNiQ7A8RNdZqUVZ9FNuM6h4f5GSf
         sW7+aic6NeDNaOmrweME0tl/Vxd5LCk5Kw8vVArrglP0igol/a/iOSIcCypkmAqA2YeL
         o5DN3FjuvL3t0vZkYEnWDToClk6Z2b9PfeAX9DmF3CU+udel3TKcDFwk7zz9Rptp9NfC
         oNyMbHNgpGC+Xi7UmMap3GLmrYuqYBkEL5nTs7S4yqKR5ArHNoIk0R445NC85C1aKGC9
         kyHhmiLfCkpEnxfOlivT4cRQ2tJ9nIwkS7lF3RJAAm4syRsCvtNzjVFK2Xlov+LrHJF0
         GQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vi1IQ7D8ZktlzlH2Ka7ftUfVGmJd+tbtL15+KmkRdHo=;
        b=kahvtZtnUvoy7dBKHDkd2QDCk7ulSU9Rf8N8ZTqNL+trzNaqzz9mY0r5qsQDsrVyHm
         ZmCzw+evYsMEhURvbziPJ2YxWpEffyGdW8SppzoWMy13+ImuxqmsXszPXy4vmCSBKgVr
         z5fDv2krH60CSR8LuyVeQvWWmiRNrNT7KI0CUc0SeKjXiNPJihiNX1x//kdhj/Tgfk7X
         RXppHVSG/WDvGr9LoB4QET9PZsTKzdJur5957Ymh2/76hrGEIaFSTneNJWeFVJTLwyDF
         uq238zvWvBO9uxSVi77QIT2Aqj0zuSpoP3OFU8RhbnofYFPia5VJ23SJ9OsfFS+jAZhE
         Yrsw==
X-Gm-Message-State: AGRZ1gK96xZfcm71bllkYwWMauThi5Fkxf56j33mndJJo8Wcs2OydoNZ
        fJxaN6BRUqnPTl9Bg7+wNxQ/5Q==
X-Google-Smtp-Source: AJdET5eAhO7txudfeXIyv7QXN7suC5yb/66Bx+nvVGRDr8M66YOy6jLZK3HkakU0iEYQv/IXWdmZTA==
X-Received: by 2002:a62:e048:: with SMTP id f69-v6mr27695121pfh.208.1541539045656;
        Tue, 06 Nov 2018 13:17:25 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id r18-v6sm45305304pgv.17.2018.11.06.13.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Nov 2018 13:17:25 -0800 (PST)
Date:   Tue, 6 Nov 2018 16:17:20 -0500
From:   Barret Rhoden <brho@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Radim =?UTF-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, yu.c.zhang@intel.com, yi.z.zhang@intel.com
Subject: Re: [RFC PATCH] kvm: Use huge pages for DAX-backed files
Message-ID: <20181106161720.4a0ecc11@gnomeregan.cam.corp.google.com>
In-Reply-To: <13b9a5a5-6773-131e-8014-f1b1bc975794@redhat.com>
References: <20181029210716.212159-1-brho@google.com>
        <20181106160553.5a8025ed@gnomeregan.cam.corp.google.com>
        <13b9a5a5-6773-131e-8014-f1b1bc975794@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-06 at 22:16 Paolo Bonzini <pbonzini@redhat.com> wrote:
> Yes, iter.gfn is the gfn inside the loop and iter.level is the level
> (1=PTE, 2=PDE, ...).  iter.level of course is unusable here, similar to
> *levelp in transparent_hugepage_adjust, but you can use iter.gfn and
> gfn_to_hva.

Great, thanks!
