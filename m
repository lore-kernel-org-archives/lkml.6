Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F45CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7AEC21780
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmFbADhQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7AEC21780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbeKOBKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:10:17 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:45852 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbeKOBKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:10:16 -0500
Received: by mail-lf1-f43.google.com with SMTP id b20so11709600lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 07:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8OQTZC8ADrC7YKRerZWY5fDQCTbH9n2BV79a+m9XLaA=;
        b=EmFbADhQmjIbECgCFPBFBYgNR4VHkFdhbtEQFMFgRiGvz37KvPMDYD4TVtexjytRXs
         RPwdpa3rJ6nYuNQSCHu/ah0Q94tJAqoJQP4GGRTtQfDY1aW+xyVSbFUMFEGdpeDLq91J
         tM+GzFt5ssrCWwc1bPYtU10ozone37d/DuRfFPink3bPFEQD7OYOrNbFiUmJEGD8eVKh
         S3w/d9j4XDmDlRFbwRWT+/p+rnscAwjuAR7hkv6TDPQRO7sEU2uVnWGkuQN+2oPs2hEh
         tHAwmU2Svb2tz53O9j3dp8r4+qvnwe2I095hHXgXSALOHRaotsz+HTQv6gK6u/UGWR4n
         XDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=8OQTZC8ADrC7YKRerZWY5fDQCTbH9n2BV79a+m9XLaA=;
        b=Wq4eVKQlP07LwTbYJz6IrSPy3PEUzLZ5NjcEySGlCoGFyR1XkrRhMsXuJAcxM4cMHf
         ys+5d3LB7aiG4yK/AQbL9ssKEY5MpjnTxwW3rFHOTf/3U5++IIla/O5G2AAjdh1jl4RK
         F9ZoRpYyjjjlIa8xzOzr4+GrTUHgpjH/5EGaF3lwRNF0K1qbOngq3zSXyb55Nm14PY8e
         E9HO1lofCEjTKAahIj11IzFqduK0AaEaIWOQuiHOxeWsQZxEiCAD5O+/phT6RGGWtQ3y
         W2roD70BSfbhKDY8eb8RZBAM+K18uFZQpWnfclEHi05Inhbtvu6gEdkb4l/fEpm9781k
         RGxg==
X-Gm-Message-State: AGRZ1gK+78gTPXc8dWqficMjcPbajcROnZ/uAUq+7fvvDnoN0kxmr92o
        KABmfGvmDLioMRZ9buiyzuOJ1jCV
X-Google-Smtp-Source: AJdET5dnSVDcI9MdTuh7FgO5eBnF8bhwoTi9CfyR7TErRymdN4z6rP+SdrQGW4V+VNS2ByjiLjfSUA==
X-Received: by 2002:a19:d912:: with SMTP id q18mr1071487lfg.24.1542207998821;
        Wed, 14 Nov 2018 07:06:38 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y80sm1279051lfd.36.2018.11.14.07.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 07:06:37 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gMwkU-000560-Gy; Wed, 14 Nov 2018 16:06:35 +0100
Date:   Wed, 14 Nov 2018 16:06:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS fixes for v4.20-rc3
Message-ID: <20181114150634.GA19442@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-4.20-rc3

for you to fetch changes up to 9ac9252b4bcdaa7c257b707584b7e06effa7c992:

  gnss: sirf: fix synchronous write timeout (2018-11-14 14:35:47 +0100)

----------------------------------------------------------------
GNSS fixes for v4.20-rc3

The two serdev drivers were using the wrong timeout argument when
expecting the serdev_device_write() helper to wait indefinitely,
something which could result in incomplete writes when the controller
write buffer was getting full.

Signed-off-by: Johan Hovold <johan@kernel.org>

----------------------------------------------------------------
Johan Hovold (2):
      gnss: serial: fix synchronous write timeout
      gnss: sirf: fix synchronous write timeout

 drivers/gnss/serial.c | 3 ++-
 drivers/gnss/sirf.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)
