Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBE5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941C6208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 18:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gnhSihhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941C6208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeH0WOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 18:14:37 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:44048 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeH0WOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 18:14:37 -0400
Received: by mail-oi0-f53.google.com with SMTP id l82-v6so23432815oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=aqDROgDCJz9/uB+dUVscTE572plyihaqAPNCPR725So=;
        b=gnhSihhu1sNWtUpwsVcErnNeELTNECl4VUUhx0+5ZK1uBq9PO5dZDGNPmX+7P7Po28
         5QVDCnSX8iGfScf5se/zBIef0FZNvc7JLv2wTv8vxUqDcGulg2mKBGSXzNDZsAVX3UAO
         JYPey6fxyBXLQiKRjy9PODSXiLk27cGyQsRQ0fP9c9fFNairWSZUOjo5KVU0ZQlV56+y
         EdKGzVcATF9bvWjF3OxIuSsjPyDSfREaXpoSQoaBeKvLunOL+4D1C8g2Rosbuji0RCDA
         b1K7zei62E+7CTNe0Un8pOVgWEoY0GCitrED8aC758ZxODLQcQhDUlLEMHXL6EKQy1/R
         iNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aqDROgDCJz9/uB+dUVscTE572plyihaqAPNCPR725So=;
        b=E8SZBHC5L6vES24Nl3NB0A1af86BH5+PHo1Q0ZDJp7D0NyaBl7bRQLNjgYaap15yVD
         zuhU13vkOUmk7w2bELmr03LG22lDYUQ4vcBLPHmzeSiD8q/VTuiIvCdMKiJHz07sFV/b
         nOhlfKPfNrnsEOulHRFwBbN8YytVzQ/wcTYEbiRCMf74+znEqtbrkLQgTf+8f74zueqS
         H6XXptRHGSEb9IVDmgTLQkY71GMwnEftXP+pWc0+GFvq2qx2hsQLZrkGLWa4k8aSvY+8
         f4gLlz3jNt2xlMuueReTXa3lPJW++uTz3yiKJ+dqDGzCpqkhdMN7IUPcWrc7t3QYqO8s
         fkAw==
X-Gm-Message-State: APzg51CYzi1sbiRbMQFuR/TUHtvLQuyZc5I7bGUjw9CHvkwpcM9nSxJX
        yhOdqIhFXzYq+NnLLF9/Z6UtHNqncuJ30vyci47nXQ==
X-Google-Smtp-Source: ANB0VdYnxvtzZqDYESUDzWsKoQ7GysHh7FK7neVTBlW7INWtWMa9JvrQYg1+7RLE5OZIv3Np5wG1CxhS73Qlk643POk=
X-Received: by 2002:aca:d986:: with SMTP id q128-v6mr12245947oig.349.1535394414812;
 Mon, 27 Aug 2018 11:26:54 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Mon, 27 Aug 2018 14:26:48 -0400
Message-ID: <CAPMnawtqVnT2ux+VQzaPhyqHvYMp_Dm0sbeoWQcpYiRM-9QE2A@mail.gmail.com>
Subject: Question On staging/drivers/staging/*/TODO
To:     Greg Kroah-Hartman <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm brand new to kernel dev and after going through Kernel Newbies
am trying to find a good first patch to work.

I just wanted to know if the TODO files, mentioned in the subject, are
up-to-date. If not, would you have any suggestions on where to find
a good first patch to work on?

Thanks so much!

Ray
