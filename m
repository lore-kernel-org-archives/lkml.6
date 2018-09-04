Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2B1C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFDA52077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="nmSN+Dl6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA52077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeIDNcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:32:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39931 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeIDNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:32:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so1382177pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 02:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=RoqvrdyJPnOuCbbcngTVCfjKNLdHZZFkoRzkAQfPkak=;
        b=nmSN+Dl6KycaM9mBY0gOAIgIQGo+zE1I+U8cM4N4eG1ayU7qMx3My7HuIJ3GhpJ/8b
         n6Z+Y5BFJVqYp/vZYinIhvsyrJfexJ0luhtBvltCcomw2YiA9I1zzCiHSH6qPtBmCTpn
         0F9jhitZx3IswOkUBawZGn47bnqXDSRDkhOyPEMtamltqE/JSP6vlAzS7Dw7I15KGHT3
         7ndlzaNkgDAzi+j16OJW81vMgx3gWJZ23WxH0NrMDux41SxtzCD7y7RT2qA+LI28g8eJ
         rwIP30LmGMTrxqiSrzdgALWMdWRsLOOYiLJipXCUdaqXPNEUCbJJq5Vev6coI+6Ex9dZ
         exGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=RoqvrdyJPnOuCbbcngTVCfjKNLdHZZFkoRzkAQfPkak=;
        b=Q0mD2CkjFtuxCQ8GI7FxGhATA5jcfEVg1HHGMsULxktjv446wXOUY6xiWo7zRxaRM7
         4+pRoKmViwK50oDElg45dU5swOLRMn+GlOjttWgsn/jTHb+udNw9HVtGFPyAJvnzXHmz
         y9hjDce8zSIy7Sm1ssKEvD3W41Vqpe3l6/hvM67mvkXUemuGFGpHAJqvCo29aWBVOoh7
         HuoYJYyX9NmDizMEY02C3NRsrbHgh9ZcHf2GJr4NpgTJ27Bxf+ln0kwEAZLN+QWsio88
         83lh9hL37dI5Ii/9D+BRkX+p/hSpmmmvgGWYWxiandQj6VmCkrQNXVDwEBz+4cXLotaX
         Y6UQ==
X-Gm-Message-State: APzg51Bil5Cpxyr4x7lfC6AhC035LXK2yPdCV3VArI6/avegbo6WylrX
        NpCiDjUKsEmZaNbLALnABZl7Ng==
X-Google-Smtp-Source: ANB0Vda3vWCn4Ot13qkXovxRYzrQ1IDgTZHcv1bZ+mp/4TYy6xIhmFfMP0dPV3ayTbkQHlAJbFOvQg==
X-Received: by 2002:a62:5d03:: with SMTP id r3-v6mr33945752pfb.150.1536052074608;
        Tue, 04 Sep 2018 02:07:54 -0700 (PDT)
Received: from cakuba (apn-77-114-125-170.dynamic.gprs.plus.pl. [77.114.125.170])
        by smtp.gmail.com with ESMTPSA id t17-v6sm41865145pfm.138.2018.09.04.02.07.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 02:07:54 -0700 (PDT)
Date:   Tue, 4 Sep 2018 11:07:45 +0200
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2] libbpf: Remove the duplicate checking of
 function storage
Message-ID: <20180904110745.3ab4dc3e@cakuba>
In-Reply-To: <20180902233007.3003-1-treeze.taeung@gmail.com>
References: <20180902233007.3003-1-treeze.taeung@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  3 Sep 2018 08:30:07 +0900, Taeung Song wrote:
> After the commit eac7d84519a3 ("tools: libbpf: don't return '.text'
> as a program for multi-function programs"), bpf_program__next()
> in bpf_object__for_each_program skips the function storage such as .text,
> so eliminate the duplicate checking.
> 
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
