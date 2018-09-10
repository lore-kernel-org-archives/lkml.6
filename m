Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6495C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7789320870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 15:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYmO8wEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7789320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeIJUXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 16:23:22 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35924 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbeIJUXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 16:23:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id f4-v6so16847533edq.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LWY57QmV0WUFHEmOKMb+VRNsMV0XtDzk+6qp1kUlfpo=;
        b=OYmO8wEGwxrk+jbr6cE5oQGIoi8Gb8CHwNodv+1EPMe8WY18b+/0G8Z2aLtHRPwTBh
         0mprB26ZWk/bo+a3ik35QIVx6kYCTvsbbE+b8QzstgDXcUtu36n7HgjC4Rq6w4M94RB9
         36RrICFbThyssWy51aNFmSQcrAOdbz8TlW9j0w9RPQ4G1+mPeDXYiz2fwKWUwal8pHXa
         U/SQgXP+ElWsQ8FGb3QJSqo8PBUubOJwelz/upyUzpiU/9VbEfIrEo7T1kitnemkfDO8
         4GubeRs7Y4uTkbFS96yPt/o/z8JwWngw+CwkilQ22OxQxXecIo84w/t+ENFSVwFopJDe
         si5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LWY57QmV0WUFHEmOKMb+VRNsMV0XtDzk+6qp1kUlfpo=;
        b=D3/XX0vfCogbcMqH1amk7z83qV5RDih3ZGg1TMitP0lAqhtEWdmyR7N0vFIv5ZeK67
         gZXn6AG9cUhwn1QVoPs49BbWpBgWGyk+1qyjPjmhbdcK85mt338DVFloIzZPP/w5r7u3
         D6UVNuGL6GqPmBrC+wqavuUL0LQPzJu6klNm3H12J73zsqoZUzn3z7VhzFy9PQkJxF+r
         9B30rIE2eTZ8nEwDcAlom5466J/eTrOa8LhhsPTRHFx0bRuyN5WSC44ug93NXdhu+ZXy
         CGNA4vlD9bUFWyLeNjE6vRmlFJWuPJ/Svy2JQ+968VwN74i+vqHFxQZPW18fQLo7CH4K
         YF1g==
X-Gm-Message-State: APzg51DzrbEF5GUIJT5FG9ZHRpGVLzFiE021vZWDiqdfIjVTlhlYCFI/
        3sJAWiuGmiCgmIbXhHtsdPA=
X-Google-Smtp-Source: ANB0VdbyR38x6iO67Zj2aBjLLywkx969AkCUODUw6Bx81Pp4kamAU8/TL8p9gfCD+Q8aBxzRgLmBBg==
X-Received: by 2002:a50:f10d:: with SMTP id w13-v6mr24850987edl.0.1536593323626;
        Mon, 10 Sep 2018 08:28:43 -0700 (PDT)
Received: from darwi-kernel ([142.93.171.10])
        by smtp.gmail.com with ESMTPSA id s41-v6sm18102425edd.61.2018.09.10.08.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 08:28:42 -0700 (PDT)
Date:   Mon, 10 Sep 2018 15:28:37 +0000
From:   "Ahmed S. Darwish" <darwish.07@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Simon Que <sque@chromium.org>, Todd Poynor <toddpoynor@google.com>,
        John Joseph <jnjoseph@google.com>,
        Rob Springer <rspringer@google.com>,
        LKML <linux-kernel@vger.kernel.org>, devel@linuxdriverproject.org
Subject: [PATCH] staging: gasket: TODO: re-implement using UIO
Message-ID: <20180910152837.GA31819@darwi-kernel>
References: <20180818155724.GA22569@kroah.com>
 <20180828103817.GB1397@do-kernel>
 <20180828123607.GB13441@kroah.com>
 <20180828143049.GA7388@darwi-kernel>
 <20180910081626.GA31344@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910081626.GA31344@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gasket in-kernel framework, recently introduced under staging,
re-implements what is already long-time provided by the UIO
subsystem, with extra PCI BAR remapping and MSI conveniences.

Before moving it out of staging, make sure we add the new bits to
the UIO framework instead, then transform its signle client, the
Apex driver, to a proper UIO driver (uio_driver.h).

Link: https://lkml.kernel.org/r/20180828103817.GB1397@do-kernel

Signed-off-by: Ahmed S. Darwish <darwish.07@gmail.com>
---
 drivers/staging/gasket/TODO | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/gasket/TODO b/drivers/staging/gasket/TODO
index 6ff8e01b04cc..5b1865f8af2d 100644
--- a/drivers/staging/gasket/TODO
+++ b/drivers/staging/gasket/TODO
@@ -1,9 +1,22 @@
 This is a list of things that need to be done to get this driver out of the
 staging directory.
+
+- Implement the gasket framework's functionality through UIO instead of
+  introducing a new user-space drivers framework that is quite similar.
+
+  UIO provides the necessary bits to implement user-space drivers. Meanwhile
+  the gasket APIs adds some extra conveniences like PCI BAR mapping, and
+  MSI interrupts. Add these features to the UIO subsystem, then re-implement
+  the Apex driver as a basic UIO driver instead (include/linux/uio_driver.h)
+
 - Document sysfs files with Documentation/ABI/ entries.
+
 - Use misc interface instead of major number for driver version description.
+
 - Add descriptions of module_param's
+
 - apex_get_status() should actually check status.
+
 - "drivers" should never be dealing with "raw" sysfs calls or mess around with
   kobjects at all. The driver core should handle all of this for you
   automaically. There should not be a need for raw attribute macros.


--
Darwi
http://darwish.chasingpointers.com
