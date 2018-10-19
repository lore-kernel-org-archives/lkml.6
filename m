Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9643FECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495E320869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 16:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Df8+KY1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495E320869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727943AbeJTA4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 20:56:25 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35805 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbeJTA4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 20:56:25 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so31442789ljj.2;
        Fri, 19 Oct 2018 09:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+hr0l62+HDLRSrdcbEQyhbqrN6hEp4/aQYn+4/XSLrM=;
        b=Df8+KY1dID4yV+Ko5yzaV7jTsRE+nr4wtfTyFyIEinEwSsNPRwuhdlbdxxKpcmYNnG
         NPax8VOPFm+EkdkXaPkVvI5C8vGvZTqxOp32u/zXCJ5KuVOmd5lbNuNvb42RjGk9G5DX
         kHDF3oxSaKrPbwbayr5BLYF9Xr0Scsz+t7rv2patN3bIbzWe45ivGBNnwfK8rSs/7JSC
         pScB4r8Kugq2TgMISSGrgEZaL/Ssf6VQp+7ocpkslRH0IMT3W95I08vpsN1rej96qmgt
         c1rckGHH3KNDyCUl2kPSxf5+FBSQrJL2ritgVH9QOAyBdRddT3hEmBtwZuiNVCrpJkID
         z2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+hr0l62+HDLRSrdcbEQyhbqrN6hEp4/aQYn+4/XSLrM=;
        b=ekDwBNFhBniKiyZrh8wN+66H3htIZXhsewm2fU0G1oqEiw9X7yL3UYSwpZXk2HxWT6
         GrYnQIR550KHNfs0Z0E7BJ6E5R2lKLK7WzlL58a8aNMERvVeH9OrenvpTXTrTO6qRGA7
         atOkD2D70Q9lCkf7s13LM4f4DqzSYPL6SobGLB3UBemGM7qXJfl2tMjUib45aBjTknM9
         a/33VKVPKdmqKiNfBhL9qu8DRWQaeEVSpXPDxWf0mF+Nbm0TG4xgsYaycpTJ74Nvceqp
         SIqQlicsDGB9T+n/2RJ/WCQRmR0L55+8moY3sR+/XEqgInl10b8J37KvfAuMYgCAsgqG
         //BQ==
X-Gm-Message-State: ABuFfog4n4Hl9Z8YH2W1kzL2ua2/36W4p1reZMrVBLnm7I66GplFVI5N
        BFdbrhJGuHMZ67XQM4KlTQ0=
X-Google-Smtp-Source: ACcGV61L3YmcFUar1lnhP1e9wx+SJhDFwGgrsuOWu4obXNNZ9Vx3cvFt/IYcpVwEXUBaIb/ngLeZFQ==
X-Received: by 2002:a2e:1b15:: with SMTP id b21-v6mr20272886ljb.104.1539967769258;
        Fri, 19 Oct 2018 09:49:29 -0700 (PDT)
Received: from uranus.localdomain ([5.18.102.224])
        by smtp.gmail.com with ESMTPSA id g14-v6sm5309895lja.96.2018.10.19.09.49.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 09:49:28 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 1EE89460689; Fri, 19 Oct 2018 19:49:27 +0300 (MSK)
Date:   Fri, 19 Oct 2018 19:49:27 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Jacob Bramley <jacob.bramley@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Adam Wallis <awallis@codeaurora.org>,
        "Suzuki K . Poulose" <suzuki.poulose@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        Amit Kachhap <Amit.Kachhap@arm.com>,
        Dave P Martin <Dave.Martin@arm.com>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andrey Vagin <avagin@gmail.com>
Subject: Re: [PATCH v5 07/17] arm64: add basic pointer authentication support
Message-ID: <20181019164927.GO2401@uranus.lan>
References: <20181005084754.20950-1-kristina.martsenko@arm.com>
 <20181005084754.20950-8-kristina.martsenko@arm.com>
 <20181019111542.6wrvjguirglzg7vg@mbp>
 <20181019112404.GD14246@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019112404.GD14246@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 12:24:04PM +0100, Will Deacon wrote:
> 
> FWIW: I think we should be entertaining a prctl() interface to use a new
> key on a per-thread basis. Obviously, this would need to be used with care
> (e.g. you'd fork(); use the prctl() and then you'd better not return from
> the calling function!).
> 
> Assuming we want this (Kees -- I was under the impression that everything in
> Android would end up with the same key otherwise?), then the question is
> do we want:
> 
>   - prctl() get/set operations for the key, or
>   - prctl() set_random_key operation, or
>   - both of the above?
> 
> Part of the answer to that may lie in the requirements of CRIU, where I
> strongly suspect they need explicit get/set operations, although these
> could be gated on CONFIG_CHECKPOINT_RESTORE=y.

Indeed. Without get/set I think we won't be able to restore programs.
