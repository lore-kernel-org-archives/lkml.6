Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id eGxBIxE6GlulIAAAmS7hNA
	; Fri, 08 Jun 2018 08:12:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53CDA607DC; Fri,  8 Jun 2018 08:12:15 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Caq2QyAc"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,FROM_EXCESS_BASE64,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id C9AB5602FC;
	Fri,  8 Jun 2018 08:12:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C9AB5602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752753AbeFHIMM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:12:12 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:39676 "EHLO
        mail-wr0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeFHIMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:12:08 -0400
Received: by mail-wr0-f178.google.com with SMTP id w7-v6so12406297wrn.6;
        Fri, 08 Jun 2018 01:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=2pmn0eYFTCeBxpLpsTQrvjpzL5UgG4jcpWzEJ4KcP1M=;
        b=Caq2QyAc8JOWsg12Rqt23BX3ch+KzdNWd4aR72TK7rNrhhzyaHUlfHug+ZYojr/nGE
         tt/bgMq7ttItUZ9dnPt+DjDDeC6gmtGi/QH6GzWyfaINpmkC0AnDUkn6feOu4vbTFDQH
         wFe8rdd1nYh9qpz3mrTqOhhO9T0vUUCS9rEjNbL3M0fKEfOjU5FG8kBMD0PXosO2H7ub
         yVporC4YT2pmkNfpzpw5NKzkcCul1Q+p2t6lZHbd6xi+OvYixQRslqaCUaMb+CqG9RG0
         Tg8/btfWrQVtHJ1UUsOm9KNI9f2C29jDh0oAQQwNauMHrbYaIc6J6IQDZk0cywJrsZ5U
         +lYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=2pmn0eYFTCeBxpLpsTQrvjpzL5UgG4jcpWzEJ4KcP1M=;
        b=D+s34S0UgZaMLuyqsnlJoPA49aRxfAUXTr8J+grsE52El6MGjTqL9u6nqVD+4BDPge
         T5QeYPbGRzvv87o8g+Ttma5guFHGXE9pYl9OyNoqBRBysf0lyD9AUs8uY54UskJH2MJg
         nPFV9UmAt/nF5mZrzj3uHbmZjobF8JSSq+iCMfhC56qDbTL9+z8YQWqVVKLiCgCoqcAI
         J+JNvVOVoOhgSAiAKbBXB21Ghnyd11Fkcb/EMm+Pe6nV6/znSP2dp6tewzvCVECtxQU6
         iELQc70mz+XftBVe3v98AZ9LsUlAzkkl6npJh/IKzXPxdboAXGfDjYf1G01iUMre/f9O
         ZPWA==
X-Gm-Message-State: APt69E2wyRuwrTfB8MkdayYkNJkA+M7K2XIYenOshKxvd+zGTupI9iRq
        fmwQjnM8ea2gHRFaZ7+ASt4=
X-Google-Smtp-Source: ADUXVKKnIhYQFj0pABlCpKOTg8tw2VnIuGElRtdiVFM5uejw6er4z/yuHToNvtxbUcwThemS1p9Fiw==
X-Received: by 2002:adf:d204:: with SMTP id g4-v6mr4165271wri.229.1528445526787;
        Fri, 08 Jun 2018 01:12:06 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id q17-v6sm23907981wrs.5.2018.06.08.01.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 01:12:05 -0700 (PDT)
Date: Fri, 8 Jun 2018 10:12:04 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ThinkPad T480s & thinkpad_acpi.ko
Message-ID: <20180608081204.ztv4yb62szuyfsz6@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi! I just found out that thinkpad_acpi.ko is not automatically loaded
on new ThinkPad T480s. Is there any reason for it? Manually calling
modprobe thinkpad_acpi is working fine, but I would expect that it
should be loaded automatically.

Here is dmesg output after loading it manually:

thinkpad_acpi: ThinkPad ACPI Extras v0.25
thinkpad_acpi: http://ibm-acpi.sf.net/
thinkpad_acpi: ThinkPad BIOS N22ET34W (1.11 ), EC unknown
thinkpad_acpi: Lenovo ThinkPad T480s, model 20L7S03000
thinkpad_acpi: radio switch found; radios are enabled
thinkpad_acpi: This ThinkPad has standard ACPI backlight brightness control, supported by the ACPI video driver
thinkpad_acpi: Disabling thinkpad-acpi brightness events by default...
thinkpad_acpi: rfkill switch tpacpi_bluetooth_sw: radio is unblocked
thinkpad_acpi: Standard ACPI backlight interface available, not loading native one

-- 
Pali Rohár
pali.rohar@gmail.com
