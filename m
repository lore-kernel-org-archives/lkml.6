Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3207182-1524777000-3-17923904860273872195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524777000; b=GeB4tZkvOjTjMV66dBlC+g8WL1afoSVcBTIY0GmLst+beBt+gw
    fr4j7QTA/H0W7bhkiozptCDHtxmwLTxIfpkGKJrfz4dku8EgqVq58U64R7TiFnh8
    SEqUYtzq/sJiMwXuws+5wJxGnCsA407lNveiekyLlHlcbKFy/Lg6zYGCcAh9VdO4
    OVRTPCw0/HT6VdDRyll8ukm5BHJ17TG9II4evDRjCs9VHdQ7NfkoZItB+e67SJMF
    gUP8vLIg3S5XfO2+yUiP6dADdQwOWmyIHmEV21OSTxqP+R+m1h+G+Iik3tihxUnm
    liV2iIBCiqNhdKTkYD5uyqgfcflbdJiQsEKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524777000; bh=phhAZ7akCxiBBO/dUZ6GLRiZZYd7Y1
    Igga36j7VP58c=; b=u5glWh7Ywmis/XYdl0Zx80X49hZnaVy1Hscf9UkHdc09XS
    FEtYX50r8Bw7IUHrNkxHI6JanGGYz+pTtC+FN7bwNNj0Z/vtclH70AvGA6bPD7GQ
    HLuGOAuLPIoeUWLLovhl+pVJ+yd2r+ZY8M8Cg6Mgp7kaXqH/3H3mBJD6LST8+NT8
    /2K9y4z0fwyGGdB07RAotSZI/BxOAQomKQV1GEXbdvakJFdGY4YKoFGOX7ZjAh0S
    mRRQ2f4untGh1x6fWKMvm5DCzO+AN6JYCZlwW08vWvxh8GtFbwUiO4yJPHEFbphX
    SXPzA0A1zuwwYuwifLIJPhr7EPKj++Pg+tcQeKQQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hTy2LWaE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pRkZ/pW2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hTy2LWaE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pRkZ/pW2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBcyNOBg8rq2jW9E4o+m/XK5wT5cU5fLwnhZkmvSO/JANFyaB/aj32oY/UFgfnR6eefUUuHHQsLCSsSs6vuVxlKaoHg81FkTSks821s0R2CB5tAEtYS5
    CPQTi4K+IoVTvFFesjrgK9B9aAyB98dUwprly6VSXI/yE7nwjjDYlagaKfw5zqn0WvBUfzaqeTODl6rylNcrHckPWVDFehIB171+YGdUgrfZegnjcvRY0qkf
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=1RuTOim2uGYjfdPttagA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbeDZVJ4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 26 Apr 2018 17:09:56 -0400
Received: from mail-yw0-f170.google.com ([209.85.161.170]:34347 "EHLO
        mail-yw0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751615AbeDZVJz (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Apr 2018 17:09:55 -0400
X-Google-Smtp-Source: AIpwx4+fyCWO79hzhMdhJl/OB4Dq8N97ex3rHCPjrIPhj53s4CIyN3Y/xjsiezjfvY6yInNl5qDLBQ==
Date: Thu, 26 Apr 2018 14:09:52 -0700
From: Tejun Heo <tj@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "Richard W . M . Jones" <rjones@redhat.com>
Subject: Re: [PATCH] libata: Apply NOLPM quirk for SanDisk SD7UB3Q*G1001 SSDs
Message-ID: <20180426210952.GU1911913@devbig577.frc2.facebook.com>
References: <20180426203221.2683-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180426203221.2683-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 10:32:21PM +0200, Hans de Goede wrote:
> Richard Jones has reported that using med_power_with_dipm on a T450s
> with a Sandisk SD7UB3Q256G1001 SSD (firmware version X2180501) is
> causing the machine to hang.
> 
> Switching the LPM to max_performance fixes this, so it seems that
> this Sandisk SSD does not handle LPM well.
> 
> Note in the past there have been bug-reports about the following
> Sandisk models not working with min_power, so we may need to extend
> the quirk list in the future: name - firmware
> Sandisk SD6SB2M512G1022I   - X210400
> Sandisk SD6PP4M-256G-1006  - A200906
> 
> Cc: stable@vger.kernel.org
> Cc: Richard W.M. Jones <rjones@redhat.com>
> Reported-and-tested-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.17-fixes.

Thanks.

-- 
tejun
