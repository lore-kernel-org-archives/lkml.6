Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D01C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7559D217F9
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 21:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="f0j5qKOs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfBQV6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 16:58:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41088 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfBQV6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 16:58:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id t7so8804674otk.8;
        Sun, 17 Feb 2019 13:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+z25ustYKZCtg4I78gtFQsiSPOzxMV27bUHQ1lAMDcA=;
        b=f0j5qKOsTzQoDBFgbTlpC1DUQife0pLeaLElWfS/0XoK5OoHxe9a4bn/dU+ldWeffi
         zG0KpPeF1m2stiPEz63tbZoH4oU5jIOc293jIxfiDTgR0dZAEC1Li3EIj0RP+hwXEO3p
         q2ZZkpt55VxOISq4ywlgR0gOewA9EqE9Lfr2jLCyUENWdUe0H3IbrijE2GZAtc0da97o
         XOx8DaYxReeKpzvei3qhb6PZ0xApbQptZJcadWIgqTkkoYwzMCdr1sP92zURJmIBXGcY
         3MwRv1z14WmEiNJ+MUhdzzuewu1c8suuTzJumIbHN+0iN1XZys8slzndAm6tkiD89k8H
         DqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+z25ustYKZCtg4I78gtFQsiSPOzxMV27bUHQ1lAMDcA=;
        b=HgoSrqeyoM3kSs4YlyeT6s1MYU5Sm/npL3aACHfo+CqBTrAfWEHHRI2lNU2TK27xCU
         XfA9SV8OAsoTd6gWpon/a+QTB5LUK+sfrJPXT0XZ6CbUqac72QVKbyPAhCuIVy0T/hDP
         RDTQKAzyGLzxyvWDKv1ByVJeffUMMWw+1dUshl6vJw4re3j2tI3//WVZhYFd78wzYgs6
         payEtzm7mvErRyd5kszSbEKe+LZ24u0g5gTbU9FJEF8S+ogG0bKayoRrKmKggiDMDCYn
         rNYCo031hTOOZfOrhVdZF5NnpH0pyb99N1M4NE0V3yzp7IPswrTrKC/sEbNMTJ67xQov
         VY0w==
X-Gm-Message-State: AHQUAuZSAxopIR5UtOF74BWZ5oAKmxRr0N+3/ZbOEYlCa0pdcyLqYwcU
        ouQu+83rQYmGVTD34+XUokXsleid/xx+H3fokHE=
X-Google-Smtp-Source: AHgI3IYsPb4qd04Jf23hSAfbOAJXcF+Rc500WLGUPXkcBqfrVi0dEhyAat/jWW/lvR07y2A7Kq/k948MD+n9k6wLjpo=
X-Received: by 2002:a05:6830:13cd:: with SMTP id e13mr5088250otq.342.1550440728865;
 Sun, 17 Feb 2019 13:58:48 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-2-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-2-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 17 Feb 2019 22:58:38 +0100
Message-ID: <CAFBinCD_n_T=Ho+yB74FW1JP8mCLj0KmHPeDFWne=yfmgd9rqg@mail.gmail.com>
Subject: Re: [PATCH 1/8] dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Add the Amlogic G12A Family USB2 OTG PHY Bindings
nit-pick: if you want to keep "OTG" in there then please add a short
description how OTG works on this PHY.
I would describe this as: "Add the Amlogic G12A Family USB2 PHY
Bindings. The PHY works for host or peripheral modes. Configuration of
the mode is part of the USBCTRL registers which are outside of the PHY
registers."

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
with the patch description nit-pick addressed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Regards
Martin
