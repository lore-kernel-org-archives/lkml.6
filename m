Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7C0C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:11:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D34F020658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HGujveEo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HGujveEo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34F020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbeH3VOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:14:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58782 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeH3VOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:14:36 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6C52A60452; Thu, 30 Aug 2018 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535649089;
        bh=COJAtFpUsM2EyKcJvfsmr4OSAIdGsTbBhYNeVnLGMKM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=HGujveEoGdcfMSmgop+Pl3fT56dOmftdNjc/rqRko9GWf4sPcBlSjmLmFqn4wj0eW
         Q40HzfiwUTz4g1gaRG6YmvY5QwzIhW7WrRxMbxMeAFCDJ5aFN7bgWEbiOfiE+xGAtP
         qzi/BClYEaRp+V88Qip4DH8vYCUDsNZt8YRtktK4=
Received: from WUFANW10 (c-71-205-14-210.hsd1.co.comcast.net [71.205.14.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wufan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AD22460445;
        Thu, 30 Aug 2018 17:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1535649089;
        bh=COJAtFpUsM2EyKcJvfsmr4OSAIdGsTbBhYNeVnLGMKM=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date:From;
        b=HGujveEoGdcfMSmgop+Pl3fT56dOmftdNjc/rqRko9GWf4sPcBlSjmLmFqn4wj0eW
         Q40HzfiwUTz4g1gaRG6YmvY5QwzIhW7WrRxMbxMeAFCDJ5aFN7bgWEbiOfiE+xGAtP
         qzi/BClYEaRp+V88Qip4DH8vYCUDsNZt8YRtktK4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AD22460445
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=wufan@codeaurora.org
From:   "wufan" <wufan@codeaurora.org>
To:     "'Tyler Baicar'" <baicar.tyler@gmail.com>,
        "'James Morse'" <james.morse@arm.com>
Cc:     <mchehab@kernel.org>, "'Borislav Petkov'" <bp@alien8.de>,
        <linux-edac@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'arm-mail-list'" <linux-arm-kernel@lists.infradead.org>
References: <1535567632-18089-1-git-send-email-wufan@codeaurora.org> <c70fa799-bc9f-64c8-e151-088ca8c3ed3e@arm.com> <000f01d4406f$6ce8f160$46bad420$@codeaurora.org> <1ac15a80-6f9a-cf9d-8e79-37d10549a4ca@arm.com> <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
In-Reply-To: <CABo9ajDf09BHsq0NOs99NSD6zOV5N-CDvgvQrGi9p_wLjpJ24g@mail.gmail.com>
Subject: RE: [PATCH] EDAC, ghes: use CPER module handles to locate DIMMs
Date:   Thu, 30 Aug 2018 11:11:27 -0600
Message-ID: <001301d44084$7dc63730$7952a590$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHcLsFbwflxxBzVeG17JegIRw3gmAF/6qNxAafQzrECfu/PJgJ4vCZXpIevo/A=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tyler,=20

> > Is printing the handle to the kernel log critical?
> >
>=20
> I don't see why we would need this print. The bank/device print is =
enough to
> map what is shown in dmesg to an SMBIOS entry if that's really needed.

This change is mostly for convenience. I'll revert it since we have two =
votes
against it now.=20

Thanks,
Fan

