Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5D82146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="F6AFswdr";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="hPbDvnBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731426AbfAKLfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:35:02 -0500
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:53084 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728997AbfAKLfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:35:02 -0500
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0BBNF27010773
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=from : to : cc :
 subject : date : message-id; s=pp;
 bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
 b=F6AFswdrcA4FsoyX0lkW8MA5v26p+s3gM1xvRAnpIap6uAWL8W0IQjtEGc4LjG1SLHsq
 jSPBklsMbjN7T4BPxl7xeSj/720nRsZgpf7IMmwUvwcN0UVI7stz4hgqiQPyp66BqlAz
 bNKFOxtBkIgq+ot7lwqPNR4oIZuuexTXKQesgGdzUdtW07LBh6Xhm32qNCRzffkyQ4Mj
 wNdndriNsDqa+RNIN3vqxbLtDcdmpA9zVDJujljcISZ1mYk+0RdHpTF9byY44WJSrucg
 WtVNyKMJU38Tfyv5OJ/c98Ax56xRShQtVWQLkDq2PlRfYTbHN8lIZbUVREiwnYvK8f9q CA== 
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        by mx08-00252a01.pphosted.com with ESMTP id 2ptjuub14f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 11:34:59 +0000
Received: by mail-wm1-f69.google.com with SMTP id f6so676628wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 03:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
        b=hPbDvnBbXbE3cVvNDMHOHEDbnPNNPkdP+fS3YDMQzQQ/TvyT10UoVVSTgQfHHPYuA3
         opwKLsFvbfWWnqMw++WHpiFeLg6qC1SWKhbRpQRVY9LL3pPx7Hzrb/B5jMWRJCEfq7vF
         yZQbXbBMCAhVajhTZMCegacbfOfWispPnuruMJ2E+4ORJaA7IHM5hyH3Yzx2vvGZHSSN
         nPwGpGP043+eM8aNMTY6QIpLNPB1PWBmKlPoedUcXU+/vCsoW/FuKP3Twijk0eWWIMRl
         OQ0Kf8omrDYP/NTxC009D3sPw6ias2+PYIWl1+eoTBzkEdUu+xLCZsYRc39dMDpW6eCX
         +lvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QooJ2+oMCgy72PaxJ/VJWzV3+0zvKgI1mojlS+3lljk=;
        b=gsYtMIQtuUcVxs3qSwMot/4/LPgu9jvGnxHuq0jQ4RVgBrPEb4F55Lb18AohnPe4bm
         nBKEKeH+bhE1YLwVCBasC/tWa30ea4wqv4ADm1zvzddouR+2YC4VImFJiJWUw589qvjQ
         pe7zBCIvA3f4Cp8QdeDC/1N32RoxTUSbh3cWr6UeSMLEqkXe9uO2PbrmEE7wihqIgb2U
         vH9OF1keKTPJU0hokGktA8g+IFMzzYIsWTSqRZiGvggBwKzqNf/GZfO/rTp8bAs3m4LT
         J8I0Wnvbk3dz3oGvwfe7BNcmR/WrSIePqUGWaGUkeIt3q1bsJgMXL0jB2VYPlz9ZC020
         E+Ow==
X-Gm-Message-State: AJcUukcDJK+v2bG5znZbBri6mdqAmVc2tJb46jOyk0APjWmuvUvrdeCL
        Ys98EvlgJlUz/+5y6MCxKceJz74dhHj0/vW61NGJ9SAFgV16gXDmoFkyzKSzu86mO1WGzKSKHIJ
        KqnCxBM5AALEiWWLeRHf/gekx
X-Received: by 2002:a1c:c707:: with SMTP id x7mr1905574wmf.120.1547206498170;
        Fri, 11 Jan 2019 03:34:58 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4yCzUIrfeJCzCcxg7bHe0+0j0incOkO1DWe5lzzTs9nQlhw0ixDKN2baDFK/hkjy6vluMNVQ==
X-Received: by 2002:a1c:c707:: with SMTP id x7mr1905552wmf.120.1547206497889;
        Fri, 11 Jan 2019 03:34:57 -0800 (PST)
Received: from localhost.localdomain (cust51-dsl50.idnet.net. [212.69.50.51])
        by smtp.gmail.com with ESMTPSA id x186sm19403931wmg.41.2019.01.11.03.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Jan 2019 03:34:57 -0800 (PST)
From:   Phil Elwell <phil@raspberrypi.org>
To:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dominic Braun <inf.braun@fau.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] staging: vchiq: Fix local event signalling
Date:   Fri, 11 Jan 2019 11:34:53 +0000
Message-Id: <1547206493-105303-1-git-send-email-phil@raspberrypi.org>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-11_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to the recent event reworking (see Fixes), thread synchronisation
was implemented using completions, the worker thread being woken with
a call to complete(). The replacement uses waitqueues, which are more
like condition variables in that the waiting thread is only woken if
the condition is true.

When the VPU signals the ARM, it first sets the event's fired flag to
indicate which event is being signalled, but the places in the
ARM-side code where the worker thread is being woken -
remote_event_signal_local via request_poll - did not do so as it
wasn't previously necessary, and since the armed flag was being
cleared this lead to a deadlock.

Fixes: 852b2876a8a8 ("staging: vchiq: rework remove_event handling")
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
index 9e17ec6..53f5a1c 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
@@ -446,6 +446,7 @@ remote_event_wait(wait_queue_head_t *wq, struct remote_event *event)
 static inline void
 remote_event_signal_local(wait_queue_head_t *wq, struct remote_event *event)
 {
+	event->fired = 1;
 	event->armed = 0;
 	wake_up_all(wq);
 }
-- 
2.7.4

