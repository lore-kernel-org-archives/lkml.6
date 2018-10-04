Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B48C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E382A213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALwun28t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E382A213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJDQaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:30:46 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41532 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbeJDQaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:30:46 -0400
Received: by mail-lj1-f193.google.com with SMTP id u21-v6so7737932lja.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=VPMAyCxtuZXPsFKvwdGBVr99bcPRHrqU7cEKo4oa+KQ=;
        b=ALwun28tO1Z7uwJ4KiqVu5ih+Kv8TJmvGcTojYs7lm3Dr3AShmejAQnaUka/uTWjeV
         HZgeJUS61/xlHlWp5IDX4L0K/9PzcUl++obi6QAyQyx5w+4m2NEYHIhfYWEixHs6T3iR
         VvtjiAgRUdQNcAYmzuN11ej8sCRQoGhkq5LBF7Rv5YS7DDtviHayM2r0fV4kl1se7P65
         YCGMGZ+fwNgFzZjImR2vNmzY8CFfzdF5EvHlv6gkPIlPjJ2CR1gH8TpMM36c73SLLado
         iZiWrb0hoiMp3Cap99xBrUhsxFcpRBvJsi6+/hsxoZ85uCCy7Xsi/eCskeqAoX9eIQOF
         8B7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=VPMAyCxtuZXPsFKvwdGBVr99bcPRHrqU7cEKo4oa+KQ=;
        b=t+cRI4KIauLTxpjWkhdVFje6GmDINeGsR287jPj64ncJtCU56V/Hs3zOSSIgSdpnml
         MHzD9xBydWnnWNshYrBjrFAqi+aNyp5gdpby0cXR36JK+/0NqwDhqSAvov+8lYjErrfG
         uzWHrx+LglfZVeTYGdQcwAd4WdNK+BGxC6f6B2iyPIGuIl4ksZqsdSLCN4jM79pHryrb
         dM5V09K2smXZp5wsd4S4E0W+pbZWGJuZQRUPIWIB47OMjUVt6+rf4naX6XIu+GVwcMDq
         nEzKtKtCAAJltovT7Lx3OCqAWzQLVoCkCCJlBrDkhDUFrvLpKr6CPrK8RVn90K7nGInC
         zOUw==
X-Gm-Message-State: ABuFfojIWf6XivamgVIy0r/dRW9+21MoEtdsNq2NEXFtG9qMeFPU5gQu
        pw3vg7yxQ6DSVG44FTZ1ndxCRuSjhIc=
X-Google-Smtp-Source: ACcGV63TNEMJ4NjfWbbN7YBePqdZL2ognwgsYtUhNDmTFj/ltHlsjVr9+Vjt2TtPuyRvv5F+LnAFVQ==
X-Received: by 2002:a2e:9a4d:: with SMTP id k13-v6mr3587342ljj.17.1538645899279;
        Thu, 04 Oct 2018 02:38:19 -0700 (PDT)
Received: from localhost.localdomain (df8yyyyyyyyyyygn-tkvt-3.rev.dnainternet.fi. [2001:14ba:2700::157f:8223])
        by smtp.gmail.com with ESMTPSA id f128-v6sm899738lff.40.2018.10.04.02.38.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 02:38:18 -0700 (PDT)
From:   Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        devel@driverdev.osuosl.org,
        Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
Subject: [PATCH 0/7] staging: vc04_services: Some dead code removal
Date:   Thu,  4 Oct 2018 12:37:40 +0300
Message-Id: <20181004093747.21750-1-tuomas.tynkkynen@iki.fi>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop various pieces of dead code from here and there to get rid of
the remaining users of VCHI_CONNECTION_T. After that we get to drop
entire header files worth of unused code.

I've tested on a Raspberry Pi Model B (bcm2835_defconfig) that
snd-bcm2835 can still play analog audio just fine.

Tuomas Tynkkynen (7):
  staging: vc04_services: Drop pointless stub functions
  staging: vc04_services: Drop 'connection' field from
    SERVICE_CREATION_T
  staging: vc04_services: Drop trivially unused fields from
    SERVICE_CREATION_T
  staging: vc04_services: Drop declaration of vchi_crc_control()
  staging: vc04_services: Drop VCHI_SERVICE_INIT and SERVICE_INFO_T
  staging: vc04_services: Drop unused parameters from vchi_connect()
  staging: vc04_services: Drop no longer needed headers

 .../bcm2835-audio/bcm2835-vchiq.c             |  10 +-
 .../vc04_services/bcm2835-audio/bcm2835.h     |   1 -
 .../vc04_services/bcm2835-camera/mmal-vchiq.c |   9 +-
 .../interface/vchi/connections/connection.h   | 324 ------------------
 .../interface/vchi/message_drivers/message.h  | 196 -----------
 .../vc04_services/interface/vchi/vchi.h       |  41 +--
 .../interface/vchi/vchi_cfg_internal.h        |  71 ----
 .../interface/vchiq_arm/vchiq_shim.c          |  38 +-
 8 files changed, 5 insertions(+), 685 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/connections/connection.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/message_drivers/message.h
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_cfg_internal.h

-- 
2.18.0

