Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7CBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4335E2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 16:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="fAYUE/Z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4335E2148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbeK0DY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:24:27 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36872 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbeK0DY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 22:24:26 -0500
Received: by mail-wr1-f68.google.com with SMTP id j10so19613581wru.4
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 08:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:from:cc;
        bh=X+xtiRmmN7GJmaVb/B8W/kcK9uQQgcRWiGcoeJxwC/c=;
        b=fAYUE/Z2QHoVvZB9AhJW6TDBP84nB8WHyrZ/8HXU5YcxqH1yTcctg0VxX3RKaFc5VI
         EQXLB4plcFJVAoimvrsVdHt78fOSBo1yS5xVjMXdcefr89HfWq6vXKndB4MNlYPE3hzQ
         gVZmt7QEFOn4yq9RmUDDjS/KfiOMhTwYV+LetOuypKsq6g+G0plKRLWmevBX7muGZ+KX
         XkoGZBKaiQRW2xPkX5QNmwtgF3nNh6Wk9I6hu12PXpWpmaU9CUKA2UEJfTOjgrl3BUtX
         je0c0bJoESowQNQ86Gj4rvC15W9bX9+08pfkjixLMbCIu3m9EiL+HmuSgJ/c4y5sgBKP
         f9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:from:cc;
        bh=X+xtiRmmN7GJmaVb/B8W/kcK9uQQgcRWiGcoeJxwC/c=;
        b=Y9Jet0BG+WjZC/epOYovGV10p+r7IYRrvLPWkn2BjZWGGuTWOlA53KuWD9drLyoR5O
         /B4vl3bMcddUfUC8sLzVqSbYuGAPyWV5jKfnb92Lg0ShC07+tlg0IuIJckXZLvD86S5h
         7a4WwEeFnCwc3g5p/PQdBJ1J7tInmwxOBHgSuyBC/ctyGUjVZNeyL9R3DVz0RgA/HLSO
         SI3+R+THsrCNtlAwLMA36y1Re4q68Z+QQIop/mndOTvrBU7gRFGnNMjDNrbc1TRUfbdY
         OOfON9aXtolplWx5pGgDKV0WdwAWrQuI0d6JW8V3357/k/vP+e0ouIZi2liZENeQIAcQ
         obfg==
X-Gm-Message-State: AA+aEWbJHHJk32V/XUF8BMgHHxtT0H98MMLCKb6hqYDL2dkuRFbxWirU
        qPBVxhobfdahZSw7PFJAYyQ82Q==
X-Google-Smtp-Source: AFSGD/U3ci3x60t5hiww7K7QIYZFlPnoO9fX7cGae3A1ciII4rMM7Xd9BhjCpUl+gN6OJuhXN1bPsQ==
X-Received: by 2002:a5d:628a:: with SMTP id k10mr23515341wru.254.1543249789871;
        Mon, 26 Nov 2018 08:29:49 -0800 (PST)
Received: from [148.251.42.114] ([2a01:4f8:201:9271::2])
        by smtp.gmail.com with ESMTPSA id b22sm1370412wmj.9.2018.11.26.08.29.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:29:49 -0800 (PST)
Message-ID: <5bfc1f7d.1c69fb81.21502.7e18@mx.google.com>
Date:   Mon, 26 Nov 2018 08:29:49 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Kernel: v4.9.140-47-gc5b0719ca177
In-Reply-To: <20181126105045.447291262@linuxfoundation.org>
References: <20181126105045.447291262@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/46] 4.9.141-stable review
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

stable-rc/linux-4.9.y boot: 53 boots: 0 failed, 53 passed (v4.9.140-47-gc5b=
0719ca177)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.140-47-gc5b0719ca177/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.140-47-gc5b0719ca177/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.140-47-gc5b0719ca177
Git Commit: c5b0719ca1770c45cde285f00545505148b143e3
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 37 unique boards, 14 SoC families, 14 builds out of 193

---
For more info write to <info@kernelci.org>
