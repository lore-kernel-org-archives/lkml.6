Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B64BFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E0C208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7BtENGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E0C208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933964AbeFLReZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:34:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933076AbeFLReY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:34:24 -0400
Received: from mail-yb0-f175.google.com (mail-yb0-f175.google.com [209.85.213.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD0CD208B4;
        Tue, 12 Jun 2018 17:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528824864;
        bh=1jTI0VVCmQNWbclT8NxkA1tKVxibFIIhkKD2B7EgAcA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=F7BtENGj5dTr5deopeYEvqMsKigp12e0OadwarN9xyVWuSfcWcsw7BZCo58QccJ6p
         ohfRHsMVqSWUI1GRD2i/RHgDkNf4sorsXjVwOdhznl6rFRkc8B2OQu1ywngRIwEaEL
         RrpO7Y58wBKAwXqvVw+7wdPVbhKOV1EFXodnWS94=
Received: by mail-yb0-f175.google.com with SMTP id d123-v6so8215935ybh.9;
        Tue, 12 Jun 2018 10:34:23 -0700 (PDT)
X-Gm-Message-State: APt69E0Z5Q6ldUH+KVYIVMNg/Sw/jcF8hBMYeWV1fnGkmW4U23W89prv
        A1AeO1guNQtz7pfHoEhlX/aKwj3anX8tEZyOtqY=
X-Google-Smtp-Source: ADUXVKKk+cPSuOa76ozTy2oxIBsDQsPG5YUUezauIgQrDV6RRAK97ZVQYd90HpE1Zblh6c3qmQt0O1JXlVbrexwqzNg=
X-Received: by 2002:a25:40c2:: with SMTP id n185-v6mr677691yba.122.1528824863084;
 Tue, 12 Jun 2018 10:34:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:b87:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 10:33:42 -0700 (PDT)
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
From:   Alan Tull <atull@kernel.org>
Date:   Tue, 12 Jun 2018 12:33:42 -0500
X-Gmail-Original-Message-ID: <CANk1AXSPd10twvT0tXKBxb9Cc2bK_TrVdZ6gnLKkB_ujCcD8wQ@mail.gmail.com>
Message-ID: <CANk1AXSPd10twvT0tXKBxb9Cc2bK_TrVdZ6gnLKkB_ujCcD8wQ@mail.gmail.com>
Subject: Re: [PATCH v6 00/29] FPGA Device Feature List (DFL) Device Drivers
To:     Wu Hao <hao.wu@intel.com>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 5:10 AM, Wu Hao <hao.wu@intel.com> wrote:
> Hi All,
>
> Here is v6 patch-series adding drivers for FPGA DFL devices.

I pushed this patchset to a branch on my linux-fpga kernel.org git
repo for the robots to test.

Alan

>
> This patch series provides a common framework to support FPGA Device Feature
> List (DFL), and also feature dev drivers under this DFL framework to provide
> interfaces for userspace applications to configure, enumerate, open, and
> access FPGA accelerators on DFL based FPGA device and enables system level
> management functions such as FPGA partial reconfiguration, power management
> and virtualization.
