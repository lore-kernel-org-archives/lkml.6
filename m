Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF12C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46502082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544027444;
	bh=klbf+rKG/TCnQYN7HTyCyUu5Si4cSKbAngCpppaNHoo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ALu1rc+1ppsl+PBO/oDCSfK5R9K6Cevr92OfIid2+q0XeWCLNP4cjCpanw4VoIwuM
	 ir9aIJUl4aGNqaDAs7rusDa6UMpEZaRR8CO6OoaLisEKNz2tpghnVQQoRpYuduKZL2
	 SO6GzE1M+2qpcm8qUhfhJkLEEwFcWQuqOlhYdvjQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C46502082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbeLEQan (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:30:43 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34369 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbeLEQan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:30:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id j2so20370284wrw.1;
        Wed, 05 Dec 2018 08:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HOpkKQtn98M6vCYoR1drA5ytyH/ssjzpbmfnTDB5m4A=;
        b=a4B879ljrxtWJxRNQmJGXD65c9r8UuLD9KWXEyvRvSfDHDjJaYT9ZtSVxeoKfddNXe
         +vCvyqiM4q56CcS/opn58OECXLPHGV3WqtG4iSP8teUhl9257/rKW2t+xhBFRWaNY2vd
         yp8L7PirVs5zRhYeNWw/SufYk6sFmGRAtgtKlux8EwG2jeQ5xT++uIGNI9zmz/6JaBtm
         QdQuDFvJHzJtSutnfzN4J9G51dnZPOQhKECeDmMhDqehVnrQ/4JokHWX3pJzARxcLRYZ
         HOi5dzMsiUhZAnSlzjY21De9I5chPpNP7gsFFsNvjXLiubQShU2CWwlD9TShsVyfyOup
         TRFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOpkKQtn98M6vCYoR1drA5ytyH/ssjzpbmfnTDB5m4A=;
        b=mGK0BdJT5T4fBU8D/Vgt2XZHiP37dBSy+XTTBS4ZEGWL58RR2gpG3V77eorfJJ3aE8
         DpL0T/miIZmGqy/O5eYPtR1yjB3Z0O7+4qiIr9cSGRatGbjGQDyGPDDgJZG2753aS0Eg
         tuXOG3tgmpJYPSMiTktTLa3jP2A93mqIDy/yQStgUSL7B0Z29BPeGUVTn1Ib3WE17jOh
         vkAlwwe2LWgIYeWEakRFVThtF8RVIPbIkcZQ5dAVeXuvTAgzNZoKHDcxFQfwb8mbXEUJ
         o+cdyr4oUzYl1x+EuTfGYZ0i/Fsn6tAuJNMl8XE8he5oJa98L+ISsdIvqo80QRb0agQW
         iNAA==
X-Gm-Message-State: AA+aEWavc6nxQE1WmFAd50U+Z+25sgyYeykKEJ6THMQbjVkwMJOOWqMX
        /6TiXdYjBdSN8YzMzjGvH+Y=
X-Google-Smtp-Source: AFSGD/Vg6EIyYFifcL5GFCSQM4BFwsOQFn1GAikhjKdRbIB8DXkg/nf/PYHRa6VG+3QEr7RlQTCwjw==
X-Received: by 2002:adf:f807:: with SMTP id s7mr23858126wrp.173.1544027440400;
        Wed, 05 Dec 2018 08:30:40 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v132sm2189944wme.20.2018.12.05.08.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 08:30:39 -0800 (PST)
Date:   Wed, 5 Dec 2018 17:30:37 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>
Subject: Re: [PATCH] x86/mce: Streamline MCE subsystem's naming
Message-ID: <20181205163037.GC109259@gmail.com>
References: <20181205141323.14995-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205141323.14995-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Rename the containing folder to "mce" which is the most widespread name.
> Drop the "mce[-_]" filename prefix of some compilation units (while
> others don't have it).
> 
> This unifies the file naming in the MCE subsystem:
> 
> mce/
> |-- amd.c
> |-- apei.c
> |-- core.c
> |-- dev-mcelog.c
> |-- genpool.c
> |-- inject.c
> |-- intel.c
> |-- internal.h
> |-- Makefile
> |-- p5.c
> |-- severity.c
> |-- therm_throt.c
> |-- threshold.c
> `-- winchip.c
> 
> No functional changes.

Cool!

Would it make sense to organize it a bit more and separate out vendor 
specific functionality:

  mce/cpu/intel.c
  mce/cpu/intel-p5.c
  mce/cpu/amd.c
  mce/cpu/winchip.c

  mce/internal.h
  mce/core.c

  mce/genpool.c
  mce/threshold.c
  mce/severity.c
  mce/inject.c
  mce/therm_throt.c
  mce/dev-mcelog.c
  mce/apei.c

?

This way there's a clear separation between low level, vendor specific 
MCE logic and higher level MCE logic.

mce/apei.c, if this is an Intel-only feature, could perhaps become 
mce/cpu/intel-apei.c?

Anyway, your patch is fine too, so whichever subset you decide to use:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
