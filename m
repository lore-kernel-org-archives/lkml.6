Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id DM0fH0k6GFsEdAAAmS7hNA
	; Wed, 06 Jun 2018 19:48:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0E35D608BA; Wed,  6 Jun 2018 19:48:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyhApi6B"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5F9AF607F7;
	Wed,  6 Jun 2018 19:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5F9AF607F7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeFFTsZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:48:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34108 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbeFFTsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:48:23 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so4469375plq.1;
        Wed, 06 Jun 2018 12:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LwbfeGI/CGq1zn+Ua4uL5IZCLnQ25ixHYrEJK2l/45Y=;
        b=NyhApi6BJLKuXK6gknsh9AOe7VlesYChH9YED8xVJKK/froivr+V6zRHkFczAcH+CW
         diVDdkx910F6MHDtPiAMaqa19U6H2uJEQanmbcyb9l9y4NI45oBHwDpv30QRgOYUM3oN
         HyYwKrUOkk7+St2uCMdL2fedyHDUccclPF5rf969h/0uXArtUZXi2hgSXBLSlIVxQ/hp
         wW1WdQ5HuF8QqeIPFmtNdk0lCrATEq/VwgQvl5U7hl+Rm3kv/LRVzNyg6UOx1ePdc+gn
         BC41dhuPxl5g+i3yTWyxxV7AyKt3xvUagyn5fwBzhL6ZgGw73tHuCwoksreTlnu4Kmu8
         67gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LwbfeGI/CGq1zn+Ua4uL5IZCLnQ25ixHYrEJK2l/45Y=;
        b=Ck5TdjYZ8fSZnUXOLrlkQIAquM/QhxGwhYGx7pA3XvR6Xnwl4k59Ir5TYt3jTkK1s0
         uZwcfn1B2WqHC6XaTR0zcSUUVeav+L8Zg05wpjdBbY3tOdwP8bVdE2E4fIEG7cgLG6qX
         l5mvbxrv3M+4zXK+nAlanZgqH3Jf27ZBjUoHIVJlr3W/at2wdYYG4Nf7bpN1CkyCEQHI
         03sAsA82GXdSRBwRWNfz4dyW1uZh//tLWiE9AoGDuDLNdPC+L5MxEH+BFfGVIrdjnx2f
         RPjpiPuEpdGzMZ3chHLoFkPQJVEn/mlsucq88H5Qhhr3i740SlEnUcdtE+j8dk8a+MER
         SGxQ==
X-Gm-Message-State: APt69E1UexaFCqfmX+V3t/7Zof43iCKBRr2XT9INv0e5Di5XJzLt/5xU
        nXsP1aPqs1IvlzpYnEkXcI+5H3gtlq2DmTqYvHzCbOwN
X-Google-Smtp-Source: ADUXVKLNbkGX3jCmHd9o2zdYRQZbMOvOIi0UD5QExqtEvw4fNuEaOz3higsgAKTUAtDVHw5WfevSwie+8fp5kb0/Q24=
X-Received: by 2002:a17:902:8f8b:: with SMTP id z11-v6mr4536294plo.203.1528314502605;
 Wed, 06 Jun 2018 12:48:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:bc04:0:0:0:0 with HTTP; Wed, 6 Jun 2018 12:47:42
 -0700 (PDT)
In-Reply-To: <20180522212932.5357-2-jprvita@endlessm.com>
References: <20180522212932.5357-1-jprvita@endlessm.com> <20180522212932.5357-2-jprvita@endlessm.com>
From: =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
Date: Wed, 6 Jun 2018 12:47:42 -0700
Message-ID: <CA+A7VXVcvhU293-hhGfkjL1evxVju_XednQySxytjF1gNOFehg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rfkill: Create rfkill-none LED trigger
To: Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux@endlessm.com,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@endlessm.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 2:29 PM, Jo=C3=A3o Paulo Rechi Vita
<jprvita@gmail.com> wrote:
> Creates a new trigger rfkill-none, as a complement to rfkill-any, which
> drives LEDs when any radio is enabled. The new trigger is meant to turn
> a LED ON whenever all radios are OFF, and turn it OFF otherwise.
>

Johannes, do you have any feedback here? This will be used by
asus-wireless in the same way fujitsu-laptop uses rfkill-any.

--
Jo=C3=A3o Paulo Rechi Vita
http://about.me/jprvita
