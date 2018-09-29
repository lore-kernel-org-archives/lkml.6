Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 062BAC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A153B20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 08:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJqdQdjM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A153B20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeI2Ox6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 10:53:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33096 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbeI2Ox6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 10:53:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so5866903pfn.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sWSx5Pg2KyRtXyD75XvycxaZYeX+wUxjGd4FM4Wjx2Y=;
        b=DJqdQdjMLSza45WxNRJtgRZWnv4kK253eZ4icBM9zD7ALVrM4mde+2xQBYuARvMNJT
         40adgXn27Vj0zwHIkNQx3n/6RNysfNwvduSjkg07tiar9FDzDMP+BTThmp8Wkd6V73hB
         6ivNqyWkKZTAd9xHKGG65+x7td6zNnb5PdIpej/jypDFUfGgyTNHsTp0/9ztwkpMBBKC
         1HS4XZ0gvo7wqz8dLPcBIUWN78G/Tw/uWqEhbRjFqQ9+8idg0e2wBDR/mqd04eLgZODT
         TpNGVIZUTB+FZEy0bvqQXHSSu5CEOSXt3FdbJIdlQ083UG/0czz5OLO9Qe5N+Lg3Nods
         5J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sWSx5Pg2KyRtXyD75XvycxaZYeX+wUxjGd4FM4Wjx2Y=;
        b=BGdwsAVgGfdbeT0rbXeS0XRuG5WTH4OR6gssTFO0ApbN4sSdVKVYK6y06PYd3p754t
         7/MUDyW4nR8lORvhIQCUb/YhwFdfQBi9VxpQgJQEtzzPb9IXJvBnBidvkMZKYwvew3N0
         9V0uBGywouhS6wEGu+nqqhVciE+hGZtQAVWf+QOIHORBY83W2WVsESK5CrcNyDzRjT2h
         4iEI71A3DeLgFVKz8oVB+2fldmyiYc4xEVPPyX+9J+yD5gh8JBJhOwkARsiQ6YGmhGAL
         owhZP68hbTeRWfy20ZqtfFOMoR0kRBOAjJiY9Wqslb4ZbVTARwlxZtcyPslz/0DnbvIm
         MHZw==
X-Gm-Message-State: ABuFfojI8Nhh3jl1EFggtWsEqucD+vdh4CaM5wOvgjHUFIlYR/ZfaGik
        ThhuiEtL7HCYzg5f9SlFPTcdri00xyo=
X-Google-Smtp-Source: ACcGV619ZISRu1T/ytLu3dGoV+LD9JQMMGM0nxRWHkRWCU5EG7M6Zy6uK9dXvh5uO59cZtkQDPCBAA==
X-Received: by 2002:a63:a42:: with SMTP id z2-v6mr1947861pgk.209.1538209585545;
        Sat, 29 Sep 2018 01:26:25 -0700 (PDT)
Received: from localhost ([110.70.26.9])
        by smtp.gmail.com with ESMTPSA id k13-v6sm4543268pff.30.2018.09.29.01.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 01:26:24 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 29 Sep 2018 17:26:19 +0900
To:     zhe.he@windriver.com
Cc:     pmladek@suse.com, sergey.senozhatsky@gmail.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] printk: Fix panic caused by passing log_buf_len
 to command line
Message-ID: <20180929082619.GA582@tigerII.localdomain>
References: <1538145961-52724-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538145961-52724-1-git-send-email-zhe.he@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (09/28/18 22:46), zhe.he@windriver.com wrote:
> This patch adds a check to prevent the panic and a check to report if someone is
> setting it over 4G.

OK, He Zhe, you are almost there.
Let's do the series the following way:

- four patches
- each change goes into a separate patch
- the first two patches Cc stable


patch #0   Cc stable

---
	unsigned int size;

	if (!str)
		return -EINVAL;
	size = memparse(str, &str);

---


patch #1   Cc stable

---

        len = sprintf(text,
                      "** %llu printk messages dropped **\n",
                      log_first_seq - console_seq);

---


=====================================================================

patch #2

---

#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

---


patch #3

---

      if (size > UINT_MAX) {
              size = UINT_MAX;
              pr_err("log_buf over 4G is not supported.\n");
      }

      ...
---

	-ss
