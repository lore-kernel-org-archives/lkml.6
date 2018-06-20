Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C5D4C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3387D20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 06:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJWkreBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3387D20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753945AbeFTGoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 02:44:25 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:35331 "EHLO
        mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751648AbeFTGoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 02:44:24 -0400
Received: by mail-lf0-f51.google.com with SMTP id i15-v6so3215564lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 23:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cYhmFCWj/MVs+lJfREvQTFFXVCZgrutQQYawjnbzxZ0=;
        b=EJWkreBNUxHWaJBrLMKP2lYlCHQEBUuKtEq+kORT5lJbB13ZobD9MA0XMgALpE0GEP
         KBFvZUY6g//V65zL85lBiicDRZf32jZv5rtdUAnRhL8VSksNsqeac+IirIq/wEmUhN62
         un+AQlJ4jw5pc8v4TGwlGuuymzN57MS1A4cvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cYhmFCWj/MVs+lJfREvQTFFXVCZgrutQQYawjnbzxZ0=;
        b=F3IoiFfMg2eEBwwNaLJWlmlsFZZR7gwVD8AsqF4EznNbxhe9OYEqIdemCpm7sl/Sjg
         5PcwxEDH/VcW2gbwicRJC1FBeJEqsOevu+GREQ/Kiqwofba8KRV6yUxu/lyD3hNA31+r
         Cs+/WZAKZBbRb5PFnEg2zacSJmejnulkPyeAGx8Rgga0P1yTBLGVBoc8i+FwVAwejpD+
         795D802PpNV39Z6Zg0HeUS4iKHFmk0n5imTCzub6Te3GR/pCKXzGRHNGck9yR3zIsKtV
         4oBst3s/9EUUzZdbGGnmt2vXCdySe02PpJ74PM1e1JMfTZBGFy0cKvJNvJcfvMfjrHKM
         qzrA==
X-Gm-Message-State: APt69E1YlltOpmO//pbkRgl4SHHEH++mu1cc1IV7fjFDtF5W/zgewVPq
        TUN5OV8imLDlU3J1UryGwXuxr/5Kw5mu+C8nY6fILA==
X-Google-Smtp-Source: ADUXVKIoOFFA0plDu/0AZgdue3x4WL8NtzF7HD34pgxJUMeEmsIrI5TVp4Xu6VWmKu0G0J7j9DBg1CrzB03cO5NGY7c=
X-Received: by 2002:a2e:9789:: with SMTP id y9-v6mr12951512lji.52.1529477062762;
 Tue, 19 Jun 2018 23:44:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:ee14:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 23:44:22
 -0700 (PDT)
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 20 Jun 2018 12:14:22 +0530
Message-ID: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
Subject: LTP CVE cve-2017-17053 test failed on x86_64 device
To:     ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>
Cc:     mmoese@suse.de, Rafael Tinoco <rafael.tinoco@linaro.org>,
        Jan Stancek <jstancek@redhat.com>, ebiggers@google.com,
        dave.hansen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTP CVE cve-2017-17053 test failed on x86_64 device.
FAIL on linux-next, mainline, and stable-rc-4.17.
PASS on stable-rc 4.16, 4.14, 4.9 and 4.4 kernel.

Test FAIL case output,
tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
tst_taint.c:88: BROK: Kernel is already tainted: 512
Summary:
passed   0
failed   0
skipped  0
warnings 0

Test comments,
/* Regression test for CVE-2017-17053, original reproducer can be found
 * here:
 * https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ccd5b3235180eef3cfec337df1c8554ab151b5cc
 *
 * Be careful! This test may crash your kernel!
 */

Full test log:
https://lkft.validation.linaro.org/scheduler/job/290429#L9581
https://lkft.validation.linaro.org/scheduler/job/259217#L10308

History of the test case shows failed on
Linux next kernel,
https://qa-reports.linaro.org/lkft/linux-next-oe/tests/ltp-cve-tests/cve-2017-17053

Linux mainline kernel,
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Linux stable rc 4.17,
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Test PASS on 4.16 kernel.
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/tests/ltp-cve-tests \
/cve-2017-17053
^ Please join link

Best regards
Naresh Kamboju
