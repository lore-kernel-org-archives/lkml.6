Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08AFC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACC442084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 19:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OyFRb5Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC442084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeJECfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 22:35:47 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36668 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeJECfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 22:35:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so6158303wmf.1;
        Thu, 04 Oct 2018 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=zwsVKiAtZBpj9PhL9Hne0q0mlWGysGOGmVnhkIa7q2Y=;
        b=OyFRb5Vvh33JAV4Hot6/vcTWtTqmZUd8J0o45bO8BRICmghGsY/BpZiFJZbqNCsZ0W
         lQJ212F7cQIC9Hdl1qcjCV4TqputnK/29lASXGobgb5BXAeaVb8APk31pPBf0ieuLTBX
         dABlLu8bkXQiDsybChVj6M/mVifVYUkkVrjczZ0yyD+X9NfhC0C0leKnu23JhDuIaXQc
         Voe34RyTYT6+UHw0QZGYIe1yk7/ZdreY00gmqFQ8dBmSEg0oj9tuJhYu76wTIt5Ihr/1
         ZPNUxn3G9RAs9yzBwbSaKbJro+PkUfcZMdF1sQGT/CkvjirPgFL4hHU8u/VXY8oiHqSV
         ASwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=zwsVKiAtZBpj9PhL9Hne0q0mlWGysGOGmVnhkIa7q2Y=;
        b=GjS/xvVuLfnpiD8Gk4bg1Cu/cfaymey1d6e/U5qup7vZ8Lnf+EAfa7R/vqvNMYUR5W
         Nr9oKP/MAf5teSK4XbvvmD/by27uwF+uWjmUNPSNycMNboj2gfoavZdDuvRAPWziqcEf
         Lk11VdL1mrtUDlGe2w+JdZ4w+zoc2wOeRkuHNZ9QHTT+LLkrPNxbXb8hx72adX5y5jfO
         Anvt95RaFvGivNIeW6yvI0C6iE7WGOBnTmeLe4pVkOXCImRH+UN045Uiglrk96t1vytu
         2V4E7doagAlJyQStxUgzYwKcWdHaUshVaEw1a+oPWV7By/6w94fKaB0mfVIbj0aerISL
         VgIA==
X-Gm-Message-State: ABuFfohwB2f2L9ZOtE0qMjhYXB2mAw4zNs3GmVMEOAAxHfbZtN7FKedW
        0t4rEgdhIeTAwwbWv8jDIgrzyYTe
X-Google-Smtp-Source: ACcGV60yS2tvZi3akeXHOsHKRfyPK6w869yensE7ApT7hnPAcZXtXisOjaD4zfmKcyVDz4EeIb/5Pg==
X-Received: by 2002:a1c:a1c6:: with SMTP id k189-v6mr6044212wme.0.1538682061686;
        Thu, 04 Oct 2018 12:41:01 -0700 (PDT)
Received: from ?IPv6:2001:a61:25ca:c200:9cfe:b5b3:4ec3:2c28? ([2001:a61:25ca:c200:9cfe:b5b3:4ec3:2c28])
        by smtp.gmail.com with ESMTPSA id e7-v6sm6618954wra.37.2018.10.04.12.41.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 12:41:00 -0700 (PDT)
Cc:     mtk.manpages@gmail.com,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>
To:     Tejun Heo <tj@kernel.org>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Cgroup v2 thread mode oddity: "domain invalid" cgroup with threaded
 controller enabled
Message-ID: <a4912516-8c6b-d8d3-b714-5c03bcfc5e91@gmail.com>
Date:   Thu, 4 Oct 2018 21:40:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Tejun,

Suppose we have the following scenario:

x [d]    (pids)
    y [dt]    (pids)
        p [t]
        q [t]
        r [t]
    z [d]

Here, x/y is a "domain threaded root" with a threaded controller
(the 'pids' controller) enabled. (In this scenario, there are no
member processes in any of the cgroups.)

Suppose we now convert x/z to "threaded" type:

     # echo threaded > x/z/cgroup.type

Now we end up in the following state:

x [dt]    (pids)
    y [inv]    (pids)
        p [t]
        q [t]
        r [t]
    z [t]

This seems odd. x/y is now of "domain invalid" type with a controller
enabled! This feels like a violation of the rules, since we can't
in other circumstances do anything with a "domain invalid" cgroup
except convert it to "threaded". In particular, we can't create
child cgroups under a "domain invalid" cgroup, or add member processes
to the cgroup, or *enable controllers in the cgroup*. In fact, when
doing the 

    # echo threaded > x/z/cgroup.type

I had expected a write(2) error because the state of x/y should
(I thought) not be permitted.

Your thoughts?

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
