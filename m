Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4E0C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068A32173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbfAGRdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:33:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45316 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726886AbfAGRda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:33:30 -0500
Received: by mail-pl1-f194.google.com with SMTP id a14so447071plm.12;
        Mon, 07 Jan 2019 09:33:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fMDGIjtbdpNwokV2Rj57YUn87tIcidUB24K2UFRSdA=;
        b=jcqgO53o0EGb7qwO3GhMjBLekJVf/Dwg8WcI1rsdQWbJe/eTOb5q7iDO+JnJ4Na0hJ
         pw6t76PCEdgu9zgcKqno2PME/2RKX10duZ43P8E4eO7iRCjwA4DhnKZo0nCM3affLRiZ
         kgvQ29sdMA9kKvySjEKcPM4x4gzWy01fMDoEV8Pg/3XntUTx0VRp76DruOgdvRxStsyt
         TqCrazwEBm4ZkeK0W1UwhWEV1axIPG72ji3/ao8BaRkgbgoWzWMJtLgNz2sQfrz5nnIU
         D9kr9QU3hhYwhOTO5zLlIDdvrH+B5uAKioStzgYiD53Df5wgvp1Z2Q3BO7ItgkX4sgvX
         x4/g==
X-Gm-Message-State: AJcUukdjRW8L2fM2fT+akvmpgdqB+cTAD9OBNmWQVkKPB0VQThGcekwe
        1uVFG9J9xQM7CQ5U18YD17f94EUBfGQ=
X-Google-Smtp-Source: ALg8bN5Jd9VZUs1CkzaLCChhmxJaxNAtDp+w3vG451RgIDomPdLW85MnrNxlvq4UcUtatT0PpWgokA==
X-Received: by 2002:a17:902:8a91:: with SMTP id p17mr62120131plo.316.1546882409842;
        Mon, 07 Jan 2019 09:33:29 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id p6sm92120057pfn.53.2019.01.07.09.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:33:29 -0800 (PST)
Message-ID: <1546882408.83374.14.camel@acm.org>
Subject: Re: [PATCH] scsi: sd: Make protection lookup tables static
From:   Bart Van Assche <bvanassche@acm.org>
To:     John Garry <john.garry@huawei.com>, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Date:   Mon, 07 Jan 2019 09:33:28 -0800
In-Reply-To: <b269a676-8941-4de4-faed-c40ec0d0a45a@huawei.com>
References: <1546872111-5627-1-git-send-email-john.garry@huawei.com>
         <1546880243.83374.12.camel@acm.org>
         <b269a676-8941-4de4-faed-c40ec0d0a45a@huawei.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-07 at 17:27 +-0000, John Garry wrote:
+AD4 On 07/01/2019 16:57, Bart Van Assche wrote:
+AD4 +AD4 On Mon, 2019-01-07 at 22:41 +-0800, John Garry wrote:
+AD4 +AD4 +AD4 Currently the protection lookup tables in sd+AF8-prot+AF8-flag+AF8-mask() and
+AD4 +AD4 +AD4 sd+AF8-prot+AF8-op() are declared non-static. As such, they will be rebuilt for
+AD4 +AD4 +AD4 each respective function call.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Optimise by making them static.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 This saves +AH4-100B object code for sd.c:
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Before:
+AD4 +AD4 +AD4    text	   data	    bss	    dec	    hex	filename
+AD4 +AD4 +AD4   25403	   1024	     16	  26443	   674b	drivers/scsi/sd.o
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 After:
+AD4 +AD4 +AD4   text	   data	    bss	    dec	    hex	filename
+AD4 +AD4 +AD4   25299	   1024	     16	  26339	   66e3	drivers/scsi/sd.o
+AD4 +AD4 
+AD4 +AD4 Since the sd+AF8-prot+AF8-op() function only has a single caller, please move it from sd.h
+AD4 +AD4 into sd.c.
+AD4 
+AD4 Can do, as long as no one has objection.
+AD4 
+AD4 Function sd+AF8-prot+AF8-flag+AF8-mask() also has a single caller AFAICS, so this 
+AD4 could also be relocated.

Please move that function too from sd.h into sd.c.

Thanks,

Bart.
