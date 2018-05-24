Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155408-2-11847205247931119166
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155407; b=i1xhlQ1g067QBRCkOYSvpvh++3BniOrsh0il/rBSnHWk2KiaXa
    l9K6DxrlxgWSEnYM2RVJ+xcOPcmeLFe5azWP8ExMCvHE+WZ0J1yPvCpukBjH6pQQ
    k16zWIBlLW12TE6R7rO3DeVaDKYAL8USta2ZNt1FuDjkDmFJxbr0wK9BNp5iarmU
    uA7DtTRwSmnqyOHDDysQoYTK8+CfIkMxvlmVgDvsHYy9ay1zR9SjboQgiiaV6ame
    Y/hrAzwqPu8lpGduu4ZLxrIDdqo0tYfNez3kmQVqs+OPy+UfZ8zLVS7sdmL7sV3o
    H/tVeausRZAl9b4bzs5aX4iGfBcb0ZHVka8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155407; bh=AhFR2XV1t03viSOJq6TyeAQAakxIvf
    /2FrO2U5VJCPs=; b=SNImz2+Fz4oL6keJTu75fjKWp4wPy2MWGQgn+BkfhHYfLl
    ax7yxVU5moqKLEZpYWZedARCh33VJw8B2USkFdPqRQZ+9DN+f/AtQWx5iKKVrcXH
    Abg1nK4jg5STh4sieZVRQUgO8QTvHowmS5n1ebJRYjixX9PxuuYt7NYoW9ZztUk7
    kZoi2C/C7RDM5ZrJMynnjUE5DKZfHh4TfLENGwVlXmAKIbKCfHqVNpLOn6tZf6/p
    3Bqp0soVVLpVxYaWdbc2MhPs9E0h1CLXh8X98X75iCwSucZrLZUuAaoBTwnrt+mp
    ep396AVy5R28PXzOn+FTg4OhPE0HUsp1tE15sg4Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=AqUfB7FF x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=AqUfB7FF x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF2zJKJyucW2/Yt9wS56TZgn3TZy+FW6RdZ5Tu1sZ8i7wdY0zNKUcngeAfkgmnM0bAB42EYzibfuIj8pHj76W0CShi/mysXXGqIFk1Z/wWboIq69Xurr
    TqfU1LkvvIVMSSkRZcDZgL5Xy6mtbLmAJ37oOlHwC0O/GZopfvFZYPGy/ZoCkTXlYcDJujI/jRWbj5GR41knkbKmxCcCLkn1kGd8e5vLkwFbO9JK+uOiimKa
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=vQBBkBfzAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=qKmdj21Zsmxc0eqd690A:9
    a=QEXdDO2ut3YA:10 a=NGXS0kB0m_rannUenejW:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967480AbeEXJuE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:40248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967432AbeEXJuC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Brad Love <brad@nextdimension.cc>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 73/96] media: cx23885: Set subdev host data to clk_freq pointer
Date: Thu, 24 May 2018 11:38:56 +0200
Message-Id: <20180524093609.575549271@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Brad Love <brad@nextdimension.cc>

[ Upstream commit 5ceade1d97fc6687e050c44c257382c192f56276 ]

Currently clk_freq is ignored entirely, because the cx235840 driver
configures the xtal at the chip defaults. This is an issue if a
board is produced with a non-default frequency crystal. If clk_freq
is not zero the cx25840 will attempt to use the setting provided,
or fall back to defaults otherwise.

Signed-off-by: Brad Love <brad@nextdimension.cc>
Signed-off-by: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/pci/cx23885/cx23885-cards.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -2282,6 +2282,10 @@ void cx23885_card_setup(struct cx23885_d
 				&dev->i2c_bus[2].i2c_adap,
 				"cx25840", 0x88 >> 1, NULL);
 		if (dev->sd_cx25840) {
+			/* set host data for clk_freq configuration */
+			v4l2_set_subdev_hostdata(dev->sd_cx25840,
+						&dev->clk_freq);
+
 			dev->sd_cx25840->grp_id = CX23885_HW_AV_CORE;
 			v4l2_subdev_call(dev->sd_cx25840, core, load_fw);
 		}
