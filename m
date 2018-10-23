Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE745C67863
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9729207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 11:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAP3h7O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9729207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbeJWTwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:52:38 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:46722 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbeJWTwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:52:38 -0400
Received: by mail-qk1-f178.google.com with SMTP id a193-v6so514658qkc.13;
        Tue, 23 Oct 2018 04:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GxaUldInxt8S0WOf96/f1dggEVygmb1yXVURh5ZUr7A=;
        b=OAP3h7O060GVB81SnN62qM9o3uJ0DeOVq9JnlEkYlTw8hDX9BZCJjcEFRaiIYTH99t
         HIOfLeQ+y7j09q4vfhzPtVpNFR/4TooErcD78R0k5z3J0KBBgFcsNkM81e10PFxt/tCl
         NHAVPEE7kVRY8av/OntQ9pkqoFzrkJ/ne47dwVRORwSlBt487F7WQNebK8AZQBRjgrs0
         M7h+GTAEEW+sHdCFvGVEaA20Zyqv8Or3DHyPDQWaAqLVqLeSxF/DLNg8dWbeS4afXIGP
         zH0hiTXutB+LLWH2c8nnDtewkowP3gsLCrHliZTfvKhThq6MraVg3Tcy0ZlDgH6izd+T
         JJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GxaUldInxt8S0WOf96/f1dggEVygmb1yXVURh5ZUr7A=;
        b=qLWuz4tB7fJU+kQ/QBduzfT1SD+pPJY7g449p2n8DPGH/dOB+4cXD/dmjebNK6c+Xr
         WnwcpYdCB/h19cNlUOTFEST0JE8h2Lbx7gi9uSQ5Hchh9HYcTKth0VGwwCzepgPKY/vz
         Gw7EgIW8WbuiMj2rVnb7wmBjqQ9Y/ne6irYBSCAakofBUDftV7tUifFRf9vYvE525d1f
         Qpzo5VR1cK7bHNBMg4dodpZ8LEHzJc6+zodDaRVMXAeo4+iehySGQ7Guqu3IQpgflE6+
         2iFh0vJZEzcWa0R5jERSJpQn70/Bwf0JuKl+OJyEwZrxQj4ywpoNpOXf4oHE6bKYRROU
         8DIA==
X-Gm-Message-State: ABuFfojiktMZR9ecF/vIhgVRQzelMFkdaudRdBihH1IkhYRAh6fGrXjO
        KroDJj5gLNPgaoF+hgb4ywDUIQN+JKsmXHKQWwo0gg==
X-Google-Smtp-Source: ACcGV60XLnjISFvfHjTBH6LabiuRlkFuyZwrnaHDj9GcKCS5BuHgqgFUg2vjxji5CMvChIFgSlYz3zHUhcaZYi3qcnE=
X-Received: by 2002:a37:9ac2:: with SMTP id c185-v6mr45678791qke.162.1540294173935;
 Tue, 23 Oct 2018 04:29:33 -0700 (PDT)
MIME-Version: 1.0
From:   Leonid Bloch <lb.workbox@gmail.com>
Date:   Tue, 23 Oct 2018 14:29:22 +0300
Message-ID: <CAOwCge2F92GninYqckfrpOaTghsAUiESqpNUUpQLzvvBwOS87g@mail.gmail.com>
Subject: Adding initramfs as an ELF section to bzImage
To:     linux-kernel@vger.kernel.org, initramfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am wondering if it is possible to add initramfs as an ELF section to
the bzImage, and if so - how?

I am aware that it is possible to compile-in an initramfs or to supply
it as an external file. Both of these options don't fit my needs. The
first one doesn't fit because it is very difficult to manipulate after
compilation, and the second - because I need a single file.

It looks like there should be no problem to append a section to the
bzImage for loading into memory as initramfs, but I didn't find a way
to do it yet.

Regards,
Leonid.
