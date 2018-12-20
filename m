Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16E6C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4CA32176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 06:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl-org.20150623.gappssmtp.com header.i=@osuosl-org.20150623.gappssmtp.com header.b="yD38YN82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbeLTGrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:47:32 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]:39509 "EHLO
        mail-qk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbeLTGrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 01:47:32 -0500
Received: by mail-qk1-f177.google.com with SMTP id q70so368942qkh.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 22:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osuosl-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=9BCbBR/kfEKweRka0x51pHs61Z1E92jki9vaPdfsCuw=;
        b=yD38YN82ZcEBcvIgmqxvNK4oN7tOHNJiOEr+T+32+WOt/o8pECqXNdpbsANk4ClFIl
         hyG9XJaF1PsrsZasH3RH0DwsT6pRg+U/F0E/fOgRCD9pKuONclyt5HH4FQkMXlq77+lv
         A33LnFZDl4O8kJfIH4AVmtKUyvAhOFrsyz+VUYrl8W75iAk/nwOYmAsUW+2WhnEEfpp0
         ELUCcx1hh18qJwoi8UJ46rfE1G6yotly3Ly0eZZdw9Kl+pXfxJK6R/UxWuHWr3sSBgxa
         kc82amXlGCRYj9m/Zm/JO8q89Rh0Cvcx7kx8rkKGl3Y/U58PeTyjXOOF1dHCLpMYXuqa
         oVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9BCbBR/kfEKweRka0x51pHs61Z1E92jki9vaPdfsCuw=;
        b=b6cSqkHJOyktGvfKD4WtazhzJN5je9z0ljOh1nlSAsI5NWQNEzC7BIvoO7GM+Xe82d
         1+/z4WaXIHZTX7GsC3NYQUfW0/tcNtIEZC9yCuk0Dl/eHkIimBSDpnuZzqrbSY0rH8pO
         noib/0byab4X35Xl2kKZvR/ORlxKVVCLsSLijo3FWe6tM0OHgxxuMjK77omBwWbxPMI+
         LeYqycrMdKZqWXLRCLytNoj+VnkxpfVyWf3Q1J/aaAQkQAJH8euNX8aB57C2uhkgIgU4
         kYaU+xDOk7axctAacNn2gYE220j1osM90jql4lR3osYHiAi/XxHbBF03ByOtl43NvATI
         nR7Q==
X-Gm-Message-State: AA+aEWZD62ev1OOzfVr9rbj6l0BUw4SNDJbWFHdDYDk+FnsBlRPeYvtP
        ZzRBdX8A6lrwUXL4A29GR2UuqX6PMRZK8cWs9Kp+NlhHUOY=
X-Google-Smtp-Source: AFSGD/UWIzaINsXjhN+EEnzXaJQMcS4/76jb26umXz/vqDQE+udmyfGJMeElwReUc4GYAx3Gt93J4G6jy41pf0Igcx0=
X-Received: by 2002:ae9:f40b:: with SMTP id y11mr23129311qkl.228.1545288451226;
 Wed, 19 Dec 2018 22:47:31 -0800 (PST)
MIME-Version: 1.0
From:   Hunter Lannon <kindlehl@osuosl.org>
Date:   Wed, 19 Dec 2018 22:47:18 -0800
Message-ID: <CAPdqyfnAJf1dMCAL4SFFM40p_zn5tmUTkdfvVknCHeGLSUEPLQ@mail.gmail.com>
Subject: Easy Kernel Patch
To:     linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003638a5057d6e8137"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003638a5057d6e8137
Content-Type: text/plain; charset="UTF-8"

This is my first patch submitted. I hope I can finally say I have a
commit in the Linux source code :)

--0000000000003638a5057d6e8137
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-Removed-twin-forward-declaration-of-struct-device.patch"
Content-Disposition: attachment; 
	filename="0001-Removed-twin-forward-declaration-of-struct-device.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jpw8txh00>
X-Attachment-Id: f_jpw8txh00

RnJvbSAxY2U2MzY1ZDA3YzczNGNlYTk5NjVkMzEzNWRkNjRlMjY0MTAyMWVmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBraW5kbGVobCA8a2luZGxlaGxAb3N1b3NsLm9yZz4KRGF0ZTog
V2VkLCAxOSBEZWMgMjAxOCAyMjozNjoyMiAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIFJlbW92ZWQg
dHdpbiBmb3J3YXJkLWRlY2xhcmF0aW9uIG9mIHN0cnVjdCBkZXZpY2UKClNpZ25lZC1vZmYtYnk6
IGtpbmRsZWhsIDxraW5kbGVobEBvc3Vvc2wub3JnPgotLS0KIGluY2x1ZGUvbGludXgvcG0uaCB8
IDIgLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2luY2x1
ZGUvbGludXgvcG0uaCBiL2luY2x1ZGUvbGludXgvcG0uaAppbmRleCBlNzIzYjc4ZDgzNTcuLmQz
MzE0N2RiOTQwMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9wbS5oCisrKyBiL2luY2x1ZGUv
bGludXgvcG0uaApAQCAtNTEsOCArNTEsNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcG1fdnRfc3dp
dGNoX3VucmVnaXN0ZXIoc3RydWN0IGRldmljZSAqZGV2KQogICogRGV2aWNlIHBvd2VyIG1hbmFn
ZW1lbnQKICAqLwogCi1zdHJ1Y3QgZGV2aWNlOwotCiAjaWZkZWYgQ09ORklHX1BNCiBleHRlcm4g
Y29uc3QgY2hhciBwb3dlcl9ncm91cF9uYW1lW107CQkvKiA9ICJwb3dlciIgKi8KICNlbHNlCi0t
IAoyLjE5LjEKCg==
--0000000000003638a5057d6e8137--
