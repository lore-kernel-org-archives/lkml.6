Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CE4ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE33020873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXWc3/2s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE33020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbeGMLh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:37:56 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:46608 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbeGMLh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:37:56 -0400
Received: by mail-ed1-f43.google.com with SMTP id r17-v6so24328300edo.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gH5K0OBQGlxfZU0Kj2XYIx3tUiUonKUAC8Ik4Dq1dUo=;
        b=JXWc3/2sE6Nm6SXfR6mGAa20G3lYEthYhvdBCfsGta22s/Ko5oryrDJLu0tWN51FR/
         HLCU/KntR9ho63gasRuUJJ3SfpfHWqXZYfPp9kY1s6MCjNlZZW3l/MJcxubn7+d6b35f
         aC/vAAcO6BIDc5FrBgI/T/2yY00bpDXEwpdZeWbuMn9pZvT8CtiWdLo5wXLi0lwbNjL/
         9fb3GJJUeWgNI0hvgbeV3K2w7wLHJchn20vcHd31EZhLQNQb33+eDhSrgr2mt5U+DuSO
         PCN8zkSTpfq3qfebQoldnsusxztbaAKxtcrRn2LT2YfbhekpcS6rutOoQPx4aLMkIKE9
         rJhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gH5K0OBQGlxfZU0Kj2XYIx3tUiUonKUAC8Ik4Dq1dUo=;
        b=l0Q/6ttCxXRoO+a73eerP6bqYslYkVqs0FByUZefj0cIm8v73EqiDugKxTSs6gTHiK
         mMWE2XVhtDzBTAOgZnCstzmfztUJBgqjmd/pzmaDuooDyfGWPGFOHRql+yi27U8u3qG0
         e0XRBTeAAPotGIZXMVQBe5GIVoMKVXJUqSRAE84ngC5W9RiBboFyjZuIW5qokYy8VkFN
         LBUM1rKBDD5nhdlzEsRafIIrDTbb4AsUfM8AN6AyTqegdQojYwoVp1+HC9fOcIvZH3Kf
         FenBvRoIwNM1gN75PxA6fA5A4Kylw9y2a/c74SloTaaIu/8RdlXED2SXgAQLFp2fTPxd
         rYxg==
X-Gm-Message-State: AOUpUlErPWXc0ZabC1A6yhieoDRJKWgmtHminGtRubwFs9eLmwOVQlCD
        9HeQcvLB6J/mdBpLOr56ozx84j5V
X-Google-Smtp-Source: AAOMgpfnifCqV0qVpg7p1zH4H0r5eTdlYKD+4BaHOVvrx2m5MLT+JapmBLoQ90M2GQZ/wUEN1y+Rdg==
X-Received: by 2002:a50:ca02:: with SMTP id d2-v6mr6378570edi.53.1531481020026;
        Fri, 13 Jul 2018 04:23:40 -0700 (PDT)
Received: from localhost.localdomain ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id r25-v6sm9392868edb.45.2018.07.13.04.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 04:23:39 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de
Subject: [0/13] staging:rtl8192u: Coding style changes
Date:   Fri, 13 Jul 2018 12:22:58 +0100
Message-Id: <20180713112311.544-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is just coding style changes to clear checkpatch issues. I don't
think that there are any changes that impact code execution.

I tacked on the end a patch from my last series that failed, again just a
rename to avoid CamelCase warning.

jwhitmore


