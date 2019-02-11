Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED8C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87133218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549886816;
	bh=NIWqjA3rGla0QaC0a+dt6K7hKdm5oJQulI08eMVI6gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WCsBaDSdzGMqU6AMiIIKQcThPp1xMBRBAAFXiXAyHtgJgoBLyMlFUAgOA4pYJ/PS1
	 A19BE7SIQDFpdteHIs/jQOef1phtI852L2zIal1zG8AdbCN5JjxHeyII4V5LwDwgOB
	 2V7pAVrhiGE394Ug74N7uVo4SmvIHgKhZdpd3jGc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfBKMGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:06:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37414 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfBKMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:06:54 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so11564641wmg.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 04:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HLCHP8NxEDiWe1qBDtN3X/VTCkmbDj2pXwqcT6cfrkk=;
        b=lyWkFD1mdYdBRQGgOh8Li5uFNQG+1vE59V7ojuFhwFzEis+bzFRPAeQP/TgtmAwceE
         b6+3UwhOowm947z3q7ACbc4C5UfmmiQjvusQjRsb3ocZCTHKIxMir0lCBuH/4+8MCRu0
         h1lWSNmqHeYC4vXlbbTB0YZmUxZx/Q7adX/Swh43WngYauYhw0KNsv2BzXhap2FhyBW0
         KJ5UV4J26o6Zi3lBOr/9eYDMeMdbZIdoEloShg8YRVh52LxAvR3IKeFD4WfvHZlSO1G8
         T6dBSrGkiNT0THIvZSe3dKX8Ncdmp82AHVssMk4PxG2kmrTVeezxmXaKihhT9RkBW48M
         /dQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HLCHP8NxEDiWe1qBDtN3X/VTCkmbDj2pXwqcT6cfrkk=;
        b=guh+Tb/hAtpEEjopPsYmDeWf9iNbGxI2NI6LeStTpFcZJ8iDVpexPcAHbUMj77jgdP
         Bi77d0e9v7uxp5H0NxPjFbNLUaGdtQxYR/CZDPBKI5Cx/MU1J1VXnRJTgVV/eDGon26Y
         rues+z4pmVcauhiGSjdYqPzyC3kScLx11ne6CBNOiWMlt/ZTo6v0U3bhMkJtc5KPWZ3u
         0LqQTRwWym3BCa/cfylXz0hIPksGSUjXL6QcNgXHrnjmycCs2Nyu+a3EDkLfcAvSjbBx
         SZHpPPPnqmotdHDDNP7+SzCBIJU/zHZ9lNQqJrgb/YCz5GrwZmT/10u1kuAy7mcjGK1F
         X5RQ==
X-Gm-Message-State: AHQUAuY8/i3uYHY03/RRFdkQlUlk7X9Qhr3tgBfmhlO32TexDnamCIWs
        ZKb0SBvolm05t7yossO4ujs=
X-Google-Smtp-Source: AHgI3Ib+lDwmvVxBgv6HhkEOcg9cDaSIFcNQ+qwueukAhaQ5mZhJGXO8pSI2GqGFlDEGS3AK9OoUMw==
X-Received: by 2002:a1c:7dd6:: with SMTP id y205mr8607793wmc.121.1549886812729;
        Mon, 11 Feb 2019 04:06:52 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id v132sm12245695wme.20.2019.02.11.04.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 04:06:52 -0800 (PST)
Date:   Mon, 11 Feb 2019 13:06:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        x86@kernel.org, linux-mm@kvack.org, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH v2 1/2] x86: respect memory size limiting via mem=
 parameter
Message-ID: <20190211120650.GA74879@gmail.com>
References: <20190130082233.23840-1-jgross@suse.com>
 <20190130082233.23840-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130082233.23840-2-jgross@suse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> When limiting memory size via kernel parameter "mem=" this should be
> respected even in case of memory made accessible via a PCI card.
> 
> Today this kind of memory won't be made usable in initial memory
> setup as the memory won't be visible in E820 map, but it might be
> added when adding PCI devices due to corresponding ACPI table entries.
> 
> Not respecting "mem=" can be corrected by adding a global max_mem_size
> variable set by parse_memopt() which will result in rejecting adding
> memory areas resulting in a memory size above the allowed limit.

So historically 'mem=xxxM' was a way to quickly limit RAM.

If PCI devices had physical mmio memory areas above this range, we'd 
still expect them to work - the option was really only meant to limit 
RAM.

So I'm wondering what the new logic is here - why should an iomem 
resource from a PCI device be ignored? It's a completely separate area 
that might or might not be enumerated in the e820 table - the only 
requirement we have here I think is that it not overlap RAM areas or each 
other (obviously).

So if I understood this new restriction you want mem= to imply, devices 
would start failing to initialize on bare metal when mem= is used?

Thanks,

	Ingo
