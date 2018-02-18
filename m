Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1274701-1518960518-2-6114045405611217622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518960517; b=gpQtNf2uacMc/ssD+sSjk33ekaz8T42IAnvIUXzWh39rMDa
    7MhT29ZlG23IQXxPncukeyJMXoU1DjXxYIl8mq3f2DKtnIkrhrOo920ZI6lOIpF9
    IFPMD2l+Y/vaPU1DG07MLEL4zr13BylSoRwlznrU2QMowFcya0pJSdBXYqoUX3NF
    iAfyNmbLUGOeK4OFeoXAYoNEzg4W4oOSqyg/xbQmMFT0lnbBsAB03NQu6kQWGwVQ
    WXTeUN6/BUu4ftBRMRP6wCf4Gt8wkbq3QWQZCPQpU3IJAKvB/alntnLhMH8i6Har
    o8Ca7qmvAnrS2gJSBW38jkbXquRVFeuuXMNQ3FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518960517; bh=7nPynlroHmTKhJ2mtNzJrCuluS
    AatutwLbr/AEzWZew=; b=NeRa5/rUeKCv/l65qzzgzrldF+g4dZ//7Heo03X3tG
    D7NV2PN/Vq8Y+PyOMMbJ0z8DvnkaIsVEAF2fbcK77U9P5Dz2n1IboT/MPXUmgk9x
    OtcDHPMu+zMjPbVO6LefQNyBMFmOtOh0kbP2xwnmZhGC8tPecHo+VXsM5TwNh6Pq
    Fd1r2L+TBNWNE74ZNcL8dlzETW8tiHuWzm2btn8rpaF+QBAmrXYmvH/8J0T8c6rL
    2gHmaZ/kd4rCIFiovIzuPq/8MWWELv2Ely7BqbNy9hQgKQ++S7F52ZiDrZSHNcS5
    vMROqnnrcXu9wNfrxen3LrjR7hUh81PWMmsiDXuMEkIQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vy8Ia45O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FW9NqU9s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Vy8Ia45O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FW9NqU9s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751428AbeBRN2g (ORCPT <rfc822;greg@kroah.com>);
        Sun, 18 Feb 2018 08:28:36 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43772 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751407AbeBRN2e (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 18 Feb 2018 08:28:34 -0500
X-Google-Smtp-Source: AH8x225Kogu24DY7mfavi3/acOGBplDZpyhMWFEvBDopCJeZGs02gQOpUtuLAe7DeGFlkYHxxnuq8g==
Date: Sun, 18 Feb 2018 05:28:30 -0800
From: Tejun Heo <tj@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] libata: Apply NOLPM quirk to Crucial MX100 512GB SSDs
Message-ID: <20180218132830.GG695913@devbig577.frc2.facebook.com>
References: <20180216094820.3587-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216094820.3587-1-hdegoede@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 10:48:20AM +0100, Hans de Goede wrote:
> Various people have reported the Crucial MX100 512GB model not working
> with LPM set to min_power. I've now received a report that it also does
> not work with the new med_power_with_dipm level.
> 
> It does work with medium_power, but that has no measurable power-savings
> and given the amount of people being bitten by the other levels not
> working, this commit just disables LPM altogether.
> 
> Note all reporters of this have either the 512GB model (max capacity), or
> are not specifying their SSD's size. So for now this quirk assumes this is
> a problem with the 512GB model only.
> 
> Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=89261
> Buglink: https://github.com/linrunner/TLP/issues/84
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to libata/for-4.16-fixes.

Thanks.

-- 
tejun
