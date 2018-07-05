Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1825C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D40C23E80
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 17:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D40C23E80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753954AbeGERCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 13:02:04 -0400
Received: from mail-it0-f71.google.com ([209.85.214.71]:51286 "EHLO
        mail-it0-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753657AbeGERCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 13:02:02 -0400
Received: by mail-it0-f71.google.com with SMTP id b83-v6so1537382itg.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 10:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FTY8+yXPqNuR4Oewo/fu/it+cEqsTgmyxYifUCu1mAM=;
        b=IejlKwXt+LKjzUN765JyE6n/3B0jPVZ7+rMHc5mpKZcBl8lCzz561OIUCbNEztoQie
         /2pMw2Ya0LLcofBVvKh9Q031/X55hiabdtEPBg/RmA7UlWZN/VUIP3dTuMRbfuBHDina
         7deaSg1VB2Rj31oD+oP1lpOxSZvsY9ZyT4pVDrOoic/0/jERDT+FKbd/o1WQ/YlENzPv
         4UvZDmehRYZ7//bVzVDXjHODpTncRGdtHsNaGvp9TdrUv9I4yGhb25o3A3W+TNpyTG5N
         IZ5OcUx823LHfWYnEnMswN5JzvpFDSfwCaBMUP3RkePjoQw94AyX0J8LP/tgYdzXn23B
         AgIQ==
X-Gm-Message-State: AOUpUlGfOBr/n2qhad+uObSG5Se/kKEdchqvpGcQ9Gf6LXSqRN+ZNp7U
        STIVo6cmVm6Yzk02H2lLU0f1kwvAmZnlRyM1YmPae40pqY8x
X-Google-Smtp-Source: AAOMgpcYN/T9iDCJiZ7iAMlWm3WX65BRFdQK+I2OnEEZ6pvnw8DZuFBzw3iHoCkkA/0rtjXVDwJDMk4nAcRvu8VQPFOtQVzM/KbJ
MIME-Version: 1.0
X-Received: by 2002:a6b:b7c1:: with SMTP id h184-v6mr3055826iof.100.1530810121611;
 Thu, 05 Jul 2018 10:02:01 -0700 (PDT)
Date:   Thu, 05 Jul 2018 10:02:01 -0700
In-Reply-To: <3579823.yyIR4au8HA@positron.chronox.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000846e9e0570438176@google.com>
Subject: Re: KMSAN: uninit-value in af_alg_free_areq_sgls
From:   syzbot <syzbot+9c251bdd09f83b92ba95@syzkaller.appspotmail.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        smueller@chronox.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo https://github.com/google/kmsan.git/---:  
failed to run /usr/bin/git [git fetch https://github.com/google/kmsan.git  
---]: exit status 129
error: unknown option `-'
usage: git fetch [<options>] [<repository> [<refspec>...]]
    or: git fetch [<options>] <group>
    or: git fetch --multiple [<options>] [(<repository> | <group>)...]
    or: git fetch --all [<options>]

     -v, --verbose         be more verbose
     -q, --quiet           be more quiet
     --all                 fetch from all remotes
     -a, --append          append to .git/FETCH_HEAD instead of overwriting
     --upload-pack <path>  path to upload pack on remote end
     -f, --force           force overwrite of local branch
     -m, --multiple        fetch from multiple remotes
     -t, --tags            fetch all tags and associated objects
     -n                    do not fetch all tags (--no-tags)
     -p, --prune           prune remote-tracking branches no longer on remote
     --recurse-submodules[=<on-demand>]
                           control recursive fetching of submodules
     --dry-run             dry run
     -k, --keep            keep downloaded pack
     -u, --update-head-ok  allow updating of HEAD ref
     --progress            force progress reporting
     --depth <depth>       deepen history of shallow clone
     --unshallow           convert to a complete repository
     --update-shallow      accept refs that update .git/shallow
     --refmap <refmap>     specify fetch refmap




Tested on:

commit:         [unknown]
git tree:       https://github.com/google/kmsan.git/---
compiler:       clang version 7.0.0 (trunk 334104)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1207511c400000

