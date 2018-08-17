Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB7EC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9270A208E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 22:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig6j2XQI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9270A208E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeHRBxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 21:53:14 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:36214 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbeHRBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 21:53:13 -0400
Received: by mail-pf1-f176.google.com with SMTP id b11-v6so4093440pfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 15:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=A0vkox9rPn3+F8NbjlMa4YgmF3l4G/voRbqOvtqqhtI=;
        b=Ig6j2XQINuIy6249TYd+e01uB4/4mZe7zOwbhYmtxIlTKUxkjYrGPjJZw/w+p7rbtT
         ddhOs+vBxSrN2K3g7svmhzlynbDxlD54ho7Vf3yX9vxi7AGf7F1cPh4BULOWfJt2GeYu
         NrXte/X+u6O/P6kNUHEIBvkDtCB1SQ4vRD5CIBEqrLcSNpaYMkHc8JI9PQNgYKhYB0S1
         zhzySOd6Bbx16mRDn+EpJMJWlIzf49cbwICCpiymOsL/3L7xlsqA+KRmXEHvrtfr4Ud0
         o/HZO3VzS0f1+/FfX09q97NztXEN9QpPR336FMvcWXaAvZ0tyvXyy31mOi/1UnCja2Lf
         +dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=A0vkox9rPn3+F8NbjlMa4YgmF3l4G/voRbqOvtqqhtI=;
        b=quyDUZtc7E0QVdC5k03GgjliUeZSAPzIMpVpimQnvRCVnahrz2o2hhgpeMoSF8l3hV
         W2AJegYFRkgG13ZlFYl3Q5GOASwNcbWMDaNgYKTLd+ANub0gF3IqPNKiU0CQ2JKYGNxN
         eJXie3AEjoCmc5bJoNVmwa6J07MwiNf7hDpe6cvo3m6Vp6NlY00LcpDpX7hXN8XWvK91
         mfDqn3lf/KM9D41TZv0IyXj24Y+EcHSkGqiZGiHRnDim0xa3GO1L8XPC2Ge6D2h5tRbg
         CVL0E/0LbEVCWbIDNNuo5UXkWbxaKNVBCtYAe73i+Trg5OfneoG6GEAqix/XEmx+b89R
         Ko+Q==
X-Gm-Message-State: AOUpUlG4fed1AC05ms32CjLvRqVsAFX/SPv7wHx6kmQaWAW9fGYedJn7
        sR4I4g1S+mhcgkgEOJOgD9w=
X-Google-Smtp-Source: AA+uWPybqXv7l6bZBjrbZ58AolPMZsbzOQcN19pIYQ8ZXOEfaodUZiBKDj70kdSoObKJwRKR8nyyig==
X-Received: by 2002:a63:4d47:: with SMTP id n7-v6mr34521294pgl.270.1534546079291;
        Fri, 17 Aug 2018 15:47:59 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d19-v6sm6615666pfm.48.2018.08.17.15.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 15:47:58 -0700 (PDT)
Date:   Fri, 17 Aug 2018 15:47:57 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>, x86@kernel.org,
        dvyukov@google.com, hughd@google.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: Crash in MM code in v4.4.y, v4.9.y with TRANSPARENT_HUGEPAGE
 enabledg
Message-ID: <20180817224757.GA22198@roeck-us.net>
References: <20180817222733.GA18575@roeck-us.net>
 <20180817223907.GH12066@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817223907.GH12066@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 03:39:07PM -0700, Andi Kleen wrote:
> On Fri, Aug 17, 2018 at 03:27:33PM -0700, Guenter Roeck wrote:
> > Hi,
> > 
> > the following crash is seen in v4.4.148, v4.4.149, v4.9.120, and v4.9.121
> > with CONFIG_TRANSPARENT_HUGEPAGE=y, CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y.
> 
> Just to confirm, it's not in mainline right? So only in backports?
> 

I have only seen it in v.4.4.y and v4.9.y. v4.14.y does not seem to be
affected.

> There's also a report for 4.17 in
> 
>  https://bugzilla.redhat.com/show_bug.cgi?id=1618792
> 
This is a different traceback, so it is most likely a different
problem.

I did not test v4.17.y. I'll do that (and v4.18.y, and mainline)
for completeness tonight.

Guenter
