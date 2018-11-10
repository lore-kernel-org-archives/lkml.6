Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AEAC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18A6208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVNjQ1F8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B18A6208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbeKKBH5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:07:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:59586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbeKKBHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:07:55 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 716D920818;
        Sat, 10 Nov 2018 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541863354;
        bh=IVeUE/1PBUH6SW9/3JkhLgS53UNYx9IIzAd7ceDeMYU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rVNjQ1F8y+JT3lkqih00czeV9TzSbaXeEq5WE5JyFpKv3pDJRjUMx0CDwrfVTTwkJ
         l3KDykeHHxQv36nviH9bkPiFq6+0Uexwhm/4cz800o4dQEFpAiJzLanPmZzD2H8apM
         ZdclV/l8r3t2MsUJUSDwLqRiQGl0WaHOg9D3qHVc=
Date:   Sat, 10 Nov 2018 07:22:32 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chenbo Feng <fengc@google.com>
Cc:     joel@joelfernandes.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Joel Fernandes <joelaf@google.com>,
        linux-kernel@vger.kernel.org, Tim Murray <timmurray@google.com>,
        netdev@vger.kernel.org, Lorenzo Colitti <lorenzo@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, stable@vger.kernel.org
Subject: Re: [PATCH v4] Wait for running BPF programs when updating map-in-map
Message-ID: <20181110152232.GA24724@kroah.com>
References: <20180816040145.gqzqicab4s6kcbye@ast-mbp.dhcp.thefacebook.com>
 <20181012105427.243779-1-dancol@google.com>
 <20181013023138.m445q6itdmyxdtoc@ast-mbp.dhcp.thefacebook.com>
 <CAEXW_YQFs9mcw5Qv04ZRv=ZAK7YeBLJKByQxXYLj34iigS-Q=Q@mail.gmail.com>
 <20181018154657.ehgj3ozy62zy47hi@ast-mbp.dhcp.thefacebook.com>
 <20181018233633.GA89903@joelaf.mtv.corp.google.com>
 <CAMOXUJ=YFEwzBdkQw8xUrQXd4ZRzX6ob0dOCCRA=uEbjvw9yEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMOXUJ=YFEwzBdkQw8xUrQXd4ZRzX6ob0dOCCRA=uEbjvw9yEQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 06:01:54PM -0800, Chenbo Feng wrote:
> Hi netdev,
> 
> Could we queue up this patch to stable 4.14 and stable 4.19? I can
> provide a backport patch if needed. I checked it is a clean
> cherry-pick for 4.19 but have some minor conflict for 4.14.

What is the git commit id of the patch in Linus's tree?

thanks

greg k-h
