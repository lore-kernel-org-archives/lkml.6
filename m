Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7CFC43143
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B1E20866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 19:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPNGaT0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7B1E20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeINA7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 20:59:12 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:39740 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbeINA7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 20:59:12 -0400
Received: by mail-it0-f47.google.com with SMTP id h1-v6so9301619itj.4;
        Thu, 13 Sep 2018 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EpSqoHloRitp382xCPsaYDoJMi4lr5stUxXxiJnsPlA=;
        b=WPNGaT0B1C2fhOUJv+s1H+H0JTT2WPX+3G8rhSvnxrGyoKUpif1+UcO8sD7qzYbvhA
         MgFKL9bNM3krcJDZsMUgbKl53x6Sisb+hn2b2Ge6B7mtoETId9nIFLuC34qQucOcPWji
         uss0q8sWrT7ns6ZvLP55+SnnVZC2bIAp2BlFhlMsjlfnh0OkAQqOMpVyUXgWKTgfQl75
         tDjs+TxLyVtj5za4esFVulqmMG2EtZBxdxI+cVx5tqr46MNKT2pDBGBXes3AlHpzjJ4D
         CpaBRDvcU57ETt6SYTVF2cZNGIQoBZKgTWUZWx/6ETC7/xIBcECHL1YxloV33WIroFge
         xjFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EpSqoHloRitp382xCPsaYDoJMi4lr5stUxXxiJnsPlA=;
        b=V0JbOoUDxLRDTu337hx+Gyg4BPm6oxxWSAVRAsaiZu6DbMRXu1oi4cosPCEIGqLCXV
         X6ItMTTbRWDPv3IIJ90dxmUhNUPMLxuKU8+IfktvEzmAnKO8ktA9VhNqSC+GiLxI2XUb
         wCfmcx34IwK+UrkeRyrzY7f2aQjuKWXqcx6pwp9d3qQqYv7lVQnF9IsoXOCq2OSm2o7B
         CSZHL9fIlwtnKWtYtdEtNl2/J8PSYFi38YcbjBh9rWCuBh/0MnYWgNCZ6Ac7Hgse9aj0
         nu1lrV9mQpg6gxcmkAxS39aTL9d+UhXgR+Fx7lgOGT3xok5xoGyRdmVfSbS8qspMClIY
         YFmQ==
X-Gm-Message-State: APzg51AxNzNuM/Kuc31lQ0qkFFZdnYkd7uowNlNWAB3aHKVV0iqOWBDU
        +P54ewuexBngymgU+cVXNoW9Y/yTXcI/xdi3AoQ=
X-Google-Smtp-Source: ANB0Vda56dvk25MRqJ8rdxI6lf2EKAR4j/4S/wLrLxhBjUdNF/m/sgB0+I5vSkBS4xOoL725P0WhdO9Y+UQG/NaaBdc=
X-Received: by 2002:a24:7bd4:: with SMTP id q203-v6mr7626953itc.123.1536868094236;
 Thu, 13 Sep 2018 12:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180911161527.GA30689@vnote> <20180912083844.iegei2kobcz4b7ag@ws.net.home>
 <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
In-Reply-To: <6d349d22d37041c1a2942d8ed4c76b69@AcuMS.aculab.com>
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
Date:   Thu, 13 Sep 2018 22:48:03 +0300
Message-ID: <CAJC2YLaug4=7otnRC7x+UdDp=5ErgJFHFL_7mjRO7sdM2CrUfQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
To:     David.Laight@aculab.com
Cc:     kzak@redhat.com, Davidlohr Bueso <dave@stgolabs.net>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I suspect you also need a sanity check that the value isn't too small
> or stupidly large.

What would be the criterion for too large entries?

-- 
Eugene
