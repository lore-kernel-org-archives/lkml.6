Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2A9AEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9336208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 00:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="a1yfOKX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9336208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935937AbeFNAJP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 20:09:15 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44087 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935764AbeFNAJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 20:09:13 -0400
Received: by mail-pg0-f66.google.com with SMTP id p21-v6so2029623pgd.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 17:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=b+ze/OARDFjoAOrU+zKI/eBRHrBH1ASzL0sb1nCeMMw=;
        b=a1yfOKX29JBN9exBn5zmHQ7Vs0dx9haqrCUgR4US/4usc8NZZ6BWk9oOfw598G2PoD
         cyUYAMpRpPoROd7juJ24zF+OSuXd8pULWDK168Lx0jhGOxmtJwfJJ6PNjybo5YV7F+Nj
         sZdAj5X45U1n7ONkDZpNCX6CnSF6CAjS/tbVctZ3Bnw9pid+fydbvUV21doXBF0WmIgD
         xTFzU2qmt5xtTFgAiCgA9pZKya5psHccsG8VpJKhCCy7VEziF2Ro7JV22e1nZ3wNL+dj
         RlUSGaIQs7pRnMJIMPYKFoa5f1QVjTamb0KnTMxdLeSFL5nV+wmdo31DdvHQ0nj0zw5H
         5dvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=b+ze/OARDFjoAOrU+zKI/eBRHrBH1ASzL0sb1nCeMMw=;
        b=XQM+/2Zas2HDNBkb2uQ1CB2iZdSnZoGdjOes34USO371xg4RUAZaae0M7UqlJBjfDk
         7W4oGjO9NyS/R4qJXTM9M1Fzk9iTZjOHBILZn/U7R4TG/0cPlWQcXJGKXp8AZquNQUYC
         PyCqfKI0HpVdTWszKhmYZg687NnQXsPQ5s9JCAtBNkZ40qLHFrE6/i0RAcqTh8qHB3SH
         SujHiFU57xkFjpsqkpDLLtaEgOyJrbRaazFz4zdZiGseuBauzKFYLIYDXdjqUhVrIQ93
         gB7CzCVZLNeca4ukDjwVvl3EzaT9+ccPlW9Ps2wfDynLNR0ACbwI0+l/KhUIp4FZVtRf
         vmuw==
X-Gm-Message-State: APt69E3eeCgCVLRM1IqbOser48pQNphOFVIY+ToGCS75fouPDiWGByET
        SngYdAl63REJii7GKv/kU7MdxQ==
X-Google-Smtp-Source: ADUXVKKu7YBr28PGEqVA5iN4oDGuHUR7Jmr7R+CJN5vZLm9FTXWAgvYph1XJfkM330PvHY+dXrg15Q==
X-Received: by 2002:a65:6252:: with SMTP id q18-v6mr295481pgv.106.1528934952843;
        Wed, 13 Jun 2018 17:09:12 -0700 (PDT)
Received: from localhost ([98.237.141.101])
        by smtp.googlemail.com with ESMTPSA id t21-v6sm8197596pfi.22.2018.06.13.17.09.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 17:09:12 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/21] 3.18.113-stable review
Organization: BayLibre
References: <20180612164825.401145490@linuxfoundation.org>
        <5b20444c.1c69fb81.cb5e6.5a8d@mx.google.com>
        <20180613044055.GA32451@kroah.com>
Date:   Wed, 13 Jun 2018 17:09:11 -0700
In-Reply-To: <20180613044055.GA32451@kroah.com> (Greg Kroah-Hartman's message
        of "Wed, 13 Jun 2018 06:40:55 +0200")
Message-ID: <7hfu1qw7o8.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

> On Tue, Jun 12, 2018 at 03:08:12PM -0700, kernelci.org bot wrote:
>> stable-rc/linux-3.18.y boot: 52 boots: 28 failed, 18 passed with 1 offline, 5 conflicts (v3.18.112-22-gb0582263e3c9)
>> 
>> Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>> Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.y/kernel/v3.18.112-22-gb0582263e3c9/
>> 
>> Tree: stable-rc
>> Branch: linux-3.18.y
>> Git Describe: v3.18.112-22-gb0582263e3c9
>> Git Commit: b0582263e3c9810fd887ca92d19cb9ff30a4d9f6
>> Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
>> Tested: 24 unique boards, 12 SoC families, 13 builds out of 183

[...]

>
> That is a lot of new failures, did the whole lab fail, or is this really
> a problem in v3.18.112 here?

Whole lab failure (more precisely, lab operator failure)  ;)

gak, I updated the rootfs images to the latest buildroot, which forced
me to upgrade the kernel headers used to build the rootfs from v3.10 to
v4.4.  So I guess it's no surprise that every single board panic'd as
soon as it hit userspace.

I downgraded the rootfs, and re-ran all those boot tests, and now things
are 100% passing in my lab.

Sorry for the noise,

Kevin
