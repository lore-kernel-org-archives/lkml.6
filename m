Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D2CC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3043F20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 23:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ABmjhLim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3043F20A8B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeHYCys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 22:54:48 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45804 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeHYCys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 22:54:48 -0400
Received: by mail-oi0-f68.google.com with SMTP id t68-v6so6850765oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 16:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8OY8BQh5z1sx5bHM+Z7pAyfOEHBwNux2JAqx8VdmZE=;
        b=ABmjhLim8C8Z+7dBrT37REqyWmnRZn6Byikij0Rem9rQJdGHJZaqFcqcwlAb3uu40v
         ivc0JOIf1IMjwNnl8Nm/fvhK/anhz94pQc+pemxxPlOhdEp/hseC0GMmGjcAuus0xKaZ
         X6+ASitM/oKITmxuWpWdzuLlbwGJ3b4AwF7wl8HpgmVX+SARcHQH7RHjvmgFHvfauO8X
         Q2VDe0E80xtVjnN6NgX+wJeGdXRGh2pRH4MJ3FcQCLBQcMRAnkkiMY+7Ld9zn10l8PNM
         tZQTfHTmKFFy/3TMmizPvvA1iD4cVyUKogaysL/FXUGwwUYlnjyXXXJepFtjsle+KegY
         SLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8OY8BQh5z1sx5bHM+Z7pAyfOEHBwNux2JAqx8VdmZE=;
        b=Br1eAinqwmj+ecDCoAbPtDEq7kGTEyEF68MiKz23uyPNLGT/t6SXU0R4RGFyclJX+B
         kOu3B2vavswVAmFt4ixhB5vBPMIU+orJSz1vATaf64pYEorUynAwTmmvTjS8VrcRWzwP
         wiPsweo+X7M/I8TMfxOAvNp+R/zNlV3holBqemZFtmlimjVmffrolk6pwlLEQgwkS89g
         0MP/1ez4jifNLMmdlEI3ctjOJ3PNPhSX2v4NHE8kq3pU7qm9gs7lzwsLA0XEXY/ync51
         BOyN7SiZLflfn/Ay66VB1WJOhRs0HPfKzm0wJdeaaHR2RDatVoRjVdTo8oh9cqSPGpQN
         rq9Q==
X-Gm-Message-State: APzg51AOkFAF5mexyovI/bJeDPIXe9byyT81SEZLyE4oN5IjOlPOH40S
        SQycf/ZAUyEAn8ppJdZNWcah28mOMdsAhPJlYy8ZAI5i
X-Google-Smtp-Source: ANB0VdZfxKcFIw4whRVr7qXQ5FRvXvs9XgmGncEd8r5Ycpy5x3JmLqjk3BBwvx0ESIUFN9mcW2leWhFUfCQ6T52hMMo=
X-Received: by 2002:aca:b40a:: with SMTP id d10-v6mr3577192oif.190.1535152684096;
 Fri, 24 Aug 2018 16:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180824224117.3356-1-casey.schaufler@intel.com> <20180824224117.3356-4-casey.schaufler@intel.com>
In-Reply-To: <20180824224117.3356-4-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 25 Aug 2018 01:17:37 +0200
Message-ID: <CAG48ez0jY6xV+nQdYRy4aT3oH+8FwAM_6MOVFQ3jwYe4Nz+KnA@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] LSM: Security module checking for side-channel dangers
To:     Casey Schaufler <casey.schaufler@intel.com>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, Dave Hansen <dave.hansen@intel.com>,
        deneen.t.dock@intel.com, kristen@linux.intel.com,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 25, 2018 at 12:42 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
> +config SECURITY_SIDECHANNEL_CAPABILITIES
> +       bool "Sidechannel check on capability sets"
> +       depends on SECURITY_SIDECHANNEL
> +       depends on !SECURITY_SIDECHANNEL_ALWAYS
> +       default n
> +       select SECURITY_SIDECHANNEL_NAMESPACES if USER_NS
> +       help
> +         Assume that tasks with different sets of privilege may be
> +         subject to side-channel attacks. Potential interactions
> +         where the attacker lacks capabilities the attacked has
> +         are blocked. Selecting this when user namespaces (USER_NS)
> +         are enabled will enable SECURITY_SIDECHANNEL_NAMESPACES.

Thanks!
