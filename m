Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AE2C71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F750208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F750208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbeJOXIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:08:32 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40161 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbeJOXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:08:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id 1-v6so9466216plv.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 08:22:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oyMye4l4PZYMQwrqfmlUSA9M5PWq7KcOpUTTwAxZxoM=;
        b=DJ0rFCzrhZziGwU6m/Ui83mH2SHk1rTGjuKF0jfmlj5CxaRDu9fXUvTam1hZabknUd
         rXrjeVeu2SyhoHn+pTSXcjC5woQDD5a7fBGHC6Kmn2UAwBI0JxPl3E/8yQyOjLWK2YSk
         gC4k50dMFgalVEyYVfwtYpJA+TIMMzJVvrItSR1RnxXPRRu3/adN7QX40f+/D8ufmfNc
         ykHaaHPeoMvRhUuaF5X3orDSj1e+vfxdo4knZlytYtYHO8nmcBp9eD1OKKl3Q8Mj0v/j
         oC2pEBWH0cSN4pnB5wExnpopDaLDVJsKlmcNoDHeEhfW9MYtXMzlfLasFt7k79Ve+MnI
         vFTQ==
X-Gm-Message-State: ABuFfohsS4X4roGrDBwu4GY+Mp9zVidrhrcgfeGj8KeNJZ4yYRl/7hOb
        4OEN74Ha7Ho273Heqz5aBGk=
X-Google-Smtp-Source: ACcGV63PMtA5Ptcoy9IJMJh9ks+nSpr5rfO39dWw5bgEhgS5HLM1T3Vi3Nnxd21Tbk2cQRZ9LKL6XQ==
X-Received: by 2002:a17:902:8347:: with SMTP id z7-v6mr17638348pln.111.1539616969606;
        Mon, 15 Oct 2018 08:22:49 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id u62-v6sm15346222pfu.69.2018.10.15.08.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 08:22:48 -0700 (PDT)
Message-ID: <1539616967.129692.4.camel@acm.org>
Subject: Re: [LKP] [sd] 7618616fcd:
 WARNING:at_drivers/scsi/scsi_lib.c:#scsi_device_quiesce
From:   Bart Van Assche <bvanassche@acm.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Lee Duncan <lduncan@suse.com>, Hannes Reinecke <hare@suse.com>,
        "Luis R. Rodriguez" <mcgrof@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@sandisk.com>, lkp@01.org
Date:   Mon, 15 Oct 2018 08:22:47 -0700
In-Reply-To: <20181015032509.GD28215@shao2-debian>
References: <20181015032509.GD28215@shao2-debian>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-15 at 11:25 +-0800, kernel test robot wrote:
+AD4 FYI, we noticed the following commit (built with gcc-7):
+AD4 
+AD4 commit: 7618616fcdf8a5de9f3dc45fc6281ebd0663bd8a (+ACI-sd: Rely on the driver core for asynchronous probing+ACI)
+AD4 https://github.com/bvanassche/linux for-next
+AD4 
+AD4 in testcase: suspend+AF8-stress
+AD4 with following parameters:
+AD4 
+AD4 	mode: mem
+AD4 	iterations: 10

Hello,

I will look into this and let you know my findings.

Bart.
