Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751048AbeFAFdS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 01:33:18 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:45989 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbeFAFdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 01:33:17 -0400
X-Google-Smtp-Source: ADUXVKKFOMzL4im1Lae+VumDKI7Meg6XkiVKySADFpPvJbrJ9wyOaQi2RriViWSbAYX98vERFh0BAEo0oPWDIUfRQ2c=
MIME-Version: 1.0
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Fri, 1 Jun 2018 08:33:16 +0300
Message-ID: <CALsPMBOcr_3t9xLDX_i0ttP4Mbb+-rTdeUP4jSD-mYgXqok7QQ@mail.gmail.com>
Subject: How to obtain file's inode in ufshcd driver
To: Vinayak Holikatti <vinholikatti@gmail.com>,
        Santosh Y <santoshsy@gmail.com>,
        "James E.J. Bottomley" <JBottomley@parallels.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody.

I am modifying ufshcd driver:
https://elixir.bootlin.com/linux/v3.8/source/drivers/scsi/ufs/ufshcd.c

I do a read of a file on ext4 filesystem and want to obtain the file's
inode. But it seems that there are no structures contatin any
references to inode at this level of abstraction.
I looked into scsi_cmd structure and all the structures it references
to. Also I used ftrace to find on which level of abstraction inode
disappear but without any luck. Could you please say to me where I
could find the lowest level where inode is still present and the best
way how to pass it throughout linux io stack to the ufshcd driver?
Frankly speaking I need not struct inode as a whole but just its
number, so using reserved or unused fields of existing structures is
appropriate.

-- 
Kind regards,
Roman
