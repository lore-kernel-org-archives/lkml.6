Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1936261-1525120428-2-8446975552792168525
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525120427; b=BF9ndZPO+VBWdqEc/9T+sB0O6mOvGljw7Dz/Bk22S3QWBoiYBC
    wPJb+guF+i0ED2TVaM8GMspSxFq+qtUg42kL0GHOxNeLIzw1AU9ncLmwRQ63fhpo
    3ndk6/qoN1W8f8xWvD1FXWMeeAUMqv67Oo6qvTYKsS/nWxgHKYkvjN/tsMWF7uQ6
    R7ucfg/jq9oaCp/TjVZNQQr/wAWnLnr4C0IZPMB32TdS044Cw2voAIg72Uq1FE+L
    gj0cIkq3FvzrpWv0w6J+QdroTKFIde2il+jqH7DLB0dI/H9gnXuN5Id9YlAWp0Zz
    t9KvtKoYoohHJWe1+XiXHEg33gvhyow/JSsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525120427; bh=8QiN2xWEEIWWVgB7jMxzuVzl4qIql0
    k53d2EmIjZ0jk=; b=ZWKGJeOlwtybpC3BRo4Dqpyj3ttpHSpYoGrCJogSluQ+QW
    xahTup1pBtQwsaqDv0id5WSFfFikja/GpLRBC8KsyRc/vAPLjIvTs9qtMWza4Sr4
    Huy5WHYO3Wtsq+1qiV9T2MyrJpyoAsIH2Lhrm/RIb363T1G7a4n9i5KVeiBSbIEv
    +7QKMFlz3rFiH9wToYRFnu4vzxqw71gYxxzC34l6AsVhfBQoFM5FlDDX+0GcEliJ
    bpK6LLLdhLr8S7/CYyBMw8g7ycNiSGH9Zp2rDTAuSJMOJ2xUuIX+vnbSvt6BSYsN
    gdpZlZvwmMshXA6A1WqtTu+H/PM+DdRQGTNsJx7Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKKCYFHanV/pKrVYMVd3H/OcMutgqr69EpnfvKDwJqPDBFXFdKUswB0c67HsGChACH0Gp5U3mgjR5raBYVHbaR92ADkQwmKEJxQA/hlpUjLywfW0T18p
    kw/rcAr4DGwK0LRDr3Kr/M/cturXknUay/dBSZg0ty4KhlcUWY5HdEvdTdoF8gReIMw9h1yhuxnky6xJqL3GEVpPXKXg7b1uEuy8YphQ8SUII1koZvhq3Sxi
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=b3VhaXx0qUTUEPc-dk4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755681AbeD3Uc7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 16:32:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755491AbeD3T0D (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:26:03 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03C2D22DCC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Todd Kjos <tkjos@google.com>
Subject: [PATCH 4.4 37/44] ARM: amba: Dont read past the end of sysfs "driver_override" buffer
Date: Mon, 30 Apr 2018 12:24:48 -0700
Message-Id: <20180430190947.814524053@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit d2ffed5185df9d8d9ccd150e4340e3b6f96a8381 upstream.

When printing the driver_override parameter when it is 4095 and 4094
bytes long, the printing code would access invalid memory because we
need count + 1 bytes for printing.

Cfr. commits 4efe874aace57dba ("PCI: Don't read past the end of sysfs
"driver_override" buffer") and bf563b01c2895a4b ("driver core: platform:
Don't read past the end of "driver_override" buffer").

Fixes: 3cf385713460eb2b ("ARM: 8256/1: driver coamba: add device binding path 'driver_override'")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Todd Kjos <tkjos@google.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/amba/bus.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -83,7 +83,8 @@ static ssize_t driver_override_store(str
 	struct amba_device *dev = to_amba_device(_dev);
 	char *driver_override, *old, *cp;
 
-	if (count > PATH_MAX)
+	/* We need to keep extra room for a newline */
+	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
 	driver_override = kstrndup(buf, count, GFP_KERNEL);
