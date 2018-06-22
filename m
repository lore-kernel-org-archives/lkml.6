Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0514DC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CB02445E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3ulnrRn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98CB02445E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754206AbeFVPJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:09:26 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:38228 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeFVPJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:09:24 -0400
Received: by mail-ot0-f178.google.com with SMTP id p95-v6so7854365ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=KumSvhZYiuaHlNNy8cCnbApkYxDl9lrTkEw/2sTTXTU=;
        b=p3ulnrRnpVDZWh/cRckaUWf76yq1eS35IQMT+xGVTLof1kv+idbyCLWk4xdUNk6ylu
         xwWhWgcljxzgFPq1GAFE7qEbzx4qYfmnMwSJGZf8hwZxJFB4OoQB7PRoUDzsWNTyQopS
         Ybegpu6SNzcr7UskR/UC62h9NYEEd2t3Tbf8irC0kYpMgcbQZMD8Hd0xnDD2EncqCasF
         zRC1n2hB8sB0qULOUMaQZieStU/9k8JsF8z4uvZCIfohslevd9tv2cm5EwNpfAbNiwK4
         LXOZuxFIEEebcvsBmAnbENJKxgTvfbJd4Js+sDH/tpLrxHCf3tdzjue9EEYOlOnJJU3+
         SIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=KumSvhZYiuaHlNNy8cCnbApkYxDl9lrTkEw/2sTTXTU=;
        b=LXc+lIp9FUc9zaSXQSUX64vxtxGdR3JbHodbxk6iJt5L9TbA7wJEimjSkDqeJxoiTY
         CL1T6NLmMMMis9gnhCSCeixAvk62kq04+BofM3eAmVKW39EKYvShDdhNc0OP94jZgsj+
         Br9KpFmFZYOm9XbIFE1Spg0WmPttpxjcO+/S4ueWR5cXJkc5O+KA1OzhLzZAyg+tvYcV
         XxPK3R8Xjl3FgoKjqfPKGvzd+5pzjibAbZB6PBXEpAk6tDDFhK5n+8wqBZknNjeTeyZF
         xsD6sg4y7IIGQ3RQKhL9GHQDqGWD84sD9XQvaIwx1ZlO2ZICKC5nC5Ezf5jNfBg4AQBz
         rmTQ==
X-Gm-Message-State: APt69E2MmXKAQGYrgdd/qI5+nt28hSLC4wuHp0lhV/4+dYuyyuM6vrQ5
        Kt95N7lcpu+h3LXik3N68IJt3z31LjxfBY5FiRdO7g==
X-Google-Smtp-Source: AAOMgpcqolYd2kNUtqnP8wOl1+4EsNg6xo9R1RXPf9mWon1jrVBvIuj4sLIp8MCyAWnJqigRLkzAaNeML0Lwk77MrRY=
X-Received: by 2002:a9d:fba:: with SMTP id d55-v6mr1222836otd.53.1529680163848;
 Fri, 22 Jun 2018 08:09:23 -0700 (PDT)
MIME-Version: 1.0
From:   Thommy Jakobsson <thommyj@gmail.com>
Date:   Fri, 22 Jun 2018 17:09:12 +0200
Message-ID: <CAOTQ16LL_W+RqDWQLzsvnRaYGT_9E9EMN_9hdr-vie8hp83gAA@mail.gmail.com>
Subject: BUG? DOC: Really jiffies in /proc/schedstat?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am measuring cpu runtime for a couple of processes, and is using
/proc/schedstat and /proc/[pid]/schedstat to do so. According to the
schedstat doc
(https://www.kernel.org/doc/Documentation/scheduler/sched-stats.txt) the last
three values are in jiffies. Doing something like

root@gvp4-base-pd-b-rev1:~#  cat /proc/schedstat  | grep cpu3; sleep
2; cat /proc/schedstat  | grep cpu3;
cpu3 0 0 0 0 0 0 41155818663320 17173365985560 1011370906
cpu3 0 0 0 0 0 0 41157858979020 17176095339120 1011430425

on a heavy loaded system seems to suggest that at least the sum of running tasks
is in nanoseconds, not jiffies. Which I also think looks correct when
checking the
code.

For /proc/[pid]/schedstat the documentation is a bit vague on unit,
but I interpret it
to be the same as the corresponding global values. Which would mean jiffies.
Also here it looks to be in nanoseconds on my system though.

Am I just confused? is it configuration/system dependent? or is the
doc just plain
wrong?

Thanks,
Thommy Jakobsson
