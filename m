Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56930C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A65C20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 13:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhgGcVN4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A65C20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeKKXPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 18:15:23 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34073 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbeKKXPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 18:15:23 -0500
Received: by mail-wr1-f68.google.com with SMTP id j26-v6so6486591wre.1;
        Sun, 11 Nov 2018 05:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kexUSHU/P4lTvyulUAn8elK0vRaAB0bNA8nSpGVqOLA=;
        b=YhgGcVN4bwEjgN+OC/pLwykN0GyT5ZP0gvy3bbVgHwe/J1JnpLf+qK0NYyHCek9xcT
         bZmk4iMKx+nNg1CeGv9cLhQXHeB2KHWcqcHS+Aa8Rzzfi1sOwYsbAwO3qzZBP6tcYslF
         PHexWvm8uPorwFcTtTgshSdaGSLh8HRkUxbKV21DPAqhGUbrbSKGEBG/EhIXZPxCtVKJ
         sa8XWfRa69WqwAiDEmQNkLmVz4nYQquS/tqWZRmo2kA4BIyTZ9BmQEYNvyRLbWCZfs1e
         9x8wGZxNGEFDl6BmQXhh89h4plcN64YxcEnWjnqDWMHd+vMU8rhyCTgQ6zPYJ3wsUtf3
         xPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kexUSHU/P4lTvyulUAn8elK0vRaAB0bNA8nSpGVqOLA=;
        b=h36hvsZ1bAXcGvPjzJ+1B7SwmRETqUhqCHy4IcEZFGpefcU695WXovl2SJgtLucNPf
         c3D+ZMtys/29E1xYpQgQEO7VtQCKPN0oTNvZveSbL2CnYHp6cn0yrbiLMfX7Cdsf0WJX
         JkZJm0J5m67D6YOWRU1VfdVYAPrhF8HMSCCrfV04Xl073wfWxAWt04xXi2k87ABER/Bv
         KjPbHPvw5bb4J5kCQYmblUtEw5hzghyAn6fJYrAcYynjpW3bU/9OaUbeNDeMHCGGOiBq
         oJ3TekrFazfp19BeOAd7+HTmcXUeWmhRGIGEmtH8ncuZyNImVYDLOqlpgColrex1ZSD6
         XmQQ==
X-Gm-Message-State: AGRZ1gL5l3ls7LLGkJNi/RXbeUNG7YTkBcVoPZHdrypoe6NwrxR7dF/W
        SSZlzxhfuMDHhlMZpCkkQzc=
X-Google-Smtp-Source: AJdET5ffElLcErXxDQCOtswxHs+q7iKQGXLMNIB03Rt6/gD88d2DTo+y3r90/Co8vm9hgl7YqyEwjw==
X-Received: by 2002:adf:f44e:: with SMTP id f14-v6mr14806409wrp.40.1541942806160;
        Sun, 11 Nov 2018 05:26:46 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d044:7580:7601:a7bd? ([2001:b07:6468:f312:d044:7580:7601:a7bd])
        by smtp.googlemail.com with ESMTPSA id e10-v6sm17900928wrp.56.2018.11.11.05.26.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 05:26:45 -0800 (PST)
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
 <20181110190521.GA2627@thunk.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
Message-ID: <566bc821-f12a-f7c1-e7c7-99092807ee27@redhat.com>
Date:   Sun, 11 Nov 2018 14:26:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181110190521.GA2627@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2018 20:05, Theodore Y. Ts'o wrote:
> I wonder if a better way of adding SG_IO command filtering is via
> eBPF?  We are currently carrying a inside Google a patch which allows
> a specific of SCSI commands to non-root processes --- if the process
> belonged to a particular Unix group id.
> 
> It's pretty specific to our use case, in terms of the specific SCSI
> commands we want to allow through.  I can imagine people wanting
> different filters based on the type of the SCSI device, or a HDD's
> WWID, not just a group id.  For example, this might be useful for
> people wanting to do crazy things with containers --- maybe you'd
> want to allow container root to send a SANITIZE ERASE command to one
> of its exclusively assigned disks, but not to other HDD's.
> 
> So having something that's more general than a flat file in sysfs
> might be preferable to resurrecting an interface which we would then
> after to support forever, even if we come up with a more general
> interface.

Heh, this was exactly the answer I dreaded, because I can't deny it
makes sense. :)

My main argument against it is that while superseding an interface and
still having to support it forever sucks, having a super-complex
interface is also bad (back in 2012 I wrote
https://lwn.net/Articles/501742/ which I'm not particularly enthusiastic
about).  In many cases a combination of MAC policies, ACLs, etc. can be
just as effective.

I'm not very eBPF savvy, the question I have is: what kind of
information about the running process is available in an eBPF program?
For example, even considering only the examples you make, would it be
able to access the CDB, the capabilities and uid/gid of the task, the
SCSI device type, the WWN?  Of course you also need the mode of the file
descriptor in order to allow SANITIZE ERASE if the disk is opened for write.

Paolo
