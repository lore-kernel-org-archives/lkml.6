Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fcHNIXVzHlsUDAAAmS7hNA
	; Mon, 11 Jun 2018 13:04:53 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 71936607BB; Mon, 11 Jun 2018 13:04:53 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwJ6DP3o"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0CCBA601C3;
	Mon, 11 Jun 2018 13:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CCBA601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933218AbeFKNEv (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 09:04:51 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:46289 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeFKNEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 09:04:49 -0400
Received: by mail-lf0-f46.google.com with SMTP id j13-v6so30413608lfb.13;
        Mon, 11 Jun 2018 06:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29fu4cM7idRcKNHOO4Gd6Bffht9Vq1Nic5V9HfI1lOg=;
        b=nwJ6DP3odzPNJETix3wlvyR0LCUPdUiJQIxLzg6HnudGVZyXUZmWvUvuVLc0aoWee7
         nS4rD7jsMuVCjAlP/XdNb1ImGiVCBL4zfnPXUu5E9yRLjOtK7+OMsOlH99xrQjPEP6VX
         USyC7C0lDX/objLsYkyE6tAXMfbF7yeZY2kG828HWrZ0X+iPTA+FdxRTgYAJ968EujQ5
         i8IOIMpXm7B7cILAjxa1ymDRThA+Fb05wMdZNysVyH4VyMwNaYzGqoeKXKJWFEaI/Ak1
         yIgutIiSfXZzmeIz4sfNfbb8HszwvImTA3D3eMn2qrstPtjEfCYVJUitj7ndObSwQqgT
         rJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29fu4cM7idRcKNHOO4Gd6Bffht9Vq1Nic5V9HfI1lOg=;
        b=hwTHRgTUOZ9C9l+f1HmWN4ciOC5apxLs1yXDdnJlnZjyeAURyISpR0kKoAqo9T4kBm
         qEZajeDR77DStMsjAnafjzWosdygRGVMSB/tEzR10mUzGENYvzc2qIjsNLlRy1RcWSPt
         ikM2g78+tk9IRRaMiU/RcxBDSDCnpo7IvtpKDg92fLRG+QSUCPbfEu27mJ97MYLbzKsR
         kygTdUvomLXByypjZqN22a1H+KUvdfOx1XfOorY6hw1D5DY/XtR3761ZybIrIdOgSpNF
         pcpmX/yJ1N6p/wqEDBxtFIPdbQ379uf4AQ6vVMx2QF1ieQfgcxOfPzIjbDw9Bi88oYd1
         SYtg==
X-Gm-Message-State: APt69E2NxBgX3yzY6Y4ixki2UfEUb3qMu/cfLv7yvRAQ7GUPWoktWhyT
        Po18dLvpZIpaz0FcTBzwCgYJD31E1I9+GaIJ5SzD4w==
X-Google-Smtp-Source: ADUXVKLiZOmtyI5YE8Ijy0iyDMs5ay8Mhr/mJOv0kRW6cev4NR7/skdUkzfQ4MegxdnSRKSs+3UuTynncS9WfGwywnM=
X-Received: by 2002:a19:5ad4:: with SMTP id y81-v6mr10757138lfk.82.1528722287064;
 Mon, 11 Jun 2018 06:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180611115240.32606-5-ricardo.ribalda@gmail.com> <94360989-9AA9-422D-9CA3-AA631731BD2D@holtmann.org>
In-Reply-To: <94360989-9AA9-422D-9CA3-AA631731BD2D@holtmann.org>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Mon, 11 Jun 2018 15:04:30 +0200
Message-ID: <CAPybu_1t20k0r1wKiAiPRRNUhs1iZRntK9SDRqXcA7XEDq=xKw@mail.gmail.com>
Subject: Re: [PATCH v2 04/24] Bluetooth: hci_nokia: Add serdev_id_table
To: Marcel Holtmann <marcel@holtmann.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Marcel

I have just removed it from my series

Sorry for the extra noise


-- 
Ricardo Ribalda
