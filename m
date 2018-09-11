Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DA7C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA91920839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 19:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA91920839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeILAXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 20:23:16 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34115 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbeILAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 20:23:16 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so29588923qth.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 12:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NunjoSAcVM/aaTz+L3MBkvCn85etpDScdIPk/gOpqL8=;
        b=XRnltB5ZeI26df0K5bLpkNGqGRxsFO3Ya9K3foTCjjHmxSkO8pbwyJdZOGe/ITBGz3
         JRWkFvjoTJnMNY/iRXVT94wWYGRwvJ5JDweHQ9jmEgux2YwejuNNjyXfjIGqNwemfj/K
         UnBKGhWFo/1B/2MvJMB4rxzQqnrzc8tMtIYZrM2Qw+v10dr9h0R4McU6q7argc9L1+ft
         p+0LPEzmUHNzRndDCYl/aZClm9BumNCE2XrlPeXbIOGJ3z1MjzrCpsa2ZdiEQSHfXhhf
         dd/2aHr5yD1w1e5lPQN3SL8JgrK3Rxx0ig2LLo72DtrWAU+byoUqLiswRWROgcyzW2IO
         oV2w==
X-Gm-Message-State: APzg51CuKqvyKIydD5JOWRxeFXZvOAGd9flnBd/5YrM/Dq03zRCZU46X
        sqKdAgPxBEICyx+EEPAKtxY5BA==
X-Google-Smtp-Source: ANB0VdY3Gjw2GZvKLruJqYNZ9ob1pmh6MQq5hZSKepCe9EjYePQUvtSdeDdCC3e9K5J2tKv9XxUVbw==
X-Received: by 2002:a0c:942f:: with SMTP id h44-v6mr20016377qvh.0.1536693752306;
        Tue, 11 Sep 2018 12:22:32 -0700 (PDT)
Received: from labbott-redhat.redhat.com ([2601:602:9802:a8dc::42c3])
        by smtp.gmail.com with ESMTPSA id g14-v6sm13639452qtc.66.2018.09.11.12.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 12:22:31 -0700 (PDT)
From:   Laura Abbott <labbott@redhat.com>
To:     "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Michael Cyr <mikecyr@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv3 0/2] String fixups in ibmvscsi
Date:   Tue, 11 Sep 2018 12:22:24 -0700
Message-Id: <20180911192226.3620-1-labbott@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is (hopefully) the last version of the string fixups found in the
ibmvscsi driver.

Laura Abbott (2):
  scsi: ibmvscsis: Fix a stringop-overflow warning
  scsi: ibmvscsis: Ensure partition name is properly NUL terminated

 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

-- 
2.17.1

