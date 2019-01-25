Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B019C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2062192C
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 08:08:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbfAYIIy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 03:08:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40313 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfAYIIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 03:08:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id s5so7755611oth.7;
        Fri, 25 Jan 2019 00:08:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e3bX8SHo3SdDyffa9EWiK+Ks58vkW8Bsn9OQwm91QoI=;
        b=SUz7NvDznmU/IvU7D5TvjDvIi6JTt1UJEj9xszhIAxq89K7n8NZ46CH+Cc+RjZksGb
         6/zJtwVWOwoX71/20xIf5Ie6WzQ9NGTMHm793sBWZTFgsp/1EkpyuE+QqSqBTDJYePN1
         52YJvAMrvOwd1YrKj2WqA3AA4pywmbOAenoJ2lzqpq+OHPU+JDQmtPQkriZj5EWmxaB+
         AZbRgvSyddcVfHJz4Qk1lYw1GCTmH0r+1IbOBPX5qypqrpQt/Ox8Wu4uR5IHG0Qas6VN
         Pu10FVSAHsCHNOQYcWKuV4pbNQutztgZ0hAessNpBruSMIkZUTmOywNu7Pr/5UrSFtsQ
         3w1w==
X-Gm-Message-State: AJcUukfv9s3XznHFxlpQNhrZ3X+4hlw3CWDZu6V9TWBjo00Bri8vxtpS
        fjmZebMFuUnlP+fdKU87U2daoZ4YC6fpCEcKPUI=
X-Google-Smtp-Source: ALg8bN7DdmcZdDzl/1cGYHTAqaFKsG3VxRmZs235iDugDWfFaC0LiasKA+FpXFv1JaW2NeJJ3iLrP/TWX2IwQ5mdhGY=
X-Received: by 2002:a9d:7503:: with SMTP id r3mr6562691otk.281.1548403732785;
 Fri, 25 Jan 2019 00:08:52 -0800 (PST)
MIME-Version: 1.0
References: <20190124180724.20910-1-malat@debian.org> <3DC0DB52-E3B0-42F3-BD4D-913FD77EDFBB@holtmann.org>
In-Reply-To: <3DC0DB52-E3B0-42F3-BD4D-913FD77EDFBB@holtmann.org>
From:   Mathieu Malaterre <malat@debian.org>
Date:   Fri, 25 Jan 2019 09:08:41 +0100
Message-ID: <CA+7wUswPXAbsrNOUDUN4GMof7oV8pbxfcWLxXXZdx7DnBd4U5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Bluetooth: Annotate implicit fall through in l2cap_config_rsp
To:     Marcel Holtmann <marcel@holtmann.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 8:56 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mathieu,
>
> > There is a plan to build the kernel with -Wimplicit-fallthrough and
> > this place in the code produced a warning (W=1).
> >
> > This commit removes the following warning:
> >
> >  net/bluetooth/l2cap_core.c:4223:6: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >
> > Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> > Signed-off-by: Mathieu Malaterre <malat@debian.org>
> > ---
> > net/bluetooth/l2cap_core.c | 1 +
> > 1 file changed, 1 insertion(+)
>
> the patches don’t apply cleanly against bluetooth-next tree. Please fix it up and resend.

Never mind, both warnings are already fixed by:

6317950c1b9c Bluetooth: Mark expected switch fall-throughs

Sorry for the noise

> Regards
>
> Marcel
>
