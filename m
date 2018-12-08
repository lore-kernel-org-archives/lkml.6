Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C93DC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7C020989
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y51D5+vQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7C020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbeLHPQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:16:45 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44891 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbeLHPQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:16:45 -0500
Received: by mail-pl1-f195.google.com with SMTP id k8so3174724pls.11;
        Sat, 08 Dec 2018 07:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=sLnczKa2VRMKFvIO5jbMnrJ6/brGyJcRR9moHRU7ftU=;
        b=Y51D5+vQvCCDD3Ik/w7ZWCRzktYJYYSi5uZLj/QLcTWNSfc25UYOgPPHNoPIdqGgtP
         EUF2Q/iP3wQ6JhWbQhPRiLwLmS4nOsa4cGjb0QIcpBDhsH+F3iLNv1yoPZvqK/Q/l/jf
         EBNCuvsWsx+R8tJDFTPsD1KOtlPa1ENUAaUJM02D+v+RHH0a3aGOOwaqfKqIbQwVzsfp
         L1RR66gSa8xA0UTzsVWTElwreR5BZdXnQG1mZot1aZ8XDmYN3/700brVN15txOmsIoqf
         VQdavUorwAnDjZXfmTuy/Ov8udT2MnLfjhmlx6tn1TYtTh+gmYv5FexfGI51p50uGWCv
         CFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=sLnczKa2VRMKFvIO5jbMnrJ6/brGyJcRR9moHRU7ftU=;
        b=fvNEAhHpezJYpqc+aPr/khgFHJyoJ7br0Br7c2LKMbDe6mCRPK8z+frbkYrcgICtta
         tsV0Fl3d2uHl8EEP3wW878b2q61x0ZpFG41LJ9BewIogVQZ0bCTt4zL2qW4h+rzs7l0K
         DagFdoV9gFq9JlHoKriipXcELLik3pLdrztWfra/9iTIeCuMkmWZPPwIgvaV7AdjTx8T
         TECsB50mUJr7JWE9ypneGvO7ByHHqkAn5PAxoQrf33ZIcMr0dVbuoKuK4irxaqwkr97x
         dZ9Yi6ab/yI0W4GgTYVThxNB5nTU+l8eWgWZKxG6ml5G0d/yoOstLnVPDNDV+HkW9GZw
         J77A==
X-Gm-Message-State: AA+aEWZjki2T+4vY18QMf1ai1B1FoJJd0cP9ZEaFhSFHmNfH96tZJOZQ
        o5ccixzgyCOoETY5G5GNUoE=
X-Google-Smtp-Source: AFSGD/V9H5C/JWInArGIZXXwouEtc7KciJ++WUlpCPukIfAm3vN9qHhIAXI+71vZeNk5YqQrG3zXwQ==
X-Received: by 2002:a17:902:8e8b:: with SMTP id bg11mr6112402plb.332.1544282204244;
        Sat, 08 Dec 2018 07:16:44 -0800 (PST)
Received: from localhost.localdomain ([103.212.140.153])
        by smtp.gmail.com with ESMTPSA id e23sm9774091pfh.68.2018.12.08.07.16.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 07:16:43 -0800 (PST)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, shreeya.patel23498@gmail.com
Subject: [PATCH v3 0/3] Remove platform data and introduce DT bindings
Date:   Sat,  8 Dec 2018 20:46:35 +0530
Message-Id: <20181208151638.8759-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces the use of device tree bindings
for setting up the irq_type and removes the usage of platform data.
Also, code related to interrupt is moved to the new function
adt7316_setup_irq to unclutter the code in adt7316_probe().
A dev_err() message is added to give more details about the error.

Shreeya Patel (3):
  Staging: iio: adt7316: Use device tree data to assign irq_type
  Staging: iio: adt7316: Move interrupt related code
  Staging: iio: adt7316: Add a dev_err() message

 drivers/staging/iio/addac/adt7316.c | 52 +++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 14 deletions(-)

-- 
2.17.1

