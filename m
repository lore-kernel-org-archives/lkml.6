Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239C7C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D56912084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 19:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tS6HZsi4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D56912084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeJZEO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 00:14:27 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39445 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeJZEO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 00:14:27 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so11340323qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lbOtJ+IXTmF0J4dzVxEShHiifrkDS0lzDb1R83v1wrE=;
        b=tS6HZsi4Jrqa7nA/i3rhsefMxFHwVswXw7i6NWeg5m8OAzD/NvZ+vAuC9yYwmIbp/o
         wjO8wepjnu1RFURvXgk7SW+YkznE868KtnlExbf8GujOn735og0UkWjZnz2BArB4ibZJ
         KY2Z41XypQAbpLwmMihLM1A7+U4hrm70ZliMN1j9RP03+zH/2RnvmPZ8HaKBZmAARGE5
         k99xOxGn2cC7LybBf0jbd3AZdATMlG9LFplvMfkTlp+wc9DYZFOHfNYY+QC3D+TQded+
         TvjbjfaCN9pkArA1wu1oeNK+euJ+dggaKrrcWfMzw7LQBRfof2xBGxOJ2qwY4QjIeINs
         FUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lbOtJ+IXTmF0J4dzVxEShHiifrkDS0lzDb1R83v1wrE=;
        b=YDtdVuy6DisyrPe8FSbmVbOFe4J8HyV8aYnEuOTsIAp8+b67VZg8S1HgDwPhjOqi0W
         4CSX0rHJswoSMu8jB5TaTy16hQwTDoAW5MmWP+7tlqPH/n0jlTzeAaLZhm/3lo3+TPil
         MfURq4fB1rVrgSX398ne7lVowC/WUKZfitRlDe8jTJ7JNFT0ImnzuB/AM90ZlBmsPVjP
         cvSAPzEmCIbnRz7rt+I1j//BJ/FePfpDFQ1QMQ32TtEYqBW7GGwcQt1TcXz2miErgUsb
         8wYHGaNRhQPLdgl5FQ3KMwrZf0vaSpKQtc75McQqdUKhsGtjR3wIUvuIhc773OknbcXf
         06eg==
X-Gm-Message-State: AGRZ1gK7M7L5q9QldNdy5UOSPbtDlKdAIqpk/X7Nj1Zctn7/ogs7pjnW
        SCSTNWUAmt1v6Sq0/LCLbTc=
X-Google-Smtp-Source: AJdET5evG/rx9ORTsRgKfynwTp9DY48QuQqLSsxjEMRY4F9AcLn+aUCC0JR8LaOj99U2nB9Qzc6kGg==
X-Received: by 2002:aed:2ec1:: with SMTP id k59-v6mr584811qtd.304.1540496420658;
        Thu, 25 Oct 2018 12:40:20 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 83sm9583078qkz.73.2018.10.25.12.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Oct 2018 12:40:20 -0700 (PDT)
Date:   Thu, 25 Oct 2018 16:40:15 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/2] staging: vboxvideo: Remove chekpatch issues
Message-ID: <cover.1540490962.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series cleans the following checkpatch.pl issues:

CHECK: Prefer kernel type 'u32' over 'uint32_t'
CHECK: Avoid using bool structure members because of possible alignment issues

Shayenne da Luz Moura (2):
  staging: vboxvideo: Change uint32_t to u32
  staging: vboxvideo: Use unsigned int instead bool

 drivers/staging/vboxvideo/vbox_drv.h        | 14 +++++++-------
 drivers/staging/vboxvideo/vbox_mode.c       |  2 +-
 drivers/staging/vboxvideo/vboxvideo_guest.h |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.19.1

