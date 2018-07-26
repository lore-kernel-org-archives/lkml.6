Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFBFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDB5420673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kutHK/sA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDB5420673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeGZPT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:19:27 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38056 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbeGZPT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:19:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so622505pfh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 07:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=pdsWk+Z1UbEXvxXt2E4+M7OsbrAaYoi05MGoJe0fuC8=;
        b=kutHK/sAaRk2P1uJVVw3vcWK+z3pbHrqnvpCkABagYA7S1anAemFcfMjHFWGbLK3Sa
         FFKz9Ecqd+c9eRNGbFPgnQtda17Z/GVh7tmyNy3UHEX2V95KOr13YT9b3JofYOmTmdYD
         dgXwV6KKd/5ipJ+0bV+edzFjAGQbeSMCv8NwVjWG+Sz1LSMPPtTESGs8lN3V6BxgVt9p
         T9MbqLNks38uYOszSYvcA85Bz7WaIO45k8gJTYOjWKwJlxN8QuocLzOzyfTcVWbyEyBD
         0sSSIOtsTMEt5N05H8KWnBtnXpWgMuz81jPAWSaQ6qiAXyzPB7WsL+trO48e22fOfcPM
         AllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=pdsWk+Z1UbEXvxXt2E4+M7OsbrAaYoi05MGoJe0fuC8=;
        b=Xxy3HB4BsikzBbanS0djX+SOoxBoQJsB6CGxbvkF7/nC2jK5NACb0omfZli4c/i1nx
         rpLxU0daAlAhOsqWhwTUWNNtb47OxfiUSM7YBM6PFHfWzojByYGvSrBKeowQPM45tTHh
         yEgV5C8fpvBgL+OosH919GbhIi4w29XR4A/MDNPz/O+mSEcBuveQN2C5nK3Sc9ADp/ue
         Y3olq82ykZXulSpLZxGp0YkH1kKYkN1wOnQMBfKFAv8FS1QqHH9j+zDrN67TbEiL9Ojz
         mZ7zw6u5X276YNFKjhxZPxo0vahD0t7Q8YAIqsYPCxl2MFh8T5LFPCBHUG/xajRMYohe
         Qn2A==
X-Gm-Message-State: AOUpUlEBwwdff5y+XMSlyNFahY7TlS78O9YNgjbEnfzEImXSGpTtIq6k
        icyL6lA9ni++KrpItYLQ1GdOnvlw
X-Google-Smtp-Source: AAOMgpeliHRSflCyU6feRfC+sL3wJUupltS1Hduj+uCSJg1qFABeklBCrGo0L+nnLktkCnFsO5gRbA==
X-Received: by 2002:a62:4147:: with SMTP id o68-v6mr2236406pfa.111.1532613746223;
        Thu, 26 Jul 2018 07:02:26 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:4414:6c14:7712:e625:1be4? ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id t186-v6sm2538254pgd.77.2018.07.26.07.02.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 07:02:25 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] staging: lustre: Possible null function pointer in
 ctx_refresh_timeout()
To:     oleg.drokin@intel.com, andreas.dilger@intel.com,
        jsimmons@infradead.org, paf@cray.com, namit@vmware.com
Cc:     lustre-devel@lists.lustre.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Message-ID: <6920e093-ad62-56dc-6f58-36cf8d7ed3b4@gmail.com>
Date:   Thu, 26 Jul 2018 22:02:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux-4.16, drivers/staging/lustre/lustre/ptlrp/sec.c,

557. int ctx_refresh_timeout(...) {
             .......
573. req->rq_cli_ctx->cc_ops->force_die(req->rq_cli_ctx, 0);
             ......
575. }

For x86 kernel configuration, there is no assignment of the function 
pointer ".force_die" in the kernel code.
So calling the function pointer in line 573 may cause a null pointer 
dereference.


Best wishes,
Jia-Ju Bai
