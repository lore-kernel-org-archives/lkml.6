Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E8CECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4C620882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 09:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJfLN0gg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4C620882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeINOU3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 10:20:29 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:33217 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbeINOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 10:20:29 -0400
Received: by mail-ot1-f50.google.com with SMTP id i10-v6so3896690oth.0;
        Fri, 14 Sep 2018 02:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1bkKxS2Yw3/LD52o6gHxSDeq6fym5N2PzqrAFFJPcuA=;
        b=kJfLN0gg0IbP261IXhu1PTp67JP8rshPMKCn+H/tthS0kVzbbITX+3VKX7/6vjSHjk
         ux8N1MFkMpFuMTI/qSjj7cs4uj4tduCvA58aDH8P1otd93eM8UP2nC5umqMbUBE1/dk2
         d52vuytQzwkPO1QkmFNctuqV6VYOIPztVS25CGPP4c06Ch2dWIT8RaLJCIos2/YSoPkX
         54ShNrKJB+wyJ6SDTGW5x+4C4zKxR34g+7juO3Hxi6CsdNLTopzvajHjnZsSsjTpmLFS
         7yb2YiAQKOhO7ec7IPimvaJkqZbJtWgCkedVTs6sz6UMgysrVc8ol0B4nqeGZ6YjqD45
         dX+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1bkKxS2Yw3/LD52o6gHxSDeq6fym5N2PzqrAFFJPcuA=;
        b=lTNLDUVc42KrQDaXnv/iq+Aojn4rTHcgNrPE0PIFFpBL0ECzquDdvvhUukLOZdr7Ov
         hUxBx10QAQqONTBr5MBhSni+ZTmJ0HlyxCMNkTwqaG1+KlVVdSA8VXYZ+6+HaonG71HJ
         qrvuHH5gts4CteNOQ42PSL0MIUO/bFhrg8ROB7tlnSFcns3RJuXBebbmgPtoc5rHhh+8
         TNitVZ9d/IMeQLJChWIgUi1hyROfdq6HMpj3xpab7eB93FaF2rYoVkJdOcztxjip1RJy
         GsUjAIu1V+xTU3TTgCXwLEoWX66v7WtSvw4gvX6rtW63eVuajek4WGPKk/SYEsdwRatS
         aCog==
X-Gm-Message-State: APzg51B2qrx8emiOIhGuCGBsrjH4lJriDR2RVn7kQJg4NkWHKDoHcCfo
        Q2+02cjjlMQRzL17My9k9lZhWSaq9KW0LTU0fPfjMaJh40QlrA==
X-Google-Smtp-Source: ANB0VdZu8KMnTsYwMgpRZHZ3hw5mw9YRoOk1+Kaet7TD2J83H3JVLe1Azw/S59SnCr7YNkbY4hnMqcqdSQ1FP+jnQxY=
X-Received: by 2002:a9d:30d1:: with SMTP id r17-v6mr3909822otg.182.1536916015314;
 Fri, 14 Sep 2018 02:06:55 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Fri, 14 Sep 2018 17:06:44 +0800
Message-ID: <CAJDTihzzLV3qwg0tGH_D4xAjCrgMy+oc4H9snpnMC_RC2q7nyw@mail.gmail.com>
Subject: metadata operation reordering regards to crash
To:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

A probably bit of complex question:
Does nowadays practical filesystems, eg., extX, btfs, preserve metadata
operation order through a crash/power failure?

What I know is modern filesystems ensure metadata consistency
after crash/power failure. Journal filesystems like extX do that by
write-ahead logging of metadata operations into transactions. Other
filesystems do that in various ways as btfs do that by COW.

What I'm not so far clear is whether these filesystems preserve
metadata operation order after a crash.

For example,
op 1.  rename(A, B)
op 2.  rename(C, D)

As mentioned above,  metadata consistency is ensured after a crash.
Thus, B is either the original B(or not exists) or has been replaced by A.
The same to D.

Is it possible that, after a crash, D has been replaced by C but B is still
the original file(or not exists)?

Or, from the view of implementation, before the crash
- in a journal filesystem,
Is the atomic transaction `rename(C, D)` permitted to be written to disk journal
before the transaction `rename(A, B)`?
- in other filesystems, say btfs,
Is it permit to reorder `rename(C,D)` and `rename(A,B)` atomic operation hiting
disk?

The question is meaningful as many applications do that:
if (flag_file_says_need_generate_data) {
    open_write_sync_close(data_tmp);
    rename(data_tmp, data);

    open_write_sync_close(flag_file_tmp, no_need_to_generate_data);
    rename(flag_file_tmp, flag_file)
}
use_data_file()

If flag is here but data is not after a crash, that is a problem.

Thanks,
Trol
