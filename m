Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E81C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CC02086B
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ix5CyBZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC02086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbeK1H5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:57:24 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54041 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeK1H5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:57:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id y1so410602wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3VZ2NLWzQN6I1sonLGUAKwWIQMJmqOFvAQ3LoVPLKHw=;
        b=Ix5CyBZYTTDbLV7wf3XH04lQgsOybe2RmF4ReRCdXruH0yZn+lOjT44WO5Ao9TAjmc
         DiahcovlvTU1cMpFQc4ejELZG2qAc6QCsl6+Y1ko9LD8ec/vrUTF+D1DmLj7aEIXyMP6
         LkNUjQGO2kinPYCCjBfEWdLFYh9mKo1B5Kx8miV6gc6iLnC79BdZeXjpae1gXeA6hFKu
         91zQgWHdGwjg0oISfCh78vCJm0hd/JfSl4lZRSvm+HneQAnh0uwpSzD6MCzKGY1huSOV
         1f8Vv7xp5gowaAdW5GY8DsFM/I1Fu4Qmy1Hg3zwI5IkpV3GSOEnRzJd1EsQjmaVvSTAZ
         JAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3VZ2NLWzQN6I1sonLGUAKwWIQMJmqOFvAQ3LoVPLKHw=;
        b=a8kgWmLUNvFIAO+35CSZmgVBy+4MPOxoqdNSbsN3LwVCYgTDamjbLcCW7SD5SGf9vk
         H4yAeuJLFIDnfzg+Bgr7Hi9bJOeYza36tYFAuWaSTh00vC34ssPxQVDj9WzgXU67j0yF
         2vG1RaqQFP6bbVlYCrUQfz2D7pKe3gYH0hMdcid5FG8Qvm+86YjVQ+cJTryWevW2jv70
         jqW4+qwvVfQX9+vw6U/fXY9gghq4EMO4Kkdx2z4cYn5+8YuxQKVgvgXX06zW9DuK7WaY
         FoI3F4CeZUxcvG6v4PLSFzWqY186UBq5jgfQ9VqPaDzRdSmtZDtChPh3pDMwi+UN3KW3
         16kw==
X-Gm-Message-State: AA+aEWZmySen9Fa07HRfkqrqTU2nARfrchFuOq3aK/jrlsMVxUJXn/e5
        49/PAf3ibyT11ymMK43GI/o=
X-Google-Smtp-Source: AFSGD/Xt7ZEVl+xBi3oMfdFbYJHD3rUqUFOidA+kIqGDDlWgENO3Xy3gOk95diLF8NzFAbKEwfXxjw==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr404708wma.68.1543352293204;
        Tue, 27 Nov 2018 12:58:13 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id c13sm8414232wrb.38.2018.11.27.12.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:58:12 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Parenthesis fix
Date:   Tue, 27 Nov 2018 21:57:15 +0100
Message-Id: <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
References: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first patch there is a fix of some parenthesis that terminate
on end of line and some parameters that are not aligned with
previous parenthesis.

The second patch is a proposal that avoid the long line refactoring
code removing cast pointer.


Cristian Sicilia (2):
  staging: emxx_udc: Align parameter with parenthesis
  staging: emxx_udc: Remove cast and move all in one line.

 drivers/staging/emxx_udc/emxx_udc.c | 282 ++++++++++++++----------------------
 1 file changed, 111 insertions(+), 171 deletions(-)

-- 
2.7.4

