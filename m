Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7356C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9FD21916
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="FGn5UHTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390572AbeLUNTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:19:32 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45380 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731379AbeLUNTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:19:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id a14so2505424plm.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hPIGiYbwJ4wmTOY4OtiCXYKgcdkvobbbAsP4fvF2164=;
        b=FGn5UHTrV0QPWL842VhepA5mMCwYbkAOBnxTKJiIT46TYomOtoW/mEw6kVWDg5SwE/
         pvC56hdJIR8ucgFTbRU0/EardX00nnUJG91j25EwSWAPiwETXPxpIMGLAdOGoOO6no+x
         J7NJX3G2/HGZ3oiLGZtPeA6HTg+5Ag7NwwT7PSI59LGb/zIGhoB8x3fG5xvPMyzMSFpu
         l7jT9weBXMxvmvKWc4ZBrMVgU6ZdtLcGfA+qVjfs8FaNRoOCEAy5cTfMpK1liEkFpn6G
         QlY9QTN2x2r4dW5l0Tjc43wNI+pMST7saYXNuJMu6KQ40iQWLXaimi+tA3ImyV04VaBD
         v2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hPIGiYbwJ4wmTOY4OtiCXYKgcdkvobbbAsP4fvF2164=;
        b=RMa5+jI/tJdcGfVAdy0vNHxG15lLsI5iZ3T/YYLB8Eu8UpnSTGYvEG8SzT8jru75Z0
         ArjMyr0q0pH56kyXc/MTzuM77cdyIPoTCrBpDsWw4OCRXIK8pt0WK5pq2er7oPDhjjTN
         uOu9lhV2KVumlfZQW8q8Rlx49aCsHis+DgKF/ZElxcDgPGPizypugBUGyGnWQjWT5KGV
         f0mpZYDr2IRu/LuPNO9ReZjT2CLmZsZPjpprz24qb3V7j7W9U5VOsxZJsWPywMkDUKIU
         8wlgxxifJRorJXGkOVLC1Hj/WjDCulGo7Y7kEWfp8sgv9xr74twpDbmMeJBVDF/EAfBL
         jKnQ==
X-Gm-Message-State: AJcUukc1v1ONwNk+wgVgFHvBCQwYWHDY0nZOrtCdndesV6kwz6VOyHeJ
        goF0zFikjWNP9G8Be2dxP4HIdQ==
X-Google-Smtp-Source: ALg8bN75HIaB/L1re48WGE4jtWKvOkl56xIRTogbRbkaZ+WYJrrAkU0WWKp7N74FjuXFcMSzqB2JFQ==
X-Received: by 2002:a17:902:9a8b:: with SMTP id w11mr2445687plp.121.1545398371358;
        Fri, 21 Dec 2018 05:19:31 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([134.134.139.82])
        by smtp.gmail.com with ESMTPSA id d68sm32983132pfa.64.2018.12.21.05.19.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 05:19:30 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 06BBF300816; Fri, 21 Dec 2018 16:19:26 +0300 (+03)
Date:   Fri, 21 Dec 2018 16:19:25 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] x86/cpu: sort cpuinfo flags
Message-ID: <20181221131925.h6ca375bakwipmo3@kshutemo-mobl1>
References: <20181219195014.A0962820@viggo.jf.intel.com>
 <20181220120240.ermrc3hnixkin2yg@black.fi.intel.com>
 <20181220160411.GC31403@zn.tnic>
 <20181221124037.s57lt567pgzbz7z3@black.fi.intel.com>
 <20181221130403.GD1325@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221130403.GD1325@zn.tnic>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 02:04:03PM +0100, Borislav Petkov wrote:
> On Fri, Dec 21, 2018 at 03:40:37PM +0300, Kirill A. Shutemov wrote:
> > But I don't see an improvement in readability of data presented to user as
> > a silly idea.
> 
> Improving readability is not a silly idea and I never said that. Rather,
> the cost of what you're trying to accomplish, needs to be weighed.
> 
> The final goal of this is, AFAIU, finding whether a feature flag is
> there or not and you can use grep for that now, on *any* kernel.
> 
> And if you need the feature flags sorted, you can do that too:
> 
> $ grep -m 1 flags /proc/cpuinfo | tr " " "\n" | sort | xargs
> 
> and there probably is even a simpler way to do that.
> 
> Or add a shell alias for that or a small script or ...

That's very valid point.

Dave's patch made me recall few cases were I wanted to check a presence
of a CPU flag with very limited userspace: shell in initrd with lean
busybox build (no grep around). Eyeballing the flag took frustratingly
long.

Yes, all this can be addressed in userspace one way or another.
But it doesn't take much for kernel to present the data in a more reasonable
way too...

-- 
 Kirill A. Shutemov
