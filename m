Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8ECC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD6C21C66
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="A0KmscSo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD6C21C66
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753565AbeGCRD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:03:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:35100 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752997AbeGCRDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:03:53 -0400
Received: by mail-io0-f193.google.com with SMTP id q4-v6so2381821iob.2;
        Tue, 03 Jul 2018 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GPmHq6ORFm7DkUSbBunQzoszqpGX6PZG9reb2nMXrws=;
        b=A0KmscSocuGShV4AuVOC5Cr+CM3fC47O9oCPjhduOkj00Y4WZ4DhpppKnLkv/W67p+
         bV7ceCN2vcsGykswPXhpglc7W4kH22invnQla8F64izDuDCwh6qWibToH2Ab11fwjfEw
         LYNn0Ev7B4xpT056fmJOtsaplzeFoUGLWao58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GPmHq6ORFm7DkUSbBunQzoszqpGX6PZG9reb2nMXrws=;
        b=oWoQb8HhbAZp6mlXTSRQ7GK+fYVKCGvOFUEvfXWIG3V/MrqIlhzDHDELwedY+GleBP
         bbURHVdYkBODDOnMUNYGTqilY7i40MjV4iWEKQZNoaZ3bQO+Nj7nFDzfPyC8CzF4dwLv
         1MnlysYXjcwPQ4XCWYTPpoHQ6S7JdlwT5FQ6fwKQdePLLxa7HTY2x0L85sN2rvw03p82
         OJ00sjZbLRmcLYaZxyl+W6nI/eYCxNetAMq+ughA5Twjhx4ZUjzUmgjAFUEd6lEmIhEh
         lIIhTcZpzkqpiBjoiQ3SErStvz/37nmv2qoIkPaXUnKPJl1x9NVmSaKdhZ0BMr8mfAqJ
         5bJg==
X-Gm-Message-State: APt69E2OC/F/qtnVZvAKEoUfrbcbXShOhd13SLGnwbhg2/HYgXrRSjKs
        coyxQBuKci/HauIPxM2Rh/m27JkztQI+8rzc7vahHg==
X-Google-Smtp-Source: AAOMgpcC2Z0P8cq+Crd4Y5ZQoUDWbzabOlY4CF7gnpRyLAPMzbnwO0t9Jv8QCrtW/36FqWrvIAFp0hq0bww62GfTvu0=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr26715382iov.203.1530637431712;
 Tue, 03 Jul 2018 10:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180702.220348.527254946062449999.davem@davemloft.net>
 <CA+55aFw4+YPQUh9RTJBzxdvJ9Xf_s4soPLbCXsXuhHT0TjPtZw@mail.gmail.com> <5b5509f1-9713-f1bc-cb33-18ebdb1cb8c5@linux.ibm.com>
In-Reply-To: <5b5509f1-9713-f1bc-cb33-18ebdb1cb8c5@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jul 2018 10:03:40 -0700
Message-ID: <CA+55aFxn_3kkxyQX-ZN_W_WhEWAsGB3i3FitAihCU4got63CYA@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     Ursula Braun <ubraun@linux.ibm.com>
Cc:     David Miller <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 6:52 AM Ursula Braun <ubraun@linux.ibm.com> wrote:
>
> Thanks Linus for your revert. I run a test, and found it is almost fine.
> Just these 2 lines are missing:

I should have realized that. I actually looked at it and decided your
other changes made that unnecessary, but that was a thinko on my part.

Fixed up. Thanks,

               Linus
