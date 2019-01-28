Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F29C282CB
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B231C2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/GgodD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfA1I5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:57:54 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:37013 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfA1I5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:57:53 -0500
Received: by mail-pg1-f170.google.com with SMTP id c25so6950932pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 00:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=uZu38z+wzt4MiIXwa4PXP7mXqfkMRkf2m6SXAtjxH5s=;
        b=I/GgodD1p7GkwbS38CJdFZtRhnA/gQJgwEdTEX+h3v/iYnYepKNuRcEg+XuhrrlzN8
         cWsffD/fgEI07I0vaQFPw1lIOeiLeJX2YDq/ooKsgH/fD6gtv3/IvDmyWCqGgM/UTzfx
         ouGsHqCriBpnWVr1PXMpy0+ETvxaSgg+vBz6ffifRRaUOXIBH2Iv4I0BhEuon8drMP4N
         hGp3HZ1jNmyn1WhWGQTLppAEKzS6UBI8vG76NY9AkpBheHXYRvpwaL1OmcXT25i5G4By
         8ps/OGFt6cdW5qcvNGiG2q0pixCdTT6qyKgiE0w4zrZNlH2sllUjYUyfNLo3U+EjQWWd
         k0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=uZu38z+wzt4MiIXwa4PXP7mXqfkMRkf2m6SXAtjxH5s=;
        b=rYQORAnBKWx8qBc1389/iLiulKWd9190FwTVzkOMdgyctpVTCe7KpGDnVrqPXn7xus
         YZwH2KnZ78Zg8KBCG1Y6x9PqWEWqGXRarYQwHQLyzkD3m7FA5KdFO8sF74togiT8Leuy
         X7+t/308a1DtIMTzJ0mb6UGDv7FcCckiyjZaImXdI2CL4zSOkW5bcn1AB9AZsptssAVP
         viq7nJE9I2dYz3/yAqZA6RDGlKMpMAKOAxWof1dxnpJ6Q2apRSMLD600xnPNWv+hxpMs
         q8VQTuD5TOrlhud/S3Nde0CCM788ucvD/B2kRc0GTmdEmlUplNVw8QanQkhWl3s/ZMrG
         3/UA==
X-Gm-Message-State: AJcUukemM9DV1h1T5xsbA19NdVinzkPGma6x0sYBJLaB6o/FUjomH7I0
        tQbDLIHMlD5HeEwe+85JQMARMeGt
X-Google-Smtp-Source: ALg8bN4dzIw3mNaJ5UhDtQ28SrDqnY80U3M444S411lQReHk+JR6PLTdbtkQSMyRrw9JqiNEw4aoEA==
X-Received: by 2002:a63:de46:: with SMTP id y6mr19022088pgi.198.1548665872029;
        Mon, 28 Jan 2019 00:57:52 -0800 (PST)
Received: from localhost ([175.223.18.40])
        by smtp.gmail.com with ESMTPSA id 202sm41945489pfy.87.2019.01.28.00.57.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 00:57:50 -0800 (PST)
Date:   Mon, 28 Jan 2019 17:57:47 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Michal Hocko <mhocko@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [linux-next] kcompactd0 stuck in a CPU-burning loop
Message-ID: <20190128085747.GA14454@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

next-20190125

kcompactd0 is spinning on something, burning CPUs in the meantime:

 %CPU         TIME+      COMMAND
 100.0   0.0  34:04.20 R [kcompactd0]

Not sure I know how to reproduce it; so am probably not going to
be a very helpful tester.

I tried to ftrace kcompactd0 PID, and I see the same path all over
the tracing file:

 2)   0.119 us    |    unlock_page();
 2)   0.109 us    |    unlock_page();
 2)   0.096 us    |    compaction_free();
 2)   0.104 us    |    ___might_sleep();
 2)   0.121 us    |    compaction_alloc();
 2)   0.111 us    |    page_mapped();
 2)   0.105 us    |    page_mapped();
 2)               |    move_to_new_page() {
 2)   0.102 us    |      page_mapping();
 2)               |      buffer_migrate_page_norefs() {
 2)               |        __buffer_migrate_page() {
 2)               |          expected_page_refs() {
 2)   0.118 us    |            page_mapping();
 2)   0.321 us    |          }
 2)               |          __might_sleep() {
 2)   0.122 us    |            ___might_sleep();
 2)   0.332 us    |          }
 2)               |          _raw_spin_lock() {
 2)   0.115 us    |            preempt_count_add();
 2)   0.321 us    |          }
 2)               |          _raw_spin_unlock() {
 2)   0.114 us    |            preempt_count_sub();
 2)   0.321 us    |          }
 2)               |          invalidate_bh_lrus() {
 2)               |            on_each_cpu_cond() {
 2)               |              on_each_cpu_cond_mask() {
 2)               |                __might_sleep() {
 2)   0.114 us    |                  ___might_sleep();
 2)   0.316 us    |                }
 2)   0.109 us    |                preempt_count_add();
 2)   0.128 us    |                has_bh_in_lru();
 2)   0.105 us    |                has_bh_in_lru();
 2)   0.124 us    |                has_bh_in_lru();
 2)   0.103 us    |                has_bh_in_lru();
 2)   0.125 us    |                has_bh_in_lru();
 2)   0.105 us    |                has_bh_in_lru();
 2)   0.123 us    |                has_bh_in_lru();
 2)   0.107 us    |                has_bh_in_lru();
 2)               |                on_each_cpu_mask() {
 2)   0.104 us    |                  preempt_count_add();
 2)   0.110 us    |                  smp_call_function_many();
 2)   0.105 us    |                  preempt_count_sub();
 2)   0.764 us    |                }
 2)   0.116 us    |                preempt_count_sub();
 2)   3.676 us    |              }
 2)   3.889 us    |            }
 2)   4.087 us    |          }
 2)               |          _raw_spin_lock() {
 2)   0.112 us    |            preempt_count_add();
 2)   0.315 us    |          }
 2)               |          _raw_spin_unlock() {
 2)   0.108 us    |            preempt_count_sub();
 2)   0.309 us    |          }
 2)               |          unlock_buffer() {
 2)               |            wake_up_bit() {
 2)   0.118 us    |              __wake_up_bit();
 2)   0.317 us    |            }
 2)   0.513 us    |          }
 2)   7.440 us    |        }
 2)   7.643 us    |      }
 2)   8.070 us    |    }


PG migration fails a lot:

pgmigrate_success 111063
pgmigrate_fail 269841559
compact_migrate_scanned 536253365
compact_free_scanned 360889
compact_isolated 270072733
compact_stall 0
compact_fail 0
compact_success 0
compact_daemon_wake 56
compact_daemon_migrate_scanned 536253365
compact_daemon_free_scanned 360889

Let me know if I can help with anything else. I'll keep the the box alive
for a while, but will have to power it off eventually.

	-ss
