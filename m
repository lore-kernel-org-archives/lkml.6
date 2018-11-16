Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59682C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF08620854
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 21:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dynamicaims-com.20150623.gappssmtp.com header.i=@dynamicaims-com.20150623.gappssmtp.com header.b="mu1nzCV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF08620854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dynamicaims.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbeKQHg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 02:36:56 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42262 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 02:36:56 -0500
Received: by mail-pl1-f194.google.com with SMTP id x21-v6so8985801pln.9
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 13:22:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dynamicaims-com.20150623.gappssmtp.com; s=20150623;
        h=to:subject:from:message-id:disposition-notification-to:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=cRAOfL7tqpx+A8JmuqZ7+/QVpobixk0KqV/o4v2NiZk=;
        b=mu1nzCV3RC7VndLIQKvNA1CILxouEU8CCNBKWkrtzquri8DW0/K7woAvgpeLY//Jcp
         Vy6AquDXuDMeuDZhnD+1/yD13H24PLOIBdErYMxcLEPXok18hFhnR8KstGEW2kkBJTpy
         seYBiaas3/JRldaZCqoRhE9oZL44ffxLzw3jqBWrjhB19pBr4cF/WwoZqM7Or3biGH8T
         suYu28occIxYgyVpXCokxT/G4AzlyMtzgIAV1AaLU2j+J65mhopn40lkZHqz6uDxXfN/
         hkcsdzegt25yTQvGovuz86wI83SraxCJ3TtWMvIcwWgL2iL230WYSbGjpbtgk0cQJUcP
         ybSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:subject:from:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=cRAOfL7tqpx+A8JmuqZ7+/QVpobixk0KqV/o4v2NiZk=;
        b=FhcyzkJbMtrleKTJwVyS0ebw/31HWtDIB0qTMpg/dwXpSw5AG4C+O4ikQtVYLrrnLb
         j/i9Zo05u5JbjyHgj+M1mBbG+aogAbaE291ZvxtGCKWK4RH6o3cQb522vYAVIt7EfFYv
         9xzlSZp+XTxlvKLMlJ8dIo3IdUS/EpXBwSg86eXPAkSVmE9q48Nq7z7lStwO68Hs7n4A
         L1EKuSXirZ6qvyUMOK/+N5mCYSQOUILDXghbsahbmOsLtCgdPsmZeh8CElv+IMbKQR+j
         fzE9rh+BUXuejdqYUS/+UueajOfAxRy4A/PVfEzVrPuW8enlkH+hgIyiXM1q9FKCKMbP
         wMlw==
X-Gm-Message-State: AGRZ1gLWox4FS3czIDfHTGOnmqeY3Q5KBUNWdrCwQWPJhpZL/d5yFjaJ
        8QyxiDNsf2IK6+nci0msqi4lqcfiUVE=
X-Google-Smtp-Source: AJdET5cL03/YqVhAUUrdHehpuuNFAgqFTPPRsOMOTJ9l75+4did01yG9DX93prryJ7EsB9HbCr+rcg==
X-Received: by 2002:a17:902:7c94:: with SMTP id y20-v6mr12586197pll.218.1542403372611;
        Fri, 16 Nov 2018 13:22:52 -0800 (PST)
Received: from [192.168.0.18] ([43.224.159.177])
        by smtp.gmail.com with ESMTPSA id g11sm6113190pfo.139.2018.11.16.13.22.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 13:22:52 -0800 (PST)
To:     linux-kernel@vger.kernel.org
Subject: Fishing Enthusiasts List
From:   Bonnie Roberts <bonnier@dynamicaims.com>
Message-ID: <cb582651-60d7-ab5f-787e-73f7f3f6c249@dynamicaims.com>
Date:   Fri, 16 Nov 2018 15:50:59 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.3; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Would you be interested in acquiring an email list of "Fishing Enthusiasts" from USA?

We also have data for Boat Owners List, Scuba Divers List, Cruise Travelers List, Spa and Resort visitors List, Travelers List, Camping and Outdoor Enthusiasts List and many more.

Each record in the list contains Contact Name (First, Middle and Last Name), Mailing Address, List type and Opt-in email address.

Let me know if you'd be interested in hearing more information about it.

Best Regards,
Bonnie Roberts

