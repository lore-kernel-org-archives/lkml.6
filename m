Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D8C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA420841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 11:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat-com.20150623.gappssmtp.com header.i=@infinidat-com.20150623.gappssmtp.com header.b="Q2Kk7TPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFA420841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infinidat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeIBPvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 11:51:33 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:38673 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeIBPvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 11:51:33 -0400
Received: by mail-oi0-f53.google.com with SMTP id x197-v6so29155492oix.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Sep 2018 04:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=p0Ptqtd1mSMYGJiy5ViH5nGDmksRKJxzK84a5BZhqJ8=;
        b=Q2Kk7TPuEXh6cNGnSPYkPZdWnMnXnauxclsa2Nhg6h62cXrbbJN+r8C8JznGtnLx0s
         llZhj/CbOncDpiMd5GJWMQsw6mEBXgRYPifoyHdrprIvJbbT4wwUsYTxuaEcRvkG7zpb
         HQveAScAOMafR2sFHJlbPJXFUC4FbmlwsuFFwNUdJNG7tAsCCIOtDuAUMUUlYXz6jUk+
         zth0Qw+cHqmWW0R5SzrzeLI0OhtTS7ebiBJY7yNx66JkIU8s7GZ2RncM0DwooAZxCJTl
         crGSK11PMartmklb3bCzKOlNsSsBJChKx9q2q6USC9miwrQnv1p8zIvHBGQbyRA4joFE
         wnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=p0Ptqtd1mSMYGJiy5ViH5nGDmksRKJxzK84a5BZhqJ8=;
        b=QqidIkX8IeHiH6K0jJu5JH2+3YzNeeWdxRVWQUufFyN0vuDVNvUAZXbd8lUY0FcwBp
         NgdyPIHTM2LStzgaJ80JqYBL7vvKZQ5513EyajJ7V8OotTTCqDY1mShxAnedIOY1cboQ
         hT0NRUOkIKEmQOzMvi1Tq8v7O04NpNcbd6P3H5f3QNuR2k9JrpbCHY/o2QV06tyy8axl
         8UbCOxE/IsFs2G2x7QZmimjciUQFZzB3e9EbvEAdnZhlkYxHZnGwbzr/vBKrLYa5aR6d
         /PyV4P4QCTbDDJLRAmBGmosQ9agRpR48Z8VS32RTrHpvMEgFis4ueKBrZsGagtf953Rn
         OuIg==
X-Gm-Message-State: APzg51ArPDNw6yD7A79rPJ1X3ozAcvmeFi3JaL0IqePdkfIzCkMQDK5q
        zmWv7reH/OnC/Wb40OB0bcutgKZbCxFqttmiKfAT6QnKCw==
X-Google-Smtp-Source: ANB0VdYVbuLjF5WksDpub7sxJvTagF0XyCgVNsIn/2oSEilWIupGKjS+47MgeLaJhYp/wnBTnFI0ldzF7Ehz6NIb3HI=
X-Received: by 2002:aca:3407:: with SMTP id b7-v6mr14354281oia.345.1535888164496;
 Sun, 02 Sep 2018 04:36:04 -0700 (PDT)
MIME-Version: 1.0
From:   Dror Levin <drorl@infinidat.com>
Date:   Sun, 2 Sep 2018 14:35:53 +0300
Message-ID: <CAOuWhkaGjX8Q_xghkFVTqzZkDrUv-sdH=VbS7hvnqFWrT+3eOQ@mail.gmail.com>
Subject: Recent removal of bsg read/write support
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Note: I am not subscribed to LKML so please CC replies to this email.

Hi,

We have an internal tool that uses the bsg read/write interface to
issue SCSI commands as part of a test suite for a storage device.

After recently reading on LWN that this interface is to be removed we
tried porting our code to use sg instead. However, that raises new
issues - mainly getting ENOMEM over iSCSI for unknown reasons.

Because of this we would like to continue using the bsg interface,
even if some changes are required to meet security concerns.

Is there any chance for this removal to be reverted? I saw it was
already included in 4.19-rc1.

Regards,
Dror
