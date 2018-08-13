Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D56C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A410A21785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/+t2aa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A410A21785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbeHMFun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 01:50:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42341 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbeHMFum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 01:50:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id y4-v6so6872377pgp.9;
        Sun, 12 Aug 2018 20:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=GRnuIkCAp9Yad6XxdSbUQ+/GvlApUDzXZbi+ZA+He9g=;
        b=I/+t2aa2EsCE4/Ah6lvtymYe9fg3K4yWV9ckz9acxKEqH6xW/ehBBKvv1HWlZ1VHnY
         rCeW1zdJOYDgVz7irh1GPK5h8yt1Gq7iqtkBeqVCvcm2H8cubKeWDDA5kkDNB7oogNbY
         WCzYYV/97nCORlThA0gFACrJC46o2kvbyUT8uVQ43N6ol+OfEyFhwY+PpUHY9F2f0ll4
         gP7rBfP5gtHz70Mvan2EPcYVHjybmjsiZyf0HyHo5ZAnLSyE/tl48o+I18R6gpMSPDtE
         zZQWijXnl6k+CaroWFL/4Hz5WOmxw612jJQBe4JH8Edue8Ee++x8mxtsIPEjE1WA+HoT
         zYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=GRnuIkCAp9Yad6XxdSbUQ+/GvlApUDzXZbi+ZA+He9g=;
        b=WyPGd6DWXcDBOFdKEXVZiKtv9WhDtgHDGO57/kyWxXsWY12gajVZFioIOQ6k+2pnQJ
         lP5OK6uIe7jyIW7+4p74L3oO1gENA0LYtqfWgcaCex0nAs64Aq7P0KTkQKDeOSAo66Jb
         sVevcX4Oe5v39TX1P4Ykxt4k6Zw7igSTLs1TXGcwF25lrnSPIB8MfkQkycZ2a7ch6Ul9
         74vDw8gHEhZyCsd182yi1TUJPHdas0GjVpAVci3/3XRhQRTKCdvXF0ojoDgFNtasqMjR
         okXMOMavUvMrmvmgAcPp7ZsTeHwbvBKL9+tRdVc107m3BS2yWq+m1voN+ACeApt972TL
         +QJA==
X-Gm-Message-State: AOUpUlFlwOmc+443lsycl2ByudRx9cTRFxGVUnPz/OFW1t89JsW4wdZn
        5UxBwgCbwtUSCCUwjur05k0FtiOh
X-Google-Smtp-Source: AA+uWPzkbN1J6yc7hfeW/uujJq9B7Z+On3HdIcIpFMTVXcOaa151yAVt2Bkt0QigrFpT4ctlIVZ8qQ==
X-Received: by 2002:a63:d80f:: with SMTP id b15-v6mr15507500pgh.347.1534129829186;
        Sun, 12 Aug 2018 20:10:29 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id c66-v6sm30854830pfc.138.2018.08.12.20.10.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:10:28 -0700 (PDT)
To:     akpm@linux-foundation.org, jack@suse.cz,
        mgorman@techsingularity.net, ak@linux.intel.com,
        mawilcox@microsoft.com, viro@zeniv.linux.org.uk,
        mawilcox@microsoft.com, ross.zwisler@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] mm: truncate: a possible sleep-in-atomic-context bug in
 truncate_exceptional_pvec_entries()
Message-ID: <f863cf8d-615f-c622-812a-a6370efe757b@gmail.com>
Date:   Mon, 13 Aug 2018 11:10:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule
fs/dax.c, 259: schedule in get_unlocked_mapping_entry
fs/dax.c, 450: get_unlocked_mapping_entry in __dax_invalidate_mapping_entry
fs/dax.c, 471: __dax_invalidate_mapping_entry in dax_delete_mapping_entry
mm/truncate.c, 97: dax_delete_mapping_entry in 
truncate_exceptional_pvec_entries
mm/truncate.c, 82: spin_lock_irq in truncate_exceptional_pvec_entries

I do not find a good way to fix, so I only report.
This is found by my static analysis tool (DSAC).


Thanks,
Jia-Ju Bai
