Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F01C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F48E20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 17:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEfErM1G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728672AbfBYRyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 12:54:04 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:47087 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbfBYRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 12:54:03 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so4803304pgf.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 09:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3XI+XUQ8UUQ37nasSjVG4chk8ABNuDIm23u0on6K8ZA=;
        b=NEfErM1Gn3uwU2RIklyUpLTFroChcMNjWeeIFMZuDDz9bvFjFbntdSSXaf1wDAUxrZ
         6fPzO3LEJL1/YD6cMeBUWjYhnVURNQEK2XVaaEmdEUUCrOsFgpRVwyaD1bCR8XoZ3aoh
         EzHAVEiFCtar+F6kn2mx28Gjx3KiuHcud5ELjBPLtk6LERD1KYUnLcgDflUy0YiTwL5C
         NFOtubUpOwRMSN92aW3IFq61q+IfnsWGtUsJY3dG22EWu6MXxZx3sfmHt9IFARVtfmM2
         Cw2lo/+k5+rvEEnm+Y6bULqeLGTX4Afy2x3v63yvTAxbqDBEn/yvVMgfYDh3708CcybX
         PQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3XI+XUQ8UUQ37nasSjVG4chk8ABNuDIm23u0on6K8ZA=;
        b=Sy3lsU/o8sJAnM7nlWTAdsEd4FFAK+mej2Ilhxr/oDwfS1aeKexnTSgsLUfrGObVhq
         QLzxgSTiHtEKrdeCEKuwzjQhMQKNQh6K3FwpIIsiuPQApvlW11YvZf+dgvBAIxizyPgN
         Fs7IRDs0higEYwsE1CF8d4FK+Q05xb/jIBgYhFr4Mh9pxXaurhwurQM+ATS6hSHJpn9K
         ki9Vt3wCEhMDhL7pzUjHxkXFEJcVITbhBzyr9RW8Xy+Rs7GbRakAkJH5hESIvZIMPCOO
         Ahspvgcn3tB83vGO05ZmhzIQppKzWt3q+IXgdNkBDnfbNNLn8S70IukHUPo/XwWkmwvs
         0qPw==
X-Gm-Message-State: AHQUAuZxFMksuKOwu18zo07t+Pkmct0VEpekiuVzfltHSP/MTYrKIJkW
        sBpzt9ez2ZyZcR6wzL/qTwIJSexnjBw=
X-Google-Smtp-Source: AHgI3IZEsrWvdl9iHG93Ff46gxUSicyNpMXkWVl607fsM0/1qJVJlap6fJ5Bmp6KUoLuEaCidS3Dlw==
X-Received: by 2002:a62:204f:: with SMTP id g76mr22206879pfg.100.1551117243066;
        Mon, 25 Feb 2019 09:54:03 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v9sm15398997pfg.144.2019.02.25.09.54.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 09:54:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] coresight: next v5.0-rc8
Date:   Mon, 25 Feb 2019 10:54:00 -0700
Message-Id: <20190225175401.26467-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning,

It is a little late in the cycle but the change is small and confined to
CoreSight - please consider for the coming merge window.

Regards,
Mathieu

Sai Prakash Ranjan (1):
  coresight: etm4x: Add support to enable ETMv4.2

 drivers/hwtracing/coresight/coresight-etm4x.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.17.1

