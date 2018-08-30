Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934BFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5087820837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alU9K9Pl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5087820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeH3Vfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:33 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34269 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeH3Vfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:32 -0400
Received: by mail-oi0-f68.google.com with SMTP id 13-v6so16913369ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=k+UszutxvUCwPJTXFQ34iRyWW1CYVNt3QJc2CwBhr3k=;
        b=alU9K9Ple46odKFkwG/b9KaEjQn5cTsxoWaVGukFIBuFl4b31nxOyB5PsnkRv0lSdI
         ed0g9MXorZP9JZ3bhWyBvASI8pEgAVX5Lep//gFflnMMyFn0ek4I4mowqqo3bBm+OKXo
         gi5bZ5GHJ4qADNihma25TVdD/L8ELIVcfv971us1nFgQnJy3lp5+kKIO+zJ8BOa3H9KA
         5PONUWLoEYQqjOd/Tb3k/vCh7s/JJrrQs+MyNPjnooBw7zjDh406NXkXJPt/lONC3sBe
         atAbBYnnjETnoOkoGs57snKq7BrugmxN51OZt6K7xsrNlFovczXrypUZJqnU0EcRN493
         sEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=k+UszutxvUCwPJTXFQ34iRyWW1CYVNt3QJc2CwBhr3k=;
        b=WfHwx7fgg+ua8tD4g1FOxiwweUs13F4f/iOo/3KDTldN3+B0BqfnP1Aoy9JoFtqFNl
         SsRspcGu5xSQJ0EUzSPN/PRc04d1bg/jmFhKRwYFq7ujmLnDO4c1zvTF2YnRXAZAbyRg
         by0+NWz+0JpRoCxJQOzQ70qKmK6IwEeUo0A5nk7SGYyL3NrC4L6GRtTpEpbK9XELdRaj
         nqa2zxn2LvnW51Ry/br2KZBoDcL59+cJL0hYx08cjJDK199HLuip+X/I10Qfv4toQM6i
         8fhlDP4Xr4u2XwS0lkZvT2Ybad6rwyAjNOnhEyUuKP+D2fXdBVRWCVyOd+WBw1Ljy055
         5GeA==
X-Gm-Message-State: APzg51ClSl0OP2gLAWNtVEaSiwhuKEak/0v0mVgDm/3uNNm9R5BT3d6g
        bwqr576wmf2uW8Pe4Lg30u+o/FIq6C+oDCimTdw=
X-Google-Smtp-Source: ANB0VdalI5UB7lHPK9WwVXo5kXCAT7fRO3EpUXiQtCokr7zJ0lOmj4ch+nBJ9kA14Qfo38DbyToKHLc4XyEtkqAuVGU=
X-Received: by 2002:aca:d452:: with SMTP id l79-v6mr3287402oig.222.1535650340717;
 Thu, 30 Aug 2018 10:32:20 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 30 Aug 2018 13:32:17 -0400
Message-ID: <CAPMnawsnkBnRM--55G7tgJtZFKyn7VsCbWQ3jxssehznhA=_Kw@mail.gmail.com>
Subject: [PATCH 2/4] staging: comedi: Correct multiline dereference as per TODO
To:     greg@kroah.com
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using checkpatch.pl I was able to find a multiline dereference which goes
again the coding style for the kernel. I'm still working on my email client so
the indentation looks bad here (in gmail) but the arguments for
comedi_check_trigger_arg_min should go just under the opening (

Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
---
 drivers/staging/comedi/drivers/ni_labpc_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_labpc_common.c
b/drivers/staging/comedi/drivers/ni_labpc_common.c
index 7fa2d39..0fad809 100644
--- a/drivers/staging/comedi/drivers/ni_labpc_common.c
+++ b/drivers/staging/comedi/drivers/ni_labpc_common.c
@@ -560,10 +560,10 @@ static int labpc_ai_cmdtest(struct comedi_device *dev,
        /* make sure scan timing is not too fast */
        if (cmd->scan_begin_src == TRIG_TIMER) {
                if (cmd->convert_src == TRIG_TIMER) {
-                       err |= comedi_check_trigger_arg_min(&cmd->
-                                                           scan_begin_arg,
-                                                           cmd->convert_arg *
-                                                           cmd->chanlist_len);
+                       err |= comedi_check_trigger_arg_min(
+                                                          &cmd->scan_begin_arg,
+                                                          cmd->convert_arg *
+                                                          cmd->chanlist_len);
                }
                err |= comedi_check_trigger_arg_min(&cmd->scan_begin_arg,
                                                    board->ai_speed *
--
2.7.4
