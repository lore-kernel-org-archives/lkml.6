Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26E1C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E9A206B5
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8VVZijn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E9A206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbeIMMfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:35:53 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33350 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeIMMfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:35:53 -0400
Received: by mail-io1-f68.google.com with SMTP id r196-v6so2384249iod.0;
        Thu, 13 Sep 2018 00:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zrv5i3ovCbSX9VpdzBWY8crb5wYLyNZNx4+GriZAa7M=;
        b=j8VVZijnj0TZBfT3rCetrUqWDeteOCMCvpI8IDBvzFJJi1cgMIhX36rFXWe8FRGk/N
         V/vutWIi1oe8LtX/Lnl1WOqj1ObiRQj1Fl2PlROYX/zOhVg/5EPcFPnPfZoOMAI4jImB
         LyFyYX/z6YBuxw6+4D2e3Hdy0a7j/AaDT0K+UF8JAU95BHGu5UB7DU2dWZ64XU9lczST
         7By2juCfggzODqRHlrKxE8Rb3o9FNS+5Zx09rNvf25G2iv6eKTl5CdNglZ3PKoOQRSie
         oBXgKos7GBqVzzzvIAaHwoH+Pj/hOBdan0Ie+GYZuInWKwnSghggqKmYcGETon5/yX2b
         A88Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zrv5i3ovCbSX9VpdzBWY8crb5wYLyNZNx4+GriZAa7M=;
        b=YcJ8IUA+yGDk5dICmAWuIkSlLI2Mvuw9u0o03CaSwd5oF/krZsVtKTdlQxzAySvWD/
         LLUCkruc18D4pg9AcyMNnF7/cJIQBENdKecb/2dYlzdT91yVO6BtNvoE+g8vL1kxueeO
         IdDH+4TDc6L68rS6stYkc7Jiwy09/7WdnCkFvYx/ujFe9prJ07yc2sOkROFp6KWz+f3p
         tOpj4bwi74EzvQ/hpRgjQ6GRlEgI1jxoWws4KHl7lRR2PsrWkZGEiygN6H4rnCDUBUwS
         2SNVBrmGpv5JpzGg34GswkGsp3SWkZOt3FzR0161gDEzALM6m8VVxszKGEigqKQT211X
         /AWA==
X-Gm-Message-State: APzg51DWpdu1stUrbOYu0FW0ODOXtIMfd3YNUV+k5gSPKA3grV0Kxckn
        oF+jIShlxDDjSUBbbZfV4hxzjkTaJVFholnx7RQ=
X-Google-Smtp-Source: ANB0VdbCL3RcdvKUzzFqLl6Nz5c5r+NizI1cmpqh1iVdWAqKDQ4xPwoGvYdnFhhpQ7VQuCiIn84EiHCVqb2S1xVa6Yg=
X-Received: by 2002:a6b:d611:: with SMTP id w17-v6mr5108255ioa.216.1536823659293;
 Thu, 13 Sep 2018 00:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180906192644.24587-1-angus@akkea.ca> <20180911145931.32441-1-angus@akkea.ca>
 <8A418EC6-62A4-4354-8928-7693696409D1@gmail.com> <9d7431e51aa069f288dd4bf39e9db9f1@www.akkea.ca>
 <20180912163259.GC3300@roeck-us.net>
In-Reply-To: <20180912163259.GC3300@roeck-us.net>
From:   Peter Chen <hzpeterchen@gmail.com>
Date:   Thu, 13 Sep 2018 15:27:28 +0800
Message-ID: <CAL411-qmQ23=hfXX3s5Zo100rSASrByMWR70qLZ8cWqt9hPgSg@mail.gmail.com>
Subject: Re: [PATCH v3] usb: typec: get the vbus source and charge values from
 the devicetree
To:     linux@roeck-us.net
Cc:     angus@akkea.ca, Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        peter.chen@nxp.com, jun.li@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:35 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Sep 12, 2018 at 10:08:58AM -0600, Angus Ainslie wrote:
> > On 2018-09-11 09:33, Guenter Roeck wrote:
> > >I cant put my finger on it but this seems wrong. As i said both src
> > >and sink should never be true at the same time. I also din=E2=80=99t
> > >understand why turning off src should power off your board. Ultimately
> > >my concern is that we may be just painting over the real problem, and
> > >that would be really bad to do with dt properties.
> > >
> >
> > I agree that this doesn't seem like the correct way of solving the prob=
lem.
> > On this HW (Emcraft iMX8M BSB) I think the PTN5110 chip has been connec=
ted
> > correctly so I'm assuming that it is some quirk of the PTN5110.
> >
> > I didn't design the HW or the chip. This is a workaround for "quirky"
> > hardware and there may be others that don't behave exactly as expected.
> >
>
> I wouldn't be that sure about that. It may as well be that the tcpc drive=
r
> and/or the tcpm driver are doing something wrong when initializing.
>
> I didn't really understand the logs you sent out earlier. It looked like
> the system would loose power if the TCPC_CMD_DISABLE_SRC_VBUS command is
> sent.  That doesn't really make sense to me since it indicates that the
> chip sources power to the remote, and turning that off should not result
> in a local loss of power.
>
> Note that the chip is supposed to be able to report if it is sourcing vbu=
s
> and if VBUS is present, in the POWER_STATUS register. Another question is
> the content of the ROLE_CONTROL register when the system boots, and the
> DEVICE_CAPABILITIES settings.
>
> Overall I suspect that we don't handle startup for your system correctly
> in the tcpc driver. The ideal solution would be to find a solution which
> does not require any devicetree properties, but to do that we'll need
> to get a better understanding about your system's requirements.
>
> Guenter

Hi Angus,

Would you please check if below patch can fix your issue?

staging: typec: don't do vbus source disable for dead battery

In PTN5110 design, DisableSourceVBUS command also disables the sink
enable signal because the EN_SNK can be used to source higher voltage,
and, there is only one TCPC command to disable sourcing voltage without
telling whether to disable 5V or the high voltage, and to keep the
design simple they designed the PTN5110 to disable both. with this
fact, we use the flag drive_vbus to check if the source vbus enable was
issued, if yes we then do vbus source disable, in dead battery case,
we never did vbus source enable, so will not issue vbus source disable
command.

Acked-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
---
 drivers/staging/typec/tcpci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/typec/tcpci.c b/drivers/staging/typec/tcpci.c
index 2d4fbb8aac5e..7352207224b5 100644
--- a/drivers/staging/typec/tcpci.c
+++ b/drivers/staging/typec/tcpci.c
@@ -381,9 +381,8 @@ static int tcpci_set_vbus(struct tcpc_dev *tcpc,
bool source, bool sink)
  struct tcpci *tcpci =3D tcpc_to_tcpci(tcpc);
  int ret;

- /* Disable both source and sink first before enabling anything */
-
- if (!source) {
+ /* Only disable source if it was enabled */
+ if (!source && tcpci->drive_vbus) {
  ret =3D regmap_write(tcpci->regmap, TCPC_COMMAND,
     TCPC_CMD_DISABLE_SRC_VBUS);
  if (ret < 0)
