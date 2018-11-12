Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1346CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA46822419
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 19:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="km+CihFe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA46822419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeKMFdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 00:33:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:33426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725749AbeKMFdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 00:33:20 -0500
Received: from localhost.localdomain (user-0ccsrjt.cable.mindspring.com [24.206.110.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 451EF22419;
        Mon, 12 Nov 2018 19:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542051520;
        bh=qtvAsDB2KZbBlM3jp854OgtE+iGzuwfwHzRH/8e3gMc=;
        h=From:To:Cc:Subject:Date:From;
        b=km+CihFeRd3pXs2uy9vUtDYYGJI+3IOGfspHuLtN5cGbb0onwTKIW8dcwklicd3US
         UWQLdnS4OpSc1JpNwWqLtjF4f+aiAoWmwfPFgkeFeAZpg6TfVzoyj5ewTWyVlrMTSK
         emH6iFRx3IKEWU5KLeD8gYnakw5n2LTwgHlfVeks=
From:   Alan Tull <atull@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: [RESEND 0/2] fpga fixes for 4.20
Date:   Mon, 12 Nov 2018 13:38:32 -0600
Message-Id: <1542051514-5205-1-git-send-email-atull@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's a reposting of the two small fixes for fpga, please
take them in.  They've been reviewed on the mailing list
and apply cleanly on today's char-misc-test.

Thanks,
Alan

Moritz Fischer (2):
  fpga: of-fpga-region: Use platform_set_drvdata
  fpga: dfl-fme-region: Use platform_get_drvdata()

 drivers/fpga/dfl-fme-region.c | 2 +-
 drivers/fpga/of-fpga-region.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.7.4

