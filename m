Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id MDUeAcACHVvFKgAAmS7hNA
	; Sun, 10 Jun 2018 14:37:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 97C7160795; Sun, 10 Jun 2018 14:37:55 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cduXCgea"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0DA506070A;
	Sun, 10 Jun 2018 14:37:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0DA506070A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753539AbeFJOhv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:37:51 -0400
Received: from mail-pl0-f47.google.com ([209.85.160.47]:37493 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeFJOht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:37:49 -0400
Received: by mail-pl0-f47.google.com with SMTP id 31-v6so10851313plc.4;
        Sun, 10 Jun 2018 07:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=djTtPuvzHaNMeZhp+RqeOusWEYZrLNs/CFDa0Axjdb0=;
        b=cduXCgeaB/qqoWFcE7u5cAAbBpcbdtUlVMkwsX8tqZp9jFKUatmIr5MmBKskPNMl3o
         TaGp3xl2PpEJ1o8stpUE5vr4gU6hEIJfF0w7PpAc0VGlHWb/eUa5V+hhi0/BxpWNdLoJ
         Yh7+SX5RG/v5yKHcgl4vUXmxxwNt04Rtfn3QrrpGECe1Qc6JG+JVZHQIzcOB6LpIpP0v
         Z8ZgmewWqvGRyEE57NbtKd6q1wsghsHS82uUFtblE6Hz6n697Nk/P76mGQNl8qGxupMy
         hG2PEdLZDpuKEGAkAtO2c0JjEYfPZS/94Falzjnbjc5p5FW7XV66VxmwuIY5Ti1EucSF
         qjWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=djTtPuvzHaNMeZhp+RqeOusWEYZrLNs/CFDa0Axjdb0=;
        b=tPlyOtEqdEb9rrI9lnvUOKM3YqCiLS8l0mDuJK2ihVmgbeCasmpy9qWR/NldKS2KA9
         b8OQ34/2hqo6RgFOJHKRrouZpLlgGjhOHnnPJ5v25Umj+mMcb5GPFjjJUpcv/6iy1UVR
         ymZ2x+KWXvklt6l839MB4dZFdn6dVIltpmRTfMc9K5LD9pZL9aT2Fcpu6uIec7n/PVyb
         Qex+OdP0QwW++pcCWWLOD3x0brKrFCjFZq73u7ZagLKH7DFcN5093Nam1D9N58/iaPiu
         XyrSv7zBs/pizavoz2g5rwhGmSpiSKB5cd74TZ7G/pliR09yAd8Ge4P5CkCyvpKlisN3
         BR8Q==
X-Gm-Message-State: APt69E27Omp/xq1Vxf7nbxE4AcPiH11iAscNbvsT2h4aiv3z+JDFFWZX
        dzPQu8gXmNcW0HhdGEEztJ4pFQyLnUnzCYQIIsbLqQ==
X-Google-Smtp-Source: ADUXVKJ/2qcgMO5sQnc3O/vu+GznQbB1xE9cdFd4aDA1e6wdUPV1T8F+cSjuq6hIycJ8DPeCs61uggkXvKl6U0you4Q=
X-Received: by 2002:a17:902:6bc7:: with SMTP id m7-v6mr14690085plt.162.1528641468776;
 Sun, 10 Jun 2018 07:37:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:a081:0:0:0:0 with HTTP; Sun, 10 Jun 2018 07:37:48
 -0700 (PDT)
From: Masanari Iida <standby24x7@gmail.com>
Date: Sun, 10 Jun 2018 23:37:48 +0900
Message-ID: <CALLJCT2K9Tkj1d-xq6-zmNhOwLjQiStnMaE7PJCTDDT+Pi=L1w@mail.gmail.com>
Subject: [BUG] make htmldocs failed with error after add converted RST file.
To: linux-kernel@vger.kernel.org, jeffrey.t.kirsher@intel.com,
        netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc <linux-doc@vger.kernel.org>,
        intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After merger a patch,  make htmldocs  and make xmldocs
failed with error.

reST markup error:
/home/iida/Repo/linux-2.6/Documentation/networking/e100.rst:90:
(SEVERE/4) Unexpected section title.

Configuring the Driver on Different Distributions
-------------------------------------------------
Documentation/Makefile:68: recipe for target 'htmldocs' failed
make[1]: *** [htmldocs] Error 1
Makefile:1542: recipe for target 'htmldocs' failed
make: *** [htmldocs] Error 2


85d63445f41125dafeddda74e5b13b7eefac9407 is the first bad commit
commit 85d63445f41125dafeddda74e5b13b7eefac9407
Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Thu May 10 12:20:13 2018 -0700

    Documentation: e100: Update the Intel 10/100 driver doc


Reported-by: Masanari Iida <standby24x7@gmail.com>

Masanari Iida
