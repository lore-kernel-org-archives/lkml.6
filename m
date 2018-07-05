Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F06C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 089792408C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXuj9fvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 089792408C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754066AbeGEQXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 12:23:41 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40901 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753418AbeGEQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 12:23:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id e19-v6so6607333edq.7;
        Thu, 05 Jul 2018 09:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s+FKHKjtY30TMLue5wlH3XNkrHmd20tOJwyQ/b/ik7s=;
        b=AXuj9fvDM+JBXjKhRWnb2Q9rbRq2hdOtxUHKCR0KDNAxtFkcj/Ink5McjF/aJao1yB
         e/669Q52+EwbwOkrNb5a3pklVvixnlQmcG7KDbIqJJ5RCKgy5uPwFTfQioIikvEexSiI
         TdVwNpG3c86NkKajwUelCanKbgZSIgYSsQslMo1k9S1ZgfwmLWJCLTY7CM3PpALxIId8
         UmkIr8NQ8OjUFma86To76kJ8SYyJnXFAav0AZb/tiqTVzsGl4P+FW13A8va/h2CC9iDh
         2h5bpOA80wUBgvVC9Pi4TOirZw+ral9ZAqhbYPA337AhHTVtD4bQ9na5vaPPJ5mTpd9u
         owZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s+FKHKjtY30TMLue5wlH3XNkrHmd20tOJwyQ/b/ik7s=;
        b=p8qWWwv1ZWCeSfMDPz9Q5PU0UFdQvVTp0eL4UIOqbzGl+Ll8r5FeVT80y2Gp4hwnPF
         1y06XdrDEkxSSp8wz94IqpcV7/hu5XUkv5qzpTNxN6wd7rYBj/FE59BGNaCpXe2g1PSl
         w1rkK8GZSDPUI3tqGNXPYP5ZC494OkvCVYzrX8NEaSPE71XqBME2NNBilcut6xaqrN63
         Va1yqAzMLExiAaKB1EZHofwvQI6UGeeXLQ+BxJN9F+HArBxpAyMSG8sF2ieF9xlBSxMj
         p4LjeD2VBJe/U8bEiwPdiD9+rFa0BwqnFboQGXlfVtWI9QWf8f+zKkzSUDl1tuqJho5P
         cjHw==
X-Gm-Message-State: APt69E2c6JXmvGmFsWvQcbZ+OG0TuyQoHKusjI/+QMY1hZnv3tL8FLPp
        IbsvXQbUYF3/M5Hw8ePs1AYCMWcTdQ3iJLIt8Ic=
X-Google-Smtp-Source: AAOMgpfO0weRQ9ju/N/VrIefRZpipVI51WX/sMKp2yVfQr5Myh4eA3XNRXtx8Gg66/568l4PcN4Y5tvAtw98XC79/nM=
X-Received: by 2002:a50:e615:: with SMTP id y21-v6mr7451077edm.278.1530807817921;
 Thu, 05 Jul 2018 09:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180703072305.29169-1-colin.king@canonical.com>
In-Reply-To: <20180703072305.29169-1-colin.king@canonical.com>
From:   Robin Holt <robinmholt@gmail.com>
Date:   Thu, 5 Jul 2018 11:23:26 -0500
Message-ID: <CAPp3RGqvCqdzzvjyFV8PFG0nGjmCyxv2B-SspQCwp4-afJ7qGg@mail.gmail.com>
Subject: Re: [PATCH] sgi-xp: remove redundant pointers ch and rp
To:     colin.king@canonical.com
Cc:     Cliff Whickman <cpw@sgi.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 2:23 AM Colin King <colin.king@canonical.com> wrote:
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
