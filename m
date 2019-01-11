Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5B520872
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 06:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8t9+leX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfAKG3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 01:29:19 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:34739 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730368AbfAKG3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 01:29:18 -0500
Received: by mail-pl1-f178.google.com with SMTP id w4so6322652plz.1;
        Thu, 10 Jan 2019 22:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=OdodkZXE/tn4FSNB0NpaxXBP5rBK66K7xUvRbQ3QQps=;
        b=G8t9+leX/R+b0ea637u0vaiVTBYH/thNk4j8J2YXFUfoDOIgML7QaQJLJa17tZvJ96
         0zpSXmjPSAoVMX7vC6b8e+Wi/tG/3Wq375t2irMV4ZgIVSlrQW4y5eNhT1GdY1/8Idtj
         Qg7uVlR2alC0mzFDOaTHB5bW2IYuGA3KcuX3i7Wct6/4PhQi1ldCNs+2NqKMYxvClvTY
         Kw++50Mlkb5h8v3hMRS1biZjrdi/as+njR0LAhHE+qV+JtNOodzwzlxoTwA+KY4NvJ7L
         ySGq6h9WcrtBwp+6+hGy5Qq3G6P1jdC0EIPKSB3tEIzFiX23JAAjey89VNBfcDPLmxd+
         tknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=OdodkZXE/tn4FSNB0NpaxXBP5rBK66K7xUvRbQ3QQps=;
        b=V5V/TVm2j/rfPth4Mtrfkl80CYAQCzjFnVeB8QM7trCi54wmbPIMif9qh0MdOXljaL
         eoizENJMvgOG0aj49iahN1YpnVLz2zFjGiSNvDo+an6CXRvu9Z/GlDqQAaAURYahsqxv
         dFfPecvtJX7p0RzSxhKBmHeTe/fo2ZqkOP66d10nl1PhfDIqRgmVuYSyohSpsja95SJ7
         mJX2powohiYBwZmaUOu8Y94I3LEWH5Bh1X3INRjy66mX0jqCPAJ2F7K+i9ojgYiWIsNr
         333olmrtyCbCo7b+G0V94FSs/tNMeb0DG2w3Ime0PRIc90y1AmBqtWFo3pBMYqr+nB0e
         tQFw==
X-Gm-Message-State: AJcUukelZzHZcOJK6+r6R9ARrdNVU8D3xDrjPTswsGQRbdluezaDjCNF
        hoTpoe9WZPlQTwOa3bqcDRoXxnWB1/C6O1nT6zr8mg==
X-Google-Smtp-Source: ALg8bN6xDNakegZu5VO6zYghKXQP1Fybl0Cs/tbckQHCGLzY5SIhE+zYpSmJlCCVcGebE67V5BXbUchc1wYHxesUWX8=
X-Received: by 2002:a17:902:e085:: with SMTP id cb5mr13277448plb.24.1547188156884;
 Thu, 10 Jan 2019 22:29:16 -0800 (PST)
MIME-Version: 1.0
References: <1547159098-19011-1-git-send-email-pshilov@microsoft.com> <1547159098-19011-5-git-send-email-pshilov@microsoft.com>
In-Reply-To: <1547159098-19011-5-git-send-email-pshilov@microsoft.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 11 Jan 2019 00:29:04 -0600
Message-ID: <CAH2r5mtF41PP_CJ_VDNdftJycNh53mOemC5FN-PYGGN3Hg=ETA@mail.gmail.com>
Subject: Fwd: [PATCH 4/7] CIFS: Do not hide EINTR after sending network packets
To:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel's patch looks correct to me, but since this may be a common
issue, how to better handle unexpected EINTR on sock_sendmsg, others
outside cifs/smb3 world may have run into this before and have
additional comments.

---------- Forwarded message ---------
From: Pavel Shilovsky <piastryyy@gmail.com>
Date: Thu, Jan 10, 2019 at 4:25 PM
Subject: [PATCH 4/7] CIFS: Do not hide EINTR after sending network packets
To: <linux-cifs@vger.kernel.org>
Cc: Steve French <smfrench@gmail.com>, Ronnie Sahlberg <lsahlber@redhat.com>


Currently we hide EINTR code returned from sock_sendmsg()
and return 0 instead. This makes a caller think that we
have successfully completed the network operation which is
not true. Fix this by properly returning EINTR to callers.

Cc: <stable@vger.kernel.org>
Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
---
 fs/cifs/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index e047f06..aaff9c5 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -387,7 +387,7 @@ __smb_send_rqst(struct TCP_Server_Info *server,
int num_rqst,
        if (rc < 0 && rc != -EINTR)
                cifs_dbg(VFS, "Error %d sending data on socket to server\n",
                         rc);
-       else
+       else if (rc > 0)
                rc = 0;

        return rc;
--
2.7.4



-- 
Thanks,

Steve
