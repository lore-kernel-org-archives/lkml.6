Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E194C65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4112081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jgEw9UJ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4112081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbeLITBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:01:48 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33729 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbeLITBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:01:47 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so5059076wmh.0;
        Sun, 09 Dec 2018 11:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXSMs0NdnNkqvE+essbtRJERcGnZDdB0NIQwHQkfznU=;
        b=jgEw9UJ5+BIrlKkd4a0Lsqon6XQXbZ/a8hmURa6s8t2Of9WWHkTXNZ3D9SlsDk8owv
         p35MalkHa2wfTimgcLVrv2EDHWJbNjFLCB/QOGZR+Gi+p2uA1WnvWTJ4dR0nLc0JzuI2
         9YeSA5rkwnFyqZJ9m7T+KkC2SykucQ6YjX3g7xkYDFkNkLvPkhSezFn1Xi2FGnVBoLm2
         HiM0QG2hz70PcXbepFY6WvQA2U/3xhP9sAW2lbZRJy11u9bFmANP6m/c/4LR+VN3EFTW
         vAydQRZqfarVAYQLHH6mb6SjzklejSG3kKoCRQKWl+rag2RGDNpD9l2nx3EmmBlK/f6W
         mqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HXSMs0NdnNkqvE+essbtRJERcGnZDdB0NIQwHQkfznU=;
        b=fgJdGVhnCyaFZnIJ5+Q3Whl3IIa27rrvFOXmhGUycbJImQvy5lsYvvlLl8oTFFKUvY
         aeEEAb3g43nm68boT7ZPWXN5OY0Hk4QIFFiOQhzQfu1jN8eTVv5kDQlHgaKOll4Dgn6u
         g8ky2iyvc3ydXZ/1zMb092etFtqm0eTz2wqhPHPyO9Za2g9B3Acjq/YxHTrOAj1bTcYL
         zK0is3RWtigy523M1gb7mUD1F7BMQnaBMzpZg4muS9QE0l68J/flIOKi3BkKRGZr/gHg
         3ycoxrCSV9jfd3zvFgifPKz1etG9NXz5fm9Lz+IPGt1x1r9Z2rlKfmYCpt+BMCmvPT7B
         9ixA==
X-Gm-Message-State: AA+aEWbFV1trLuvI+OSo4W+IqhCYUWQTfQtlgvJb8PaEW4rARf2ACUbA
        k2GAEIhGDVzRqw20BqgE3GiAXj7F
X-Google-Smtp-Source: AFSGD/Usb7ciHKS1m2JjKfFgZbtzRFNRlos0jD2DrM3jwhZQOcFrGJW5a5qHnQqTXg2cxDnVHYRb4A==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr7474590wmj.29.1544382105141;
        Sun, 09 Dec 2018 11:01:45 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l197sm30560215wma.44.2018.12.09.11.01.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 11:01:44 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-usb@vger.kernel.org, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        Arthur.Petrosyan@synopsys.com, christianshewitt@gmail.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] usb: dwc2: fix hot plugging on Amlogic devices
Date:   Sun,  9 Dec 2018 20:01:28 +0100
Message-Id: <20181209190129.11870-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up to an issue I had a while ago but never had the
time to debug it: [0]
Short summary:
- on Meson8b USB devices are only detected if they are plugged in
  before booting Linux
- if they are plugged in after booting Linux they are not detected
  (except when running "lsusb -v" as a workaround)

Christian Hewitt made me aware of a similar issue that was fixed for
Rockchip devices. This single patch applies the same fix to the
Amlogic devices as well.


[0] http://lists.infradead.org/pipermail/linux-amlogic/2018-May/007310.html


Martin Blumenstingl (1):
  usb: dwc2: disable power_down on Amlogic devices

 drivers/usb/dwc2/params.c | 1 +
 1 file changed, 1 insertion(+)

-- 
2.19.2

