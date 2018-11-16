Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEE3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540352086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 18:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 540352086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbeKQEau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 23:30:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33635 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeKQEat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 23:30:49 -0500
Received: by mail-pf1-f193.google.com with SMTP id v68-v6so11783127pfk.0;
        Fri, 16 Nov 2018 10:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VS4yQYxrVV3rmPyj1W8Aka8PAakIlu57zoxgm4jM6GA=;
        b=Weu4faHgHdypkPWUDWmjrjTuq4mFb0xSOxfiKVseSnaEr/2PJJeaxSD/JaqBwduUwU
         u3wvi9z5dltmTNLrqqFUaLRTV2NiNSpX17edJKSLbB0EJ66I8fKpz1MzpEP52+HvuuYH
         stLlskCKjNMx0JzxlGXr247CsftpxlagfY31NwSQth3zar/E6mCyctuS906318iI4IXY
         D24Op9KCyphX4i24BdMGTYFpNGIAvtYavRVZzlMcs7BDcFubHnTSCu8xGjIngs2F5dZT
         AeWKkw7InxYytJMbp5glWO6k+h2zurp45XAMmMuClqAfLbQjOkwPIy8WD1yIg1VZ5oGD
         zoEw==
X-Gm-Message-State: AGRZ1gI2Oq9/eJMwIz1nbnTMTKf+bB1B6FMNbVWtltzxfKMy5vhjWxA/
        u6l2Wpt5AvL/aNPgf6FLoZNSGTOG
X-Google-Smtp-Source: AJdET5cr0IFtrcv+zR398SezdxE/vorPovjiOwBIhG4tx5Rtaxffzv6n36Slig77nRvAM18/eArvEg==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr11002567pgo.378.1542392242562;
        Fri, 16 Nov 2018 10:17:22 -0800 (PST)
Received: from [10.20.154.116] ([204.239.253.217])
        by smtp.gmail.com with ESMTPSA id 11-v6sm43973997pfr.55.2018.11.16.10.17.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 10:17:21 -0800 (PST)
Message-ID: <1542392239.100259.52.camel@acm.org>
Subject: Re: [PATCH 0/3] SG_IO command filtering via sysfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Fri, 16 Nov 2018 10:17:19 -0800
In-Reply-To: <20181116174352.GH20617@thunk.org>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
         <20181111131445.GB25441@infradead.org> <20181111134241.GA2447@thunk.org>
         <20181112082013.GA9307@infradead.org>
         <79d7d4b2-e9b3-00b4-2ad0-789888f7ee36@redhat.com>
         <20181116093225.GA17033@infradead.org>
         <fa3ed175-13a3-bedf-ebf9-ddf46a2decd5@redhat.com>
         <20181116174352.GH20617@thunk.org>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 12:43 -0500, Theodore Y. Ts'o wrote:
+AD4 I'd argue that a purpose-built eBPF access control facility is
+AD4 superior to the security+AF8-file+AF8-ioctl() LSM hook because it can make
+AD4 available to the authorization function access to the cached results
+AD4 of the SCSI INQUIRY command, and it avoids needing to duplicate
+AD4 knowledge of how to parse the parameters of the SG+AF8-IO ioctl in the LSM
+AD4 module as well as in the SCSI stack.

If an eBPF program would decide which SG+AF8-IO commands will be executed
and which ones not, does that mean that a SCSI parser would have to be
implemented in eBPF? If so, does that mean that both the eBPF and the
LSM approach share the disadvantage of requiring to do SCSI CDB parsing
outside the SCSI core?

Bart.
