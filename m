Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7312C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D7121872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rydal-org.20150623.gappssmtp.com header.i=@rydal-org.20150623.gappssmtp.com header.b="RJ+akumZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfAXRjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:39:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36471 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbfAXRjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:39:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so7443613wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rydal-org.20150623.gappssmtp.com; s=20150623;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=L7e8uvGltUrkZabQxuZGKsrr86dgVMdBKYMIiDAJleY=;
        b=RJ+akumZSoy7kSyUgEp6kMLvGXjs2idSj6pm5Z9YuJuVCAfAnYHQBhLmgyiu+0l2Jg
         i02ZXUAxMT/QigebjmCLzSThUWOm56z8dmFXWVSyIU2VnColzuziu56xtskWzL23rZTL
         OJguUhhlA2TsJF7mf/ANEH5ledWLMwOBH3K5co/BH0w8LxnY67BN+8R43YPJaDrGir9Z
         XLbc2G58x9rDEVjB4A4+RimXK+HQOmDE8VG8fvHjGxl+4QDDm2oEGMlvq7Gz6oCfr0en
         X6AAwdxNp3sekhBznsvICVGH2JbR+CfLWnbwiu1aoS3p8nNcXWoiYtwMaawbw2s5Lb6V
         iHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=L7e8uvGltUrkZabQxuZGKsrr86dgVMdBKYMIiDAJleY=;
        b=qvO6HaSgRJPjd9N899H8azxCWAuS/6E7CYD7FNGL0m6xJR5Z3G+BAZSJKtYWlmTCpO
         REOyiaIVGeJmXELDSqxOuIo49s1wd0sw/MTiA9xKaNbY6aKqUHA+D/tvohEll/OvcE8o
         byDF33qQVUgkNprUo/hKxI+t3mcX5h+2CJGR83ECtv/DwEBeRvseLmAOacwH0jGgOEp9
         L1cdq5Bjji4IJkskcsXDlZgsXOoA9YAmVYEy7CiSJtU6Girr4M73omcIf9qmCz/26C9T
         FAVWgqc2kz/vkdcIlEb2ewtLIvaOqy6NsNeJUA3MgF7Q6+L/HRHE/dTcIzCC4sIyEGXw
         7yNA==
X-Gm-Message-State: AJcUukd4EzokVm12v9fVg/lvw2rPRlQ76iHi801zNEcu0MT7b7bf8Wsn
        Bnuvl6fYJ+pDUij0OiuYhvZJA2+JbxY=
X-Google-Smtp-Source: ALg8bN4OpFGwVjvBTLSXBSqW7u7sUJOY9flJZkpP0kVYL7z65JAbvGQzY4gjvk7Ox9EHC7e4xceYuQ==
X-Received: by 2002:adf:dec4:: with SMTP id i4mr7865312wrn.307.1548351590192;
        Thu, 24 Jan 2019 09:39:50 -0800 (PST)
Received: from [129.12.129.161] (stu81A1.kent.ac.uk. [129.12.129.161])
        by smtp.gmail.com with ESMTPSA id s1sm150588127wro.9.2019.01.24.09.39.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 09:39:49 -0800 (PST)
Subject: Fwd: Fwd: Tuxconfig - automated linux kernel module installer.
References: <ed407815-5b61-e1e6-373a-c677a590627f@rydal.org>
To:     linux-kernel@vger.kernel.org
From:   Rob Brew <rob@rydal.org>
X-Forwarded-Message-Id: <ed407815-5b61-e1e6-373a-c677a590627f@rydal.org>
Message-ID: <c430c45d-16c0-4867-efa1-908b8085fbbc@rydal.org>
Date:   Thu, 24 Jan 2019 17:39:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <ed407815-5b61-e1e6-373a-c677a590627f@rydal.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi everyone / Linus

For my Master's dissertation at Kent University I've built a platform
and GUI to automate the process of submitting kernel module
configurations and installing kernel modules from those configurations.

Developers submit kernel module source code including a special file as
to how these kernel modules are built.
End users have a graphical way of installing said kernel modules, as
well as upgrading them and uninstalling them, and recovering failed builds.

Think of it as a Ubuntu restricted drivers app enhanced by allowing
anyone to contribute a git repository for others to install, or the
windows "install new device" process..

It's a proof of concept, and does need some work in order to be a final
version.

https://github.com/rydal/dissertation-doc
<https://github.com/rydal/dissertation-doc>is the dissertation document,
with readme.md defining what it does.
https://github.com/rydal/tuxconfig-backend
<https://github.com/rydal/tuxconfig-backend>is the back end written in
Java and JSP.
https://github.com/rydal/tuxconfig-frontend
<https://github.com/rydal/tuxconfig-frontend>is the front end written in
C++.


What i need:
In order to prevent malicious code and Trojan horses the platform will
need a team to vet each contribution to ensure binaries come from
trusted sources and Makefiles aren't damaging to the system.

The package and website for those contributing is at
https://www.linuxconf.feedthepenguin.org/hehe/


Features which could be added:
Change the udev rules to make the application run every time a new
device is inserted
Harsher recovery when adding Linux packages.
Cryptographicaly signing the get and post requests to ensure they are
from the application.

I'm happy to work on this concept, as well as moderate the git pull
requests.

Thanks,
   Rob Brew.


