Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F9C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3039B2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 20:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnmonRnt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3039B2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbeJ3Evs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:51:48 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51137 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3Evr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:51:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2-v6so5731022wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=t4o6vkl8GtIZ/bH/Qbi+my4lpjQHH2H03Qtk7uBOr3Y=;
        b=SnmonRnt/4rKQwbqxKg2GSh1igoVIDb00gEYIPbnIvD94ijkjKV4iNAWTypLSB/S4A
         M64pTS0bCI8Mqs0ppx5Rei4WVSmJGWDM7aD+82DNpiGJqK3JUsFrkQmWOkgsGPz4DTLR
         Kx7t4Iyp0AktedptdVrMgeP4nce3hW7p3PRuW9SnhiJ9uDTyeElfSmYdc6bINuuNDJAl
         X7hu7uusxpI0JIEA94AuEeHDB7xTabJ6AarEYhNws4XtxgpL3X2r9Wd/l7ALOuwzUF2K
         zFHK/fBcv7LX8h7S7mIXNKsyhDAX6Os+2fpezG7niPg+dbmLcizd2Sb+SMQAoKwtqKn3
         eNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=t4o6vkl8GtIZ/bH/Qbi+my4lpjQHH2H03Qtk7uBOr3Y=;
        b=EQmE/dDVKd4cXw7kJ8gf+LyjuO093YO5295SPvUB3y0u7ilEUpc/Q2JNQYVEacZ7Gw
         fg3TmbHJgvQxdXNXvGmL5LA/kYb+hMUrPO+z51tSGwOxqzZg1ENfgHh8L0A0V9wv2rEi
         +li3RSPpcDTu98kPDIyug3AOEGP90/3UcttqBj4B1cBSA+x8g7GSNgFdH2y2kBa1IILk
         wY1rI9YNJbIvc1bYQ7pxeMLiKZpUvJlkWgaRVF4/O7NrwMswEYqzqkl8B8Dc6KPSoGSq
         +gId1uolhv2e2pAtvC93+/3he/g/v6H913JiOvsHg3aPfTC0lMQCk5OVJpPivFe8Fiuh
         /mOg==
X-Gm-Message-State: AGRZ1gKS/Y4TFV+4/8BTTuxSI+WBi0Nm8yonnEmq6Tdqtz/8zbHUqxAV
        IjafU+uSFT5ihr7DvCb4gw==
X-Google-Smtp-Source: AJdET5fvsWSmGvHPstzUzCDusUsyxKBdgVDzpA/08lUY1rueVz7uRrO0S03Ryjcj857T58gCA8Wn7g==
X-Received: by 2002:a1c:85d0:: with SMTP id h199-v6mr14655554wmd.127.1540843294944;
        Mon, 29 Oct 2018 13:01:34 -0700 (PDT)
Received: from avx2 (nat5-minsk-pool-46-53-217-92.telecom.by. [46.53.217.92])
        by smtp.gmail.com with ESMTPSA id h78-v6sm12981070wmd.4.2018.10.29.13.01.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 13:01:34 -0700 (PDT)
Date:   Mon, 29 Oct 2018 23:01:31 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     dave@stgolabs.net, llong@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: introduce /proc/stat2 file
Message-ID: <20181029200131.GA23290@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I am wondering if /proc/stat_noirqs will be a more descriptive name of
> the intent of this new procfs file or we should just go with the more
> generic stat2 name.

What would you do if someone asks for /proc/stat without CPU numbers?
