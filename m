Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58785C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBAD20664
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="PDkEXdkP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBAD20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0DY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:24:29 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33162 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeK0DY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:24:28 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so13967462wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=qsonarNJaRkqxd9M8FdOorcHkbQcQdFMg1xqqjijfF4=;
        b=PDkEXdkP+aIIiZD2rPfPSg9qA8hEOOdoYjWQE9Fov3kNHrkV2K2tfLGI0Ho5mMn0Ii
         Vdi8rSa/Adfr2bPrG0CB4XkN8nZ9aK/zgyw+2jGeCpTHz20jJJ4adxCFWVjIH65imyGZ
         XArs3YXPhGwahZ/qWAugBD7C+IW5Qwmg8ihHT8Qj9aefTPmgGSQOSdMPpGk9mFnFi391
         Bwr43sT5haa90/73e1gWmJtH7KVQkUVNqayVr/rqbDfEDBcfBNvMTEa8+c46SHjDIgjO
         68cJ5TGSG9SnxCJwmnR6qUBA4aD9Eo1Tr5JMHjjWANSWHszMLYPIOmlHwn46nKYobcue
         1kuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=qsonarNJaRkqxd9M8FdOorcHkbQcQdFMg1xqqjijfF4=;
        b=RsPDwiKAgrwvQEjHgxWipZQEH+5Hh7FCwd3GhyQVkQOUNYdCFYUHEKbYfhThXkGKzm
         SbrAPYvAbAFuNHESpjCQ7ZxlYNBQ79P5fCxTpJom7PJwaEi03bgs6p8juU2kcBReT1rn
         aXWVyqb5TcablJ1ZXBs23At/+nD6ksSlQ8nkr6CfOwN5V0JoTMS/F+fJBzAjo68VuFiX
         +z7CafmjY8IU+8/bTBCe0AQgDDCdHNxMdnmUUa24mvST5ucKTzuNiNX4f+8fWc12Gbf6
         7TWza/BhZxBV6QfUtq6gW51Ijyw/Wj5ebcQuCVN4jZoEVMhv6uRni5p91zR5oB9GCt5Y
         lvJQ==
X-Gm-Message-State: AA+aEWZEQ5HTD/UD40lbNvktcmfzGB7sQnmyDWja5S1LNrXLhXukvjC4
        D/Y6RJDnbIUKABNSKfgbbhtFfw==
X-Google-Smtp-Source: AFSGD/VopUJ3Z8O8JI6K9QpHeX8D7ft2P7eeWFC2mnuqubBuIkWtXJL10YXEY5cyCV97QF2VDyYq2A==
X-Received: by 2002:adf:f8d2:: with SMTP id f18mr21218320wrq.265.1543249791219;
        Mon, 26 Nov 2018 08:29:51 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id m65sm656200wmb.4.2018.11.26.08.29.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:29:50 -0800 (PST)
Message-ID: <5bfc1f7e.1c69fb81.c4247.37d4@mx.google.com>
Date:   Mon, 26 Nov 2018 08:29:50 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.164-71-g2646be341868
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/70] 4.4.165-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stable-rc/linux-4.4.y boot: 47 boots: 1 failed, 46 passed (v4.4.164-71-g264=
6be341868)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.164-71-g2646be341868/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.164-71-g2646be341868/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.164-71-g2646be341868
Git Commit: 2646be341868dced4199335842b6642b8a01aa0c
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 30 unique boards, 11 SoC families, 13 builds out of 187

Boot Failure Detected:

arm64:

    defconfig
        qcom-qdf2400: 1 failed lab

---
For more info write to <info@kernelci.org>
