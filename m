Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id G4THJ02YGVshAwAAmS7hNA
	; Thu, 07 Jun 2018 20:42:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 070736074D; Thu,  7 Jun 2018 20:42:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRRtZx3P"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=2.0 tests=BAYES_50,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,
	MAILING_LIST_MULTI,T_MONEY_PERCENT autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8AB1960452;
	Thu,  7 Jun 2018 20:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8AB1960452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932568AbeFGUmP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:42:15 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:33215 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750914AbeFGUmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:42:14 -0400
Received: by mail-qk0-f193.google.com with SMTP id h7-v6so7480751qkm.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=zPc6rffUiclTeWnipU8z2MyZ51aFzaFpxkvohhY3BNU=;
        b=gRRtZx3Ph9Xe26GdPuDbqHkqxJRWtrfH177NUKfFhcRvSEG6RyUOmK1FgrwI3qja41
         mhHCAksQFB8y7Ub1N+niMBH3RtvZUtNiKrVVLO6EfOMsjVtsurdExJ6WUfTObdcbdfX4
         C8+1meNOHsgsOirrWTz+oBWsNPuuJvIvqhhxGQcv/v9nqi0Ps7THBRNCZB8qkU2/7Yk7
         uPjOB5GsXj7+VeQ+P2WKy9a7PRkDuYzSBU6d5Qfmc6yRb/pg/UAJggENPvcGQDrxvQHr
         uWLiV+soFoPu4wpmFI8bVKBpZIMC3qRdQLv2o+SNKlvsSya+JWxINh3keJnL5xse2T8N
         z0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=zPc6rffUiclTeWnipU8z2MyZ51aFzaFpxkvohhY3BNU=;
        b=LxKZQhqlj+vbPwQYukLErkyKhg5ptMyxW4jdSFyy6dyE6BDb+ONId5bCoYGFl33MGI
         OauFo2lMNNacLkTfs/zuUHtVZfY6TgRJnYBzO9x8MiTdU4gWV2aQ68mWI8pdNsdYfDCw
         MNVABdU4ZyuzGySDgHo3WPROnGLNeuptld41diPQq7Ir77NT0H9G0ZklA/eUHTZgC5b0
         Qr2OPz23iR1qiY6NlydRZLlriJyIEHMduSAFNSKK8z/xBMYXfWQQXxEeMsM3ZHPkfrfc
         l5kNEfJkFTMMY6iu9kXz8yphmAPXLW0f7cVniyc8OY652epDCOqvPRHcyqCLyROkxj4H
         r9Zw==
X-Gm-Message-State: APt69E2/mUwPpDPn1xXQH2aT6zo7MmVFxtv8lwYhJxmUIi30az4m+6Ix
        dz/ymBSWlGFjZ/Hfy02I9z3jC18oV+AZVnMtStk=
X-Google-Smtp-Source: ADUXVKI9z6ORmOB1LvHf9JjXnR9uKYiyDjPNA+F+8HRey70PSr65skiSFNmFAfwuc+Vs9b0hTPTufD9i27A9ZUAoDiw=
X-Received: by 2002:a37:b384:: with SMTP id c126-v6mr2921910qkf.160.1528404133468;
 Thu, 07 Jun 2018 13:42:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:230e:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 13:42:13 -0700 (PDT)
Reply-To: dannewmanoffice.uk@yahoo.com
From: "Mr. Dan Mustapha." <officecontact44@gmail.com>
Date: Thu, 7 Jun 2018 13:42:13 -0700
Message-ID: <CAHZS28SZCHprs7zoKtJGpsQWsYtcgzT=AyjEjXu_a0d92JCJuA@mail.gmail.com>
Subject: Hello My Dear,
To: undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello My Dear,

My name is Mr.Dan Mustapha, I am a Bank audit Manager in Cote
D'Ivoire. I have a deal or business proposal to the tune of ($18.5
MILLION Dollars) presently in bond form in an escrow account, we shall
share in ratio of 40% for you and 60% for me. Everything about this
transaction is legal,so if you are interested get back to me urgently.

When I hear from you, we then commence all arrangements and I will
give you more details on how we should handle this project.Please
treat this business with utmost confidentiality and send me the
following as asap:

(1) Full names:
(2) Private phone number:
(3) Current residential address:
(4) Occupation with company name if available:
(5) Age and Sex:

Kind Regards.
Mr.Dan Mustapha.
