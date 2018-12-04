Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ADAC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A86B20834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fgC6DsST"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A86B20834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbeLDUjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:39:08 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46673 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbeLDUjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:39:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id c73so8782577pfe.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wJ/j62LiSch6bvKVll7Ac7D2SHOc9QfdG+9Z3J+Td8Y=;
        b=fgC6DsST2PrCjZ14iXyAwzH9xdulZU3S3eQ0J/vuo+Ruher0dWrKlDtX4cI8HGrt1I
         ivJXMdrLgalI66ZDh6OQoFxjCf7NKPRzVNBx1l6fyabR4143DdqXk9o+D9yrKxBl2pQU
         /PoQu7JN9CovdgffPfR9cylfjrZ9s4GW93Cqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wJ/j62LiSch6bvKVll7Ac7D2SHOc9QfdG+9Z3J+Td8Y=;
        b=SJ1i5qI0XZbKqsKal1PNwIxX0ZJYLkDBRyqXXS5heeRGmNxORK0/16VzRennj1YDsY
         U48Whin/BfOtbqrCOhznTdPSI4q0XAvb3htcZIdkhsg0kskCLL5V2wjXYZ2HKevP4roo
         khZl4X142zyGcraTqRNjW3eeBK73NtaLq84HslRut2fJ31fV9YCzA8oahlDJLCUyRbly
         EWpDkyCh1vY3M274Hs4j7qj/eawHLD6kATZwESHKeh8jT/q3TQSJ5QSnIdPmlFkCDkZM
         jfHHhU4cdsqr4HRJg60sRRzIQYS6XeIfyvCr3GAwyTomLZm0PMTj5RbjK3cYziGbzIws
         ueyQ==
X-Gm-Message-State: AA+aEWZRMj5lsdYtH9PKDoG+tMbBlbeSmJF19kc1qAUIZPrfbp0VAptE
        DPLqM5hI8+ZEh5wNpeRYoE9EbA==
X-Google-Smtp-Source: AFSGD/WpnY5IDI33GsU6V2fG8hr8j58z0pD6J5ea4LS3kMD9TZviBzIXqwPO0tU4RQ/R03HWFjJMaw==
X-Received: by 2002:a62:c583:: with SMTP id j125mr21727839pfg.37.1543955946497;
        Tue, 04 Dec 2018 12:39:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r76sm29783274pfb.69.2018.12.04.12.39.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 04 Dec 2018 12:39:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 0/3] perf tools: Add support for ETMv3/PTM1.1 decoding 
Date:   Tue,  4 Dec 2018 13:39:01 -0700
Message-Id: <1543955944-10042-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

This is a resend of a set previously published in November [1].  It adds support
for ETMv3/PTM1.1 trace decoding.  The work has been tested on TC2 and
ST-Microelectronics' mp157c-ev1 boards.  It also applies cleanly to your
perf/core branch [2] and does not affect results yielded by "perf test".

If it is already in your set of patches to apply, please disregard and delete.
Otherwise I would appreciate if you could consider adding to your next branch
for the 4.21 cycle.

*** Before this set ***

$ perf report --stdio
# To display the perf.data header info, please use --header/--header-only options.
#
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0020 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0022 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
        DCD_ETMV4_0024 : 0x0003 (OCSD_ERR_NOT_INIT) [Component not initialised.]; No decoder configuration information
Warning:
AUX data lost 2 times out of 2!

Error:
The perf.data file has no samples!


*** After this set ***

$ perf report --stdio
[...]

# Samples: 12K of event 'branches'
# Event count (approx.): 12049
#
# Children      Self  Command  Shared Object     Symbol                 
# ........  ........  .......  ................  .......................
#
    28.18%    28.18%  uname    libc-2.19.so      [.] strcmp
     9.13%     9.13%  uname    libc-2.19.so      [.] strcpy
     7.87%     7.87%  uname    libc-2.19.so      [.] strnlen
     5.58%     5.58%  uname    libc-2.19.so      [.] strlen
     2.24%     2.24%  uname    libc-2.19.so      [.] __rawmemchr
     1.91%     1.91%  uname    ld-2.19.so        [.] 0x000000000001156a
     1.49%     1.49%  uname    libc-2.19.so      [.] __argz_stringify
     1.46%     1.46%  uname    libc-2.19.so      [.] malloc
     0.96%     0.96%  uname    libc-2.19.so      [.] 0x0000000000054770
     0.91%     0.91%  uname    libc-2.19.so      [.] 0x000000000002430a
     0.85%     0.85%  uname    ld-2.19.so        [.] 0x0000000000007244
     0.83%     0.83%  uname    libc-2.19.so      [.] __stpcpy

[...]

Regards,
Mathieu

[1]. https://lkml.org/lkml/2018/11/16/884
[2]. 34434e3633de tools lib traceevent: traceevent API cleanup

Mathieu Poirier (3):
  perf tools: Add configuration for ETMv3 trace protocol
  perf tools: Add support for ETMv3 trace decoding
  perf tools: Add support for PTMv1.1 decoding

 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 31 +++++++++++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  9 +++
 tools/perf/util/cs-etm.c                        | 73 ++++++++++++++++++++-----
 3 files changed, 99 insertions(+), 14 deletions(-)

-- 
2.7.4

