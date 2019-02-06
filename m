Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68FDC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB2D218A1
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 07:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qj7E/kH8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbfBFHjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 02:39:43 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35597 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBFHjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 02:39:42 -0500
Received: by mail-wr1-f46.google.com with SMTP id z18so5617655wrh.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JoJ6HF/m7Ezs89fXyzg0J7G8YI6H3WnNexxE+t1KKEc=;
        b=qj7E/kH8+CQ8gmwhcht31zdxo9/fLxip08wq52w+78DsB/yjrZlrJnDeKSI9vmrz9+
         oaeD5o0QGYpiMfzMzUp7cylEXFpbaV6K7ihyGtneMsW0Gkj0m9+vQ+TKex6Zv+0d3vO6
         EHynKQRNNR0FWbzt6Qz5+fPE35rEPlqbqoiuackocK9x0nv8beaPJnhp9sJ5XMWX3g+W
         9wFi9QPu9PEer2NHJ27P3SG9+wKluMiQQvZtxiYFLCK5qAtxcpDu4t07hyBlEIsZDXWO
         7q8ZFS4Fhv9dRi7MRisPIgIA1ge4pr+z4qXxJd/V/uP9QVetGlHEzOuU0OKnht8Rq3Et
         RrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JoJ6HF/m7Ezs89fXyzg0J7G8YI6H3WnNexxE+t1KKEc=;
        b=BaYFBZsAc5xCWlNqQztfYTyOsKu/ErnKt6QYMQP0eqZ7VgwEwyhCMv1mNgBXQzqyxa
         8i66/gyVmatO6g0tnXOGomBwfavueue5HnAvwuobe+rv2YcIc27uB+Pk4iTidbrbFzWF
         8NDnvho8Fz569/VqaLx9QeHhcpsG57meedUmy++BFGP02hylq1DrRDFR101ApFLcE9UT
         ruZmYchGRiw0G0f9LuzoI/LB2Qi0jDSkarB23oPITT5xgQyceUpuxTmBAGfherucsUW/
         5lf87sBE6lQk2IrxbgO0iI26EDdxYcccOoAbc5DzMLOFsoG49Kc3mNADh6FnNQzyGfwG
         HdTA==
X-Gm-Message-State: AHQUAub9QcW2vKXfoUrd+Fz3AZ4X3ghzlWDAZGlJKhsPM2nryGM+7LN+
        2q/nFiDxHMiJwgwTLZnYoMq2QiM=
X-Google-Smtp-Source: AHgI3IaMej458uyYcgd68T8TdxbSrLMxBtqotZsHBn0AFjBDV80ce5WKYf6qcomz61u3i4ozDp57Mw==
X-Received: by 2002:a5d:6710:: with SMTP id o16mr6953067wru.152.1549438780975;
        Tue, 05 Feb 2019 23:39:40 -0800 (PST)
Received: from avx2 ([46.53.242.9])
        by smtp.gmail.com with ESMTPSA id x186sm31090631wmg.41.2019.02.05.23.39.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 23:39:40 -0800 (PST)
Date:   Wed, 6 Feb 2019 10:39:38 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH -mm 2/2] proc: use ramfs for executable generation
Message-ID: <20190206073938.GC15311@avx2>
References: <20190206073659.GB15311@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190206073659.GB15311@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tmpfs is under CONFIG_TMPFS which can be disabled.
ramfs is always enabled.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	fold into proc-test-proc-maps-smaps-smaps_rollup-statm.patch

 tools/testing/selftests/proc/proc-pid-vm.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/tools/testing/selftests/proc/proc-pid-vm.c
+++ b/tools/testing/selftests/proc/proc-pid-vm.c
@@ -20,7 +20,6 @@
  * Test /proc/$PID/smaps_rollup
  * Test /proc/$PID/statm
  *
- * FIXME require CONFIG_TMPFS which can be disabled
  * FIXME test other values from "smaps"
  * FIXME support other archs
  */
@@ -58,7 +57,7 @@ static void make_private_tmp(void)
 	if (mount(NULL, "/", NULL, MS_PRIVATE|MS_REC, NULL) == -1) {
 		exit(1);
 	}
-	if (mount(NULL, "/tmp", "tmpfs", 0, NULL) == -1) {
+	if (mount(NULL, "/tmp", "ramfs", 0, NULL) == -1) {
 		exit(1);
 	}
 }
