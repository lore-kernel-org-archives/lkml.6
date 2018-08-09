Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D04F6C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD1821EB7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 16:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD1821EB7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbeHISvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 14:51:49 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:34599 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730634AbeHISvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 14:51:48 -0400
Received: by mail-qt0-f176.google.com with SMTP id m13-v6so7181018qth.1;
        Thu, 09 Aug 2018 09:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9R7x9ToAPzwUVOo2x/YNFzCz6Om4ghoYx46d/PS8Wc=;
        b=QyZLotuZJ3KZE12uxwISx1aeZqSHC5sR0Qx2xd4IAIEi0TskJzPdFdIh7OiDWFvSKx
         Z8IziP8XyitIv/6o7OJRMH8uE791J7qx+L8ye3HkE3TC+tYpJak9gSi0YcHYibPnq8e2
         ItHlk0X4b38q40+5Eyg6w3tQX+mHPXBXeB381O5m2sHJ9VJDZKXauO54zHAiysdScV2L
         nSLZemhg0FaVmh6iS5r2Au7wixD7w3v4tpSZsycHzlSQ0/FtNIvFUF75CvrAgmIX6Nm7
         j+HXZXv3li0HKnWLr8+t2OTdmSpFgMAvpiOtlHZsqaNZINqul07uvtfa5/juT8tvUG88
         2qBA==
X-Gm-Message-State: AOUpUlEAKELzx2BSEo6OJ1424o87u8uUVPAC+vIWwITzzrFMLmzTTyUo
        d2Ai3pXC1fJx7mLsmic7dx7EWQY9iEaSD/jIkrE=
X-Google-Smtp-Source: AA+uWPzN/tlTK0oElyR8BIlTklvC+3Mwa8wEHdNNQn+U1wMpS9PoncuYEwJVDO2tn0uPxZMrQloDGKFoaeRrg0t7dPc=
X-Received: by 2002:a0c:ae17:: with SMTP id y23-v6mr2504457qvc.157.1533831970493;
 Thu, 09 Aug 2018 09:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180808174735.3114-1-prarit@redhat.com> <20180808195856.GA20912@amd>
 <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
In-Reply-To: <932b8a78-a7b4-ea8c-a640-b7f657f45b63@redhat.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 9 Aug 2018 12:25:59 -0400
Message-ID: <CAJvTdKkXTtPwvYBd5N2AGQiWcn-aAksHCht6BR+4AWP-pmGKNw@mail.gmail.com>
Subject: Re: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD systems
To:     Prarit Bhargava <prarit@redhat.com>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> "ACPI FFH INTEL MWAIT 0x%x"

> Should we drop INTEL from the above or not (as suggested later in this thread)?
> It feels like everyone is on the fence about it.

Okay with me to drop the "INTEL" part of this string -- it actually
doesn't add any information.

thanks,
-Len
