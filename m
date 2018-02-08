Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224G1kDgZAahxo7BOI6mrt7amhWyvGoyAur1l9ILsj/2+m0Gk8XtnRVSnnRYL1z48WFKEufZ
ARC-Seal: i=1; a=rsa-sha256; t=1518076313; cv=none;
        d=google.com; s=arc-20160816;
        b=KTBYTDzEhhwXAJeP9fcZopD8nlOy4swhjNNVgAKw9/+SCTMGSQCk4VHqEsjDgoJLL7
         EPCbn5WTNYIcBGqcA+bbclmjM9vMHd1Cq5A9V4Sn8yZN9BI9jNloiN5OSojcNdqD4ff8
         fEq7h5dmIWpoQf9TqrZu2fIRpUaLGKtMEPiYLkHP245gIOkRa5xutP5PUJYTjX8EZJrr
         M4emz24oq/4lVzX7qMuKK0wTV9op+s2P3KJbt+EVuNfntOwVaQjDN7sd1xvdwkKpb9ue
         nw8PxVY/UHGBtfJBJEQu9B4Fu2AkQs5zdp3kGI35yF3KPTXH6fXrTaDugwyJLazGDHGD
         FYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=MIBMG66OjvGInoLDX0sX6uMsecMdbeZEkB8wForwp5o=;
        b=hmv1Q+PJWWpGnk3yDMaSy7lEGdvadouEb6ehhDiJ/nyD3NYLDYds7vEdi7yTGs3nHA
         sHB1jFoQK4CUgpdzrbbz/zHIozZ/xqHkkHtouVvJmvD+PF+6QrkHTqbTqvKoAAtATwfj
         vpyxRtnESqyT5mcODdLBE07uD2MVua7M/54hjqp/I8djnBz2eorFscsEzNAhLnrgi3EO
         0AHh1Vv64e4iRmRjGBKBxiPUllCt5QkHl7EmCPiGrHYciS1ye20WEbPZ74Q/69hxOpSW
         tIThIj6ylYAtGsphB4AkQhJ/R+Zk6ckdFLC2xnp21wb1XQK0zrcGeix9HUzQJaJlGSBQ
         ++Ug==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=CCaMzTv9;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@shutemov-name.20150623.gappssmtp.com header.s=20150623 header.b=CCaMzTv9;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750822AbeBHHvx (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 8 Feb 2018 02:51:53 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:52108 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeBHHvw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Feb 2018 02:51:52 -0500
Date: Thu, 8 Feb 2018 10:51:48 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        aneesh.kumar@linux.vnet.ibm.com, Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests/x86: Remove 5lvl test from Makefile
Message-ID: <20180208075148.gpxuve4cwwcp2etb@node.shutemov.name>
References: <1518069029-22457-1-git-send-email-daniel.diaz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518069029-22457-1-git-send-email-daniel.diaz@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591810804203183380?=
X-GMAIL-MSGID: =?utf-8?q?1591818388722327138?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 11:50:28PM -0600, Daniel Díaz wrote:
> The 5lvl.c test file was incorporated into another one in
> selftests/vm (va_128TBswitch.c) in commit 235266b8.
> 
> Signed-off-by: Daniel Díaz <daniel.diaz@linaro.org>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
