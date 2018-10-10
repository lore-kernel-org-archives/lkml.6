Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D546C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32382086E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 16:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32382086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJJXYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:24:51 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:36906 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbeJJXYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:24:51 -0400
Received: by mail-it1-f197.google.com with SMTP id y73-v6so6398478ita.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 09:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=yN3SkKoekkO8hZ3EOBFvf2qZQRBfhmtg7wD54e1qRpU=;
        b=fpHekaWieFmi5MyByAVL7ilDNzIiXtsx41B2q8Xs7Jl9q6gtUd2vDGfO1tWuQTZ6kB
         db6/zGGgb6CXO9myExJ590Hu1RUe1nntLlDYYAixy1itzN7Xf5VWX2y8hs7x2ySHwr0y
         QwirlzjdRFjvaUdjw8rXEPQlzcjMhFq/vqT8ScXGAbhcBeivClbkCWMLbSuk5rFU4fEi
         H/sWbdeoXJ1OuBpCW2RYEyuUdquswHZSjrMMM6dmf+bHZTTJPfOUFhv2uayhI+RTmF0T
         i2y6U4ixiSjIqnFCc/FvQTWpBJj+0G49ZJg2PDKgS+A3y/s55urFimOADU+JRmnrP94a
         K1Aw==
X-Gm-Message-State: ABuFfogPjqBpUrh9bh4AEdXqJqQkVOgsVAoWtmCiSF+hwBHerO/9eJPZ
        +h44p2lkPAXDGEl/g3WQNjuS30CaJAcTedGcE3m7bMQsFS1l
X-Google-Smtp-Source: ACcGV617nI5N1lRu3grwYvKTXgKOaK37/mcDV0Tc9wv3RYuUlxPiHMNO5a9f5J/w5qh5cOaR/yqQLf/h7JA7RqdzRY0+4mwIrDDL
MIME-Version: 1.0
X-Received: by 2002:a24:8306:: with SMTP id d6-v6mr1203946ite.24.1539187322899;
 Wed, 10 Oct 2018 09:02:02 -0700 (PDT)
Date:   Wed, 10 Oct 2018 09:02:02 -0700
In-Reply-To: <20181010160022.GD20918@nautica>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009fd54d0577e1f9a0@google.com>
Subject: Re: BUG: corrupted list in p9_read_work
From:   syzbot <syzbot+2222c34dc40b515f30dc@syzkaller.appspotmail.com>
To:     asmadeus@codewreck.org, davem@davemloft.net, dvyukov@google.com,
        ericvh@gmail.com, linux-kernel@vger.kernel.org, lucho@ionkov.net,
        netdev@vger.kernel.org, rminnich@sandia.gov,
        syzkaller-bugs@googlegroups.com,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

failed to checkout kernel repo git://github.com/martinetd/linux.git on  
commit e4ca13f7d075e551dc158df6af18fb412a1dba0a: failed to run  
["git" "checkout" "e4ca13f7d075e551dc158df6af18fb412a1dba0a"]: exit status  
128
fatal: reference is not a tree: e4ca13f7d075e551dc158df6af18fb412a1dba0a



Tested on:

commit:         [unknown]
git tree:       git://github.com/martinetd/linux.git  
e4ca13f7d075e551dc158df6af18fb412a1dba0a
compiler:       gcc (GCC) 8.0.1 20180413 (experimental)

