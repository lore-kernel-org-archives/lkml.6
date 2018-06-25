Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A276C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB8725594
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AP2Q8oCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB8725594
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeFYIGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:06:10 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:46732 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752524AbeFYIGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:06:05 -0400
Received: by mail-oi0-f67.google.com with SMTP id h79-v6so11605198oig.13;
        Mon, 25 Jun 2018 01:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=P9R9njFiwMS/c0R54ZR1I673q33WXlVUobwFCEmdKK8=;
        b=AP2Q8oCZNKzmPpFGKMMlr1hI7a3OjPwcoG39f6VMZgJxEhC7w8Ul1K2ilndc3FaFyU
         /H/fIL1DUDPYCTp0Dvlkl0QLuIx6zmlkq0mHAM3VOCQ3ycPTKAYekNGrZuiKGtHsdirv
         +Zc7SCY6+ikU9JWSESAIG2XhhUdEfeUp4cmWRBnP7RNiYv2a5E0ebdzQ0oFgi7kFsffu
         PMo5AmOS551lQvWJtiDa32Nx0OQ6HsAMJXghINcNwJ6bgygwhbbakx60Z/jWvEywTEo7
         i3SBpibuaspdUJxp6t2vZzDoAEY8nkbVnTgQJOEaT8LkFUV7bfkLKd20LVxsUY0Qj9pQ
         JFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=P9R9njFiwMS/c0R54ZR1I673q33WXlVUobwFCEmdKK8=;
        b=PUx3YG+UOrK6+tduQ4NvBET/wCXasNHPzIqv0XkuV38mdTeheOCSDhvEhf99SL4IpI
         enA6Jn+5AutKetywS6tj8wFeAgujFHeryJwwDlRyF+v74+9rZGk/ubVXOAxwcIKn5hoa
         8xI1hUFiyK2ZzHeVxFrRP2jjgXFYPq66jlF+BUmp+qUWj0FeMwR2UZYNDazOlD4VPMTs
         z/Xn4WHZTEh6C39494m5LHfPOP/VWQII5VAtqqX3md5zipfIRtEXffYPAqZS6QjjwDiM
         gKMiXy1N4uw1i4UZTHCRO4ImMoDl4ndQz0SodHTcaJ9q1pUa5PAJ0skJe/rmv1Xkapra
         BOMA==
X-Gm-Message-State: APt69E3sObat/NfEULG0NAwJzxQBHewHMFST3TeHEUKcM967zshPjTId
        Ry9Q5UI3tkpBAAIotAvSHx2ZDj5ULQxwZ/Y+1sE=
X-Google-Smtp-Source: AAOMgpdkJHChnfIaLdMtTZIWgr1eRS3W8ANcw/4d27DHdHt/U9M7IJtMDb/Rho+A0WyzSajD6ssQ8zCUarqnDOenb3U=
X-Received: by 2002:aca:6910:: with SMTP id e16-v6mr6081578oic.358.1529913965139;
 Mon, 25 Jun 2018 01:06:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:06:04
 -0700 (PDT)
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon> <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:06:04 +0200
X-Google-Sender-Auth: FMJKSIn00wHGrNhRlNQnJxwCHfc
Message-ID: <CAJZ5v0j9P6dXM+8qBdgGwfd8diQ4F+hh+QZ8h09y769YYFtEkw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
To:     =?UTF-8?Q?S=C3=A9bastien_Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 10:01 AM, S=C3=A9bastien Szymanski
<sebastien.szymanski@armadeus.com> wrote:
> Hi,
>
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
>> On Tue, May 22, 2018 at 08:28:51AM +0200, S=C3=A9bastien Szymanski wrote=
:
>>> Check the max speed supported from the fuses for i.MX6ULL and update th=
e
>>> operating points table accordingly.
>>>
>>> Signed-off-by: S=C3=A9bastien Szymanski <sebastien.szymanski@armadeus.c=
om>
>>
>> Acked-by: Shawn Guo <shawnguo@kernel.org>
>>
>
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ?

Please do.

> Should I merge them together ?

If they make related changes, you can do that.
