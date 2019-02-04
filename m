Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70508C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD582083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549265121;
	bh=ftO0qA2PRcRJL3vSVOWrc24xWkR3zFfEUciDAJR4Aw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zBRC+rSQFgYg+fs+Pm9OrOm3cEQ/cUHNoulNvIfs0VaMDUa5QaWbuYfj3Lu2QvfFd
	 kflYVdkH8wNACPUunHJK4agZ+y8xShw/SB5Ov2tfx+aZyi4YRnWcEzvS2PzVWyDV9p
	 D5RsFlZk9ug/V1iSbZS2+3XAZcs2DGczGCPgzwzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfBDHZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:25:19 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46760 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfBDHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:25:19 -0500
Received: by mail-wr1-f66.google.com with SMTP id l9so13151310wrt.13;
        Sun, 03 Feb 2019 23:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mqWbLQy2xmqwwljVim8KsNdXxcP6SOLzqImasPCYQ6g=;
        b=j6Xp4hMsZ8cdcqEjpVvy4JC/Q/FKz5sfRBEwq0EkagddlaqnLW7LqSOGwhw6aeHODt
         xPDplQnVIH7mbYLMqNSUwgVb7sYYVxorjN2aGFJ1Sx8JeGsdd/eb+VV9aGpYJrScxBRi
         Qh8wt1yfml+TKblkqMe/vyuflYFQnOXhz+HObXjbfTjPFg1usuxDmyZwEG5HaLkSTFfa
         pgeKAS7aq23x2xrJcw+C961fswIlkTIKvtstRQulhEdgJUwSy7pSUUFYQxJzN/V7DhrP
         3VdiZ/twbVoariOuvEn5opxbcKbB63sV7kSgWVo33R2elCBhDciZ1FvCIHnA/sU2TXDz
         9/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mqWbLQy2xmqwwljVim8KsNdXxcP6SOLzqImasPCYQ6g=;
        b=ppNeA+AXdb/LVwOiFR0VXtUOaoQVVc+vpPsVK26SdTHhTH7xJMTvrGj+KIiZxQf5hl
         DZVg/Czx9A3N24FGC534hh9gWs6k4WkMi3snvrknC4gx2RN2SJDg/NHVZ8pw4oFax0Z8
         YxvwmeSIYlEXufMh59n5ZlI9oh9QH0fSXYhiGPlwI02A8yDa+R74bq8WRUSPyTwx9a/y
         9nRMt1d9iaa4ngmvHN/GhAPMkf50Q+gYfJtr0IDoCLDifoEz+FCsbUlge1+hKVEBwaMZ
         MD4Lj3QeO6a01hI8gnOe7BZICEfquOFyGA+ZfiQ4sWhql/Oe+LGZCGPGE2zuPypLbQEZ
         zFyA==
X-Gm-Message-State: AJcUukcFR2k1mP/jgJghZA2cahNpF+SnKiDjh7QARQf8X3Y0dJKNmxY+
        MUHwkBhOcmdjWymd2jgemRd/c3xk
X-Google-Smtp-Source: ALg8bN4ex6varlh1m3TTtjrm1xBCqhm/b+B97vBrkt3WDTDGzj39QRmCXwwHPwbqlU+xCIs0h7JesA==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr45126592wre.94.1549265117372;
        Sun, 03 Feb 2019 23:25:17 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v26sm16128817wrv.78.2019.02.03.23.25.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:25:16 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:25:14 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH 02/10] x86/efi: Return error status if mapping EFI
 regions fail
Message-ID: <20190204072514.GB115714@gmail.com>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-3-ard.biesheuvel@linaro.org>
 <20190204071809.GA115714@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204071809.GA115714@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> Note that I also fixed up the grammar and readability of the changelog - 
> see the updated version below.
> 
> Thanks,
> 
> 	Ingo
> 
> =============>
> Subject: x86/efi: Return error status if mapping of EFI regions fails
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Date: Sat, 2 Feb 2019 10:41:11 +0100
> 
> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

Also note that I left out this patch from the series for the time being 
under the assumption that it gets a v2 update. Since it has no 
dependencies in the remaining patches AFAICS I applied all the other 
patches to tip:efi/core.

Thanks,

	Ingo
