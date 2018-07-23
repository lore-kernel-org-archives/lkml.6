Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A05CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79FB20899
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 14:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkmL0Lz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E79FB20899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbeGWPvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 11:51:24 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:35758 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387877AbeGWPvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 11:51:24 -0400
Received: by mail-ed1-f47.google.com with SMTP id e6-v6so1218260edr.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=J0cV6AEIxjbxhU5BZhWUG7zw+ASvVedTWE8Wx+4/vwE=;
        b=kkmL0Lz5uxU3o3Gpsbki6Oc801GQPbh7iDnR0x/MaA3+KRoc8oxY8gdFLnr8PwA1Vv
         mSOgLbuansG7dOo1xGVHKGCC9EVw2uXi3w56Mz5a1n2jHSq1prdo+aN0HXeaj3OGYz0I
         hiG/AuDmm8tJlwXhx3MXKRa5pQVvKhl0x6s/368HbQ9Hv5Qc+yQj4bDEScl0wFvntBw4
         0/qSJUzMWRzsgssNE2HZW9PHpgorDpzbZar/lmPz4tFI5J6w2i/0HGL70RI1cWmSikj4
         5hfn+Zg6mF02cn3MjT0gzkfN3MQ4oHVdarmwnampN+jrkZm+bgNzI4egS1mdrkv/Q881
         CeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=J0cV6AEIxjbxhU5BZhWUG7zw+ASvVedTWE8Wx+4/vwE=;
        b=YchiHy3fPV+sv3T0KmOFcJjoAFMIPViZ33qgVfp24KLQSAlFUfHycFgRBXix0dS5Jl
         BCw+f8OvYQbRL3whUGvt/fsALZGObNUy1+p1/IY0JIsg33rXwiE35LyfL31K+hM7KgTq
         rKbBoB9l2XHIFqw4WZ18rOOgXGEZU1WGEbAy4UW5QIZ4Lj9Gc0+LfIjfOjmG1Kwpd7ix
         sgX2sNQw2DpNoOdZuitOswv4uvPNIvZ0DVpLE7wjphke1VO9Ta9D3TJ0bgKF3Dx6tpum
         Pzxq3SPdyvV1tB9pqydIlAgCDnL7eXx/Xp03OA7mQjKc+DW2n4nl2rtx+Dz6IZIU0C06
         cqXg==
X-Gm-Message-State: AOUpUlHApraq3On0WkfFSCVxxx6aRQy9aoyLxq/7F3GcFQ413dYAwB7m
        rwFuTk1gTck7hI4PZx5n/1WxlTh0
X-Google-Smtp-Source: AAOMgpf+x99J+tkG47nWz7z6wSjsMv3YOBd2ePbIZgWuMd/ZOOFgmSqJp3wjr9bzIai7qx/QJinHOw==
X-Received: by 2002:a50:b1bc:: with SMTP id m57-v6mr14681849edd.3.1532357387768;
        Mon, 23 Jul 2018 07:49:47 -0700 (PDT)
Received: from [10.218.54.27] (54-240-197-235.amazon.com. [54.240.197.235])
        by smtp.gmail.com with ESMTPSA id c7-v6sm2550194edi.79.2018.07.23.07.49.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 07:49:47 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Gal Pressman <pressmangal@gmail.com>
Subject: Fault injection stacktrace filter for x86-64?
Message-ID: <a075185b-b610-c08d-33fd-a2c4c9c2323a@gmail.com>
Date:   Mon, 23 Jul 2018 17:49:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to commit [1], dwarf2 unwinder had some issues that prevented the
fault injection stacktrace filter from working on x86-64.

Does anyone know whether this issue still exists 11 years later?
Are there any objections to revert this patch?

Gal

[1] 6d690dcac92a ("fault injection: disable stacktrace filter for x86-64")
