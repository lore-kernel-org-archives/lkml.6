Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D658C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C7220664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 17:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C7220664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbeKAC2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 22:28:40 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34349 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbeKAC2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 22:28:40 -0400
Received: by mail-pl1-f194.google.com with SMTP id f10-v6so7623030plr.1;
        Wed, 31 Oct 2018 10:29:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkjoOGnaBEy3Dq3ztAvqrefz1uSM8p1pV4RyU0ZaBco=;
        b=mNJlWEAsLkikgHwmbrp5j60Fm1pUNKpa8yZL1xW/k6OeVTBDMFwwSgNgMO98KRPdFP
         AUijplumtYbBxMUKO/Vq8HHN54jCemfrM5BCHmyMHAY0npw4Sbl3igEPLxMWJ6VHZ1H8
         uTNeHj8SChcvF5ouK+RPhX/4MRjvqmas02pZdLQ8ZV7owsyfIM+FvG2oUCLnB5f6tYwq
         aC89/EHMwneIFP4UGlGd8hbxlTTB3DAGzuHdvyj7DmHDeBWtJLa7UkIAhHeWT8wgCKFU
         7/NiAOObQ+1a48jJBkVcWxfB+jpt4sAyPaEL8WyH//sNa2+sorS95kgWEIVLPoVMjCio
         RnaQ==
X-Gm-Message-State: AGRZ1gJb/2jkT9Bgci1snxzp5imHTxrvz1ZqTs9mnrR6kPhJKpsGOXEF
        jFvaj7gOSjz7G14lgsHiEMM=
X-Google-Smtp-Source: AJdET5ftD/u3PtSK9Nme8tDDyEqp2QHgzhTtekt+tmRLE2aDDX1bzwx0RzIUWLxQ+BkybNqxx1/+RA==
X-Received: by 2002:a17:902:be0f:: with SMTP id r15-v6mr4239305pls.170.1541006982502;
        Wed, 31 Oct 2018 10:29:42 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id o195-v6sm11534098pfg.112.2018.10.31.10.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 10:29:41 -0700 (PDT)
Message-ID: <1541006979.196084.138.camel@acm.org>
Subject: Re: remove exofs and the T10 OSD code V2
From:   Bart Van Assche <bvanassche@acm.org>
To:     Boaz Harrosh <ooo@electrozaur.com>, Christoph Hellwig <hch@lst.de>,
        martin.petersen@oracle.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 31 Oct 2018 10:29:39 -0700
In-Reply-To: <c9740eeb-6b96-35b6-a436-7537669da1a9@electrozaur.com>
References: <20181027082019.20838-1-hch@lst.de>
         <c9740eeb-6b96-35b6-a436-7537669da1a9@electrozaur.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-10-31 at 18:34 +-0200, Boaz Harrosh wrote:
+AD4 On 27/10/18 11:20, Christoph Hellwig wrote:
+AD4 +AD4 The only real user of the T10 OSD protocol, the pNFS object layout
+AD4 +AD4 driver never went to the point of having shipping products, and we
+AD4 +AD4 removed it 1.5 years ago.  Exofs is just a simple example without
+AD4 +AD4 real life users.
+AD4 +AD4 
+AD4 +AD4 The code has been mostly unmaintained for years and is getting in the
+AD4 +AD4 way of block / SCSI changes, so I think it's finally time to drop it.
+AD4 +AD4 
+AD4 +AD4 Quote from Boaz:
+AD4 +AD4 
+AD4 +AD4 +ACI-As I said then. It is used in Universities for studies and experiments.
+AD4 +AD4 Every once in a while. I get an email with questions and reports.
+AD4 +AD4 
+AD4 +AD4 But yes feel free to remove the all thing+ACEAIQ
+AD4 
+AD4 I think I'm changing my mind about this.
+AD4 +AFs ... +AF0

The osd driver was accepted in the upstream kernel in 2009. I have checked all
commits in Linus' tree for the osd driver that went in since 2009. All changes
made by other kernel developers than you are the result of tree-wide refactoring,
compiler warning fixes, fixes for issues detected by static source code
analyzers or spelling fixes. Hence my question: how big is the user base of the
exofs and osd kernel drivers? 

Thanks,

Bart.
