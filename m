Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D607BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E23720C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TpAjuoXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E23720C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeK0KPX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:15:23 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40015 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeK0KPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:15:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so20740075wrt.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TiPau+spQg+ZcgAL5hvt+IBYe1FXUi2fH8oxrnxnQAo=;
        b=TpAjuoXJlFvP0M5tGUv04ziGzm4WPajVRyHPAItqszzuRBVmY0Mp3/Zr1HvUkWihGa
         IL0WuHIzEOrispOg0O+5PyJUqe4ubkbq0dVf4XzPs/ZwS6Wvowo3QTBqAtKYBqfkyVQ7
         DuSMN5/q+gXBKlXAnA5hhI+xhIEHPnp1IKmoBVzfgGXTZ1xMN5WWPn6H6Mgjf8a5SJOY
         nUOATjNRX/52KO23cJevwnbDtPt6bY/PQSyH/b+e343wxxy62IdN4ovck99Yb/EtF3zu
         euQYMt8bZXohOm/1Jj+AhHSgxxpBa/eNnjJVROuiMptQ6KcH3R8GXzjeqlDxAUK30JvB
         xBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TiPau+spQg+ZcgAL5hvt+IBYe1FXUi2fH8oxrnxnQAo=;
        b=O5UA6GB8AcZWWaGfMODGk4W1RWhACLb0fLngDSZK9fzCxyqeMML7TCMQuChczmlYQy
         8BHP/qy4MLdZmTeOo9EpnvNVx50siYfEYfWeu1moG6CQFg58gFYBusS6C8s1nqxSDAgT
         3JldmGMqnZoOekCid5cCthWTFjmGYkSwXd5WzhmeesnB9UyvqrdoqqdHdFZ93DX7iA6A
         4IvYTpFSahLuUGlPNvelMTHlSD5SWJxs3jQx+TX9Xwn39/S+t8I35KUtWO4jbwhQ0eLe
         lAmaDu1viGRlngXz5DLErVAvQVPa9ItqMCxSb+GcOGKGmuvMLAbG1NKAmK6M0MefRGAA
         zxxg==
X-Gm-Message-State: AA+aEWZlTRN53f5/ev6ZevUoVTAMIvTV+TfAY0Q1qrCNpGH5BW367uDS
        lJMeU2jJFJCVe1Bd0p6XtYI=
X-Google-Smtp-Source: AFSGD/VFe6lTyZ/BCntShAtccC/Pq5QAbZdzT5XQxIaxZNdEw3d888yvfIfKtZMBv9qnRezuINwDWA==
X-Received: by 2002:a5d:4c8a:: with SMTP id z10mr21117190wrs.75.1543274377032;
        Mon, 26 Nov 2018 15:19:37 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id v5sm1014750wrr.11.2018.11.26.15.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:19:35 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Parenthesis fix and temp vars
Date:   Tue, 27 Nov 2018 00:19:07 +0100
Message-Id: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the first patch there is a fix of some parenthesis that terminate
on end of line and some parameters that are not aligned with
previous parenthesis.

The second patch is a proposal that avoid the long line refactoring
code and using a temporary parameter that will be passed to the
function on next line.

Cristian Sicilia (2):
  staging: emxx_udc: Align parameter with parenthesis
  staging: emxx_udc: Added a temporary variable with address.

 drivers/staging/emxx_udc/emxx_udc.c | 288 +++++++++++++++---------------------
 1 file changed, 117 insertions(+), 171 deletions(-)

-- 
2.7.4

