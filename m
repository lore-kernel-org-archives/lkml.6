Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FCFC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CDF52086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 14:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CDF52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389875AbeKQAz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 19:55:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37255 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbeKQAz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 19:55:28 -0500
Received: by mail-pg1-f193.google.com with SMTP id 80so10704700pge.4;
        Fri, 16 Nov 2018 06:42:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UgjcRyV7OUvNnVP7FZ3Km2sCQSg6U2Y4wwFUhvpwIvU=;
        b=DH3Nh0EVQULGQBrNyKjJvni4g4HKEnKHwn2MYeAYt4lvVJhlimpDNdYnchDochz9iW
         qua1RwxnjcC1t8xvRsNdun41sY8yAVYWQ3r9LW95T+duoTDCrMLMT8FAFY7WqKBuaNey
         lCQEoE3yOZK3EdP26mT7CdRwUHWMO4+G8vvABnjoatlReLAp1ekNmW9duvfriLhK1z/s
         VKxmMsvVejdDb2NwQbtcXfiLXk3KqIJCz6Zwb8vcT4P0gUVLAGLuB3RedMGpeaAyUKlW
         0rS9Wlelx7thWBuxLaBhPo2emOs2tdChF5Aye1yUPt71Kt9CQ6GSoHZrYzEsQTrPDTLq
         CUag==
X-Gm-Message-State: AGRZ1gIvsCPhtvFeCtl8nIVYNrvNw632Pu2GFtT+4HI7fucfgB78x4dN
        0QhxIxh2MSP794pMiz5J1MA=
X-Google-Smtp-Source: AJdET5d3fgKSoTkEYER/XcKVST3ZWnzTj2dVwqscHyxc3MMxyzIHWEISZLGBSw+uCADS2FQOhpaycA==
X-Received: by 2002:a65:6447:: with SMTP id s7mr10147933pgv.226.1542379368255;
        Fri, 16 Nov 2018 06:42:48 -0800 (PST)
Received: from [192.168.40.151] ([64.114.255.114])
        by smtp.gmail.com with ESMTPSA id x184-v6sm21091329pfx.42.2018.11.16.06.42.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 06:42:47 -0800 (PST)
Message-ID: <1542379365.100259.34.camel@acm.org>
Subject: Re: [PATCH 3/3] block: add back command filter modification via
 sysfs
From:   Bart Van Assche <bvanassche@acm.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Fri, 16 Nov 2018 06:42:45 -0800
In-Reply-To: <44a2a5d0-1802-e6b0-b6e2-5930eed37e21@redhat.com>
References: <1541867733-7836-1-git-send-email-pbonzini@redhat.com>
         <1541867733-7836-4-git-send-email-pbonzini@redhat.com>
         <1542347164.100259.32.camel@acm.org>
         <44a2a5d0-1802-e6b0-b6e2-5930eed37e21@redhat.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-16 at 08:00 +-0100, Paolo Bonzini wrote:
+AD4 On 16/11/18 06:46, Bart Van Assche wrote:
+AD4 +AD4 I do not know any application for which it would be useful to allow some but
+AD4 +AD4 not all of these commands. With the proposed interface however users will
+AD4 +AD4 have to examine all SCSI opcodes and for each opcode they will have to decide
+AD4 +AD4 whether or not it should be allowed. Additionally, for opcodes like 7fh that
+AD4 +AD4 represent multiple commands, users will have to decide whether they want to
+AD4 +AD4 allow all these commands or none. That's why I think that filtering SCSI
+AD4 +AD4 commands based on their CDB is an unfortunate choice. Would it be sufficient
+AD4 +AD4 for the use cases you are looking at to group SCSI commands as follows and to
+AD4 +AD4 enable/disable these commands per group:
+AD4 +AD4 +ACo SCSI command that read information from the medium (e.g. READ) or from the
+AD4 +AD4   controller (e.g. READ CAPACITY).
+AD4 +AD4 +ACo SCSI commands that modify information on the medium (e.g. WRITE).
+AD4 +AD4 +ACo SCSI commands that modify controller settings (e.g. MODE SELECT or SET
+AD4 +AD4   TARGET PORT GROUPS).
+AD4 
+AD4 And also:
+AD4 
+AD4 +ACo all SCSI commands (e.g. write microcode, vendor specific commands).
+AD4 
+AD4 It would.  However, it would be impossible to do this without making the
+AD4 filter depend on the SCSI device type.  This has been rejected in 2012.

Do you have a link available to that discussion? Since the meaning of several
SCSI opcodes depends on the SCSI device type, I don't see how we can avoid
making filtering dependent on the SCSI device type.

Bart.
