Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49765C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD78217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 17:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548177803;
	bh=fj4DBBX7L8VKSzIbI9Spva4P4xuW4xMdCWMcpa9/P+k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XPE0+HsyMzr5Logs8qpVRcgjNhrSbXhloYa//6iei8RWyjocVDq+ajYWmQ4uhifJB
	 LHqz90PwUauANxymGSOHk4VGkiKOjPpiuUmCZ/4cHxsoV4nWTA+aFqMBEIoc6W58eA
	 jy1RF1cVRmtvFKkkcHV/5KLtnEQCgtkwdrbMbLaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729615AbfAVRXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 12:23:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43427 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728719AbfAVRXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 12:23:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id u18so18653431lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 09:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VoM/91Fb4gx9HBMkw8Lvu2yX0BYegWL0/rwRamL4XwQ=;
        b=r5nrA+8W3PNFfoEkeAxVYfWGTa3c+/r2QBjq4/dEA1BqykL0COplcYmIpbKQqFEl9y
         xFkbsFXZQj7L2n2nmU2IFm4eAjGs99HgY6g9xFoIsSSyr7eAh44zqqibWb/4HfW/b+5N
         NyAbOptVOLpjfpj/GaqvxucXVL8CbrdTgiu53uDhyM6l+0eKoHr6rbcYnks4VP/qhJxb
         2daVcX2G7TuCEk4bQvcUlUL8wBcvq6wvO/HAPhpypaGqsvalQUh0rOXqpdFD5oIATDM3
         XGYEw7e5HUWq+HF2cKsNmHncb0vN5lLKrUX3gfRKzx9Is+Xk44pPRfjVDrW+/IzT7puG
         zJzA==
X-Gm-Message-State: AJcUukchj/HXTkQBK9WZeolvEf5HldE5r8uIZO//H/cfNZn3jcEskU+K
        XbDbik5dmLdq5Nd5nwAm5OmVJg9z
X-Google-Smtp-Source: ALg8bN7jk2TuZwtpMgflJY8fC+eJo2X+4QgXhnP8/a6r6cadyuBuQL6oCx0GT7+zTH0/M5hL8GmkVA==
X-Received: by 2002:ac2:41cb:: with SMTP id d11mr22302276lfi.3.1548177798565;
        Tue, 22 Jan 2019 09:23:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id q10-v6sm100801ljj.3.2019.01.22.09.23.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 09:23:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@xi.terra>)
        id 1glzla-0004gA-Mn; Tue, 22 Jan 2019 18:23:14 +0100
From:   Johan Hovold <johan@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] gnss: sirf: fixes and cleanup
Date:   Tue, 22 Jan 2019 18:22:52 +0100
Message-Id: <20190122172255.17944-1-johan@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fixes an issue where the sirf wakeup interrupt was
prematurely enabled during probe. As Andreas suggested, we should also
make sure that the receiver is indeed suspended at probe (to avoid
wasting power until first open or suspend).

Johan


Johan Hovold (3):
  gnss: sirf: fix premature wakeup interrupt enable
  gnss: sirf: force hibernate mode on probe
  gnss: sirf: drop redundant double negation

 drivers/gnss/sirf.c | 45 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 32 insertions(+), 13 deletions(-)

-- 
2.20.1

