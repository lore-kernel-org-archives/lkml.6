Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0812C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F8920869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 02:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdI84kvL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75F8920869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbeJPKfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 06:35:23 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42376 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeJPKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 06:35:23 -0400
Received: by mail-pl1-f194.google.com with SMTP id c8-v6so10215288plo.9;
        Mon, 15 Oct 2018 19:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xyXerfVj3ZhyBj11fCc3nanRzINJD20WZqX5OySxvBI=;
        b=KdI84kvLbm0MQb7ui5IK767NzmuqIbO8s6dpmT+q2jReZSsfoq8Kas3u4+mm/gObid
         4Ocuat2L0W4QjTgbuO2xEBKN/sFuLOsHgYuHh2Yz7Xex0hrCXHOED3jwE+iy3xYH7Z3b
         f0ecMP9n8NQz1NRh639SocSYAOyvQ0e3NUArpTmHPJrm2PVrK/Ucr2IO6gVLpBM37uJN
         Jf1cdQ1iS7c8KTiTvOPXE8yyfDdZmiR+TNsXEMYKmIVdtA1Ry+kS86cmgsRSU4S/Lj2U
         Z1YDp4mdfvDto/igK1MixkNqeV2mkHUnX1ndtD4tG13HNdI3xCK+5z52oBEw3aDg7fya
         cyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xyXerfVj3ZhyBj11fCc3nanRzINJD20WZqX5OySxvBI=;
        b=bRK7FXj4cemqAJWYEZrLyRcGTr8ObzkbD8WMOtRIDzqKwQZJ68kAw60GEVf8s1gGrp
         oQHTFJfs9N+GCzfBir2OhTQExiv//GtORYVlrzZo27xA6IhVyvAryMY8dMXj8pM/DEnZ
         s4a7qwrioFneErdskhBbvbJU0yk7+s9x7u/DRzcgmNzTjMlYr8hyM5M5Ygs4n2Yrumm7
         jxfiAcY2poHx7efrFIavIiIVq8p6ql2hwRAoHkkgLbuoc588StwO9KjwityvZ+E/BL5b
         UChIXcsU3idY76UjV65AAzdyu3KZ2TppQ9ob2yajRf7rIhtgdZ4w83VqTP0jK1/Slt65
         8UJA==
X-Gm-Message-State: ABuFfogPfpRhheVW4HwkHUQxtuxuJVEq/W7x9G1lcpNHJMj6rq3FLKPl
        ZjbRs+Bh/+cHrRsPy0dlSfI=
X-Google-Smtp-Source: ACcGV62olSiQBBsHTBkPA9TRWqjqlgRkQWILUuI9wymkFcbHs8kM9tT7cJIiAGIeqSwGR24inXSQoQ==
X-Received: by 2002:a17:902:b182:: with SMTP id s2-v6mr19462160plr.84.1539658038121;
        Mon, 15 Oct 2018 19:47:18 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l71-v6sm20353451pge.89.2018.10.15.19.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 19:47:17 -0700 (PDT)
Subject: Re: [PATCH v2] of: overlay: user space synchronization
To:     valdis.kletnieks@vt.edu
Cc:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        geert@linux-m68k.org, Alan Tull <atull@kernel.org>
References: <1539649621-5518-1-git-send-email-frowand.list@gmail.com>
 <5408.1539650158@turing-police.cc.vt.edu>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <294737e8-f94e-5d53-acaf-ecb9a4ef42af@gmail.com>
Date:   Mon, 15 Oct 2018 19:47:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5408.1539650158@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/15/18 17:35, valdis.kletnieks@vt.edu wrote:
> On Mon, 15 Oct 2018 17:27:01 -0700, frowand.list@gmail.com said:
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> When an overlay is applied or removed, the live devicetree visible in
>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>> changes.  There is no method for user space to determine whether the
>> live devicetree was modified by overlay actions.
>>
>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>> user space to determine if the live devicetree has remained unchanged
>> while a series of one or more accesses of /proc/device-tree/ occur.
>>
>> The use of both dynamic devicetree modifications and overlay apply and
>> removal are not supported during the same boot cycle.  Thus non-overlay
>> dynamic modifications are not reflected in the value of tree_version.
> 
> Is there an easy way from userspace to detect "yes/no dynamic modifications
> have been done since boot"?
> 

Unfortunately not.

I considered adding detecting dynamic modifications in another patch, making
this a two patch series, but that feature will be much more intrusive than
detecting modifications made by overlays.  I may add that feature in the
future, but not anytime soon.

If you want to understand a little bit about why dynamic modifications
occur, please see my reply to Geert in the thread about version 1 of
this patch.
