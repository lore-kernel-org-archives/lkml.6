Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B31C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA4C620989
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 13:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdHjE3JW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbeLSNXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 08:23:10 -0500
Received: from mail-it1-f173.google.com ([209.85.166.173]:37939 "EHLO
        mail-it1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbeLSNXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 08:23:10 -0500
Received: by mail-it1-f173.google.com with SMTP id h65so9330489ith.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 05:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=6w3lFz3xPzBhtqnZvsPD5vfuvHeua/zEeX+sxPtgnKk=;
        b=AdHjE3JWaOZqKPNvJpgXWrQNKk89HtTbn00VCEWtkikUB1joMTb6RTJ+7LtiQaKuZ6
         4lgAaH36ExYWQy0lPHAuWizMWo5TiudRLs5r5Opv8/JUEXnQyEPC2op6/SlvOZmK9rhz
         wZwDf8F8b53X9+hxERIOdh0BixowaFAH6Z2z/BrJ/bymg4GCGcOBMWoA9EQ2Gpb6KkdW
         ei+YJZXw4X/Cdte64be4Ap0fvjwOKiWrtjb3hqxJSLuPuqF+PArCOj/pwnZy7xgjRYkK
         oYKeEZEaR3U3ASfcZojxbnaPRD3psAv5UtyCrQUR+DE/OTCSp4t0tytDgv6iJkfl76Bh
         06jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=6w3lFz3xPzBhtqnZvsPD5vfuvHeua/zEeX+sxPtgnKk=;
        b=J4DB8/ToN1vi65MG+R9uDeMVs5HJJ7tyJeykGHGL3jRKwXLeHQJYHkImFXzI2Wghhd
         c2q6cSn4IigLUheXuJzs5kPiHvLUf7mb6GJkTM6Zxtc5rBxePv3hmt1bZ18IblANTfCf
         YRUfvEPMRh9tFN9WqKKF/F8JZronhRcC12lykN3olpzpMI2PGernLEWkD+HFdAUH82Sy
         NidaKzDGp5ClTSXtIzY/CHYTtWmLdTsa/DLr7smsfiEVUFa7VI2egGvOYd3378uSledS
         PMLF7+6sCBqY5qr6TpI8XLRjyDeQH6ZzePoA+VPO2Q4rvL4c+rwGJq7FpziG2VRsdyOq
         OqNA==
X-Gm-Message-State: AA+aEWapbi/UVhtd6d429LhPWONCpyvGy8g78LjC5K9mnH+scEHk38m7
        wX9WRHHSok5xSNVI9mu9e0MVweK2RS4oaaF3bP5omNW+rhM=
X-Google-Smtp-Source: AFSGD/UKgyew3ZZ+xu1on2z8p8nk77sAWcFYBSzb4vnLhIxLNkYPu73FMp+sAQoy+MlmDbqlm0iPkO376j1oSTZe3yc=
X-Received: by 2002:a24:8983:: with SMTP id s125mr7172042itd.116.1545225788498;
 Wed, 19 Dec 2018 05:23:08 -0800 (PST)
MIME-Version: 1.0
X-Google-Sender-Delegation: praveenkumar1511@gmail.com
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
Date:   Wed, 19 Dec 2018 18:52:39 +0530
X-Google-Sender-Auth: cLyKfg32gkp2CpUaoe6-1K2YZz4
Message-ID: <CABcWhv5QApdqti+fhGuH-3puhk89n2jgfziV2zG3H8Y59RE63A@mail.gmail.com>
Subject: /proc/modules not showing any output
To:     kernelnewbies@kernelnewbies.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Compiled the vanila kernel 4.20.0-rc6 build, and was trying to get
module information, but /proc/modules is not showing any output ( both
on arm64 and x86_64 )

root@ubuntu:~# uname -a
Linux ubuntu 4.20.0-rc6-00082-g65e08c5e8631 #7 SMP PREEMPT Fri Dec 14
15:54:30 IST 2018 aarch64 aarch64 aarch64 GNU/Linux

root@ubuntu:~# cat /proc/modules
root@ubuntu:~#

Tried with older version 4.4.162-78-default modules were properly shown.

Can you please help if there is something which I am missing during
compilation or is there any potential bug here ? Thanks in advance.

Regards,

~Praveen.
