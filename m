Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9A6C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF54F2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vHGXjSbc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfBEGA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:00:59 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37012 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfBEGA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:00:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so973607pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=UwXJ5fcbDek9cKk6Y8sH/rqvHx/66Nk6tKGazZE2Lfg=;
        b=vHGXjSbcjhw9yoaeGFUJi6IasmyaOwdZpX/aAyBBBKfrQiioLL6yQ1bVvGI2UbhS1H
         +pbOUlZxMblWA37UBgtm9UrQcGkA/zYvEINvTUWnT/IsAfOsc70c9UKr+3zHb5XDD0Wf
         +MC2/UWrhwVFpLXAEq3ewXNFmTUG3ihzus2jcZ4YiGJxlE2VsEWxnMOINxdI3qLMVUgE
         fv9J0IviPkqa0Ugg988rFZOuG5T9bmPz0cqaEFDA8YujumgZBGrdf+AxFUwLMNU9IyyY
         oXE9YEiQ1W4ll3nCM1uW2MB5Ud/Uu/fUa7+VNo+LHTEW7+NOf1dzzockzDUVQH7eJfXa
         PXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UwXJ5fcbDek9cKk6Y8sH/rqvHx/66Nk6tKGazZE2Lfg=;
        b=fWFE2v9CKBB05aqc7M95CxyJfhpoSmZAA3fqYs5kp7f+qf/cBVO2llhv20maYTlmHJ
         17Z6fJcP+PXdmR5PsMANK/XcCPFYzdpAAfS9ddSO5La2i+uTHFdYVJHd2OxG/gfGHsoh
         hIbSvin4qQ8pek/ri7xafahmMet2IyleRjfScR7Dl19eZSDn/vEZcYQYSmj35wx6eOWc
         ovEhqM1dSfsz8MluwC6HPjdQxTwr/pOcDM/HYQuB66lGbD2zwnZuitkP0TZCMYK7GKDE
         XveNaMe9DLemQzsXkklaSMRPqCsU1fctx4IheIKCOyrOJn3Jgf+jE0LkePos8gAnQGlQ
         SLTg==
X-Gm-Message-State: AHQUAuYV1+SPHk+DVdp+D3X4AkoDyeT0eALZYahpbFGiLAdajm7F6Hdl
        x9VK1t3QIS5U0wShjhpDdM8UTDBk
X-Google-Smtp-Source: AHgI3IaqvyjzrXspJ0+p7R86vIe7ObCP4aFp7Ocdf2h8kQXPxc1MdKnyqmMcgOFTyf9tBqCb5mzpAw==
X-Received: by 2002:a62:1043:: with SMTP id y64mr3347339pfi.78.1549346458115;
        Mon, 04 Feb 2019 22:00:58 -0800 (PST)
Received: from bharath12345-Inspiron-5559 ([2402:3a80:d1b:825c:11ee:4c9c:a227:c021])
        by smtp.gmail.com with ESMTPSA id a17sm2519928pgm.26.2019.02.04.22.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 22:00:57 -0800 (PST)
Date:   Tue, 5 Feb 2019 11:30:53 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     kernelnewbies@kernelnewbies.org
Cc:     linux-kernel@vger.kernel.org
Subject: make modules_install install is failing
Message-ID: <20190205060053.GA309@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am unable to execute make modules_install install. 
I get the following error:

ln: target 'linux-00096-gd1aa1a8/source' is not a directory
Makefile:1281: recipe for target '_modinst_' failed
make[1]: *** [_modinst_] Error 1
Makefile:296: recipe for target '__build_one_by_one' failed
make: *** [__build_one_by_one] Error 2

I made a change to a driver and did not commit the changes. I then built the kernel and two weird looking files appeared in my root directory:

linux-00095-g94832d9-dirty
linux-00096-gd1aa1a8

Since then , I have commited my changes and made the kernel again. The
dirs still exist. I have tried manually removing them but they reappear
 whenever I make the kernel again.

 I am running the version: 5.0.0-rc2+

I am not able to make the kernel modules because of this. Is this a
common problem? Any answers?

Thank you 
