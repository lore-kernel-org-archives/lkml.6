Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2F8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C669B20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ncllfg59"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C669B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbeK1BaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:30:18 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44502 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeK1BaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:30:18 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so8453121pfh.11;
        Tue, 27 Nov 2018 06:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyjXImLbd97+OASihcDoAxMhsoRxlpcwVXY0gHzFcK0=;
        b=Ncllfg59VKkuzHWT2pej3vh+54K9XWPCtRrvkVLlTOLojsPftoIoIvCWLSq+CudVnt
         c+B6DQLfbW3lt12gigN4GPx3Ylf6+sSPGabdMxCZ5GD60SvCtC0KVrSe8ThxvxI0teYY
         CLjhDKqreM4K5NPP1Kl0A4BesXGG4JQrKYFjocfkMfyL+NNyH/Vd/CDpuuW6rNDTD5nD
         AtsC+0UI6/qbIFnrKU1Ua0kOXNAEkwPuAO33KCVwqVrsdtcxyLwFHzq6eFZJliHQ0BW0
         I9m9+Z3Wz2Fley8TQ+fOLDq7b1CVJXSvmEpAMsj7GvTdExgvQIeZViuXE0iFqqYLmfeP
         FBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyjXImLbd97+OASihcDoAxMhsoRxlpcwVXY0gHzFcK0=;
        b=innToY2k91dRbWkpbqK/YyTUD4bvJJL0s51HQj/SMteDO96q4x3XaP630vJXSVbsFg
         ufbM0TJHzJJluEgR29ZSWUQDc/eXGHPTZK+7kRrlodW1Lxrnmqrxbf8MmA21EjF2OTvV
         VYS7Q1ctVGLZNq0aWHNK1FwDSdVg4RZAVWFBuZ5KlwwHwnHNnqfa0J/IVmd+Vv7DC96p
         p6Z5XfKu5Oc+X7YAe4G2KoUxFNWCL8Y3Dl5rBu/+ZvsRBcXS4aTAGASJW8id3OaBq4N+
         +0FWqeTU2roPXmccnpgo7BRIq+p1tJi9/Gd+MR3zy9jFUC4NUOJ9XynguCdykABVqWT0
         ywog==
X-Gm-Message-State: AA+aEWaMjOzojbMBtl+4wNFpb9fkIhE+PMJlyat6+RByYvGVC3W0/sGs
        9AsDJ5gibOlYvb5GdcSdww8kNfIY
X-Google-Smtp-Source: AFSGD/WAMMl/FXyHhKG22wppu6utxWKqhLQzjYKpA2n2mMhsEcM758vxhPFV+mwciIJJU8GyXrIFRA==
X-Received: by 2002:a62:3811:: with SMTP id f17mr5074970pfa.206.1543329131254;
        Tue, 27 Nov 2018 06:32:11 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b9sm4500659pfi.118.2018.11.27.06.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 06:32:09 -0800 (PST)
Subject: ext4 file system corruption with v4.19.3 / v4.19.4
From:   Guenter Roeck <linux@roeck-us.net>
To:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
Message-ID: <b43fb902-9b64-22d9-25ca-c970b3842a43@roeck-us.net>
Date:   Tue, 27 Nov 2018 06:32:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <065643a0-f9aa-a361-715a-03ca978d9228@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[trying again, this time with correct kernel.org address]

Hi,

I have seen the following and similar problems several times,
with both v4.19.3 and v4.19.4:

Nov 23 04:32:25 mars kernel: [112668.673671] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602889: comm git: bad extra_isize 33661 (inode size 256)
Nov 23 04:32:25 mars kernel: [112668.675217] Aborting journal on device sdb1-8.
Nov 23 04:32:25 mars kernel: [112668.676681] EXT4-fs (sdb1): Remounting filesystem read-only
Nov 23 04:32:25 mars kernel: [112668.808886] EXT4-fs error (device sdb1): ext4_iget:4831: inode #12602881: comm rm: bad extra_isize 33685 (inode size 256)
...

Nov 25 00:12:43 saturn kernel: [59377.725984] EXT4-fs error (device sda1): ext4_lookup:1578: inode #238034131: comm updatedb.mlocat: deleted inode referenced: 238160407
Nov 25 00:12:43 saturn kernel: [59377.766638] Aborting journal on device sda1-8.
Nov 25 00:12:43 saturn kernel: [59377.779372] EXT4-fs (sda1): Remounting filesystem read-only
...

Nov 24 01:52:31 saturn kernel: [189085.240016] EXT4-fs error (device sda1): ext4_lookup:1578: inode #52038457: comm nfsd: deleted inode referenced: 52043796
Nov 24 01:52:31 saturn kernel: [189085.263427] Aborting journal on device sda1-8.
Nov 24 01:52:31 saturn kernel: [189085.275313] EXT4-fs (sda1): Remounting filesystem read-only


The same systems running v4.18.6 never experienced a problem.

Has anyone else seen similar problems ? Is there anything I can do
to help tracking down the problem ?

Thanks,
Guenter
