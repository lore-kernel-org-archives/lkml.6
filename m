Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366CDC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD70426CD9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 05:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWVMoRK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD70426CD9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeF1FFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 01:05:11 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43618 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751306AbeF1FFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 01:05:10 -0400
Received: by mail-oi0-f67.google.com with SMTP id x18-v6so3990367oie.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 22:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:to:from:cc:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=w6MvHJDEpIyKZeqmM0BKQhmdxGsfIJ2/+ylvvtJuZGk=;
        b=fWVMoRK4ogLRpvDseTGykTMN4bu/yaxe+qwg26cfE79XKQWO4maqroHIKtXLBba/X7
         8VNzvX5M520TW2e1lgqaXsFfPzOaltr/nnU/jPITsQDg8lj96SGrdnoT83R+84Kp5LmT
         tK92lG/nwDJZ8idhMECBKbtZGvYZBi7bQUx7UknsYER9csZPdLXGix9Qbgg3hAqRWklG
         Ed4mTy6Ihqkz9r3NnAEOgFtq2WpVP5zWSvWCTtxUVi2ASXSyjG1IA8WJFyL2ZAGrjWzo
         XsjcjfQwy+vxjQqDcXojUJOcoNBNevNxIby1nIxqWO1WQC6z/5AHukZTOy1YwJsbeHmt
         7UOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:from:cc:subject:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=w6MvHJDEpIyKZeqmM0BKQhmdxGsfIJ2/+ylvvtJuZGk=;
        b=t5+lz57GpbUALq03nceoGRrTQf/R80wlBjjOhZj3HFqEYgCWG+iSVFOS7p8H2lfGPO
         1XFAc8836A400p6yjvzvDYAyR0j2U9svDUtTBgkjrIBztXXonRoiWvxCQPP/kHtC4eXu
         zPxXyDeE+PRm7JevYF2tUWK2H7sI4GgOnvD6isU5UjvK2Kdz68YkSVVCVPE0wIVqqyPo
         9P6ZibcW3XidQhT6RJriKxBPKakhAkOTyJDz9ql5W0ku9WMwS8NcnQV4AOPRdfFdzwMc
         69Br7BR9/uvY12CuTFxQTNwnlhaIu0hciLyYCIylgDcyPCFwX6FkuthRdt1QByr1ZuoV
         FiKw==
X-Gm-Message-State: APt69E3H6piW5tG54wKUKADKRyXmw8fOzA0CAaRN3CUtPnosAoxD6LCU
        GL2fkYXIMDjsw7CGyjFs8mKVcg==
X-Google-Smtp-Source: AAOMgpdZGd/5b4Dm7vLsxpuVH8HgtyWN1ljqg6LapPC0cshhgbW/7xuuqfR0yMZZMhjNg25inp6Dgg==
X-Received: by 2002:aca:c43:: with SMTP id i3-v6mr4671520oiy.271.1530162309735;
        Wed, 27 Jun 2018 22:05:09 -0700 (PDT)
Received: from [192.168.1.107] (cpe-24-31-253-228.kc.res.rr.com. [24.31.253.228])
        by smtp.gmail.com with ESMTPSA id g6-v6sm877497otj.57.2018.06.27.22.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 22:05:08 -0700 (PDT)
To:     Matthew Wilcox <mawilcox@microsoft.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Pekka Enberg <penberg@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Regression in 4.18 - 32-bit PowerPC crashes on boot - bisected to
 commit 1d40a5ea01d5
Message-ID: <5a98ad6b-e209-a9dc-98db-1745ef5b7f87@lwfinger.net>
Date:   Thu, 28 Jun 2018 00:05:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My PowerBook G4 Aluminum crashes on boot with 4.18-rcX kernels with a kernel BUG 
at include/linux/page-flags.h:700! The problem was bisected to commit 
1d40a5ea01d5 ("mm: mark pages in use for page tables"). It is not possible to 
capture the bug with anything other than a camera. The first few lines of the 
traceback are as follows:

free_pgd_range+0x19c/0x30c (unreliable)
free_pgtables_0xa0/0xb0
exit_pmap+0xf4/0x16c
mmput+0x64/0xf0
do_exit+0x33c/0x89c
oops_end+0x13c/0x144
_exception_pkey+0x58/0x128
ret_from_except_full+0x0/0x4
--- interrupt: 700 at free_pgd_range+0x19c/0x30c
     LR = free_pgd_range+0x19c/0x30c
free_pgtables+0xa/0xb
exit_mnap+0xf4/0x16c
mmput+0x64/0xf0
flush_old_exec+0x490/0x550

I have a PDF of the complete dump, but I hesitate to send this to the entire group.

Thanks,

Larry
