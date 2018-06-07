Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JIrPK+CzGVsCaQAAmS7hNA
	; Thu, 07 Jun 2018 22:41:42 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id BD0CE606FA; Thu,  7 Jun 2018 22:41:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24B9F601C3;
	Thu,  7 Jun 2018 22:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24B9F601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752413AbeFGWlk (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 18:41:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:51210 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752135AbeFGWlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 18:41:39 -0400
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w57Mfc65001215
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 18:41:38 -0400
Received: from mail-qt0-f198.google.com (mail-qt0-f198.google.com [209.85.216.198])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w57MfXYS020229
        for <linux-kernel@vger.kernel.org>; Thu, 7 Jun 2018 18:41:38 -0400
Received: by mail-qt0-f198.google.com with SMTP id f8-v6so462058qth.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 15:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=sNEnC5liJ6aJznoaFlANYvCiQZ3KI5+f0CBCfTNMaNY=;
        b=iulh/73Udb+NV7JYQS6Fguqku3hGRO247iuDGqv7IFie9DeKLEKCEaOK+fRDK9mGem
         jRY8oTtVZ5HO69gJOy2sDdKpyJwU4a6V31gT2ia49LfIB71c465d9cZWl8xxlOjO7mla
         8BNQIj19mytB6USPyJqjDqzm6jo9UJSMobBZM2dsu9gU1B8IMGMbIsV32sHOida8gcuN
         djAAlFflrCnTaLf9H9rD8ntaR/csiLq5KksToNb68PyJW71FKFWpOkNCttPsmsQMEGN0
         pKUuivKVA/60iDKTyDSb86jj9Cb+APDflWNO/cnqrETO8iKHxQHZPvmbFLlnijMZOrbF
         7/AQ==
X-Gm-Message-State: APt69E08msKSRbPxKwji8yhFQNEVdyb1Y2m2qxtf3ufM7BDGhth7U1n4
        YWbqjiPK4kj2VlJWwAnbHNDIwIw/gsaxzDAUerOlShIhDaBFM+lYxicPuXBJFvDcdE5tsJLFI0k
        fOm4bWCeznGQL1kgt0F/xwEfKDetpjMTVyAg=
X-Received: by 2002:a0c:b203:: with SMTP id x3-v6mr3579442qvd.86.1528411293316;
        Thu, 07 Jun 2018 15:41:33 -0700 (PDT)
X-Google-Smtp-Source: ADUXVKJc7RFhaiZTcnXZchdAYP/0/0h433HPFwKOGFRYc/6VrTEes4vKSyS25Z/yvjEnwpZBp2uoIg==
X-Received: by 2002:a0c:b203:: with SMTP id x3-v6mr3579433qvd.86.1528411293057;
        Thu, 07 Jun 2018 15:41:33 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2607:b400:24:0:cc9d:915a:7ccc:2ab0])
        by smtp.gmail.com with ESMTPSA id v56-v6sm16273649qtv.50.2018.06.07.15.41.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 15:41:31 -0700 (PDT)
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, axboe@kernel.dk
Subject: Re: next-20180605 - kernel tried to execute NX-protected page - exploit attempt?
In-Reply-To: <20180607211401.GD4481@redhat.com>
References: <21051.1528404057@turing-police.cc.vt.edu>
 <20180607211401.GD4481@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1528411294_2703P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 07 Jun 2018 18:41:35 -0400
Message-ID: <136327.1528411295@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1528411294_2703P
Content-Type: text/plain; charset=us-ascii

On Thu, 07 Jun 2018 17:14:01 -0400, Mike Snitzer said:
> Can you please share what you test is?  We've gotten lots of reports
> with failure following wake_up but I don't have a canned test to trigger

Just a laptop with 16G of RAM, no clear reproducer -  Chrome with a lot of
tabs, a mail reader, a bunch of SSH windows, and the next thing I know, it's
locked up good and solid with wreckage in /sys/fs/pstore :)

I got bit a third time a little while ago.  Will test the patches and see if
they help - looks like I'm averaging two hours or so of active use before it
hits, so it shouldn't take long before I know if the issue is swatted...

--==_Exmh_1528411294_2703P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWxm0no0DS38y7CIcAQIGHAf/XtIUwKadG6TE1Cp4TbsXt0252qnv6N2K
4SNCOxJdx1wWh3IcMrTc9Ff/iWuABARWhWjOOFsn88tG81WYBVveuF1rmy+vVlX+
MJ6vTiuJKZDLQxvSn5q/2FA70CnG9OR+Hfih9RTXo9Qqzh5+iLxX6ON/wIgX9big
ANChJeSh5+dtey5LDDy2mL43BXpLtD2vAxtjnrrk0R2pD9qOHmc7eLoBamrE8qwr
BTBUjCMtREE1wO+V5ZCUWmS62gVjlh54rgLEe/Zw3Ug8TZcpRghlVlIgvoUE0IqU
ZlNF8V4422yzu1qDF2moR0YFJxxusamPlxspDOm6+J6JuiHM0X0oKg==
=mIUo
-----END PGP SIGNATURE-----

--==_Exmh_1528411294_2703P--
