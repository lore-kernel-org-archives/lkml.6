Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D018C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01073279A5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBxkCZJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01073279A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936064AbeF1Whb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 18:37:31 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:43439 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934984AbeF1Wh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 18:37:28 -0400
Received: by mail-pg0-f68.google.com with SMTP id a14-v6so3079069pgw.10;
        Thu, 28 Jun 2018 15:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=cvh7wdYAf5SrDD4ATZzl4f6p3kZaepf28aeSOhNAoiU=;
        b=lBxkCZJt2JhC6hgCfsTgFFuWuw41446G7jU6vysL7DHfiKNGgeZFmE+dwbTkfFgDgo
         lHoWEQHFgYcGHTXtmDmqWRuLLOk8GpBwMZLcjVxGrYWLgSPTCviN/7NMu09NisQ7ZTvB
         4IfnRXHJxsmq3KVtnc6xfyutNMUQf/K6DQI0U5IP1ouU+X8d+hgrKYFBqXv7Q7LLAEQS
         gdocE9ONvCHMoU7lUTQ9eSskIexKoSL7mDj6LWH2nY8ZfemrPQXMTcDmLSDy1EbD4r1y
         eg4nOTN/wUJNJekXQfv3Jy2SNIoCC+3A3CSWKHjBKT0oBxkpOG19L8T0zzjjk41IOCFN
         6zLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=cvh7wdYAf5SrDD4ATZzl4f6p3kZaepf28aeSOhNAoiU=;
        b=Gs5n9lfSyvRE2/tdxtaEm4uvMgvKJt5uZnsbSMnWGMCmvefzr+h8IIdzqpIWppVQAW
         ohDJA0D4S6uZNNdvIiAy1e5PGaZGI1iFd8YiUt1WKIAw6EdFVtz+5MyhsUsyJptq3/Tl
         wWT+YMK3FxiaPozN1d29NkkjGTqeEKCOGnb/QfTmXBnrX6ANNrrjE2n7xuwdUi8aHx96
         5t0SSibmtHtmNM9KpMuC19DYIIVwRzAA0B1wT89j2RjwLTemyYO2px0FQw4wWz96i34W
         1dfIn4euNQIf6hSK3fovAN4ob/VT59LCNk4d5WOqsojmW6u+FwKzX3YIHnASglBwKg1/
         L8bA==
X-Gm-Message-State: APt69E3qSosmd361IN7zkKawufoOEJhbKxoz9KVeaFoKcinbySpNVQXP
        t2Hp1JWH5t07jA7tHS8tXKAe4nzi31eMtzFqS6gl6LaR
X-Google-Smtp-Source: ADUXVKKogbcJWlX+SQUB5tS77yV/Nl2LVb6zh8PsCbnT9y72hJisyb4UsS3Nz/YdtbFWm6C641IYJLw75vo22NPmowY=
X-Received: by 2002:a63:91c8:: with SMTP id l191-v6mr10111947pge.180.1530225447628;
 Thu, 28 Jun 2018 15:37:27 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 28 Jun 2018 17:37:15 -0500
Message-ID: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
Subject: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ronnie brought up an interesting point about the problems consistently
configuring file systems (or any Linux module for that matter) so that
reboot doesn't wipe away security or performance tuning changes.

Linux file systems typically allow configuration via various ways (I
may have left some out) for example:
- module load parameters (modprobe etc. e.g. for cachefs
"deferecreate" or "deferlookup" can be configured, as can various
parms in the nfs or cifs/smb3 modules)
- Settings via /proc/fs/ or /sys/fs (e.g. /sys/fs/ext4/features)
- Settings via mount parms

Other than /etc/fstab which is fairly limited,  AFAIK the only file
system that has persistent configuration in text files is nfs - which
allows a limited number of mount related settings to be set to
defaults via nfsmount.conf

Are there good examples of either text based configuration of Linux
kernel (preferably file system drivers) e.g. something vaguely like
/etc/btrfs or an /etc/xfs to set default security or performance
related parameters consistently over reboot of machine, or even better
something vaguely like Samba's "net conf" tools for setting
keyword=value for various types of settings in a somewhat safer way
(in a registry, which in Samba's case is cluster safe, and fairly
robust)

What is the recommended way to persist configuration settings for
Linux drivers across reboot?

-- 
Thanks,

Steve
