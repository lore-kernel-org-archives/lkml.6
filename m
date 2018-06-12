Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 774E7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:58:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A894208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nNP1PcUq";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dQhV6wfG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A894208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754255AbeFLK6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:58:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:38862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753932AbeFLK6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:58:14 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 189D960791; Tue, 12 Jun 2018 10:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801094;
        bh=FyIqBS3SuhLSDTqjHpZta3pco6zqrorJJZSZlCmGdO4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=nNP1PcUqHg6nAPX1Y8THK2h5DA+cZZGXk+NcxdZEJndyCu3ixnwGa2ypj4bSR/DvZ
         DQvbX85S1uFVP9rUotapVd4Ln8BC1t0Tpw5XiTuskyegXTO5ez8bXyRphzj8Mn0v7+
         Jt0h+HL1+gx7o9gsG3KWLXo2F9DYcjCX1CN5DYpU=
Received: from purkki.adurom.net (purkki.adurom.net [80.68.90.206])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E792A601C3;
        Tue, 12 Jun 2018 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528801093;
        bh=FyIqBS3SuhLSDTqjHpZta3pco6zqrorJJZSZlCmGdO4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=dQhV6wfGn25IlKa7Ro4xoYOYrMN6bfRJy25BYtyzSaY1MCLoKpQCRtt/KaSRY//OF
         06n9z3hGfydt3xngf9/wI4QZBOtQqG3NiBfO0vKlZpmJwTaGP9tEO0bsEOktJ6E2TY
         Nym34fsD+L+UtTGit3FKozbeOEeMEC4GjXjbEHaQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E792A601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     torvalds@linux-foundation.org, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 2/4] ARM: Device-tree updates
References: <20180612000142.28883-1-olof@lixom.net>
        <20180612000142.28883-3-olof@lixom.net>
Date:   Tue, 12 Jun 2018 13:58:10 +0300
In-Reply-To: <20180612000142.28883-3-olof@lixom.net> (Olof Johansson's message
        of "Mon, 11 Jun 2018 17:01:40 -0700")
Message-ID: <87efhcb7b1.fsf@purkki.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson <olof@lixom.net> writes:

> - Qualcomm:
> + SDM845, a.k.a Snapdragon 845, an 4+4-core Kryo 385/845
> (Cortex-A75/A55 derivative) SoC that's one of the current high-end
> mobile SoCs.
>
> It's great to see mainline support for it. So far, you
> can't do much with it, since a lot of peripherals are not yet in the
> DTs but driver support for USB, GPU and other pieces are starting to
> trickle in. This might end up being a well-supported SoC upstream if
> the momentum keeps up.

The wifi chip is called wcn3990 and we are working on supporting that in
ath10k. I'm hoping to get it ready for v4.19.

-- 
Kalle Valo
