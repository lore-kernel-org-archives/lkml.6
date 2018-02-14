Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3145149-1518623833-2-1660334978491111863
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518623833; b=EaDhZmIQGW0rgyR0MDHx2SVimzNiD1W7KrxcL4lniZGGnwi
    pKNfdaKN33UTzNMtfiIkR1p9xZ8utbkz0migkNZ1v9AQkRCe8NtVBcBjf3/vVB2r
    HTs9USLV9KIlHEb7v6LKkKE9V51RWIAOSDjI1jLjBjL0a/rBg1xerwabedaDIoH+
    hT0wr8n5Ew6xcxfG2mFH8Dm2L2o/KCOfC6Qa0qAluRVQanWKvg5hiOG6Ow5DzjTg
    rh/aBE9TpJ6644ik/OHB4KJWFnl/N4mtzfR8ZFOSmJsONzyT+3fcrJTWEOvYc5Bh
    vyHUMSa1/ZOWQFkmI18Mcp25tRq3hSpgHPRdVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518623833; bh=j0IQmAjSGsxpPEy3fSGsgxauEWRTo/ZT9KlmvX
    5LhSo=; b=kDpYCG/nUNyo/Nw/4JGayb5YR6186sM1m6tF4VKgwfOrBlQcO5lZgk
    AmoJJK2/Nesib0M2049pIdW3ASrqIwCtDRDnys/7ZTGQgSzN24FEV/47zGngWnsH
    gT6SxAGhFsZUlaeDpEME808EdoL1ul1vuI8PrbXbFzwxUDZfLBMZIyfi/adB8BNy
    cljyOzYW3g7MtqvG/rFJ1EHgGHAAa8V03EOu5ZJFjY4IA6pAjFIEMuXo7oxLYk29
    nSxzacAmQ6/G6STIcSk/hIwQ9slDuTj6pKN0D/jp7RdFhWnJrIw0PliEhBGwNM4r
    P9+SVM38giXUD1t0sra6SF5tOj+in3HQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031832AbeBNP4L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 10:56:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031649AbeBNPz5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 14 Feb 2018 10:55:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EDB217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=atull@kernel.org
X-Google-Smtp-Source: AH8x227iFZcYigpJ/rPK+gupjrdD6ehGr2LEeRs7tKyrYBMiBJM05HG8DWiPR2M3k5+SWevzehqmyQkS8yVb25WVEt4=
MIME-Version: 1.0
In-Reply-To: <1518513893-4719-4-git-send-email-hao.wu@intel.com>
References: <1518513893-4719-1-git-send-email-hao.wu@intel.com> <1518513893-4719-4-git-send-email-hao.wu@intel.com>
From: Alan Tull <atull@kernel.org>
Date: Wed, 14 Feb 2018 09:55:15 -0600
X-Gmail-Original-Message-ID: <CANk1AXT4hSSa8j0A2Q=M91jjxDzkNayHZaftnOYSdZoppTMEAA@mail.gmail.com>
Message-ID: <CANk1AXT4hSSa8j0A2Q=M91jjxDzkNayHZaftnOYSdZoppTMEAA@mail.gmail.com>
Subject: Re: [PATCH v4 03/24] fpga: mgr: add status for fpga-manager
To: Wu Hao <hao.wu@intel.com>
Cc: Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, "Kang, Luwei" <luwei.kang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 3:24 AM, Wu Hao <hao.wu@intel.com> wrote:

Hi Hao,

> This patch adds status to fpga-manager data structure,

Please update the header to better describe the current changes, this
patch no longer adds status to the fpga mgr data struct.

> to allow
> driver to store full/partial reconfiguration errors and other
> status information, and adds one status callback to fpga_manager_ops
> to allow fpga_manager to collect latest status when failures are
> detected.

Other than that, looks good to me!  Thanks for taking my feedback.
Alan

>
> The following sysfs file is created:
> * /sys/class/fpga_manager/<fpga>/status
>   Return status of fpga manager, including reconfiguration errors.
>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
