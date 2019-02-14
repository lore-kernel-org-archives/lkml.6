Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7327EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41DA421B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 23:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="hvEkx0sD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbfBNXtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 18:49:50 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46802 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbfBNXtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 18:49:50 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so8938399qtm.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 15:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iysI1wB/0IWb4pCFfVwtSNZMVU6oGg5xTMZgAA4BlqY=;
        b=hvEkx0sDae+vXuPkRrfz6GJpMcmtwOQoFSjorPtzJ7i/ZlZ+N2DS8RHhtUbzd2y8aO
         93zCFM5f7/VQorSYljRscCmvDMT6v89kczMv5nSnCHvFEegerCJ6Xb764Nd59OwMZGh2
         NR0NbloEkvUqHfCWvo4BrQcaPp8/NpqhtjLmAQgxztm5ByUDgCAXzPDq+BlqmiBG8EGV
         ME/1vaG7H5+GvHHBdTqNAFIcuC2Ueippty3sTQasR/b//BeWt+Za8V6wljLiKAfeu1Ua
         8dD/hcP3II2Mhhb9gsYGvTIhagIB+dNDWETUdvkn94BpgBZq/gWHYermiCVlUERwF+Bk
         K6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iysI1wB/0IWb4pCFfVwtSNZMVU6oGg5xTMZgAA4BlqY=;
        b=jOcagJVUsCNSm1T3rKNdhFEqEGsnXS2BVVU4ZPDWrUVKjU+j/sq/XoFmTY4JC52cv6
         0pMVSrY5xpAVAvQRskJ7qZBPc0v3IaVnu2cwH38fXaauNv4QcDwEn4jDnh/MWIiPIQeB
         hB7s/GtFdkAkfNka7/SMybxw5MEpbqdpeHorWgIcQfeHCuRlLtksSjFLEYNiFFVFQj/j
         HE9q7il+h5uI+ITOxwKaWGYpyxtZqAe6czD+BdpCIgg0Rren05WsFvMi498cDdzRVkwZ
         nVucjG9rDGVkVQCxhgVOj88aHBzw8CmjXGU4V7B2JuMf3YpAE++p3y7v1WdA5xzggRJi
         5QAw==
X-Gm-Message-State: AHQUAuZAumMnH2aVw9GzBVrx5N3ZUfmTL0gDJMZJd/DoSiX3MTNpC49s
        gKWk6zjoGJOH4d8NMYY/xrcWAw==
X-Google-Smtp-Source: AHgI3IZknsyHISGjxlHiQOHLeB8lB0ycvuC7u1AyuZY91RkGx/hANlj0RYTPcWTfc+1rGg/X944lrg==
X-Received: by 2002:ac8:969:: with SMTP id z38mr5363680qth.49.1550188188860;
        Thu, 14 Feb 2019 15:49:48 -0800 (PST)
Received: from cisco ([192.241.255.151])
        by smtp.gmail.com with ESMTPSA id y68sm1965923qkd.49.2019.02.14.15.49.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 15:49:48 -0800 (PST)
Date:   Thu, 14 Feb 2019 16:49:43 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     juergh@gmail.com, jsteckli@amazon.de, ak@linux.intel.com,
        torvalds@linux-foundation.org, liran.alon@oracle.com,
        keescook@google.com, akpm@linux-foundation.org, mhocko@suse.com,
        catalin.marinas@arm.com, will.deacon@arm.com, jmorris@namei.org,
        konrad.wilk@oracle.com,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        deepa.srinivasan@oracle.com, chris.hyser@oracle.com,
        tyhicks@canonical.com, dwmw@amazon.co.uk,
        andrew.cooper3@citrix.com, jcm@redhat.com,
        boris.ostrovsky@oracle.com, kanth.ghatraju@oracle.com,
        joao.m.martins@oracle.com, jmattson@google.com,
        pradeep.vincent@oracle.com, john.haxby@oracle.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com, hch@lst.de,
        steven.sistare@oracle.com, labbott@redhat.com, luto@kernel.org,
        dave.hansen@intel.com, peterz@infradead.org,
        kernel-hardening@lists.openwall.com, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v8 07/14] arm64/mm, xpfo: temporarily map dcache
 regions
Message-ID: <20190214234943.GF15694@cisco>
References: <cover.1550088114.git.khalid.aziz@oracle.com>
 <ea50404604bdbe1547601b6ea0af89e3da8886b0.1550088114.git.khalid.aziz@oracle.com>
 <20190214155435.GA15694@cisco>
 <92787149-bb9e-6ee9-6d04-431ec145e9a4@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92787149-bb9e-6ee9-6d04-431ec145e9a4@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 10:29:52AM -0700, Khalid Aziz wrote:
> On a side note, do you mind if I update your address in your
> signed-off-by from tycho@docker.com when I send the next version of this
> series?

Sure that would be great thanks. This e-mail is a good one to use.

Cheers,

Tycho
