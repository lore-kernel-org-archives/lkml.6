Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31CCC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE9C21773
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 05:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgzKRZfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfBTFSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 00:18:07 -0500
Received: from mail-it1-f181.google.com ([209.85.166.181]:50217 "EHLO
        mail-it1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfBTFSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 00:18:06 -0500
Received: by mail-it1-f181.google.com with SMTP id m137so12470193ita.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 21:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf+6C6Q2gn8Yl3O4FWNWMNmmdvkyd7bHWyarizMUDJY=;
        b=mgzKRZfY5RuEkbrYiUCxWDnjszfxyhgfcXL3nAL1gQTrWHJ8m86toa5UUpFUeMB9s5
         a5NupSp24JWL0XjRpo37I2AUX/YUM/VXByHgNU3c0Ibpeag94HDc2JlqWQ9f0JrbcW9/
         gXPXEXmgfWCWZFUhQLroy3hA06TUkCie3aYTMTwtMLAqgnClvsvYl7+k3/AnIQCnP15r
         L86f7gxDOL4gfUKLlhMyajbKNxluxGZFClAhzGMXA5z9TStfaPhT2+1ar8PcZmVDgFqb
         iZYpRDIV/yXwQ2Z2P6zII7Zqhyb8oPXvjJmr9SmjHOEJaR9nOsZqx06t9+KqGwYXwJd4
         0iMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hf+6C6Q2gn8Yl3O4FWNWMNmmdvkyd7bHWyarizMUDJY=;
        b=W3WmqeyV+QVUXIX5iThz5rBCfgbdt5n6zMzXszSqL6wbyuYNPkaCxCWn9DNeFdaLLs
         ydHWfwLyFVpJVy7kKCNuTxRWkDn+6RxYea/4J9y5153bEjpT3zTCRd+CCL4KctNI4Hrj
         3rCYL1+Ek1Rjn7F2iNlM/6SsnkmKP0a7NDNTGULa2l3n2zbf2NW8jO9AauP3rXYNmE+2
         ZD+VuBIj/bgYg7eeRhOZ0RfCQ6G/G4MJhX77pnrDcT5DT4ARCB+7KIeVIV5Q4eZRpIDD
         Z8RnYqjt/yutOlUaeQGWvHmNpuPtN1ie3GtGBgFpONaOe88Co0dVu91iQWmaIeMJhk2I
         jfPQ==
X-Gm-Message-State: AHQUAubTo/Z7lO60yhX6ENy0ddzjhgadRvTztDZ9k/cu91ASGrftQxKp
        1BHx4lrccU0cR51STBdhPBXfL6C6
X-Google-Smtp-Source: AHgI3IbnAHcwkI+SemPMnjkj3ZKCW2INSrkQTroKj2nv3zlFNYETxcDa1TTvV3Uy/ulwfcO8Y9CumQ==
X-Received: by 2002:a02:9b6e:: with SMTP id g43mr18016574jal.9.1550639885692;
        Tue, 19 Feb 2019 21:18:05 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id k64sm2297550itb.7.2019.02.19.21.18.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 21:18:04 -0800 (PST)
From:   George Hilliard <thirtythreeforty@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Neil Brown <neil@brown.name>
Subject: mt7621-mmc driver improvements
Date:   Tue, 19 Feb 2019 22:17:44 -0700
Message-Id: <20190220051754.12195-1-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series of patches to provide a little TLC for the mt7621-mmc driver.
My original goal was to get it working on the MT7688, and I have succeeded.  I
suspect it will now work on any of the MT762x line.  The main change was
getting the driver to use the pinctrl subsystem instead of hand-jamming the
pinctrl registers -- the bit offsets were only correct for the MT7621.

Because of this change, the driver now expects a pinctrl device reference in
the mmc controller's device tree node; without it, it will bail out.  This
could break existing setups that don't specify it because it "just worked" up
until now.  So currently I just let the old behavior fall away because this is
a staging driver.  But if this is a problem, the old behavior could be added
back as a fallback.

Beyond that, there are largely code cleanups and a couple other correctness
fixes that I hope are self-explanatory.  The TODO list is largely unchanged,
aside from the couple of TODO comments in the code that I have addressed.
Ultimately, I think this driver could potentially be merged with the "real"
mtk-mmc driver as the TODO suggests, but someone who is more familiar with the
IP core will have to do that.  Mediatek documentation (that I can find) is very
sparse.  Besides, their codebases have begun to diverge.

Feedback welcome!


