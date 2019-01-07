Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23F1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39642070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 23:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMnvqTrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbfAGXhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 18:37:25 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:36812 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfAGXhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 18:37:24 -0500
Received: by mail-wm1-f42.google.com with SMTP id p6so2540306wmc.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 15:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wid+jioh0zryvJfRcjARqiFU+q4SSkz8696pzO0mQZ4=;
        b=tMnvqTrFs9P0ksObKT6T4eEW/XR+RTNHyY8yVWAjUanancfm6hmhDluRmq0ruvLFPJ
         +Q//myTYsC22uFvD16px1U9gtXt/56XcOy/KYOqxoSR8s/y1riFybpToNsHhh6fKBPtz
         Uf1WnOmPd9hS1F0XAgaZFXGfFuPY4pHHKDyAoAvpXNP2fv0HIAdQyfGfI60pqxwm2AsM
         TcWm0B1gvOBuLEiHElNhBzTxmn/8QqMScDNR7yhHj6URBK3vn+bDBTbphs59rQmcO3qt
         T0T3Ci4eeDdYcGJmIvAipkJKKXROzn8EE/XYG66skPGl9TsGBdcXxUXHeRlUApPPuKnH
         CSmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wid+jioh0zryvJfRcjARqiFU+q4SSkz8696pzO0mQZ4=;
        b=k7Qx4wKD2X/eIJcO5AFvB7dgUxN3a7qsjOgasTtadgjk6m7uD0SZEiUjLux4OZW8rI
         xIAeCR2XkWP6FBdj/nwLcMLlj+lBtBQ9QRL9q/rvc3q4Msco2JOGFhnlJYOPucw6rhlf
         fPWl3HhdYIBJwRKh+BhXA5ommfeMisS7LZ61iCVD7barwW96cTrLO4nBjdLpbQh56Jsy
         zV1aMEjzae8m+Vx43CPWOH2nGjtdzMriMTffQp6IeXpk+vlDrp448TwPOqZM8cQ80+5K
         5GTbOebcb8iS632iJ6oF0OPLpeqSrpcvH+EPsLTGJnlWr7Q69IYnUHU0s4ldDnegSHIg
         Hydg==
X-Gm-Message-State: AJcUuke5HKG94bgKxELQt+nGDWFKFcgeJauVtbLbfUTefs6P6yex3+QG
        KwQt9nK1pxAs51cvCjGbi67wBZg=
X-Google-Smtp-Source: ALg8bN5RHAMUYQuOIqAU83MphcnnfUxzpEIn/is+itgY9VL/S+HXuimaMe6CT5BgVo/21NRFNYnwVg==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr9852227wmf.111.1546904242880;
        Mon, 07 Jan 2019 15:37:22 -0800 (PST)
Received: from avx2 (nat-minsk-pool-46-53-201-92.telecom.by. [46.53.201.92])
        by smtp.gmail.com with ESMTPSA id y13sm42694775wrn.73.2019.01.07.15.37.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 15:37:22 -0800 (PST)
Date:   Tue, 8 Jan 2019 02:37:20 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: + proc-fix-proc-net-after-setns2-checkpatch-fixes.patch added to
 -mm tree
Message-ID: <20190107233720.GA26994@avx2>
References: <20190107223609.Z6BC6rJ1M%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190107223609.Z6BC6rJ1M%akpm@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 02:36:09PM -0800, akpm@linux-foundation.org wrote:
> Subject: proc-fix-proc-net-after-setns2-checkpatch-fixes
> 
> WARNING: Block comments use * on subsequent lines
> #56: FILE: fs/proc/proc_net.c:44:
> +	// /proc/net/* can be changed under us by setns(CLONE_NEWNET)
> +	pde->proc_dops = &simple_dentry_operations;

I did it on purpose! Otherwise default vim colouring marks "/*" in red
because it is comment without "*/"
