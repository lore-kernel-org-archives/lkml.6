Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0871ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1252086E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 19:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1252086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbeJTDqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 23:46:19 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33906 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727885AbeJTDqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 23:46:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id f78-v6so11153462pfe.1;
        Fri, 19 Oct 2018 12:38:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zkDSVje/CWf6xMIBjOVB5zxQWyR/qFgd8OVphJaQNdM=;
        b=uTqhxYxQ8qrHcvX4njkl9GeodsSWYRLjN84NcvDQQlzkGVsZ+UbKWW5CKrEVozvt09
         4cbW8qhK0LJrTFCbXjxG06z/Hk+CLRGFoerjpTRgFtKfdTjIP6kXVHe9JKXse60g2cEa
         FKTGannizM4xN3GRLPvS+N+8C5QGVPcLDENpDCyZPBm5gWadjo8OYRV3GE1WWh4UZWsw
         bu1ayhpJ+wSmYpQKdlpmrL7E0x5h3BDl2MM2cJlBmmvk45SnIMHLiryFPYuuWpUKYDKc
         ZF+U7+ya9DP6loZ33tCuyUTcguTlRrQ/AXKra0dBi+5qEzTkhXGot+HmX41KMbKVaiZC
         ZKww==
X-Gm-Message-State: ABuFfohSporOd76hecHivrbgYwi7m7/0ln4x/Bhj6reEV+Q2SC5oGaJV
        Lux+rgoqQKUNUNqjWfGea3g=
X-Google-Smtp-Source: ACcGV61Wdn7d7U2hf9NuJUlqBAVzVLdtTo0Qg17bPV+fyb5nz3c4k4ZH8uFosntAGF5S3eq7DuBT6g==
X-Received: by 2002:a62:f553:: with SMTP id n80-v6mr35697915pfh.59.1539977927939;
        Fri, 19 Oct 2018 12:38:47 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b62-v6sm43345482pfa.159.2018.10.19.12.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 12:38:47 -0700 (PDT)
Message-ID: <1539977925.81977.55.camel@acm.org>
Subject: Re: [PATCH] scsi/ata: Use unsigned int for cmd's type in ioctls in
 scsi_host_template
From:   Bart Van Assche <bvanassche@acm.org>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>,
        "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
        Uma Krishnan <ukrishn@linux.vnet.ibm.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Don Brace <don.brace@microsemi.com>,
        Brian King <brking@us.ibm.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        esc.storagedev@microsemi.com
Date:   Fri, 19 Oct 2018 12:38:45 -0700
In-Reply-To: <20181019175714.444-1-natechancellor@gmail.com>
References: <20181019175714.444-1-natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-19 at 10:57 -0700, Nathan Chancellor wrote:
+AD4 Clang warns several times in the scsi subsystem (trimmed for brevity):
+AD4 
+AD4 drivers/scsi/hpsa.c:6209:7: warning: overflow converting case value to
+AD4 switch condition type (2147762695 to 18446744071562347015) +AFs--Wswitch+AF0
+AD4         case CCISS+AF8-GETBUSTYPES:
+AD4              +AF4
+AD4 drivers/scsi/hpsa.c:6208:7: warning: overflow converting case value to
+AD4 switch condition type (2147762694 to 18446744071562347014) +AFs--Wswitch+AF0
+AD4         case CCISS+AF8-GETHEARTBEAT:
+AD4              +AF4
+AD4 
+AD4 The root cause is that the +AF8-IOC macro can generate really large numbers,
+AD4 which don't find into type 'int', which is used for the cmd paremeter in
+AD4 the ioctls in scsi+AF8-host+AF8-template. My research into how GCC and Clang are
+AD4 handling this at a low level didn't prove fruitful. However, looking at
+AD4 the rest of the kernel tree, all ioctls use an 'unsigned int' for the
+AD4 cmd parameter, which will fit all of the +AF8-IOC values in the scsi/ata
+AD4 subsystems.
+AD4 
+AD4 Make that change because none of the ioctls expect to take a negative
+AD4 value, it brings the ioctls inline with the reset of the kernel, and it
+AD4 removes ambiguity, which is never good when dealing with compilers.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

