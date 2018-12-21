Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B93B4217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPfABtHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391176AbeLUSK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:10:56 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:40822 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbeLUSK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:10:56 -0500
Received: by mail-wm1-f54.google.com with SMTP id f188so6554117wmf.5;
        Fri, 21 Dec 2018 10:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3R8SuVDFl0Z4HAHam8UVMNeqALQrcICms40UAUz2vG0=;
        b=ZPfABtHIVEmTUYvVmD/nUJEnK1msOnxX8TCEPR8TDSb7/oX8NeSC/i7Hj0GNU3SYAG
         IXp9nkYN5dy93ecDc01Iy1iayOsRsS9v29OwlrSQt0KhK9/JQrHlhtOEWMqBjKuH9s44
         21uI/BJJUdu07QT9oX4fwiW6bZxsDpSILKo3XAmTRJKAB32E7wg5Za+ljnEh2PeJkyGE
         EuxvpK8FwlgaQE9bHO8QglRuhiQDk81Iz2BSvFRpPWSv98lgll4seSPcTfyJSqTIi+Cn
         gdRbtNKRtxeeF0A7ybXKiFYevijanCSqDfEArqDb5LymPekx6OH8hKu7KNAGuNfN670m
         q/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3R8SuVDFl0Z4HAHam8UVMNeqALQrcICms40UAUz2vG0=;
        b=Ol3xA6Uy4esXmfR/9aHRfHTbSLAu678u99Aejybf1d3vX28CprZyPXDoxMmUmCvoCR
         Q49rPME0lWLebOd7sNE5F2+Zv4Bsun8bJTFgrruwiND202jgLu4TPWFVqfmHoeU7IAhu
         8W5uzg1zhEmBKrilZ7JEGe/GfTBOMb3STmirbJUEOJcdFTI5G0tB5QCoX1/efy4NBaRq
         r4h9c//tqt8I2IQ3c3b2IeRupWTaS49M1NjzS+CsfxXnZSU+VEEyqNWZXszGUgryVzLd
         UHMVBxcNBs7/2UHjCSSO/O/mqw9oaAVz9neU2raMUFVxZUdPzxNusMfBoxyfqNgPs2bT
         SVHA==
X-Gm-Message-State: AJcUukdLkJXfPLZEK+EQrcTCnTYn+AFKF4GVb8myIIy0jDpcRORjCfnM
        UTXBoG+89RL+Ur+RwkKTIKiSFQk=
X-Google-Smtp-Source: AFSGD/WirXPXVOQsjoGu28hSF71u9x+sXsXmm5G+3CChklnQ40naFi0IW/XfF8amc6keKO06hrJeGg==
X-Received: by 2002:a1c:5fd7:: with SMTP id t206mr3948738wmb.145.1545415854153;
        Fri, 21 Dec 2018 10:10:54 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id 67sm3800324wra.37.2018.12.21.10.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 10:10:53 -0800 (PST)
Date:   Fri, 21 Dec 2018 21:10:51 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     =?utf-8?B?56iL5rSL?= <d17103513@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Davidlohr Bueso <dbueso@suse.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: > [PATCH] Security: Handle hidepid option correctly
Message-ID: <20181221181051.GA29429@avx2>
References: <18d54cd3edbf4fd3a7c01962f41ead58@cnbox5.mioffice.cn>
 <CADd0cq1HHv4xXn0tEWb4SfQ2XvoH33O1d1rogojj=hBTm+Lwww@mail.gmail.com>
 <20181214154436.GA16772@avx2>
 <CADd0cq21TfsncsoViQD+1Q=GKyjG5fKuWEnZr8JxevLh3mSeag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADd0cq21TfsncsoViQD+1Q=GKyjG5fKuWEnZr8JxevLh3mSeag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 12:21:40PM +0800, 程洋 wrote:
> Actually I'm pretty sure kernel calls proc_mount()
> Here is the call stack

OK, hidepid= is still misdesigned. :-(
