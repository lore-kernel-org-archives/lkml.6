Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF92C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 586F820880
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rWVnjeft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 586F820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbeLJNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:22:32 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbeLJNWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:22:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so10437935wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFgo3cZiyawH9xdE2X8cjZ2ISVECpYqIFuLSf0Trn+U=;
        b=rWVnjeftjL65PBCJK2q1XRs+F53KpKGA/PbZiQARkvUDYSk+jws9SWQia91R6Xge8N
         6HqJ6zhHqJhAUo8FHwWjJHhJH9426n+yENrwYrABzcI1idEm5MyRZSP47pCc11OpyBzl
         SzlscosA54ha/7N2K8CZBVtmJ4hkHLLU78HBUdutbEH8X8u97rwHcBSGAd5z9jDDS7HU
         ndt5EgsxQC+ZQDqUCfPUEN1HMjrJqVPQSJ6g5RfbYCFzJNtUlKCyCkVtZ8Y5OMPns2Bw
         aecrkpuL28yRH1SFWIiGmNWlit38l9I1TiWhvRFnx9TJt8Dvykp6F++6nP3uiiueWNPc
         m0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BFgo3cZiyawH9xdE2X8cjZ2ISVECpYqIFuLSf0Trn+U=;
        b=XICmsTaIF0v7VFN9NTfjlP/EIWLbdl+AHyzBDyQdPRqqO+bKFa5dndapVUyqNsfJwt
         yPGQl/Ja3t1nZj3t5k0ljOq5ubvcMu6i5MvCTyQQcKZINxeCDVRSq65uOJYb+esXZ+rd
         82FP32ejG/mA8xB4l01HrkcuFgWmmhMtQYXFrEtfDMIwg56RdpuhoWZ44Lorw66TbEyr
         uRsHEA18cPyOEmOtNtWUW0Ay+LMDfwbmCuOB4kqm7bweAT24GsfDn1+D4zTUhbXdm8iQ
         xL/E/Dggt2mP+lYSvcT9gKv0yQo98PAtvcjuMBFrKgeAZuX0UdAfH4mSpaNAgSrrNg2o
         VQng==
X-Gm-Message-State: AA+aEWaUvgRN03hSEsjvPBldoHTQA2Q5hDq0WSaFqU+fGqrRRu+1GJ1/
        eZZJ8ELQSViFT4wQtpZHcyfMcg==
X-Google-Smtp-Source: AFSGD/Xsxi+ia6g8WUPGZy/3/0qDawjuGqS+1FgMn6fvB0Q0c8LGJWJzjq+eJReKYfar4Y15DQjq+w==
X-Received: by 2002:adf:c711:: with SMTP id k17mr9369567wrg.197.1544448150145;
        Mon, 10 Dec 2018 05:22:30 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id l3sm11208424wru.36.2018.12.10.05.22.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Dec 2018 05:22:29 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: meson-gxm: Add support for the Mali T820 GPU
Date:   Mon, 10 Dec 2018 14:22:25 +0100
Message-Id: <20181210132227.29262-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds :
- Optional reset properties in the midgard bindings
- Mali T820 Node in Amlogic Meson GXM DTSI

Christian Hewitt (1):
  arm64: dts: meson-gxm: Add Mali-T820 node

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         |  2 ++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi    | 27 +++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.19.2

