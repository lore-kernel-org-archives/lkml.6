Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192D6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA1A22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549877656;
	bh=qPXvrnQBPW+PZAJ6eH32iPZReqWaBPhJfvjJVi0BwuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xuXbyuVXtKVyafEo+Oxasxw9GNy8zVEp60zkAlbtFVVs9228vh5W4Jihr1GYodZVu
	 S59gVX4+a5aluuH8xosewPtfT6ZnAejhWqF0MEEky1kyN/ZpfpQ4a0DeTZbYNphV7i
	 p6qGkRWo5x7voDySWNrsWB7cnKW+XsyWtaBORmHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfBKJeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:34:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46759 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfBKJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:34:15 -0500
Received: by mail-lf1-f65.google.com with SMTP id f5so7140193lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:34:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GGNbmJkMGxB/e9Dld/rXMbHkhkq/LorbsCdQM1ESt5I=;
        b=J0D3iUioHGR4CqSjq8HcAs3y9Xm6xmFyuy56xQCZV+6O952EKvw+kOGadfexsFJDxd
         J++kXGysN91sOrQoFYcwtlBLe25wvClWfvAumOCn/DL7x0QhfFHfTXbFXmfcYBwuTqZy
         pLdLwlJtZVvbg8+M0h8gAvvBvIjYOfqLI2Hq060IqnwumeF31QiXvn+mJVzeGRZTemtm
         eQaEsu/awoMPFPY4464UrwSwDF5hjvf1I6R/CBanDIFKRu9HyGPmaUGZ/IOaXYkLninI
         vulK1X33L1jHTfkk7HgHpfDe/4y3QQLWiLWpx5uVyfAx04uKKKWWMMadzOLQZ5nrhFP+
         mlFA==
X-Gm-Message-State: AHQUAuZAZFpHkZw434QS3QFME7+Bb0pPPgnT79EClcwFpmmIvy3lxCNV
        AnPZZqhQyq0NwZ1aawmcnxg=
X-Google-Smtp-Source: AHgI3IbWHH0e/x0SW1ck3rdLRePKz5UxREybCPzc+dJkw35iOIJP1/4VEliMA3Yjtr9WwJiFelK4hA==
X-Received: by 2002:ac2:5335:: with SMTP id f21mr16233314lfh.85.1549877652755;
        Mon, 11 Feb 2019 01:34:12 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u21-v6sm2025960lju.46.2019.02.11.01.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 01:34:11 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gt7yY-0005Bn-F7; Mon, 11 Feb 2019 10:34:06 +0100
Date:   Mon, 11 Feb 2019 10:34:06 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, Andreas Schwab <schwab@suse.de>,
        Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/5] riscv: minor fixes and cleanups
Message-ID: <20190211093406.GW4686@localhost>
References: <20190118140308.9599-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118140308.9599-1-johan@kernel.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:03:03PM +0100, Johan Hovold wrote:
> This series fix up some minor issues found through inspection.
> 
> Note that the fourth patch changes which cpu (hart) devicetree nodes
> are enabled by following the Linux convention of considering nodes
> without a status property as enabled.
> 
> These patches are against the riscv-next (and fixes) branch with Andreas
> node-reference fix applied:
> 
> 	https://lore.kernel.org/lkml/mvm8szwwo1o.fsf@suse.de/
> 
> and have been tested using QEMU.

> Johan Hovold (5):
>   riscv: add missing newlines to printk messages
>   riscv: use pr_info and friends
>   riscv: fix riscv_of_processor_hartid() comment
>   riscv: treat cpu devicetree nodes without status as enabled
>   riscv: use for_each_of_cpu_node iterator

Are these still in your queue, Palmer?

Note that the node-reference dependency mentioned above is now in
Linus's tree.

Johan
