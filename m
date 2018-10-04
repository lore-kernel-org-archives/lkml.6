Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8699C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80B292083F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 18:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B292083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeJEB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 21:29:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39606 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeJEB3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 21:29:02 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so3480377pfe.6;
        Thu, 04 Oct 2018 11:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrquAgqPqeD2rvB9XaKGI2DD/jWvMz/jpQNkDgR5v48=;
        b=igirjmF/ipb0kszKOV/8o04jS9AdHyvUBGbf4/HsZaFEq3c9TX+n9jFqm+LccI42iL
         IxHOl+7guIYdaps3bg03Oyo1SyPa2ONCwHbiGEQjbpNPFnqo0eEIKJ0IvsU+EUyR44ic
         NzSh8zemUW5If9j6DxLTzdpAPWtMvaMHCWVCv1HRzOz+y1v9PtrJYwWVjIGoBOMsJAOh
         OjuPu4QIlvRNmJM94Fu859tT4OBA7KIyBd7Fw3snCyIAKhh7iVtvnxgRwy6LFt/vwKgW
         1PpMvfFoyf/tz+pKcyPhQd6BUGPjmuRo3sP8XfimGRQj5iImV881Z8nHdeCRqW1EP1eZ
         +Dvw==
X-Gm-Message-State: ABuFfojjsfBBDz1lb5H/x75qdMbFfH8M4UZRzGXJZA0sjk4FNnEohaVL
        2mhC5GPn9uM3G5BhdIPXEV4=
X-Google-Smtp-Source: ACcGV62VQ39+HvSL5aUnoOV2zT/2dPrS8C0TSPb5gNIIfUTMQs05QyZOLoQ13VZgIM+08bPctKWBQw==
X-Received: by 2002:a65:664e:: with SMTP id z14-v6mr6624426pgv.347.1538678071691;
        Thu, 04 Oct 2018 11:34:31 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u9-v6sm12662348pfi.104.2018.10.04.11.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 11:34:31 -0700 (PDT)
Message-ID: <1538678069.230807.6.camel@acm.org>
Subject: Re: -Wswitch Clang warnings in drivers/scsi
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Oct 2018 11:34:29 -0700
In-Reply-To: <20181004183047.GA1885@flashbox>
References: <20181004183047.GA1885@flashbox>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-04 at 11:30 -0700, Nathan Chancellor wrote:
+AD4 Hi SCSI folks,
+AD4 
+AD4 In an effort to get the kernel building warning free with Clang, we've
+AD4 come across an interesting occurrence in a few scsi drivers:
+AD4 
+AD4 drivers/scsi/hpsa.c:6533:7: warning: overflow converting case value to switch condition type (2148024833 to 18446744071562609153) +AFs--Wswitch+AF0
+AD4         case CCISS+AF8-GETPCIINFO:
+AD4              +AF4
+AD4 ./include/uapi/linux/cciss+AF8-ioctl.h:65:26: note: expanded from macro 'CCISS+AF8-GETPCIINFO'
+AD4 +ACM-define CCISS+AF8-GETPCIINFO +AF8-IOR(CCISS+AF8-IOC+AF8-MAGIC, 1, cciss+AF8-pci+AF8-info+AF8-struct)
+AD4                          +AF4
+AD4 ./include/uapi/asm-generic/ioctl.h:86:28: note: expanded from macro '+AF8-IOR'
+AD4 +ACM-define +AF8-IOR(type,nr,size)      +AF8-IOC(+AF8-IOC+AF8-READ,(type),(nr),(+AF8-IOC+AF8-TYPECHECK(size)))
+AD4                                 +AF4
+AD4 ./include/uapi/asm-generic/ioctl.h:70:2: note: expanded from macro '+AF8-IOC'
+AD4         (((dir)  +ADwAPA +AF8-IOC+AF8-DIRSHIFT) +AHw +AFw
+AD4         +AF4
+AD4 
+AD4 I see this warning in drivers/scsi/hpsa.c and drivers/scsi/smartpqi/smartpqi+AF8-init.c
+AD4 on an arm64 allyesconfig build and it has also been reported in a couple of files in
+AD4 drivers/scsi/cxlflash.
+AD4 
+AD4 As the warning states, there is an overflow because the switch statement's value is of
+AD4 type int but the switch value is greater than INT+AF8-MAX. I did a brief sweep of the tree
+AD4 and it seems that all uses of +AF8-IOC in switch statement values either are small enough
+AD4 to fit into size int or the value is of size unsigned int.
+AD4 
+AD4 I am unsure of the implications of using a smaller +AF8-IOC value or converting all ioctls
+AD4 to expect a cmd of type unsigned int (especially since that has userspace implications)
+AD4 but I didn't see any negative ioctl commands. Some clarity and insight would be
+AD4 appreciated.

Have you verified how gcc compiles these switch statements? Maybe gcc supports
switch / case statements on integral types that are larger than an int?

Bart.
